//
//  AppDelegate+AepAnalytics.m
//

#import "AppDelegate+AepAnalytics.h"
#import "AepAnalytics.h"

#import "MainViewController.h"

#import "ACPCore.h"
#import "ACPAnalytics.h"
#import "ACPUserProfile.h"
#import "ACPIdentity.h"
#import "ACPLifecycle.h"
#import "ACPSignal.h"

static NSString *const PLUGIN_NAME = @"AepAnalytics";

@implementation AppDelegate (AepAnalytics)

    - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
        
        BOOL *aepPluginEnabled = FALSE;
        if (aepPluginEnabled == FALSE) {
            printf("### AepAnalytics - Not started because aepPluginEnabled is FALSE");
            return [super application:application didFinishLaunchingWithOptions:launchOptions];
        }

        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            printf("### AepAnalytics - First time App Launch - Init Aep & Track Install");

            [ACPCore setLogLevel:ACPMobileLogLevelDebug];
            [ACPCore configureWithAppId:@"{AepAppId}"];

            printf("### AepAnalytics - ConfigureWithAppID: {AepAppId}");

            [ACPAnalytics registerExtension];
            [ACPUserProfile registerExtension];
            [ACPIdentity registerExtension];
            [ACPLifecycle registerExtension];
            [ACPSignal registerExtension];
            [ACPCore start:^{
                [ACPCore lifecycleStart:nil];
            }];

            [ACPCore trackAction:@"install" data:@{@"platform":@"ios"}];

            self.viewController = [[MainViewController alloc] init];
        }

        return [super application:application didFinishLaunchingWithOptions:launchOptions];
    }

@end