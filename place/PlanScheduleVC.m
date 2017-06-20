//
//  PlanScheduleVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 28/03/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "PlanScheduleVC.h"
#import <UserNotifications/UserNotifications.h>
#import "DataBase.h"
#import "Define.h"
#import "MenuVC.h"

#define PickerBG [UIColor colorWithRed:(61.0/255.0) green:(63.0/255.0) blue:(73.0/255.0) alpha:1.0]

@interface PlanScheduleVC ()
{
    NSString *selDate;
    NSString *selTime;
    NSString *fireTime;
    BOOL isLocalNotificationSet;
    
}
@end

@implementation PlanScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [_timepickeroutlet setValue:[UIColor whiteColor] forKey:@"textColor"];
    self.calender = _calender;
    isLocalNotificationSet=NO;
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-yyyy";
    selDate=[dateFormatter stringFromDate:[NSDate date]];
    
    if ([self checkDateFormat12or24hours])
    {
        [dateFormatter setDateFormat:@"HH:mm"];
    }
    else
    {
        [dateFormatter setDateFormat:@"HH:mm a"];
    }
    selTime=[dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"Current Time & Date %@ %@",selTime,selDate);
    _bottomLbl.text=[NSString stringWithFormat:@"%@,%@",selDate,selTime];
     NSLog(@"Data ============= %@",_planDict);
   // [_timepickeroutlet setBackgroundColor:PickerBG];
    
     [_savebtnOutlet setTitle:@"Save" forState:UIControlStateNormal];
    
  
    UIButton *leftarrowclick = [[UIButton alloc] initWithFrame:CGRectMake(40, 10, 50, 50)];
    [leftarrowclick setImage:[UIImage imageNamed:@"leftarrow"] forState:UIControlStateNormal];
   
    [leftarrowclick setTitleShadowColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftarrowclick addTarget:self action:@selector(detectleftscroll) forControlEvents:UIControlEventTouchUpInside];
    

    UIButton *rightarrowclick = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 10, 50, 50)];
    
    [rightarrowclick setImage:[UIImage imageNamed:@"rightarrow"] forState:UIControlStateNormal];
    [rightarrowclick setTitleShadowColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightarrowclick addTarget:self action:@selector(detectrightscroll) forControlEvents:UIControlEventTouchUpInside];
    [_calender addSubview:leftarrowclick];
    [_calender addSubview:rightarrowclick];
   // [_calender bringSubviewToFront:leftarrowclick];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




-(BOOL)checkDateFormat12or24hours
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24h = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
    NSLog(@"%@\n",(is24h ? @"YES" : @"NO"));
    return is24h;
}

- (IBAction)bckBtnTap:(id)sender
{
     
    // [self.viewDeckController toggleLeftViewAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    selDate=nil;

   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";

    NSLog(@"did select date %@",[dateFormatter stringFromDate:date]);
    _bottomLbl.text=[NSString stringWithFormat:@"%@,%@",selTime,[dateFormatter stringFromDate:date]];
    selDate=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    
    
    dateFormatter.dateFormat = @"MM-dd-yyyy";
    NSString *seldat=[dateFormatter stringFromDate:date];
    _bottomLbl.text = [NSString stringWithFormat:@"%@,%@",seldat,selTime ];
}



-(IBAction)pkrValueChange:(UIDatePicker*)sender{
    
    selTime=nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   // dateFormatter.dateFormat = @"dd/MMM/yyyy";
    if ([self checkDateFormat12or24hours])
    {
       [dateFormatter setDateFormat:@"HH:mm"];
    }
    else
    {
     [dateFormatter setDateFormat:@"HH:mm a"];
    }
    NSLog(@"Slected Time %@",[dateFormatter stringFromDate:sender.date]);
    
    
    selTime=[dateFormatter stringFromDate:sender.date];
    
     [dateFormatter setDateFormat:@"hh:mm:ss a"];
    fireTime=[NSString stringWithFormat:@"%@ %@",selDate,[dateFormatter stringFromDate:sender.date]];
    
     dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date=[dateFormatter dateFromString:selDate];
    dateFormatter.dateFormat = @"MM-dd-yyyy";
    NSString *seldat=[dateFormatter stringFromDate:date];
    if (seldat==nil)
    {
        _bottomLbl.text = [NSString stringWithFormat:@"%@,%@",selDate,selTime];
    }
    else
    {
       _bottomLbl.text = [NSString stringWithFormat:@"%@,%@",seldat,selTime];
    }
    
   
    
    
    
    
}



- (IBAction)planascheduleBtnTap:(id)sender
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to schedule this plan"
                                                        message:nil delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Yes",@"No",nil];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
       
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss a";
        //2017-03-28 13:00:22 +0000
        
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"request succeeded!");
                                      
                                      [self setLocalNotification];
                                      
                                  }
                              }];
        
    }
    else if (buttonIndex == 1)
    {
        [alertView dismissWithClickedButtonIndex:1 animated:TRUE];
    }
}


-(void)setLocalNotification
{
    NSArray *adress=[[_planDict valueForKey:@"location"] valueForKey:@"display_address"];
    NSString *address    = [adress componentsJoinedByString:@","] ;
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"EEEE"];
    NSLog(@"%@", [dateFormatter1 stringFromDate:[NSDate date]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss a";
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitTimeZone fromDate:[dateFormatter dateFromString:fireTime]];
    NSLog(@"%@",[[NSDate date] dateByAddingTimeInterval:15]);
    UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
    objNotificationContent.title = [NSString localizedUserNotificationStringForKey:@"Scheduled Plan!" arguments:nil];
    objNotificationContent.subtitle=[NSString localizedUserNotificationStringForKey:[_planDict valueForKey:@"name"] arguments:nil];
    objNotificationContent.body = [NSString localizedUserNotificationStringForKey:[_planDict valueForKey:@"snippet_text"] arguments:nil];
    objNotificationContent.categoryIdentifier=[NSString localizedUserNotificationStringForKey:@"prayer1"
                                                                                    arguments:nil];
    objNotificationContent.launchImageName=[NSString localizedUserNotificationStringForKey:@"a.jpeg"
                                                                                 arguments:nil];
    objNotificationContent.badge=@([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);//[NSNumber numberWithInt:1];
    objNotificationContent.sound = [UNNotificationSound defaultSound];
    NSMutableDictionary* notiDict=[[NSMutableDictionary alloc] init];
    [notiDict setObject:@"hi" forKey:@"a"];
    [notiDict setObject:@"hello" forKey:@"b"];
    [notiDict setObject:@"hbye" forKey:@"c"];
    objNotificationContent.userInfo=_planDict;
    
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Prayer"
                                                                          content:objNotificationContent trigger:trigger];
    UNUserNotificationCenter *userCenter = [UNUserNotificationCenter currentNotificationCenter];
    [userCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            
            NSLog(@"Local Notification succeeded");

            //            SchedulePlan *splan;
//            Favorite *fav;

            NSArray *adress=[[_planDict valueForKey:@"location"] valueForKey:@"display_address"];
            NSString *address    = [adress componentsJoinedByString:@","] ;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEEE"];
            NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
            
            isLocalNotificationSet=YES;
            
            if ([_fromScrn isEqualToString:@"favorite"])
            {
              [[DataBase sharedChatTableClass] insertScheduledPlansWithPlaceId:_fav.placeid Rating:[NSString stringWithFormat:@"%@",_fav.rating] ImageUrl:_fav.imageurl IsScheduled:@"yes" DateName:_fav.datename DescriptionText:_fav.descriptiontext Day:[dateFormatter stringFromDate:[NSDate date]] Address:_fav.address UserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"] PhoneNumber:[NSString stringWithFormat:@"%@",_fav.phonenumber] ReviewCount:[NSString stringWithFormat:@"%@",_fav.reviewcount] locationLat:[NSString stringWithFormat:@"%@",_fav.locationlat] locationLong:[NSString stringWithFormat:@"%@",_fav.locationlong] PlanDate:selDate PlanTime:selTime PlanDateTime:fireTime OpenCloseTime:[NSString stringWithFormat:@"%@",_fav.openingclosing] WebsiteUrls:_fav.websiteurl];
            }
            else if  ([_fromScrn isEqualToString:@"future"])
            {
                
            }
            else if  ([_fromScrn isEqualToString:@"completed"])
            {
                
            }
            else
            {

            [[DataBase sharedChatTableClass] insertScheduledPlansWithPlaceId:[_planDict valueForKey:@"id"] Rating:[NSString stringWithFormat:@"%@",[_planDict valueForKey:@"rating"]] ImageUrl:[_planDict valueForKey:@"image_url"] IsScheduled:@"yes" DateName:[_planDict valueForKey:@"name"] DescriptionText:[_planDict valueForKey:@"snippet_text"] Day:[dateFormatter stringFromDate:[NSDate date]] Address:address UserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"] PhoneNumber:[NSString stringWithFormat:@"%@",[_planDict valueForKey:@"display_phone"]] ReviewCount:[NSString stringWithFormat:@"%@",[_planDict valueForKey:@"review_count"]] locationLat:[NSString stringWithFormat:@"%@",[[[_planDict valueForKey:@"location"] valueForKey:@"coordinate"] valueForKey:@"latitude"]] locationLong:[NSString stringWithFormat:@"%@",[[[_planDict valueForKey:@"location"] valueForKey:@"coordinate"] valueForKey:@"longitude"]] PlanDate:selDate PlanTime:selTime PlanDateTime:fireTime OpenCloseTime:[NSString stringWithFormat:@"%@",[_planDict valueForKey:@"is_closed"]] WebsiteUrls:[_planDict valueForKey:@"url"]];
            

             }
            
        }
        else {
            
            NSLog(@"Local Notification failed");
            
        }
    }];

}




- (IBAction)shareDateBtnTap:(id)sender
{
    if (isLocalNotificationSet==YES)
    {
       [self shareOptions];
    }
    else
    {
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Set a Plan First"  cancelButtonTitle:@"ok" otherButtonTitles: nil];
    }
    
}

-(void)shareOptions
{
    NSString *textToShare;
    NSURL *myWebsite;
    
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"myScheme://"]];
//    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ItsaDate://"]]){
//        // Means your app is installed, and it can be open
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ItsaDate://"]];
//    }
//    else{
//        //Your app is not installed so, Open app store with your apps iTunes Url
//        NSString *iTunesUrlofApp = @"itms://itunes.apple.com/us/app/apple-store/...";
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesUrlofApp]];
//        
//    }
    
    
    textToShare =[NSString stringWithFormat:@"%@ wants to share Future date %@",[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"name"],_placename];
    
    NSURL* url = [NSURL URLWithString:[@"http://ItsaDate%3A//"stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    myWebsite = url;
    
    
    NSArray *activity =@[textToShare,myWebsite];
    UIActivityViewController *activityController = [[UIActivityViewController alloc]initWithActivityItems:activity applicationActivities:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
    
    
   // typedef void (^UIActivityViewControllerCompletionWithItemsHandler)(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError);
    
    [activityController setCompletionWithItemsHandler:
     ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError)
     
     {
        
        NSLog(@"Activity Type: %@,Return Items: %@,Activity Type: %@",activityType,returnedItems,activityError);
     }];
    
    

    NSArray *excludeActivities =@[UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo];
    activityController.excludedActivityTypes = excludeActivities;
    activityController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:activityController animated:YES completion:nil];
      
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityController];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, _shareviewOutlet.frame.origin.y+_shareviewOutlet.frame.size.height, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

}

-(void)detectleftscroll
{
   // NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentMonth = self.calender.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calender setCurrentPage:previousMonth animated:YES];
 
}
-(void)detectrightscroll
{
    NSDate *currentMonth = self.calender.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calender setCurrentPage:nextMonth animated:YES];
 
}

@end
