//
//  SendTransactionViewController.m
//  Divvy
//
//  Created by Kevin Johnson on 7/22/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import "SendTransactionViewController.h"
#import "SVProgressHUD.h"
#import "DivvyJSManager.h"
#import "DivvyJSManager+SendTransaction.h"

@interface SendTransactionViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField * textFieldRecipient;
@property (weak, nonatomic) IBOutlet UITextField * textFieldAmount;
@property (weak, nonatomic) IBOutlet UILabel     * navTitle;

@end

@implementation SendTransactionViewController

-(void)done
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == self.textFieldRecipient) {
        [self.textFieldAmount becomeFirstResponder];
    }
    else if (textField == self.textFieldAmount) {
        
    }
    return YES;
}

-(IBAction)buttonSend:(id)sender
{
//    [self.textFieldAmount resignFirstResponder];
//    [self.textFieldRecipient resignFirstResponder];
//    
//    [SVProgressHUD showWithStatus:@"Sending..." maskType:SVProgressHUDMaskTypeGradient];
//    
//    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
//    [f setNumberStyle:NSNumberFormatterDecimalStyle];
//    NSNumber * number = [f numberFromString:self.textFieldAmount.text];
//    [[DivvyJSManager shared] wrapperSendTransactionAmount:number currency:self.currency toRecipient:self.textFieldRecipient.text toCurrency:self. withBlock:^(NSError *error) {
//        [SVProgressHUD dismiss];
//        if (error) {
//            UIAlertView *alert = [[UIAlertView alloc]
//                                  initWithTitle: @"Could not send"
//                                  message: error.localizedDescription
//                                  delegate: nil
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil];
//            [alert show];
//        }
//        else {
//            // Success
//            [self done];
//        }
//    }];
    
}
-(IBAction)buttonCancel:(id)sender
{
    [self done];
}


-(void)DivvyJSManagerConnected
{
    
}
-(void)DivvyJSManagerDisconnected
{
    [self done];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.textFieldRecipient becomeFirstResponder];
    
    self.navTitle.text = [NSString stringWithFormat:@"Send %@", self.currency];
    
    
    // Subscribe to divvy network state
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DivvyJSManagerConnected) name:kNotificationDivvyConnected object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DivvyJSManagerDisconnected) name:kNotificationDivvyDisconnected object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
