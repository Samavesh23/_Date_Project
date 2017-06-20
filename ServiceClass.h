//
//  ServiceClass.h
//  Motary
//
//  Created by Yatharth Singh on 05/01/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ServiceClass : NSObject

+(ServiceClass *) sharedServiceClass;

-(void)hitServiceForSignUpByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForSighInByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForUpdateProfile:(NSMutableDictionary*)parameters ;//withImage:(UIImageView *)image;


-(void)hitServiceForCreateProfileByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForChangePasswordByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForGetCarListByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForgotPSWRDByAF:(NSMutableDictionary*)parameters;
-(void)hitServiceVerifyOtpByAF:(NSMutableDictionary*)parameters;
-(void)hitServiceForGetCategories:(NSMutableDictionary*)parameters;
-(void)hitServiceForGetSubCategories:(NSMutableDictionary*)parameters;
-(void)hitServiceForAddtofavourite:(NSMutableDictionary*)parameters;
-(void)hitServiceForGetAllDates:(NSMutableDictionary*)parameters;
-(void)hitServiceForGetFavoriteDates:(NSMutableDictionary*)parameters;




-(void)hitServiceForHomeScreenDataByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForLocationByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForLocationDetailsByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForBannerImage:(NSMutableDictionary *)parameters;
-(void)hitServiceForOpenAndCloseTime:(NSMutableDictionary *)parameters andUrl:(NSString*)fullURL;
-(void)hitServiceForAddPlaceByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForReviewByAF:(NSMutableDictionary *)parameters;
-(void)hitserviceForUploadImage:(NSMutableDictionary *)parameters andImages:(NSMutableArray*)imgArray;

//----------->>>M3 Service Methods<<<<---------------


-(void)hitServiceAddCarByAF:(NSMutableDictionary *)parameters;// imgArr:(NSMutableArray *)imgArr;
-(void)hitServiceAddCarImageByAF:(NSMutableDictionary *)parameters withImage:(NSMutableArray *)imgArr;
-(void)hitServiceCarLikeByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceAddFavouriteCarByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceforCarTableByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceforGetfilterData:(NSMutableDictionary *)parameters;
-(void)hitServiceEditCarByAF:(NSMutableDictionary *)parameters;// imgArry:(NSMutableArray *)imgArry;


//----------->>>M4 Service Methods<<<<---------------


-(void)hitServiceForFavCars:(NSMutableDictionary*)parameters;
-(void)hitServiceForGetSoldCars:(NSMutableDictionary*)parameters;
-(void)hitServiceForUserProfile:(NSMutableDictionary*)parameters;

-(void)hitServiceBlockCarByAF:(NSMutableDictionary *)parameters;

//----------->>>M5 Service Methods<<<<---------------
-(void)hitServiceReportCarByAF:(NSMutableDictionary *)parameters;
-(void)hitServiceForChatPush:(NSMutableDictionary *)parameters;
-(void)hitServiceAdminSettingByAF:(NSMutableDictionary *)parameters;

//----------->>>M6 Service Methods<<<<---------------

-(void)hitServiceForGetPlate:(NSMutableDictionary *)parameters;
-(void)hitServiceForGetPayment:(NSMutableDictionary *)parameters;
-(void)hitServiceForAddPlate:(NSMutableDictionary *)parameters;
-(void)hitServiceForPlateLike:(NSMutableDictionary *)parameters;
-(void)hitServiceForFavouritePlate:(NSMutableDictionary *)parameters;
-(void)hitServiceForAllFavPlate:(NSMutableDictionary *)parameters;
-(void)hitServiceForLikePlatesByAF:(NSMutableDictionary *)parameters;

-(void)hitServiceForReportPlate:(NSMutableDictionary *)parameters;
-(void)hitServiceForGetHistory:(NSMutableDictionary *)parameters;
-(void)hitServiceForBlockPlate:(NSMutableDictionary *)parameters;
-(void)hitServiceForPlateCategory:(NSMutableDictionary *)parameters;
-(void)hitServiceForUpdateLocate:(NSMutableDictionary *)parameters;
-(void)hitServiceForEnableorDisable:(NSMutableDictionary *)parameters;
-(void)hitServiceForGetAllPlateCategory;
-(void)hitServiceForGetCity;

#pragma Yelp APIs

-(void)hitserviceForGetHomeScreendataFromYelp:(NSMutableDictionary *)parameters;




@end
