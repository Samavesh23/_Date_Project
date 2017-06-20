    //
//  AppHelper.m
//  Motary
//
//  Created by Yatharth Singh on 05/01/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//


#import "AppHelper.h"
#import "AppDelegate.h"
#import "Define.h"
#import <Social/Social.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Accounts/Accounts.h>


@implementation AppHelper

+ (UIImage*)appLogoImage
{
    return [UIImage imageNamed:@"appLogo.png"];
}


+(void)saveToUserDefaults:(id)value withKey:(NSString*)key
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	if (standardUserDefaults) {
		[standardUserDefaults setObject:value forKey:key];
		[standardUserDefaults synchronize];
	}
}

+(NSString*)userDefaultsForKey:(NSString*)key
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:key];
	
	return val;
}
+(void)removeFromUserDefaultsWithKey:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [standardUserDefaults removeObjectForKey:key];
    [standardUserDefaults synchronize];
}


+ (void)showActivityIndicator:(UIView*)view
{
    [self hideActivityIndicator:view];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(view.frame.size.width/2,view.frame.size.height/2, 20, 20)];
    
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge ];
    [activityIndicator.layer setBackgroundColor:[[UIColor colorWithWhite: 0.0 alpha:0.30] CGColor]];
    
    [activityIndicator setFrame:view.frame];
    CGPoint center = view.center;
    activityIndicator.center = center;
    [view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [activityIndicator setHidesWhenStopped:YES];
    
    [activityIndicator setTag:1024];
    
}

+ (void)hideActivityIndicator:(UIView*)view
{
    [[view viewWithTag:1024]removeFromSuperview];
}



+ (NSString *)getCurrentLanguage {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    
    
    NSArray *languages2 = [[NSBundle mainBundle] localizations];
    NSLog(@"languages2 = %@", languages2);
    
    NSString *language = [languages objectAtIndex:0];
    NSLog(@"language = %@", language);
    
    //nslog(@"languages = %@", languages);
	return [languages objectAtIndex:0];
}
+(BOOL) validEmail:(NSString *)emailString{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else
        return YES;
}

+ (BOOL) validateUrl: (NSString *) candidate {
   // NSString *urlRegEx =
   // @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
   // NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    if ([candidate isKindOfClass:[UIImageView class]])
    {
        return NO;
    } else
        return YES;
}

+(BOOL) validEmailNoEdu:(NSString*) emailString {
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else
        return YES;
}



+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, scaleTransform);
    
    [image drawAtPoint:origin];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, newRect, imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}


+(NSString*)removeSpaces:(NSString*)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}


+(NSString*)removeWhiteSpaces:(NSString*)string
{
    return [string stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceCharacterSet]];
}

+(BOOL)isPasswordValid:(NSString *)pwd {
    
    NSString *passRegEx = @"(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[^a-zA-Z]).{8,}";
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegEx];
    if ([passTest evaluateWithObject:pwd] == NO)
        return false;
    else
        return true;
}


+(BOOL)ShouldNotContainSpace:(NSString *)NoBlankSpace
{
    
    NSString *rawString =@" ";
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0)
    {
        return NO;
    } else
        return YES;
}



+(BOOL) ValidCharacter:(NSString *)CharaterString{
    NSString *regExPattern = @"[A-Z0-9]";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:CharaterString options:0 range:NSMakeRange(0, [CharaterString length])];
    NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else
        return YES;
}



+(void)getfb:(ACAccountStore *)accountStore
{
   
    if (accountStore == nil)
    {
        accountStore = [[ACAccountStore alloc] init];
    }
    
    ACAccountType * facebookAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    NSArray * permissions = @[@"user_likes",@"user_friends",@"email",@"public_profile",];
    NSDictionary * dict = @{ACFacebookAppIdKey : @"610754679116903", ACFacebookPermissionsKey : permissions, ACFacebookAudienceKey : ACFacebookAudienceEveryone};
    [accountStore requestAccessToAccountsWithType:facebookAccountType options:dict completion:^(BOOL granted, NSError *error) {
        if (granted)
        {
            NSLog(@"granted");
            
            NSArray *accounts = [accountStore accountsWithAccountType:facebookAccountType];
            
            ACAccount *account = [accounts lastObject];
            
            {
                NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/"];
//                SLRequest *request = [SLRequest requestForServiceType: SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL :url parameters:nil];
        SLRequest *request = [SLRequest requestForServiceType: SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL :url parameters:@{@"fields": @"name,picture.type(normal),gender,email"}];
                // 4. attach an account to the request
                
                [request setAccount :account];
                
                // 5. execute the request
                [request performRequestWithHandler:^(NSData *responseData,NSHTTPURLResponse *urlResponse,NSError*error) {
                    
                    if (responseData)
                    {
                        NSError *jsonError =nil;
                        NSDictionary *jsonDict = [ NSJSONSerialization JSONObjectWithData :responseData options : NSJSONReadingAllowFragments error:&jsonError];
                        // caution we're on an arbitrary queue
                        [[
                          NSOperationQueue
                          mainQueue
                          ]
                         addOperationWithBlock
                         :^{
                             NSLog(@"-- json: %@", jsonDict);
                             
                             NSMutableDictionary  *Fbdict=[[NSMutableDictionary alloc]init];
                             if(jsonDict[@"email"]==nil)
                             {
                                 [Fbdict setObject:@"" forKey:@"email"];
                             }
                             else{
                                 [Fbdict setObject:jsonDict[@"email"] forKey:@"email"];
                             }
                             //[Fbdict setObject:jsonDict[@"email"] forKey:@"email"];
                             [Fbdict setObject:jsonDict[@"name"] forKey:@"name"];
                             [Fbdict setObject:jsonDict[@"id"] forKey:@"socialId"];
                             [Fbdict setObject:jsonDict[@"picture"][@"data"][@"url"] forKey:@"profileImage"];
                             [Fbdict setObject:jsonDict[@"gender"] forKey:@"gender"];
                             NSLog(@"fbdict user:%@",jsonDict);
                             [[NSNotificationCenter defaultCenter] postNotificationName:FbDataNotification object:nil userInfo:Fbdict];
                             //                             FaceDict=jsonDict;
                             //                             NSString *Email=FaceDict[@"email"];
                             //                             // NSMutableDictionary *dict1=[[NSMutableDictionary alloc]init];
                             //                             [dict1 setObject:fbid forKey:@"uniqueId"];
                             //                             [dict1 setObject:SignUpFor forKey:@"loginType"];
                             //                             [AppHelper saveToUserDefaults:Email withKey:@"Email"];
                             //                             [AppHelper saveToUserDefaults:fbid withKey:@"uniqueId"];
                             //                             [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitForSignIn:) name:NotificationSignInInfo object:nil];
                             //                             [[ServiceClass sharedServiceClass] hitServiceForSighInByAF:dict1];
                             //
                             
                         }];
                        
                    }
                    else
                    {
//                        UIButton *button = (UIButton *)sender;
//                        button.userInteractionEnabled=YES;
//                        __weak         UIButton *button2=(UIButton *)[self.view viewWithTag:116];
//                        button2.userInteractionEnabled=YES;
                        
                        UIAlertView*    aAlert = [[UIAlertView alloc] initWithTitle:@"Pavi" message:@"Your Facebook account details can't be accessed right now. Please try later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [aAlert show];
                        
                    }
                    
                }];
                
            }
        }
        else
        {
            NSLog(@"not granted");
            
            if ([FBSDKAccessToken currentAccessToken])
            {
                
                [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
                
                if ([FBSDKAccessToken  currentAccessToken])
                {
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name,gender, picture.type(normal), email"}]
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             NSLog(@"fetched user:%@",result);
                             NSLog(@"%@",result[@"email"]);
                             NSMutableDictionary  *Fbdict=[[NSMutableDictionary alloc]init];
                             if(result[@"email"]==nil)
                             {
                                 [Fbdict setObject:@"" forKey:@"email"];
                             }
                             else{
                                 [Fbdict setObject:result[@"email"] forKey:@"email"];
                             }
                            // [Fbdict setObject:result[@"email"] forKey:@"email"];
                             [Fbdict setObject:result[@"name"] forKey:@"name"];
                             [Fbdict setObject:result[@"gender"] forKey:@"gender"];
                             [Fbdict setObject:result[@"id"] forKey:@"socialId"];
                             [Fbdict setObject:result[@"picture"][@"data"][@"url"] forKey:@"profileImage"];
                             NSLog(@"fbdict user:%@",Fbdict);
                             
                            [[NSNotificationCenter defaultCenter] postNotificationName:FbDataNotification object:nil userInfo:Fbdict];
                             
                             
                             
                         }
                     }];
                }

                //[self performSelectorOnMainThread:@selector(getUserDetail) withObject:nil waitUntilDone:YES];
            }
            else
            {
                FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
                
                [login logInWithReadPermissions:@[@"user_friends",@"email",@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                    if (error) {
                        // Process error
                    } else if (result.isCancelled) {
                        // Handle cancellations
                    } else {
                        // If you ask for multiple permissions at once, you
                        // should check if specific permissions missing
                        if ([result.grantedPermissions containsObject:@"email"]) {
                            // Do work
                            
                            
                            [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
                            
                            if ([FBSDKAccessToken  currentAccessToken])
                            {
                                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name,gender, picture.type(normal), email"}]
                                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                     if (!error) {
                                         NSLog(@"fetched user:%@",result);
                                         NSLog(@"%@",result[@"email"]);
                                         NSMutableDictionary  *Fbdict=[[NSMutableDictionary alloc]init];
                                         if(result[@"email"]==nil)
                                         {
                                             [Fbdict setObject:@"" forKey:@"email"];
                                         }
                                         else{
                                             [Fbdict setObject:result[@"email"] forKey:@"email"];
                                         }
                                        // [Fbdict setObject:result[@"email"] forKey:@"email"];
                                         
                                         
                                         [Fbdict setObject:result[@"name"] forKey:@"name"];
                                         [Fbdict setObject:result[@"id"] forKey:@"socialId"];
                                         [Fbdict setObject:result[@"gender"] forKey:@"gender"];
                                         [Fbdict setObject:result[@"picture"][@"data"][@"url"] forKey:@"profileImage"];
                                         NSLog(@"fbdict user:%@",Fbdict);
                                         [[NSNotificationCenter defaultCenter] postNotificationName:FbDataNotification object:nil userInfo:Fbdict];
                                     }
                                 }];
                            }

                            //[self performSelectorOnMainThread:@selector(getUserDetail) withObject:nil waitUntilDone:YES];
                            
                        }
                    }
                }];
                
            }

            
            //[self performSelectorOnMainThread:@selector(FbLoginFromWeb) withObject:nil waitUntilDone:YES];
        }
    }];
    
    
    
    
}


/*-(void)openPhonebook
{
    
    
    if (status == kABAuthorizationStatusDenied || status == kABAuthorizationStatusRestricted)
    {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Allow access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if (!addressBook)
    {
        NSLog(@"ABAddressBookCreateWithOptions error: %@", CFBridgingRelease(error));
        return;
    }
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                             {
                                                 if (error)
                                                 {
                                                     NSLog(@"ABAddressBookRequestAccessWithCompletion error: %@", CFBridgingRelease(error));
                                                 }
                                                 
                                                 if (granted)
                                                 {
                                                     // if they gave you permission, then just carry on
                                                     // [Peoplename removeAllObjects];
                                                     if (_Peoplename.count>0)
                                                     {
                                                         
                                                     }
                                                     else
                                                     {
                                                         [self listPeopleInAddressBook:addressBook];
                                                         
                                                     }
                                                     
                                                     
                                                 } else
                                                 {
                                                     // however, if they didn't give you permission, handle it gracefully, for example...
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         // BTW, this is not on the main thread, so dispatch UI updates back to the main queue
                                                         [[[UIAlertView alloc] initWithTitle:nil message:@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                                                     });
                                                 }
                                                 CFRelease(addressBook);
                                                 
                                             });
    
}
- (void)listPeopleInAddressBook:(ABAddressBookRef)addressBook
{
    {
        _allPeoplet = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
        NSInteger numberOfPeople = [_allPeoplet count];
        for (NSInteger i = 0; i < numberOfPeople; i++)
        {
            ABRecordRef person = (__bridge ABRecordRef)_allPeoplet[i];
            
            NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
            NSString *eMail  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonEmailProperty));
            NSData *imageData  = CFBridgingRelease(ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail));
            NSLog(@"%@",imageData);
            
            NSLog(@"%@",eMail);
            // NSLog(@"Name:%@ %@ %@ %@", firstName, lastName ,eMail,imageData);
            NSString *name=[NSString stringWithFormat:@"%@ %@ ",firstName,lastName];
            name = [name stringByReplacingOccurrencesOfString:@" (null)"
                                                   withString:@""];
            
            name = [name stringByReplacingOccurrencesOfString:@"(null) "
                                                   withString:@""];
            
            
            
            NSMutableArray *emailArr=[[NSMutableArray alloc] init];
            
            ABMutableMultiValueRef eMail1  = ABRecordCopyValue(person, kABPersonEmailProperty);
            CFIndex numberOfemails = ABMultiValueGetCount(eMail1);
            for (CFIndex j = 0; j < numberOfemails; j++)
            {
                NSString *emailid = CFBridgingRelease(ABMultiValueCopyValueAtIndex(eMail1, j));
                
                NSLog(@"%@",emailid);
                
                [emailArr addObject:emailid];
                
            }
            CFRelease(eMail1);
            NSLog(@"==");
            
            if (ABMultiValueGetCount(eMail1)>0)
                
            {
                [_Peoplename addObject:name];
            }
            NSMutableDictionary *contactDetail=[[NSMutableDictionary alloc] init];
            
            ABMutableMultiValueRef phoneNumbers = ABRecordCopyValue(person,kABPersonPhoneProperty);
            
            CFIndex numberOfPhoneNumbers = ABMultiValueGetCount(phoneNumbers);
            for (CFIndex i = 0; i < numberOfPhoneNumbers; i++)
            {
                NSString *phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, i));
                
                NSLog(@"phone:%@", phoneNumber);
                if (phoneNumber.length == 0)
                {
                    
                    
                }
                else
                {
                    
                    NSMutableArray *array = [NSMutableArray array];
                    
                    for (int i = 0; i < [phoneNumber length]; i++) {
                        NSString *ch = [phoneNumber substringWithRange:NSMakeRange(i, 1)];
                        [array addObject:ch];
                        
                    }
                    
                    
                    if ([[array objectAtIndex:0] isEqualToString:@"+"])
                    {
                        NSString *no=[NSString stringWithFormat:@"%@",phoneNumber];
                        [contactDetail setObject:no  forKey:@"Contact"];
                    }
                    else
                    {
                        NSString *no=[NSString stringWithFormat:@"+%@%@",Code,phoneNumber];
                        [contactDetail setObject:no  forKey:@"Contact"];
                    }
                    
                }
                
                [_Peoplenumt addObject:phoneNumber];
            }
            CFRelease(phoneNumbers);
            
            
            
            
            
            if(emailArr.count!=0)
            {
                
                
                              if( !(name == nil))
                {
                    [contactDetail setObject:name forKey:@"Name"];
                }
                if (imageData == nil)
                {
                    [contactDetail setObject:@""  forKey:@"Image"];
                }else
                {
                    [contactDetail setObject:imageData  forKey:@"Image"];
                }
                [contactDetail setObject:emailArr  forKey:@"Email"];
                [contactDetail setObject:@"NO" forKey:@"checked"];
                [contactDetail setObject:@"NO" forKey:@"paw"];
                
                //  [contactDetail removeObjectForKey:@"Contact"];
                [conatctsArr addObject:emailArr];
                [ValueArry addObject:@"no"];
                [array1 addObject:contactDetail];
                
                
                
            }
            
            //get the contact image
            
        }
        
        
        NSSortDescriptor *brandDescriptor;
        NSSortDescriptor *sortDescriptors;
        brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES];
        
        sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        SortedContacts = [[array1 sortedArrayUsingDescriptors:sortDescriptors]mutableCopy];
        //[[NSUserDefaults standardUserDefaults] setObject:SortedContacts forKey:@"Key"];
        
        
        [AppHelper saveToUserDefaults:[SortedContacts mutableCopy]withKey:@"contacts"];
        // [userDefaults setObject:arrayOfImage forKey:@"tableViewDataImage"];
        
        NSLog(@"%@",SortedContacts);
        
        
    }
}
*/

+ (UIImage *)scaleAndRotateImage:(UIImage *) image {
    int kMaxResolution = 1280;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}



@end
