/********* Echo.h Cordova Plugin Header *******/

#import <Cordova/CDV.h>

@interface AVSession : CDVPlugin

- (void)setCategory:(CDVInvokedUrlCommand*)command;
- (void)setNowPlayingInfoWithArtist:(CDVInvokedUrlCommand*)command;

@end
