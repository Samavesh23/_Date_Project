//
//  define.h
//  Motary
//
//  Created by Yatharth Singh on 05/01/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "SignInViewController.h"
#import "ViewController.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "ServiceClass.h"
#import "AppHelper.h"
#import "AppDelegate.h"
#import "ForgotPasswordViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Base64.h"
#import "UIImageView+WebCache.h"
#import "IISideController.h"
#import "IIViewDeckController.h"
#import "AFNetworking.h"
#import "JSON.h"
#import "Define.h"
#import "AppHelper.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "NSString+SBJSON.h"
#import "JSON.h"
#import "UIImageView+AFNetworking.h"
#import "YelpClient.h"
#import "YelpListing.h"
#import "CategoryVC.h"
#import "DetailVC.h"
#import "MyAccountVC.h"
#import "ShareVC.h"
#import "PlaceVC.h"
#import "NSData+Base64.h"
#import "NSData+NSDataAdditions.h"
#import "NSString+NSStringAdditions.h"
#import "PlacelistVC.h"
#import "PlaceFilterVC.h"
#import "FavoriteVC.h"
#import "PlanScheduleVC.h"
#import "FutureDatesVC.h"
#import "CompletedDatesVC.h"

#define Usermane @"admin"
#define Password  @"1234"



#define HeaderColor [UIColor colorWithRed:(251/255.0) green:(49/255.0) blue:(79/255.0) alpha:1.0]
#define flowlayoutBoxColor [UIColor colorWithRed:(69/255.0) green:(57/255.0) blue:(67/255.0) alpha:1.0]
#define HeaderTextColor [UIColor colorWithRed:0.224 green:0.224 blue:0.224 alpha:1]
#define GrayBoxColor [UIColor colorWithRed:0.314 green:0.314 blue:0.314 alpha:1]

#define FONT_NAME @"Lato-Regular"
#ifndef AFNetwork_Define_h
#define AFNetwork_Define_h


#define IS_IPHONE_4                         ([[UIScreen mainScreen] bounds].size.height ==480)?TRUE:FALSE
#define IS_IPHONE_5                         ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define IS_IPHONE_6                         ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define IS_IPHONE_6Plus                     ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE




#pragma Yelp Keys

#define kYelpConsumerKey  @"tTR9sWnV-b-vME5mSBJkIA"
#define kYelpConsumerSecret  @"frCKmJDtx5ticYlbuu1_rjwHO5M"
#define kYelpToken  @"qPsDCzs_zMzVLeOSAfHzaRdnYM40eToC"
#define kYelpTokenSecret  @"EyJvX3OJa3UionNmjgZrNxtq29w"




#define APP_NAME    @"Its a Date"

//LivE URL
//#define Mainurl    @"http://motary.ae/motaryApp/index.php/"

//Testing URL
#define Mainurl  @"http://ec2-52-205-20-98.compute-1.amazonaws.com/date_night_app/index.php/"

//http://ec2-52-205-20-98.compute-1.amazonaws.com/PlaceApp/index.php/select_search_Data

#define ForgotPSWRDUrl   @"forgetPassword"
#define SignUpUrl     @"webservices/user/user_signup/"
#define SignInUrl     @"webservices/user/user_login/"
#define locationUrl @"select_search_Data"
#define locationDetailUrl @"locationDetail"
#define ChangePasswordUrl @"webservices/user/send_otp/"
#define UpdateProfile  @"webservices/user/edit_user_details/"
#define GetCategory    @"webservices/user_product/get_categories/"
#define GetSubCategories    @"webservices/user_product/get_subcategories/"
#define AddToFavourite     @"webservices/user_product/save_product_details/"
#define GetAllDates        @"webservices/all_dates/get_all_dates/"
#define GetFavoriteData     @"webservices/user_product/get_products/"
#define AddPlace @"add_Place"
#define Review @"addReview"
#define AddImages @"add_images"
#define CreateProfileUrl     @"createProfile"
#define VerifyCodeUrl     @"verifyCode"

#define HomeScreenUrl     @"homeScreen"
//#define AddCarUrl     @"addCar"
//#define EditCarUrl    @"editCar"


#define AddCarUrl     @"addCarWithPushNew"
#define AddCarImageUrl     @"UploadCarImage"

#define EditCarUrl    @"editCarWoImage"
#define GetPayment    @"GetPayment"

#define CarLikeUrl    @"carLike"
#define AddFavUrl     @"addFav"
#define FilterData    @"carTablesKeywords"
#define carTableUrl    @"carTables"
#define favCarsUrl     @"favCars"
#define GetSoldCars   @"GetCarHistory"
#define GetUserProfile  @"userProfile"

#define BlockCarUrl  @"blockCar"
#define reportCarUrl  @"reportCar"
#define GetAdminSettingUrl  @"getAdminSetting"
#define getChatPush  @"chatPush"
#define UpdateLocale @"updateLocale"
#define getPlateUrl  @"getPlates"
#define addPlateUrl  @"addPlate"
#define plateLikeUrl  @"PlateLike"




#define NotificationForOpenClose @"NotificationForOpenClose"
#define NotificationForBannerImage @"NotificationForBannerImage"
#define NotificationForAddPlace @"NotificationForAddPlace"
#define NotificationForgotPSWRD  @"NotificationForgotPSWRD"
#define NotificationSignUpInfo   @"NotificationSignUpInfo"
#define NotificationSignInInfo   @"NotificationSignInInfo"
#define NotificationChangePasswordInfo   @"NotificationChangePasswordInfo"
#define NotificationHomeScreenInfo @"NotificationHomeScreenInfo"
#define NotificationLocation @"NotificationLocation"
#define NotificationLocationDetails @"NotificationLocationDetails"
#define NotificationForReview @"NotificationForReview"
#define NotificationForAddImages @"NotificationForAddImages"
#define NotificationGetallCategories  @"NotificationGetallCategories"
#define NotificationGetallSubCategories  @"NotificationGetallSubCategories"
#define NotificationForAddToFavourite  @"NotificationForAddToFavourite"
#define FbDataNotification    @"FbDataNotification"
#define NotificationForGetAllDates  @"NotificationForGetAllDates"
#define NotificationGetFavoriteData @"NotificationGetFavoriteData"

#define NotificationCreateProfileInfo   @"NotificationCreateProfileInfo"
#define NotificationVerifyCodeInfo   @"NotificationVerifyCodeInfo"
#define NotificationGetcar    @"NotificationGetcar"
#define NotificationForAddCar   @"NotificationAddCar"
#define NotificationForAddCarImage   @"NotificationForAddCarImage"
#define NotificationForEditCar   @"NotificationEditCar"
#define NotificationForCarLike   @"NotificationCarLike"
#define NotificationForAddFav   @"NotificationAddFavCar"
#define NotificationCarfilterdata   @"NotificationCarfilterdata"
#define NotificationCarTable    @"NotificationCarTable"

#define NotificationOnFavCarList    @"NotificationOnFavCarList"
#define NotificationForGetSoldCars    @"NotificationGetSoldCars"
#define NotificationForUserProfile    @"NotificationUserProfile"
#define NotificationForUpdateProfile    @"NotificationForUpdateProfile"
#define NotificationForBlockCar    @"NotificationBlockCar"
#define NotificationForReportCar    @"NotificationReportCar"

#define NotificationForAdminSetting    @"NotificationAdminSetting"
#define NotificationForPaymentBackBtnTap    @"NotificationForPaymentBackBtnTap"
#define NotificationForChatPush    @"NotificationForChatPush"


#define NotificationForGetPlate    @"NotificationGetPlate"
#define NotificationForAddPlate    @"NotificationAddPlate"
#define NotificationForUserPlateLike    @"NotificationForPlateLike"
#define NotificationForFavPlate    @"NotificationFavPlate"
#define NotificationForAllFavPlates  @"NotificationAllFavPlates"
#define NotificationForLikePlates    @"NotificationLikePlates"
#define NotificationForReportPlate    @"NotificationReportPlate"
#define NotificationForGetHistory    @"NotificationGetHistory"
#define NotificationForBlockPlate    @"NotificationBlockPlate"
#define NotificationForPlateCategory    @"NotificationPlateCategory"
#define NotificationForGetAllPlateCategory    @"NotificationGetAllPlateCategory"
#define NotificationForGetCity    @"NotificationGetCity"
#define NotificationForUpdateLocale    @"NotificationForUpdateLocale"
#define NotificationForEnableDisablePush    @"NotificationForEnableDisablePush"
#define NotificationForGetPayment    @"NotificationForGetPayment"


#define PushEnable   @"يبدو أن التنبيهات غير مفعلة لتطبيق موتري، من فضلك قم بزيارة ضبط الهاتف اختر مركز الإشعارات واضغط على أيقونة موتري ثم قم بتفعيل الإشعارات"

#define ADUNIT_320x50_ROS @"/188001951/AU-app-320x50-ROS"



#pragma Yelp API


#define HomeVC_SearchAPI_Yelp @"https://api.yelp.com/v3/businesses/"
#define NotificationForHomeVC_SearchAPI_Yelp @"NotificationForHomeVC_SearchAPI_Yelp"
#endif
