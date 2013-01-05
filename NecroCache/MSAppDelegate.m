//
//  MSAppDelegate.m
//  NecroCache
//
//  Created by Seth Raphael on 1/4/13.
//  Copyright (c) 2013 MagicSeth. All rights reserved.
//

#import "MSAppDelegate.h"
#import "NecroCache.h"

@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSCache * c = [[NecroCache alloc] init];
    [c setCountLimit:3];
    for (int i = 0; i< 10; i ++) {
        [c setObject:[NSString stringWithFormat:@"object %d", i] forKey:[NSString stringWithFormat:@"%d", i]];
    }
    
    for (int i = 0; i< 10; i ++) {
        NSNumber * n = [c objectForKey:[NSString stringWithFormat:@"%d", i]];
        if (n) {
            NSLog(@" cache hit for %d", i);
        } else {
            NSLog(@" cache miss for %d", i);
        }
    }
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        for (int i = 0; i< 10; i ++) {
            NSNumber * n = [c objectForKey:[NSString stringWithFormat:@"%d", i]];
            if (n) {
                NSLog(@" cache hit for %d", i);
            } else {
                NSLog(@" cache miss for %d", i);
            }
        }

    });

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
