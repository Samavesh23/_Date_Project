//
//  ServiceClass.m
//  Motary
//
//  Created by Yatharth Singh on 05/01/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "ServiceClass.h"
#import "AFNetworking.h"
#import "JSON.h"
#import "Define.h"
#import "AppHelper.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "NSString+SBJSON.h"
#import "JSON.h"
#import "UIImageView+AFNetworking.h"

int j;

@implementation ServiceClass

+(ServiceClass *) sharedServiceClass
{
    static ServiceClass *singleton;
    
    if(!singleton)
    {
        singleton=[[ServiceClass alloc] init];
    }
    return singleton;
}

-(void)hitServiceForgotPSWRDByAF:(NSMutableDictionary*)parameters
{
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection]){
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
        [manager POST:[Mainurl stringByAppendingString:ChangePasswordUrl] parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForgotPSWRD object:nil userInfo:jsonDict];
             
             
         } failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             //   NSLog(@"Error: %@", error);
             
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:@"1" forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForgotPSWRD object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForgotPSWRD object:nil userInfo:dict];
    }
}

-(void)hitServiceForSignUpByAF:(NSMutableDictionary *)parameters
{
      NSLog(@"Sign Up Parameters %@",parameters);
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
        [manager POST:[Mainurl stringByAppendingString:SignUpUrl] parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSignUpInfo object:nil userInfo:jsonDict];
             
             NSLog(@"Sign Up Response Data ======= %@",jsonDict);

         } failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSignUpInfo object:nil userInfo:dict];
         }];
    }
    else
    {
        
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSignUpInfo object:nil userInfo:dict];
        
    }
    
}

-(void)hitServiceForSighInByAF:(NSMutableDictionary *)parameters
{

     NSLog(@"login Parameters %@",parameters);
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
       // [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
         [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
        
        [manager POST:[Mainurl stringByAppendingString:SignInUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSignInInfo object:nil userInfo:jsonDict];
             
             NSLog(@"Log In Response Data ======= %@",jsonDict);
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             
             
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSignInInfo object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSignInInfo object:nil userInfo:dict];
        
    }
}


-(void)hitServiceForUpdateProfile:(NSMutableDictionary*)parameters ;//withImage:(UIImageView *)image
{
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection]){
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
       // [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
         [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
//        AFHTTPRequestOperation *op = [manager POST:[Mainurl stringByAppendingString:UpdateProfile] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            
//            
//            NSData* data=UIImageJPEGRepresentation(image.image ,0.5);
//                
//                [formData appendPartWithFileData:data name:@"image_link" fileName:@"image" mimeType:@"image/png"];
//            
//            
//            
//        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [manager POST:[Mainurl stringByAppendingString:UpdateProfile] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"%@",decodedString);
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUpdateProfile object:nil userInfo:jsonDict];
             
             
         } failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             //   NSLog(@"Error: %@", error);
             
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:@"1" forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUpdateProfile object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUpdateProfile object:nil userInfo:dict];
    }
}

-(void)hitServiceForChangePasswordByAF:(NSMutableDictionary *)parameters
{
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:ChangePasswordUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangePasswordInfo object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangePasswordInfo object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangePasswordInfo object:nil userInfo:dict];
        
    }
    
}


-(void)hitServiceForAddPlaceByAF:(NSMutableDictionary *)parameters
{
    
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:AddPlace] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddPlace object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddPlace object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddPlace object:nil userInfo:dict];
        
    }
    
}


-(void)hitServiceForReviewByAF:(NSMutableDictionary *)parameters
{
    
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:Review] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForReview object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForReview object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForReview object:nil userInfo:dict];
        
    }
    
}



-(void)hitserviceForUploadImage:(NSMutableDictionary *)parameters andImages:(NSMutableArray*)imgArray{

    
    if ([[ AppDelegate getAppDelegate] checkInternateConnection]) {
        
        AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]init];
//        manager.requestSerializer.timeoutInterval = 120;
//        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:doctorid,@"doctor_id", nil];
        
        
        AFHTTPRequestOperation *op = [manager POST:[Mainurl stringByAppendingString:AddImages] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            for (int i=0; i<imgArray.count; i++) {
                
                [formData appendPartWithFileData:[imgArray objectAtIndex:i] name:[NSString stringWithFormat:@"image%d",i+1] fileName:[NSString stringWithFormat:@"image%d",i+1] mimeType:@"image/png"];
            }
            
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
            SBJSON *parser = [[SBJSON alloc] init];
            NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddImages object:nil userInfo:jsonDict];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@ ***** %@", operation.responseString, error);
            
            NSLog(@"%@",error);
            NSMutableDictionary *dict = nil;
            dict = [[NSMutableDictionary alloc] init];
            [dict setObject:error forKey:@"error"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddImages object:nil userInfo:dict];
            
            
        }];
        
        [op start];

        
    }else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddImages object:nil userInfo:dict];
        
    }


}




-(void)hitServiceForCreateProfileByAF:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:CreateProfileUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCreateProfileInfo object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCreateProfileInfo object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCreateProfileInfo object:nil userInfo:dict];
        
    }
    
}

-(void)hitServiceVerifyOtpByAF:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:VerifyCodeUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationVerifyCodeInfo object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationVerifyCodeInfo object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationVerifyCodeInfo object:nil userInfo:dict];
    }
}

-(void)hitServiceForHomeScreenDataByAF:(NSMutableDictionary *)parameters
{
//    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
//    {
//        [parameters setObject:@"en" forKey:@"locale"];
//    }
//    else
//    {
//        [parameters setObject:@"ar" forKey:@"locale"];
//    }
    //  NSLog(@"login Parameters %@",parameters);
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:HomeScreenUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             NSLog(@"Response %@",jsonDict);
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeScreenInfo object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:@"Data not found" forKey:@"message"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeScreenInfo object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeScreenInfo object:nil userInfo:dict];
        
    }
    
}

-(void)hitServiceForLocationByAF:(NSMutableDictionary *)parameters
{
    //    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    //    {
    //        [parameters setObject:@"en" forKey:@"locale"];
    //    }
    //    else
    //    {
    //        [parameters setObject:@"ar" forKey:@"locale"];
    //    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:locationUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation object:nil userInfo:jsonDict];
             NSLog(@"Response %@",jsonDict);
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
//             [dict setObject:error forKey:@"error"];
             [dict setObject:@"Data not found" forKey:@"message"];

             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation object:nil userInfo:dict];
        
    }
    
}

-(void)hitServiceForLocationDetailsByAF:(NSMutableDictionary *)parameters;
{
    //    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    //    {
    //        [parameters setObject:@"en" forKey:@"locale"];
    //    }
    //    else
    //    {
    //        [parameters setObject:@"ar" forKey:@"locale"];
    //    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:locationDetailUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocationDetails object:nil userInfo:jsonDict];
             NSLog(@"Response %@",jsonDict);
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
//             [dict setObject:error forKey:@"error"];
             [dict setObject:@"Data not found" forKey:@"message"];

             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocationDetails object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocationDetails object:nil userInfo:dict];
        
    }
    
}



-(void)hitServiceForBannerImage:(NSMutableDictionary *)parameters{
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        NSString *fullURl=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%@&key=AIzaSyCe4S6h4o95udvN7jqZggoCDbJDf_J2Q4k",[parameters valueForKey:@"reference"]];
//        NSString *fullUrl=[NSString stringWithFormat:@"https://developer.foursquare.com/docs/venues/hours"];
        
        [manager GET:fullURl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForBannerImage object:nil userInfo:jsonDict];
             NSLog(@"Response %@",jsonDict);
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             //             [dict setObject:error forKey:@"error"];
             [dict setObject:@"Data not found" forKey:@"message"];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForBannerImage object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForBannerImage object:nil userInfo:dict];
        
    }
    
    
    
}



-(void)hitServiceForOpenAndCloseTime:(NSMutableDictionary *)parameters andUrl:(NSString*)fullURL{

    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
//        NSString *fullURl=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyCe4S6h4o95udvN7jqZggoCDbJDf_J2Q4k",[parameters valueForKey:@"place_id"]];
//        NSString *fullUrl=[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/40a55d80f964a52020f31ee3?client_id=YCHJ3Y0T31TDLH4JGID3MMURSTW3QO2EYXRKEDRMXWLEZEE5&client_secret=JWIWEWRXE3IUGW3QVVECVUFZLQ1Z0KEAMPUNS3I0VLNM5BIT&v=20130815"];
        
        [manager GET:fullURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForOpenClose object:nil userInfo:jsonDict];
             NSLog(@"Response %@",jsonDict);
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
//             [dict setObject:error forKey:@"error"];
             [dict setObject:@"Data not found" forKey:@"message"];

             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForOpenClose object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForOpenClose object:nil userInfo:dict];
        
    }
    


}


//----------->>>M3 Service Methods<<<<---------------





-(void)hitServiceAddCarByAF:(NSMutableDictionary *)parameters //imgArr:(NSMutableArray *)imgArr
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    NSLog(@"%@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:AddCarUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddCar object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddCar object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddCar object:nil userInfo:dict];
        
    }
}
/*
-(void)hitServiceAddCarImageByAF:(NSMutableDictionary *)parameters withImage:(NSMutableArray *)imgArr
{
    int m=0;
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        
       // [AppHelper saveToUserDefaults:@"yes" withKey:@"editcarImage"];
        if ([[AppHelper userDefaultsForKey:@"editcarImage"]isEqualToString:@"yes"])
        {
            int y=0;
            
            for(id object in imgArr)
            {
                y++;
                if([[object valueForKey:@"imageType"] isEqualToString:@"string"])
                {
                    NSString* string = object;
                    NSLog(@"String: %@", string);
                }
                else if([[object valueForKey:@"imageType"] isEqualToString:@"url"])
                {
                    NSURL* url = object;
                    NSLog(@"URL: %@", url);
                    [parameters setObject:[object valueForKey:@"image"] forKey:[NSString stringWithFormat:@"carImage%d",y]];
                    m++;
                }
                else if([[object valueForKey:@"imageType"] isEqualToString:@"UIImage"])
                {
                    UIImage* image = object;
                    NSLog(@"UIImage: %@", image);
                }

            }
        }
       
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    
    NSLog(@"%@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:AddCarImageUrl] parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData>formData)
         
         {
             if ([[AppHelper userDefaultsForKey:@"editcarImage"]isEqualToString:@"yes"])
             {
                
                 long j=10-m;
                int n=m;
                 if (j!=0)
                 {
                     for(int i=0; i<n; i++)
                     {
                       if(![[[imgArr] valueForKey:@"imageType"] isEqualToString:@"url"])
                       {
                           n++;
                           if(![[object valueForKey:@"imageType"] isEqualToString:@"UIImage"])
                           {
                           NSData* data=UIImageJPEGRepresentation([[imgArr objectAtIndex:n] valueForKey:@"image"],0.5);
                           [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"carImage%d",n] fileName:[NSString stringWithFormat:@"carImage%d",n] mimeType:@"image/png"];
                           }
                           else
                           {
                               NSMutableData* data=[[NSMutableData alloc]init];
                               [formData appendPartWithFormData:data name:[NSString stringWithFormat:@"carImage%d",n]];
                           }
                       }
                         
                     }
                     
                    
                 }
 

             }
             else
             {
             int i;
             for (i=0; i<[imgArr count]; i++)
             {
                
                                  if ([[[imgArr objectAtIndex:i]valueForKey:@"image" ]isKindOfClass:[UIImage class]])
                                  {
                 
                                  NSData* data=UIImageJPEGRepresentation([[imgArr objectAtIndex:i] valueForKey:@"image"],0.5);
                                  [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"carImage%d",i+1] fileName:[NSString stringWithFormat:@"carImage%d",i+1] mimeType:@"image/png"];
                                  }
                 
                 
                                  else
                                  {
                                       [formData appendPartWithFormData:[[imgArr objectAtIndex:i] valueForKey:@"image"] name:[NSString stringWithFormat:@"carImage%d",i+1]];
                                  }
                 
                 
             }
             long k=imgArr.count;
             long j=10-k;
             
             if (j!=0)
             {
                 
                 int k;
                for (k=1; k<=j; k++)
                {
                    i++;
                    NSMutableData* data=[[NSMutableData alloc]init];
                   [formData appendPartWithFormData:data name:[NSString stringWithFormat:@"carImage%d",i]];
                    
                }
                 
             }
             }
             
         }
              success: ^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddCarImage object:nil userInfo:jsonDict];
             
             
         } failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         
         {
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:@"1" forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddCarImage object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddCarImage object:nil userInfo:dict];
        
    }
}

*/

-(void)hitServiceEditCarByAF:(NSMutableDictionary *)parameters

{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
   // NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSLog(@" %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:EditCarUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForEditCar object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForEditCar object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForEditCar object:nil userInfo:dict];
        
    }
}


-(void)hitServiceCarLikeByAF:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:CarLikeUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForCarLike object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForCarLike object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForCarLike object:nil userInfo:dict];
        
    }
    
}



-(void)hitServiceAddFavouriteCarByAF:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:AddFavUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddFav object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddFav object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddFav object:nil userInfo:dict];
        
    }
    
}



-(void)hitServiceforCarTableByAF:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:carTableUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCarTable object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCarTable object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCarTable object:nil userInfo:dict];
        
    }
    
}

-(void)hitServiceforGetfilterData:(NSMutableDictionary *)parameters

{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:FilterData] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCarfilterdata object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCarfilterdata object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCarfilterdata object:nil userInfo:dict];
        
    }
    
}


//---------->>>>M4 Service Methods<<<<----------------------


-(void)hitServiceForFavCars:(NSMutableDictionary*)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    if ([[AppDelegate getAppDelegate] checkInternateConnection]){
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        [manager POST:[Mainurl stringByAppendingString:favCarsUrl] parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOnFavCarList object:nil userInfo:jsonDict];
             
             
         } failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             //   NSLog(@"Error: %@", error);
             
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:@"1" forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOnFavCarList object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOnFavCarList object:nil userInfo:dict];
    }
}


-(void)hitServiceForGetSoldCars:(NSMutableDictionary*)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    if ([[AppDelegate getAppDelegate] checkInternateConnection]){
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        [manager POST:[Mainurl stringByAppendingString:GetSoldCars] parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetSoldCars object:nil userInfo:jsonDict];
             
             
         } failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             //   NSLog(@"Error: %@", error);
             
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:@"1" forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetSoldCars object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetSoldCars object:nil userInfo:dict];
    }
}


-(void)hitServiceForUserProfile:(NSMutableDictionary*)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    if ([[AppDelegate getAppDelegate] checkInternateConnection]){
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        [manager POST:[Mainurl stringByAppendingString:GetUserProfile] parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUserProfile object:nil userInfo:jsonDict];
             
             
         } failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             //   NSLog(@"Error: %@", error);
             
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:@"1" forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUserProfile object:nil userInfo:dict];
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUserProfile object:nil userInfo:dict];
    }
}



-(void)hitServiceBlockCarByAF:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:BlockCarUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForBlockCar object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForBlockCar object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForBlockCar object:nil userInfo:dict];
        
    }
    
}

//---------->>>>M5 Service Methods<<<<----------------------

-(void)hitServiceReportCarByAF:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:reportCarUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForReportCar object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForReportCar object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForReportCar object:nil userInfo:dict];
        
    }
    
}




-(void)hitServiceAdminSettingByAF:(NSMutableDictionary *)parameters
{
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:GetAdminSettingUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAdminSetting object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAdminSetting object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAdminSetting object:nil userInfo:dict];
        
    }
    
}
-(void)hitServiceForChatPush:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:getChatPush] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForChatPush object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForChatPush object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForChatPush object:nil userInfo:dict];
        
    }
    
}


//----------->>>M6 Service Methods<<<<---------------


-(void)hitServiceForGetPlate:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:getPlateUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetPlate object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetPlate object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetPlate object:nil userInfo:dict];
        
    }
}

-(void)hitServiceForAddPlate:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
       [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        [manager POST:[Mainurl stringByAppendingString:addPlateUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddPlate object:nil userInfo:jsonDict];
             
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddPlate object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddPlate object:nil userInfo:dict];
        
    }
    
}

-(void)hitServiceForPlateLike:(NSMutableDictionary *)parameters
{
    if ([[AppHelper userDefaultsForKey:@"language"]isEqualToString:@"eng"])
    {
        [parameters setObject:@"en" forKey:@"locale"];
    }
    else
    {
        [parameters setObject:@"ar" forKey:@"locale"];
    }
    //  NSLog(@"login Parameters %@",parameters);
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        
        [manager POST:[Mainurl stringByAppendingString:plateLikeUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUserPlateLike object:nil userInfo:jsonDict];
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUserPlateLike object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForUserPlateLike object:nil userInfo:dict];
        
    }
    
}

-(void)hitServiceForGetCategories:(NSMutableDictionary *)parameters
{
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
       // [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
         [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
        
        [manager POST:[Mainurl stringByAppendingString:GetCategory] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetallCategories object:nil userInfo:jsonDict];
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetallCategories object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetallCategories object:nil userInfo:dict];
        
    }
 
}

-(void)hitServiceForGetSubCategories:(NSMutableDictionary *)parameters
{
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
       // [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
         [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
        [manager POST:[Mainurl stringByAppendingString:GetSubCategories] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetallSubCategories object:nil userInfo:jsonDict];
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetallSubCategories object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetallSubCategories object:nil userInfo:dict];
        
    }
    
}

-(void)hitServiceForAddtofavourite:(NSMutableDictionary *)parameters
{
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
       // [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
        
        [manager POST:[Mainurl stringByAppendingString:AddToFavourite] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddToFavourite object:nil userInfo:jsonDict];
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddToFavourite object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForAddToFavourite object:nil userInfo:dict];
        
    }
    
  
}
-(void)hitServiceForGetAllDates:(NSMutableDictionary *)parameters
{
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        // [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
        
        [manager POST:[Mainurl stringByAppendingString:GetAllDates] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetAllDates object:nil userInfo:jsonDict];
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetAllDates object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationForGetAllDates object:nil userInfo:dict];
        
    }
    
    
}
-(void)hitServiceForGetFavoriteDates:(NSMutableDictionary *)parameters
{
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        // [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:Usermane password:Password];
        
        [manager POST:[Mainurl stringByAppendingString:GetFavoriteData] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             SBJSON *parser = [[SBJSON alloc] init];
             NSString *decodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSDictionary *jsonDict = [parser objectWithString:decodedString error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetFavoriteData object:nil userInfo:jsonDict];
             
         }
              failure: ^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             NSLog(@"%@",error);
             NSMutableDictionary *dict = nil;
             dict = [[NSMutableDictionary alloc] init];
             [dict setObject:error forKey:@"error"];
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetFavoriteData object:nil userInfo:dict];
             
         }];
    }
    else
    {
        NSMutableDictionary *dict = nil;
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Connection Error.Please check your internet connection and try again" forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetFavoriteData object:nil userInfo:dict];
        
    }
    
    
}



#pragma Yelp APIs



@end
