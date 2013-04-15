//
//  RVAppDelegate.m
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVAppDelegate.h"

#import "RVViewController.h"

#import "SCAPI.h"

@implementation RVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [SCSoundCloud setClientID:@"25fb957261fef632e2261b548b5d7520"
                       secret:@"7d408562a7c6b384377b4f3bf48fac47"
                  redirectURL:[NSURL URLWithString:@"rvsoundcloud://oauth"]];

    
    self.viewController = [[RVViewController alloc] initWithNibName:@"RVViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
