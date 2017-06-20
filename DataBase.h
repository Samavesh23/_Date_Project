//
//  DataBase.h
//  Pavi
//
//  Created by Yatharth Singh on 18/12/15.
//  Copyright © 2015 fourthscreen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Favorite+CoreDataClass.h"
#import "SchedulePlan+CoreDataClass.h"

@interface DataBase : NSObject
{
    NSManagedObjectContext *managedObjectContext;
}

+(DataBase *) sharedChatTableClass;
-(BOOL)insertFavoriteWithPlaceId:(NSString *)PlaceId WebsiteUrl:(NSString*)websiteurl Rating:(NSString*)rating OpeningClosing:(NSString*)openingclosing ImageUrl:(NSString*)imageurl Favorite:(NSString*)favorite DateName:(NSString*)datename DescriptionText:(NSString*)descriptiontext Day:(NSString*) day Address:(NSString*)address UserId:(NSString *)userid PhoneNumber:(NSString*)phonenumber ReviewCount:(NSString *)reviewcount locationLat:(NSString*)latitude locationLong:(NSString*)longitude;
-(Favorite *)getTagByPlaceId:(NSString *)PlaceId;
-(NSArray *)getTagByUserId:(NSString *)UserId;
- (void) deletefavoriteWithEntityName:(NSString *)entityName  AndPlaceId:(NSString *)placeid;
-(BOOL)insertScheduledPlansWithPlaceId:(NSString *)PlaceId Rating:(NSString*)rating  ImageUrl:(NSString*)imageurl IsScheduled:(NSString*)isscheduled DateName:(NSString*)datename DescriptionText:(NSString*)descriptiontext Day:(NSString*) day Address:(NSString*)address UserId:(NSString *)userid PhoneNumber:(NSString*)phonenumber ReviewCount:(NSString *)reviewcount locationLat:(NSString*)latitude locationLong:(NSString*)longitude PlanDate:(NSString*)plandate PlanTime:(NSString*)plantime PlanDateTime :(NSString*)plandatetime OpenCloseTime:(NSString *)openclosetime WebsiteUrls:(NSString *)websiteurls;
-(SchedulePlan *)getTagsByPlaceId:(NSString *)PlaceId;
-(NSArray*)getdataByUserId:(NSString *)UserId;
- (void) deleteScheduledPlanWithEntityName:(NSString *)entityName  AndPlaceId:(NSString *)placeid;

@end
