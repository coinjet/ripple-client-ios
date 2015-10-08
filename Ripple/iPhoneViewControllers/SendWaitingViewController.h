//
//  SendWaitingViewController.h
//  Divvy
//
//  Created by Kevin Johnson on 7/24/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPNewTransaction;

@interface SendWaitingViewController : DivvyStatusViewController

@property (strong, nonatomic) RPNewTransaction * transaction;

@end
