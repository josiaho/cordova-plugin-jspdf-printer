#import <Cordova/CDVPlugin.h>
#import <AppKit/NSPrinter.h>
#import <Quartz/Quartz.h>

@interface printJSPDF : CDVPlugin

- (void) getPrinters:(CDVInvokedUrlCommand *)command;
- (void) getPrinterDescription:(CDVInvokedUrlCommand *)command;

@end
