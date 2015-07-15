//
//  MFMailComposeViewController+Recipient.m
//  medicalog
//
//  Created by Hai on 7/17/14.
//  Copyright (c) 2014 Peerbits. All rights reserved.
//

#import "MFMailComposeViewController+Recipient.h"
#import <objc/message.h>

static void MethodSwizzle(Class c, SEL origSEL, SEL overrideSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod = class_getInstanceMethod(c, overrideSEL);
    
    if (class_addMethod(c, origSEL, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(c, overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

@implementation MFMailComposeViewController (Recipient)

+ (void)load {
    MethodSwizzle(self, @selector(setMessageBody:isHTML:), @selector(setMessageBodySwizzled:isHTML:));
}



- (void)setMessageBodySwizzled:(NSString*)body isHTML:(BOOL)isHTML
{
//    if (isHTML == YES) {
//        NSRange range = [body rangeOfString:@"<torecipients>.*</torecipients>" options:NSRegularExpressionSearch|NSCaseInsensitiveSearch];
//        if (range.location != NSNotFound) {
//            NSScanner *scanner = [NSScanner scannerWithString:body];
//            [scanner setScanLocation:range.location+14];
//            NSString *recipientsString = [NSString string];
//            if ([scanner scanUpToString:@"</torecipients>" intoString:&recipientsString] == YES) {
//                NSArray * recipients = [recipientsString componentsSeparatedByString:@";"];
//                [self setToRecipients:recipients];
//            }
//            body = [body stringByReplacingCharactersInRange:range withString:@""];
//        }
//    }
    
        [self setToRecipients:@[@"feedback@541go.com"]];
   
    
    [self setMessageBodySwizzled:body isHTML:isHTML];
}


@end
