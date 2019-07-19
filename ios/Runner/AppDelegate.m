#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>

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
    /// flutter 通信 start
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel methodChannelWithName:@"sukoshi.flutter.io/battery" binaryMessenger:controller];
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"onShock" isEqualToString:call.method]) {
            [self onShock];
        }
    }];
    /// flutter 通信 end
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void) onShock {
    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [feedBackGenertor prepare];
    [feedBackGenertor impactOccurred];
}

@end
