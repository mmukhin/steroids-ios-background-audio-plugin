/********* Echo.m Cordova Plugin Implementation *******/

#import "Echo.h"
#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>

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

- (void)setNowPlayingInfo:(CDVInvokedUrlCommand*)command {

    	CDVPluginResult* pluginResult = nil;
	
	NSString* artist = [command.arguments objectAtIndex:0];
    NSString* title = [command.arguments objectAtIndex:1];
    NSString* album = [command.arguments objectAtIndex:2];
    NSString *cover = [command.arguments objectAtIndex:3];
    
	// async cover loading
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *image = nil;
        // check whether cover path is present
        if (![cover isEqual: @""]) {
            // cover is remote file
            if ([cover hasPrefix: @"http://"] || [cover hasPrefix: @"https://"]) {
                NSURL *imageURL = [NSURL URLWithString:cover];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                image = [UIImage imageWithData:imageData];
            }
            // cover is local file
            else {
                NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *fullPath = [NSString stringWithFormat:@"%@%@", basePath, cover];
                BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
                if (fileExists) {
                    image = [UIImage imageNamed:fullPath];
                }
            }
        }
        else {
            // default named "no-image"
            image = [UIImage imageNamed:@"no-image"];
        }
        // check whether image is loaded
        CGImageRef cgref = [image CGImage];
        CIImage *cim = [image CIImage];
        if (cim != nil || cgref != NULL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
                    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage: image];
                    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
                    center.nowPlayingInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                        artist, MPMediaItemPropertyArtist,
                        title, MPMediaItemPropertyTitle,
                        album, MPMediaItemPropertyAlbumTitle,
                        artwork, MPMediaItemPropertyArtwork
                    ];

                    NSString *resultText = [NSString stringWithFormat:@"Set now playing info to %@", center.nowPlayingInfo];

                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultText];

                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }
            });
        }
    });
}

@end

