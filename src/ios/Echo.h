/********* Echo.h Cordova Plugin Header *******/

#import <Cordova/CDV.h>

@interface AVSession : CDVPlugin

- (void)setCategory:(CDVInvokedUrlCommand*)command;
- (void)setNowPlayingInfoWithArtist:(NSString*)artist withTitle:(NSString*)title withAlbum:(NSString*)album;

@end
