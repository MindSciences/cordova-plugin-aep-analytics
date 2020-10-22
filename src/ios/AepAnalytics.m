/********* AepAnalytics.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface AepAnalytics : CDVPlugin { }

- (void)testStrReturn:(CDVInvokedUrlCommand*)command;
@end

@implementation AepAnalytics

- (void)testStrReturn:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
