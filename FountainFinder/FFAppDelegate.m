//
//  FFAppDelegate.m
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFAppDelegate.h"
#import "FFLoginViewController.h"
#import "FFFirebase.h"

@implementation FFAppDelegate

- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    UIWindow* window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setBackgroundColor:[UIColor whiteColor]];
    [self setWindow:window];

    FFLoginViewController* loginVc = [FFLoginViewController new];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    [window setRootViewController:nav];

    [window makeKeyAndVisible];

    [FFFirebase listenForFountains];
    return TRUE;
}

@end
