//
//  AppDelegate.m
//  DraftWithFriends
//
//  Created by Trent Ellingsen on 9/11/13.
//  Copyright (c) 2013 Trent Ellingsen. All rights reserved.
//

#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "Consts.h"

@implementation AppDelegate

#pragma mark - configuration methods

- (void)configureStyles
{
    [[UIBarButtonItem appearance] setTintColor:MTG_DRAFT_COLOR];
    [[UINavigationBar appearance] setTintColor:MTG_DRAFT_COLOR];
}

- (void)configureParseWithLaunchOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"MaANXOh7VHs2wCnEwKI6Oa0P1pJRe9UlbOnxtodE"
                  clientKey:@"BeIJrjDOcnOtoP1UP7JGALqmsfF3MeaXUKb3xzU2"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

#pragma mark - application methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureParseWithLaunchOptions:launchOptions];
    [self configureStyles];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.wireframeViewController = [[WireframeViewController alloc] initWithWindow:self.window];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
