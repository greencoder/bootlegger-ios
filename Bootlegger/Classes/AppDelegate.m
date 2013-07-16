//
//  AppDelegate.m
//  RumRunner
//
//  Created by Scott Newman on 4/22/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseOverlayView.h"
#import "MainViewController.h"
#import "Constants.h"
#import "Credentials.h"
#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // API key is found in Credentials.h
    [Crashlytics startWithAPIKey:CRASHLYTICS_API_KEY];
    UILabel *lblAppearance = [UILabel appearanceWhenContainedIn:[BaseOverlayView class], nil];
    [lblAppearance setFont:FONT_16];
    [lblAppearance setTextColor:VERY_DARK_GRAY_COLOR];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    MainViewController *mainVC = (MainViewController *)self.window.rootViewController;
    if (mainVC.gameInProgress) {
        [mainVC saveData];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    MainViewController *mainVC = (MainViewController *)self.window.rootViewController;
    if ([mainVC savedFileExists]) {
        [mainVC loadData];
    }
}

@end
