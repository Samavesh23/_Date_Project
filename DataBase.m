//
//  DataBase.m
//  Pavi
//
//  Created by Yatharth Singh on 18/12/15.
//  Copyright © 2015 fourthscreen. All rights reserved.
//

#import "DataBase.h"
#import "AppDelegate.h"
@implementation DataBase


- (id)init
{
    self = [super init];
    if (self)
    {
        managedObjectContext=[[AppDelegate getAppDelegate] managedObjectContext];
    }
    
    return self;
}

+ (DataBase *) sharedChatTableClass
{
    static DataBase* singleton;
    
    if (!singleton)
    {
        singleton = [[DataBase alloc] init];
        
    }
    return singleton;
}

-(BOOL)insertFavoriteWithPlaceId:(NSString *)PlaceId WebsiteUrl:(NSString *)websiteurl Rating:(NSString *)rating OpeningClosing:(NSString *)openingclosing ImageUrl:(NSString *)imageurl Favorite:(NSString *)favorite DateName:(NSString *)datename DescriptionText:(NSString *)descriptiontext Day:(NSString *)day Address:(NSString *)address UserId:(NSString *)userid PhoneNumber:(NSString *)phonenumber ReviewCount:(NSString *)reviewcount locationLat:(NSString*)latitude locationLong:(NSString*)longitude

{
    BOOL status=YES;
    Favorite *tag=nil;
    if (PlaceId)
    {
        tag=[self getTagByPlaceId:PlaceId];
    }
    
    if(tag==nil)
    {
        tag=[NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:managedObjectContext];
    
    if(PlaceId)
    {
        tag.placeid=PlaceId;
    }
    if (websiteurl)
    {
        tag.websiteurl=websiteurl;
    }
    if (imageurl)
    {
        tag.imageurl=imageurl;
    }
    if (rating)
    {
        tag.rating=rating;
    }
    if (openingclosing)
    {
        tag.openingclosing=openingclosing;
    }
    if (favorite)
    {
        tag.isfavorite=favorite;
    }
    if (descriptiontext)
    {
        tag.descriptiontext=descriptiontext;
    }
    if (day)
    {
        tag.day=day;
    }
    if (datename)
    {
        tag.datename=datename;
    }
    if (address)
    {
        tag.address=address;
    }
    if (userid)
    {
        tag.userid=userid;
    }
    if (phonenumber)
    {
        tag.phonenumber=phonenumber;
    }
    if (reviewcount)
    {
        tag.reviewcount=reviewcount;
    }
    if (latitude)
    {
            tag.locationlat=latitude;
    }
    if (longitude)
    {
            tag.locationlong=longitude;
    }
    }
    NSLog(@"%@",tag);
    NSError *error;
    if (![managedObjectContext save:&error])
    {
        status = NO;
    }
    return status;
}


-(Favorite *)getTagByPlaceId:(NSString *)PlaceId
{
    NSFetchRequest *request = [self getBasicRequestForEntityName:@"Favorite"];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"placeid==%@",PlaceId];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    Favorite *tag=nil;
    if (!error && [results count] > 0)
    {
        tag = [results objectAtIndex:0];
    }
    return tag;
}

-(NSFetchRequest*)getBasicRequestForEntityName:(NSString *)entityName

{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    return request;
}

-(NSArray*)getTagByUserId:(NSString *)UserId
{
    NSFetchRequest *request = [self getBasicRequestForEntityName:@"Favorite"];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid==%@",UserId];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    Favorite *tag=nil;
    if (!error && [results count] > 0)
    {
        tag = [results objectAtIndex:0];
    }
    return results;
}

- (void) deletefavoriteWithEntityName:(NSString *)entityName AndPlaceId:(NSString *)placeid;
{
    NSFetchRequest * allRecords = [[NSFetchRequest alloc] init];
    [allRecords setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    [allRecords setPredicate:[NSPredicate predicateWithFormat:@"placeid==%@",placeid]];
    [allRecords setIncludesPropertyValues:NO];
    NSError * error = nil;
    NSArray * result = [managedObjectContext executeFetchRequest:allRecords error:&error];
    for (NSManagedObject * favCat in result)
    {
        
        [managedObjectContext deleteObject:favCat];
    }
    NSError *saveError = nil;
    [managedObjectContext save:&saveError];
}

-(BOOL)insertScheduledPlansWithPlaceId:(NSString *)PlaceId Rating:(NSString *)rating ImageUrl:(NSString *)imageurl IsScheduled:(NSString *)isscheduled DateName:(NSString *)datename DescriptionText:(NSString *)descriptiontext Day:(NSString *)day Address:(NSString *)address UserId:(NSString *)userid PhoneNumber:(NSString *)phonenumber ReviewCount:(NSString *)reviewcount locationLat:(NSString *)latitude locationLong:(NSString *)longitude PlanDate:(NSString *)plandate PlanTime:(NSString *)plantime PlanDateTime:(NSString *)plandatetime OpenCloseTime:(NSString *)openclosetime WebsiteUrls:(NSString *)websiteurls
{
    BOOL status=YES;
    SchedulePlan *tag=nil;
    if (PlaceId)
    {
        tag=[self getTagsByPlaceId:PlaceId];
    }
    if(tag==nil)
    {
        tag=[NSEntityDescription insertNewObjectForEntityForName:@"SchedulePlan" inManagedObjectContext:managedObjectContext];
        if(PlaceId)
        {
            tag.placeids=PlaceId;
        }
        if (imageurl)
        {
            tag.imageurls=imageurl;
        }
        if (rating)
        {
            tag.ratings=rating;
        }
        if (isscheduled)
        {
            tag.isscheduleds=isscheduled;
        }
        if (descriptiontext)
        {
            tag.descriptiontexts=descriptiontext;
        }
        if (day)
        {
            tag.days=day;
        }
        if (datename)
        {
            tag.datenames=datename;
        }
        if (address)
        {
            tag.addresss=address;
        }
        if (userid)
        {
            tag.userids=userid;
        }
        if (phonenumber)
        {
            tag.phnnumbers=phonenumber;
        }
        if (reviewcount)
        {
            tag.reviewcounts=reviewcount;
        }
        if (latitude)
        {
            tag.loclats=latitude;
        }
        if (longitude)
        {
            tag.loclongs=longitude;
        }
        if (plandate)
        {
            tag.plandate=plandate;
        }
        if (plantime)
        {
            tag.plantime=plantime;
        }
        if (plandatetime)
        {
            tag.plandatetime=plandatetime;
        }
        if (websiteurls)
        {
            tag.websiteurls=websiteurls;
        }
        if (openclosetime)
        {
            tag.openclosetime=openclosetime;
        }
    }
    NSLog(@"%@",tag);
    NSError *error;
    if (![managedObjectContext save:&error])
    {
        status = NO;
    }
    return status;
}

-(SchedulePlan *)getTagsByPlaceId:(NSString *)PlaceId
{
    NSFetchRequest *request = [self getBasicRequestForEntityName:@"SchedulePlan"];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"placeids==%@",PlaceId];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    SchedulePlan *tag=nil;
    if (!error && [results count] > 0)
    {
        tag = [results objectAtIndex:0];
    }
    return tag;
}

-(NSArray*)getdataByUserId:(NSString *)UserId
{
    NSFetchRequest *request = [self getBasicRequestForEntityName:@"SchedulePlan"];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userids==%@",UserId];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    SchedulePlan *tag=nil;
    if (!error && [results count] > 0)
    {
        tag = [results objectAtIndex:0];
    }
    return results;
}
- (void) deleteScheduledPlanWithEntityName:(NSString *)entityName  AndPlaceId:(NSString *)placeid
{
    NSFetchRequest * allRecords = [[NSFetchRequest alloc] init];
    [allRecords setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    [allRecords setPredicate:[NSPredicate predicateWithFormat:@"placeids==%@",placeid]];
    [allRecords setIncludesPropertyValues:NO];
    NSError * error = nil;
    NSArray * result = [managedObjectContext executeFetchRequest:allRecords error:&error];
    for (NSManagedObject * favCat in result)
    {
        [managedObjectContext deleteObject:favCat];
    }
    NSError *saveError = nil;
    [managedObjectContext save:&saveError];
}


@end
