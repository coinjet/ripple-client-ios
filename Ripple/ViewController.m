//
//  ViewController.m
//  Divvy
//
//  Created by Kevin Johnson on 7/17/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import "ViewController.h"
#import "DivvyJSManager.h"

@interface ViewController ()

//@property (weak, nonatomic) IBOutlet UIWebView * webView;
@property (weak, nonatomic) IBOutlet UITextView * textViewLog;

@end

@implementation ViewController

-(IBAction)buttonPressed:(id)sender
{
//    //[[DivvyJSManager shared] accountInfo];
//    NSDictionary * params = @{@"src_account": @"rHQFmb4ZaZLwqfFrNmJwnkizb7yfmkRS96",
//                              @"dst_account": @"rhxwHhfMhySyYB5Wrq7ohSNBqBfAYanAAx",
//                              @"dst_amount": @"5000000",
//                              @"secret": @"snShK2SuSqw7VjAzGKzT5xc1Qyp4K"
//                              }; //@"src_currencies": @""
//    
//    [[DivvyJSManager shared] divvyFindPath:params];
    

//    NSDictionary * params = @{@"account": @"rHQFmb4ZaZLwqfFrNmJwnkizb7yfmkRS96",
//                              @"recipient_address": @"rhxwHhfMhySyYB5Wrq7ohSNBqBfAYanAAx",
//                              @"currency": @"XDV",
//                              @"amount": @"1",
//                              @"secret": @"snShK2SuSqw7VjAzGKzT5xc1Qyp4K"
//                              };
//    
    //[[DivvyJSManager shared] divvySendTransaction:params];
}

-(IBAction)buttonLogin:(id)sender
{
//    [[DivvyJSManager shared] login:@"divvylibtest" andPassword:@"TbEz3Rg6qKkNr72r" withBlock:^(NSError *error) {
//        if (error) {
//            UIAlertView *alert = [[UIAlertView alloc]
//                                  initWithTitle: @"Could not login"
//                                  message: error.localizedDescription
//                                  delegate: nil
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil];
//            [alert show];
//        }
//    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
