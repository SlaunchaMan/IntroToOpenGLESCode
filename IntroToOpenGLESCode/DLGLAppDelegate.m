//
//  DLGLAppDelegate.m
//  IntroToOpenGLESCode
//
//  Created by Jeff Kelley on 5/4/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//


#import "DLGLAppDelegate.h"

#import "DLGLDemoSelectionTableViewController.h"


@implementation DLGLAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:
     [[DLGLDemoSelectionTableViewController alloc] init]];
    
    self.window.rootViewController = navigationController;
    
    return YES;
}

@end
