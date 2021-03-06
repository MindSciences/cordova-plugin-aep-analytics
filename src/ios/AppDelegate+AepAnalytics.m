//
//  AppDelegate+AepAnalytics.m
//

#import "AppDelegate+AepAnalytics.h"
#import "AepAnalytics.h"

#import "MainViewController.h"

#import "ACPCore.h"
#import "ACPMobileServices.h"
#import "ACPAnalytics.h"
#import "ACPUserProfile.h"
#import "ACPIdentity.h"
#import "ACPLifecycle.h"
#import "ACPSignal.h"

static NSString *const PLUGIN_NAME = @"AepAnalytics";

@implementation AppDelegate (AepAnalytics)

    - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
        
        BOOL aepPluginEnabled = NO;
    
        if (!aepPluginEnabled) {
            printf("### AepAnalytics - Not started because aepPluginEnabled is False\n");
            return [super application:application didFinishLaunchingWithOptions:launchOptions];
        }

        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            printf("### AepAnalytics - First time App Launch - Init Aep & Track Install\n");

            [ACPCore setLogLevel:ACPMobileLogLevelWarning];
            [ACPCore configureWithAppId:@"{AepAppId}"];

            printf("### AepAnalytics - ConfigureWithAppID: {AepAppId}\n");

            [ACPMobileServices registerExtension];
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
        else {
            printf("### AepAnalytics - Not the first launch\n");   
        }

        return [super application:application didFinishLaunchingWithOptions:launchOptions];
    }

@end
