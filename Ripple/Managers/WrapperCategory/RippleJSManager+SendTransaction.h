//
//  DivvyJSManager+SendTransaction.h
//  Divvy
//
//  Created by Kevin Johnson on 7/25/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import "DivvyJSManager.h"

@interface DivvyJSManager (SendTransaction)

-(void)wrapperFindPathWithAmount:(NSNumber*)amount currency:(NSString*)currency toRecipient:(NSString*)recipient withBlock:(void(^)(NSArray * paths, NSError* error))block;
-(void)wrapperSendTransactionAmount:(RPNewTransaction*)transaction withBlock:(void(^)(NSError* error))block;
-(void)wrapperIsValidAccount:(NSString*)account withBlock:(void(^)(NSError* error))block;

@end
