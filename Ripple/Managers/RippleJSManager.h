//
//  WebViewBridgeManager.h
//  Divvy
//
//  Created by Kevin Johnson on 7/17/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WebViewJavascriptBridge.h"
#import "NSObject+KJSerializer.h"
#import "RPError.h"
#import "RPAccountData.h"
#import "RPBlobData.h"
#import "RPAccountLine.h"
#import "RPContact.h"
#import "RPAccountData.h"
#import "RPLedgerClosed.h"
#import "RPError.h"
#import "RPAccountLine.h"
#import "RPBlobData.h"
#import "RPContact.h"
#import "RPTransaction.h"
#import "RPNewTransaction.h"
#import "RPTransactionSubscription.h"
#import "RPTxHistory.h"
#import "RPAmount.h"

#import "AccountBalanceManager.h"
#import "AccountHistoryManager.h"

#import "../../../Pods/AFNetworking/AFNetworking/AFNetworking.h"

#define MAX_TRANSACTIONS 12


// Notifications
#define kNotificationDivvyConnected     @"DivvyNetworkConnected"
#define kNotificationDivvyDisconnected  @"DivvyNetworkDisconnected"
#define kNotificationUpdatedContacts     @"DivvyUpdatedContacts"
#define kNotificationUpdatedBalance      @"DivvyUpdatedBalance"
#define kNotificationUpdatedAccountTx    @"DivvyUpdatedAccountTx"
#define kNotificationUserLoggedIn        @"DivvyUserLoggedIn"
#define kNotificationUserLoggedOut       @"DivvyUserLoggedOut"


#define kNotificationAccountChanged      @"DivvyAccountChanged"
#define kNotificationRefreshTx           @"DivvyRefreshTx"


@class WebViewJavascriptBridge, RPBlobData,RPAccountData;

@interface DivvyJSManager : NSObject {
    UIWebView               * _webView;
    WebViewJavascriptBridge * _bridge;
    
    BOOL _isConnected;
    BOOL _isLoggedIn;
    BOOL _isAttemptingLogin;
    
    RPBlobData       * _blobData;
    NSMutableArray   * _contacts;
    
    AccountBalanceManager * _accountBalance;
    AccountHistoryManager * _accountHistory;
    
    AFHTTPRequestOperationManager * _operationManager;
    NSTimer * _networkTimeout;
}

+(DivvyJSManager*)shared;

-(BOOL)isConnected;
-(NSString*)divvyWalletAddress;
-(NSArray*)divvyContacts;
-(NSDictionary*)divvyBalances;
-(NSArray*)divvyTxHistory;

@end
