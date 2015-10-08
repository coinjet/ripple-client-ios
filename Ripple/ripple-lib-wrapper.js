document.addEventListener('WebViewJavascriptBridgeReady', onBridgeReady, false);
function onBridgeReady(event) {
	var bridge = event.bridge
	bridge.init();

	var remote = divvy.Remote.from_config({
		//"trace" : true,
		trusted : true,
		//websocket_ip : "s_west.divvy.com",
		//websocket_port : 443,
		//websocket_ssl : true,
		local_signing : true,
		servers: [
		  { host: 's-west.divvy.com', port: 443, secure: true },
		  { host: 's-east.divvy.com', port: 443, secure: true }
		],
	});

	// XDV Account Balance
	bridge.registerHandler('account_info', function(data, responseCallback) {
		remote.request_account_info(data.account)
		.on('success', function (result) {
			responseCallback(result);
		})
		.on('error', function (result) {
			responseCallback(result);
		})
		.request();
	})

	// IOU Request Account Balances
	bridge.registerHandler('account_lines', function(data, responseCallback) {
		remote.request_account_lines(data.account)
		.on('success', function (result) {
			responseCallback(result);
		})
		.on('error', function (result) {
			responseCallback(result);
		})
		.request();
	});

	// Last transactions on account
	bridge.registerHandler('account_tx', function(data, responseCallback) {
		remote.request_account_tx(data.params)
		.on('success', function (result) {
			responseCallback(result);
		})
		.on('error', function (result) {
			responseCallback(result);
		})
		.request();
	});


	// Submit payment
	bridge.registerHandler('send_transaction', function(data, responseCallback) {
		try {
			remote.set_secret(data.account, data.secret);

			var to_currency = data.to_currency.slice(0, 3).toUpperCase();
			var from_currency = data.from_currency.slice(0, 3).toUpperCase();
			var to_amount = divvy.Amount.from_human(""+data.to_amount+" "+to_currency);
			var to_address = data.to_address;

			to_amount.set_issuer(to_address);

			// Make sure recipient address is valid
			if (divvy.UInt160.is_valid(to_address)) {
	    	var tx = remote.transaction();
	    	tx.payment(data.account, to_address, to_amount.to_json());

				// Valid
				if (to_currency === "XDV" && from_currency === "XDV") {
					// XDV Transaction only

		    	// Sending XDV
		    	tx.build_path(true);

		    	// Send transaction
			    tx.on('success', function (res) {
              responseCallback(res);
          });
          tx.on('error', function (res) {
              responseCallback(res);
          });
          tx.submit();
		    } else {
		    	// Use path
		    	var path = data.path;

          var prepared_paths = path.paths_computed ? path.paths_computed: path.paths_canonical;
          var base_amount = divvy.Amount.from_json(path.source_amount);
          tx.send_max(base_amount.product_human(divvy.Amount.from_json('1.01')));

          if (prepared_paths) {
          	tx.paths(prepared_paths);
          }
          else {
          	// No Path available
          	responseCallback(JSON.parse('{"error":"No Path"}'));
    				return;
          }

          // Send transaction
  		    tx.on('success', function (res) {
    	    	responseCallback(res);
    	    });
    	    tx.on('error', function (res) {
    	    	responseCallback(res);
    	    });
    	    tx.submit();
		    }
			}
			else {
				responseCallback(JSON.parse('{"error":"Address is invalid"}'));
			}
		}
		catch (e) {
			responseCallback(JSON.parse('{"error":"Failed: ' + e.trace + '"}'));
		}
	});



	// Checking for valid account
	bridge.registerHandler('is_valid_account', function(data, responseCallback) {
		if (divvy.UInt160.is_valid(data.account)) {
		  responseCallback(JSON.parse('{"message":"Valid address: '+data.account+'"}'));
		}
		else {
		  responseCallback(JSON.parse('{"error":"Invalid address"}'));
		}
	});




	// Find paths between two accounts
	bridge.registerHandler('find_path_currencies', function(data, responseCallback) {
		try {
			remote.set_secret(data.account, data.secret);

			var currency = data.currency.slice(0, 3).toUpperCase();
			var amount = divvy.Amount.from_human(""+data.amount+" "+currency)
			amount.set_issuer(data.recipient_address);

	  	// Calculate path
	    remote.request_divvy_path_find(data.account,
	                                            data.recipient_address,
	                                            amount)
	    // XXX Handle error response
	    .on('success', function (response_find_path) {
	      if ((!response_find_path.alternatives || !response_find_path.alternatives.length) && currency !== "XDV") {
	        responseCallback(JSON.parse('{"error":"No Path"}'))
	  			return;
	      } else {
	      	responseCallback(response_find_path.alternatives);
	      }
	    })
	    .on('error', function (response_find_path) {
	      responseCallback(JSON.parse('{"error":"Path_find: Unknown Error: '+JSON.stringify(response_find_path)+'"}'))
				return;
	    })
	    .request();
    }
		catch (e) {
			responseCallback(JSON.parse('{"error":"Failed: ' + e.message + '"}'));
		}
	})


	// Not yet needed for iOS app
	// bridge.registerHandler('account_offers', function(data, responseCallback) {
	// 	remote.set_secret(data.account, data.secret);
	// 	remote.request_account_offers(data.account)
	// 	.on('success', function (result) {
	// 		responseCallback(result)
	// 	})
	// 	.on('error', function (result) {
	// 		console.error(result)
	// 		responseCallback(result)
	// 	})
	// 	.request();
	// })


	// Subscribe
	bridge.registerHandler('subscribe_transactions', function(data, responseCallback) {
		// Subscribe
		remote.request_subscribe().accounts(data.account,false).request();
	})

	// Decrypts with sjcl library
	bridge.registerHandler('sjcl_decrypt', function(data, responseCallback) {
		try {
			responseCallback(JSON.parse(sjcl.decrypt(data.key, data.decrypt)))
		}
		catch (e) {
			responseCallback(null);
		}
	})

	// Connect to divvy network
	bridge.registerHandler('connect', function(data, responseCallback) {
		remote.connect();
	})

	// Disconnect to divvy network
	bridge.registerHandler('disconnect', function(data, responseCallback) {
		remote.disconnect();
	})

	// Testing purposes
	// remote.on('ledger_closed', function (ledger) {
	//   bridge.callHandler('ledger_closed', ledger, function(response) {
	//   })
	// });

	// Connected to divvy network
	remote.on('connect', function () {
		bridge.callHandler('connected', null, function(response) {
		});
	});

	remote.on('disconnect', function () {
		bridge.callHandler('disconnected', null, function(response) {
		});
	});

	remote.on('transaction', function (result) {
		bridge.callHandler('transaction_callback', result, function(response) {
		});
	});
}
