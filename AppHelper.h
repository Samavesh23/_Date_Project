//
//  AppHelper.h
//  Motary
//
//  Created by Yatharth Singh on 05/01/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface AppHelper : NSObject {
    // UIAlertView *alertView;
}
//@property (nonatomic, strong) ACAccountStore *accountStore;


+(void)saveToUserDefaults:(id)value withKey:(NSString*)key;
+(NSString*)userDefaultsForKey:(NSString*)key;
+(void)removeFromUserDefaultsWithKey:(NSString*)key;
+ (void)showActivityIndicator:(UIView *)view;
+ (void)hideActivityIndicator:(UIView *)view;
+ (NSString *)getCurrentLanguage;
+(BOOL) validEmail:(NSString*) emailString;
+(BOOL) ValidCharacter:(NSString *)CharaterString;
+(BOOL) validEmailNoEdu:(NSString*) emailString;
+(BOOL)ShouldNotContainSpace:(NSString *)NoBlankSpace;
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;
+(void)getfb:(ACAccountStore *)accountStore;
+ (UIImage *)scaleAndRotateImage:(UIImage *) image;
+ (BOOL) validateUrl: (NSString *) candidate;

+(NSString*)removeSpaces:(NSString*)string;
+(NSString*)removeWhiteSpaces:(NSString*)string;
+(BOOL)isPasswordValid:(NSString *)pwd;

@end
