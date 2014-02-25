/********* Echo.h Cordova Plugin Header *******/

#import <Cordova/CDV.h>

@interface Echo : CDVPlugin

- (void)echo:(CDVInvokedUrlCommand*)command;

@end

@interface AVSession : CDVPlugin

- (void)setCategory:(CDVInvokedUrlCommand*)command;

@end
