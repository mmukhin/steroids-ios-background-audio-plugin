/********* Echo.m Cordova Plugin Implementation *******/

#import "Echo.h"
#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>

@implementation AVSession

- (void)setCategory:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* argumentOne = [command.arguments objectAtIndex:0];

    NSLog(@"Setting AVSession category with argument %@", argumentOne);

//    if (echo != nil && [echo length] > 0) {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL ok;
    NSError *setCategoryError = nil;
    ok = [audioSession setCategory:AVAudioSessionCategoryPlayback
                           error:&setCategoryError];

    // add error handling ... someday ^.^'' 

    NSLog(@"Do you see an error here? %@", setCategoryError);
    NSLog(@"Our brand new category is: %@", [audioSession category]);
    
    NSString *resultText = [NSString stringWithFormat:@"Set AVAudioSessionCategory to %@", [audioSession category]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultText];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
