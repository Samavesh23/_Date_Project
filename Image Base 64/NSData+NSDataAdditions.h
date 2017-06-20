//
//  NSData+NSDataAdditions.h
//  testBase64
//
//  Created by itrentalindia on 4/25/15.
//  Copyright (c) 2015 fourthscreenlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSDataAdditions)
+ (NSData *) base64DataFromString:(NSString *)string;
@end
