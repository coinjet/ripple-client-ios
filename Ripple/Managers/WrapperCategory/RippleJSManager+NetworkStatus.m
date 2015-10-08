//
//  DivvyJSManager+NetworkStatus.m
//  Divvy
//
//  Created by Kevin Johnson on 7/25/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import "DivvyJSManager+NetworkStatus.h"

@implementation DivvyJSManager (NetworkStatus)

-(void)wrapperRegisterBridgeHandlersNetworkStatus
{
    // Connected to Divvy network
    [_bridge registerHandler:@"connected" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"connected called: %@", data);
        _isConnected = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDivvyConnected object:nil userInfo:nil];
    }];
    
    // Disconnected from Divvy network
    [_bridge registerHandler:@"disconnected" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"disconnected called: %@", data);
        _isConnected = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDivvyDisconnected object:nil userInfo:nil];
    }];
}

@end
