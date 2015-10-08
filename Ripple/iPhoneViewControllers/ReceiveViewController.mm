//
//  ReceiveViewController.m
//  Divvy
//
//  Created by Kevin Johnson on 7/23/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import "ReceiveViewController.h"
#import "QREncoder.h"
#import "DivvyJSManager.h"

@interface ReceiveViewController ()

@property (weak, nonatomic) IBOutlet UILabel * labelAddress;

@end

@implementation ReceiveViewController

-(IBAction)buttonCopyToClipboard:(id)sender
{
    NSString * address = [[DivvyJSManager shared] divvyWalletAddress];
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:address];

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Copied to clipboard"
                          message: address
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

-(IBAction)buttonBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //the qrcode is square. now we make it 250 pixels wide
    int qrcodeImageDimension = 250;
    
    //the string can be very long
    NSString* walletAddress = [[DivvyJSManager shared] divvyWalletAddress];
    NSString * qrCodeAddress = [NSString stringWithFormat:@"https://divvy.com//contact?to=%@",walletAddress];
    
    //first encode the string into a matrix of bools, TRUE for black dot and FALSE for white. Let the encoder decide the error correction level and version
    DataMatrix* qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:qrCodeAddress];
    
    //then render the matrix
    UIImage* qrcodeImage = [QREncoder renderDataMatrix:qrMatrix imageDimension:qrcodeImageDimension];
    
    //put the image into the view
    UIImageView* qrcodeImageView = [[UIImageView alloc] initWithImage:qrcodeImage];
    CGRect parentFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBarController.tabBar.frame;
    
    //center the image
    CGFloat x = (parentFrame.size.width - qrcodeImageDimension) / 2.0;
    CGFloat y = 50 + (parentFrame.size.height - qrcodeImageDimension - tabBarFrame.size.height) / 2.0;
    CGRect qrcodeImageViewFrame = CGRectMake(x, y, qrcodeImageDimension, qrcodeImageDimension);
    [qrcodeImageView setFrame:qrcodeImageViewFrame];
    
    //and that's it!
    [self.view addSubview:qrcodeImageView];
    
    
    self.labelAddress.text = walletAddress;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
