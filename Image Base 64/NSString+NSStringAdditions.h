//
//  NSString+NStringUtils.h
//  testBase64
//
//  Created by itrentalindia on 4/25/15.
//  Copyright (c) 2015 fourthscreenlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringAdditions)
+ (NSString *) base64StringFromData:(NSData *)data length:(NSInteger)length;

@end
