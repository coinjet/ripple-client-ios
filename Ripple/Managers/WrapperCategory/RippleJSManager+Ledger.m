//
//  DivvyJSManager+Ledger.m
//  Divvy
//
//  Created by Kevin Johnson on 7/25/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import "DivvyJSManager+Ledger.h"

@implementation DivvyJSManager (Ledger)

-(void)registerBridgeHandlers
{
    //    // Testing purposes
    //    [_bridge registerHandler:@"ledger_closed" handler:^(id data, WVJBResponseCallback responseCallback) {
    //        NSLog(@"ledger_closed called: %@", data);
    //        [self log:data];
    //
    //        RPLedgerClosed * obj = [RPLedgerClosed new];
    //        [obj setDictionary:data];
    //        // Validate?
    //
    //        //responseCallback(@"Response from testObjcCallback");
    //    }];
}

@end
