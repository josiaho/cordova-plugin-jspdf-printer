#import "printJSPDF.h"

@implementation printJSPDF

- (void) getPrinters:(CDVInvokedUrlCommand *)command {
    //NSArray* printerTypes = [NSPrinter printerTypes];
    NSArray* printers = [NSPrinter printerNames];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:printers];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) getPrinterDescription:(CDVInvokedUrlCommand *)command {
    NSString* name = [command argumentAtIndex:0];
    NSPrinter *prius = [NSPrinter printerWithName:name];
    NSString *desc = [prius description];
    //NSArray* printers = [NSPrinter printerNames];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:desc];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) printPDF:(CDVInvokedUrlCommand *)command {
    NSString* fileURL = [command argumentAtIndex:0];
    NSString* printerName = [command argumentAtIndex:1];
    NSString* paperW = [command argumentAtIndex:2];
    NSString* paperH = [command argumentAtIndex:3];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:fileURL options:0];
    PDFDocument *pdfDocument = [[PDFDocument alloc] initWithData:data];
    
    NSPrintInfo *printInfo = [NSPrintInfo sharedPrintInfo];
    [printInfo setTopMargin:0.0];
    [printInfo setBottomMargin:0.0];
    [printInfo setLeftMargin:0.0];
    [printInfo setRightMargin:0.0];
    [printInfo setHorizontalPagination:NSFitPagination];
    [printInfo setVerticalPagination:NSFitPagination];
    
    float pW = [paperW floatValue];
    float pH = [paperH floatValue];
    
    [printInfo setPaperSize:NSMakeSize(pW, pH)];
    [printInfo setPrinter:[NSPrinter printerWithName:printerName]];
    
    PDFPrintScalingMode scale = kPDFPrintPageScaleToFit;
    
    NSPrintOperation *op = [pdfDocument printOperationForPrintInfo: printInfo scalingMode: scale autoRotate: YES];
    
    [op setShowsPrintPanel:NO];
    [op setShowsProgressPanel:NO];
    [op runOperation];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:fileURL];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
