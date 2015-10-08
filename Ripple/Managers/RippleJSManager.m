//
//  WebViewBridgeManager.m
//  Divvy
//
//  Created by Kevin Johnson on 7/17/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import "DivvyJSManager.h"

#import "DivvyJSManager+Initializer.h"
#import "DivvyJSManager+AccountInfo.h"
#import "DivvyJSManager+AccountLines.h"
#import "DivvyJSManager+TransactionCallback.h"
#import "DivvyJSManager+NetworkStatus.h"
#import "DivvyJSManager+Authentication.h"
#import "DivvyJSManager+SendTransaction.h"
#import "DivvyJSManager+AccountOffers.h"
#import "DivvyJSManager+AccountTx.h"


@interface DivvyJSManager ()

@end

@implementation DivvyJSManager

-(NSString*)divvyWalletAddress
{
    return [self account_id];
}

-(NSArray*)divvyContacts
{
    return _contacts;
}

-(NSArray*)divvyTxHistory
{
    return [_accountHistory divvyTxHistory];
}

-(BOOL)isConnected
{
    return _isConnected;
}

-(void)updateAccountInformation
{
    if (_isLoggedIn) {
        [self wrapperSubscribeTransactions];  // Subscribe to users transactions
        [self wrapperAccountLines];           // Get IOU balances
        [self wrapperAccountInfo];            // Get Divvy balance
        [self wrapperAccountTx];              // Get Last transactions
    }
}

-(void)refreshTx
{
    if (_isLoggedIn) {
        [self wrapperAccountTx];              // Get Last transactions
    }
}

-(NSDictionary*)divvyBalances
{
    return [_accountBalance divvyBalances];
}

-(void)connect
{
    [_bridge callHandler:@"connect" data:@"" responseCallback:^(id responseData) {
    }];
}

-(void)disconnect
{
    // Disconnect from Divvy server
    [_bridge callHandler:@"disconnect" data:@"" responseCallback:^(id responseData) {
    }];
}

-(void)divvyNetworkConnected
{
    [self updateAccountInformation];
}

-(void)divvyNetworkDisconnected
{
    
}

-(void)userLoggedIn
{
    _accountBalance = [[AccountBalanceManager alloc] initWithAccount:[self divvyWalletAddress]];
    _accountHistory = [[AccountHistoryManager alloc] initWithAccount:[self divvyWalletAddress]];
    [self updateAccountInformation];
}


-(void)userLoggedOut
{
    _accountBalance = nil;
    _accountHistory = nil;
}

+(DivvyJSManager*)shared
{
    static DivvyJSManager * shared;
    if (!shared) {
        shared = [DivvyJSManager new];
    }
    return shared;
}

- (id)init
{
    self = [super init];
    if (self) {
        _isConnected = NO;
        _isLoggedIn = NO;
        _isAttemptingLogin = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(divvyNetworkConnected) name:kNotificationDivvyConnected object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(divvyNetworkDisconnected) name:kNotificationDivvyDisconnected object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoggedIn) name:kNotificationUserLoggedIn object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoggedOut) name:kNotificationUserLoggedOut object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAccountInformation) name:kNotificationAccountChanged object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTx) name:kNotificationRefreshTx object:nil];
        
        [self wrapperInitialize];
        [self wrapperRegisterBridgeHandlersNetworkStatus];
        [self wrapperRegisterHandlerTransactionCallback];
        
        _operationManager = [AFHTTPRequestOperationManager manager];
        
        [self connect];
        
        // Check if loggedin
        [self checkForLogin];
        
        
//#warning Testing purposes
//        NSDictionary * params = [[NSUserDefaults standardUserDefaults] objectForKey:@"transaction"];
//        [_bridge callHandler:@"test_transaction" data:params responseCallback:^(id responseData) {
//            NSLog(@"test_transaction response: %@", responseData);
//            
//        }];
    }
    return self;
}




@end
