//
//  AppDelegate.h
//  place
//
//  Created by Yatharth Singh on 04/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>
#import <UserNotifications/UserNotifications.h>
@class YLPClient;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UNUserNotificationCenterDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) UIWindow *window;




+ (AppDelegate*) getAppDelegate;
- (BOOL) checkInternateConnection;
@property (nonatomic,strong)UINavigationController *navigationController;
-(void)alert:(NSString*)alertTitle message:(NSString*)alertMessage cancelButtonTitle:(NSString*)cnclTitle otherButtonTitles:(NSString*)othrTitle;

@end

