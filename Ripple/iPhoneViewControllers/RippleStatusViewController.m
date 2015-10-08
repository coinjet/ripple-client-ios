//
//  DivvyStatusViewController.m
//  Divvy
//
//  Created by Kevin Johnson on 7/24/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import "DivvyStatusViewController.h"
#import "DivvyJSManager.h"

@interface DivvyStatusViewController () {
    UILabel * labelStatus;
    
    BOOL  showingDisconnected;
}

@end

@implementation DivvyStatusViewController

-(void)DivvyJSManagerConnected
{
    showingDisconnected = NO;
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    else
    {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)DivvyJSManagerDisconnected
{
    showingDisconnected = YES;
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    else
    {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 20.0f;
        self.view.frame = f;
    } completion:^(BOOL finished) {
        
    }];
}

// Add this method
- (BOOL)prefersStatusBarHidden {
    if (showingDisconnected) {
        return YES;
    }
    else {
        return NO;
    }
}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

//-(void)connectedNoAnimation
//{
//    CGRect f = self.view.frame;
//    f.origin.y = 0.0f;
//    self.view.frame = f;
//}
//
//-(void)disconnectedNoAnimation
//{
//    CGRect f = self.view.frame;
//    f.origin.y = 20.0f;
//    self.view.frame = f;
//}

-(void)checkNetworkStatus
{
    if ([[DivvyJSManager shared] isConnected]) {
        [self DivvyJSManagerConnected];
    }
    else {
        [self DivvyJSManagerDisconnected];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Subscribe to divvy network state
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DivvyJSManagerConnected) name:kNotificationDivvyConnected object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DivvyJSManagerDisconnected) name:kNotificationDivvyDisconnected object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus) name: UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self performSelector:@selector(checkNetworkStatus) withObject:nil afterDelay:0.1];
    [self checkNetworkStatus];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Unsubscribe to divvy network state
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationDivvyConnected object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationDivvyDisconnected object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect f = CGRectMake(0, -20, 320, 20);
    labelStatus = [[UILabel alloc] initWithFrame:f];
    labelStatus.text = @"Offline";
    [labelStatus setTextAlignment:NSTextAlignmentCenter];
    labelStatus.textColor = [UIColor whiteColor];
    labelStatus.backgroundColor = [UIColor blackColor];
    
    self.view.clipsToBounds = NO;
    [self.view addSubview:labelStatus];
    
    if (![[DivvyJSManager shared] isConnected]) {
        CGRect f = self.view.frame;
        f.origin.y = 20.0f;
        self.view.frame = f;
        
        showingDisconnected = YES;
    }
    else {
        showingDisconnected = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
