#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

//
//@import UIKit;
//@import Firebase;
//
//@implementation AppDelegate
//
//- (BOOL)application:(UIApplication *)application
//didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [FIRApp configure];
//    return YES;
//}
//
//@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
