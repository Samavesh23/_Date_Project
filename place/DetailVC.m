 //
//  DetailVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 01/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "DetailVC.h"
#import "DataBase.h"
#import "WebsiteVC.h"
#import "PlanScheduleVC.h"
#import "Define.h"

@interface DetailVC ()
@property (nonatomic, strong) YLPClient  *client;
@end

@implementation DetailVC
{
    NSString *isFav;
    NSString *businessID;
    SchedulePlan *splan;
    Favorite *fav;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    NSLog(@"DATA ========= %@",_catDetail);
    
    
    _addView1.adUnitID = ADUNIT_320x50_ROS;
    self.addView1.rootViewController = self;
    [self.addView1 loadRequest:[DFPRequest request]];
   
    
    
    
    self.reviewTV.rowHeight = UITableViewAutomaticDimension;
    self.reviewTV.estimatedRowHeight = 99.0; //
    
    
   
    
    [self setdata:_catDetail];
    
    
    
    
    
    

    
    
    
    
    
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

-(void)setdata:(NSMutableDictionary *)data
{

    UIImageView *favHeartImg=(UIImageView*)[self.view viewWithTag:5];
    NSString *rating;
    NSArray *arr;
     NSMutableArray *array=[[NSMutableArray alloc]init];
//     SchedulePlan *splan;
//     Favorite *fav;
    
    
    if ([_fromDB isEqualToString:@"future"])
    {
       arr=[[[DataBase sharedChatTableClass]getdataByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
       
        
        if (arr.count>0)
        {
            splan=[arr objectAtIndex:_indx.row];
            for (NSDictionary *dict in arr)
            {
                if ([[dict valueForKey:@"placeids"]isEqualToString:splan.placeids])
                {
                    [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
                    isFav=@"yes";
                }
                else
                {
                    [favHeartImg setImage:[UIImage imageNamed:@"favourite"]];
                    isFav=@"no";
                }
                
            }
            
        }
        else
        {
            isFav=@"no";
        }

       
        NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%@,%@&%@&sensor=true",splan.loclats, splan.loclongs,@"zoom=10&size=375x200"];
        NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
        _mapImageView.image=image;
         businessID=splan.placeids;
        rating=splan.ratings;
        _addressLbl.text=splan.addresss;
        _daysLbl.text=splan.days;
                    if ([splan.openclosetime isEqualToString:@"0"])
                    {
                        _timeLbl.text=@"Open";
                    }
                    else
                    {
                        _timeLbl.text=@"Closed";
                    }
        
        _phnNoLbl.text=[NSString stringWithFormat:@"phone %@",splan.phnnumbers];
        _reviewCountLbl.text=[NSString stringWithFormat:@"%@ Reviews",splan.reviewcounts];
        [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
        isFav=@"yes";
        _ratingLbl.text=rating;
        _datenameLbl.text=splan.datenames;

    }
    else if ([_fromDB isEqualToString:@"completed"])
    {
        arr=[[[DataBase sharedChatTableClass]getdataByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
       
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss a";
        NSString *cDate=[dateFormatter stringFromDate:[NSDate date]];
        for (SchedulePlan *splan in arr)
        {
            if ([splan.plandatetime compare:cDate] == NSOrderedDescending)
            {
                NSLog(@"date1 is later than date2");
            } else if ([splan.plandatetime compare:cDate] == NSOrderedAscending)
            {
                NSLog(@"date1 is earlier than date2");
                [array addObject:splan];
               
                
            } else
            {
                NSLog(@"dates are the same");
            }
        }
           splan=[array objectAtIndex:_indx.row];
        
        if (array.count>0)
        {
            for (NSDictionary *dict in array)
            {
                if ([[dict valueForKey:@"placeids"]isEqualToString:splan.placeids])
                {
                    [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
                    isFav=@"yes";
                }
                else
                {
                    [favHeartImg setImage:[UIImage imageNamed:@"favourite"]];
                    isFav=@"no";
                }
                
            }
            
        }
        else
        {
            isFav=@"no";
        }
        

        NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%@,%@&%@&sensor=true",splan.loclats, splan.loclongs,@"zoom=10&size=375x200"];
        NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
        _mapImageView.image=image;
         businessID=splan.placeids;
        
        rating=splan.ratings;
        _addressLbl.text=splan.addresss;
        _daysLbl.text=splan.days;
                    if ([splan.openclosetime isEqualToString:@"0"])
                    {
                        _timeLbl.text=@"Open";
                    }
                    else
                    {
                        _timeLbl.text=@"Closed";
                    }
        
        _phnNoLbl.text=[NSString stringWithFormat:@"phone %@",splan.phnnumbers];
        _reviewCountLbl.text=[NSString stringWithFormat:@"%@ Reviews",splan.reviewcounts];
        [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
        isFav=@"yes";
        _ratingLbl.text=rating;
        _datenameLbl.text=splan.datenames;
    }
    else if ([_fromDB isEqualToString:@"favorite"])
    {
        arr=[[[DataBase sharedChatTableClass]getTagByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
        
        
        
        if (arr.count>0)
        {
             fav=[arr objectAtIndex:_indx.row];
            for (NSDictionary *dict in arr)
            {
                if ([[dict valueForKey:@"placeid"]isEqualToString:fav.placeid])
                {
                    [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
                    isFav=@"yes";
                }
                else
                {
                    [favHeartImg setImage:[UIImage imageNamed:@"favourite"]];
                    isFav=@"no";
                }
                
            }
           
        }
        else
        {
            isFav=@"no";
        }

        NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%@,%@&%@&sensor=true",fav.locationlat, fav.locationlong,@"zoom=10&size=375x200"];
        NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
        _mapImageView.image=image;
        businessID=fav.placeid;
        rating=fav.rating;
        _addressLbl.text=fav.address;
        _daysLbl.text=fav.day;
                    if ([fav.openingclosing isEqualToString:@"0"])
                    {
                        _timeLbl.text=@"Open";
                    }
                    else
                    {
                        _timeLbl.text=@"Closed";
                    }
        
        _phnNoLbl.text=[NSString stringWithFormat:@"phone %@",fav.phonenumber];
        _reviewCountLbl.text=[NSString stringWithFormat:@"%@ Reviews",fav.reviewcount];
        [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
        isFav=@"yes";
        _ratingLbl.text=rating;
        _datenameLbl.text=fav.datename;
    }
    else
    {
         businessID=[_catDetail valueForKey:@"id"];
        arr=[[[DataBase sharedChatTableClass]getTagByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
        if (arr.count>0)
        {
            for (NSDictionary *dict in arr)
            {
                if ([[dict valueForKey:@"placeid"]isEqualToString:[_catDetail valueForKey:@"id"]])
                {
                    [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
                    isFav=@"yes";
                }
                else
                {
                    [favHeartImg setImage:[UIImage imageNamed:@"favourite"]];
                    isFav=@"no";
                }
                
            }
        }
        else
        {
            isFav=@"no";
        }
        
        
        rating=[NSString stringWithFormat:@"%@",[data valueForKey:@"rating"]];
        NSArray *adress=[[data valueForKey:@"location"] valueForKey:@"display_address"];
        _addressLbl.text    = [adress componentsJoinedByString:@","] ;
        _ratingLbl.text=rating;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
        _daysLbl.text=[dateFormatter stringFromDate:[NSDate date]];
        if ([[data objectForKey:@"is_closed"]boolValue]==0)
        {
            _timeLbl.text=@"Open";
        }
        else
        {
            _timeLbl.text=@"Closed";
        }
        _phnNoLbl.text=[NSString stringWithFormat:@"phone %@",[data valueForKey:@"display_phone"]];
        _reviewCountLbl.text=[NSString stringWithFormat:@"%@ Reviews",[data valueForKey:@"review_count"]];
        _datenameLbl.text=[_catDetail valueForKey:@"name"];
        
        float yourLatitude=[[[[_catDetail valueForKey:@"location"] valueForKey:@"coordinate"] valueForKey:@"latitude"]floatValue];
        
        float yourLongitude=[[[[_catDetail valueForKey:@"location"] valueForKey:@"coordinate"] valueForKey:@"longitude"]floatValue];
        
        NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@&sensor=true",yourLatitude, yourLongitude,@"zoom=10&size=375x200"];
        NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
        _mapImageView.image=image;
        
        

    }
    
    
    [self getBusinessDetailsbyID];
    if ([rating isEqualToString:@"1"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"1.5"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"Whitehalfstar"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"2"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"2.5"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"Whitehalfstar"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"3"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"whitestar"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"3.5"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"Whitehalfstar"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"4"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"whitestar"]];
    }
    
    else if ([rating isEqualToString:@"4.5"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"Whitehalfstar"]];
    }
    else if ([rating isEqualToString:@"5"])
    {
        [_staroneImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star2ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star3ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star4ImgView setImage:[UIImage imageNamed:@"staryellow"]];
        [_star5ImgView setImage:[UIImage imageNamed:@"staryellow"]];
    }
    
    
    
}


- (IBAction)bckBtntap:(id)sender
{
    
    
    NSString *itemToPassBack = @"Pass this value back to ViewControllerA";
    [self.delegate addItemViewController:self didFinishEnteringItem:itemToPassBack];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)favBtnatp:(id)sender
{
      UIImageView *favHeartImg=(UIImageView*)[self.view viewWithTag:5];
   
    NSArray *adress=[[_catDetail valueForKey:@"location"] valueForKey:@"display_address"];
    NSString *address    = [adress componentsJoinedByString:@","] ;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    NSArray *arr;
    NSMutableArray *array=[[NSMutableArray alloc]init];
   
    
    

              [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
              if ([_fromDB isEqualToString:@"future"])
              {
                  arr=[[[DataBase sharedChatTableClass]getdataByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
                  
                  
                  if (arr.count>0)
                  {
                      splan=[arr objectAtIndex:_indx.row];
                      
                      
                  }
                  
                  
                [[DataBase sharedChatTableClass]insertFavoriteWithPlaceId:splan.placeids WebsiteUrl:splan.websiteurls Rating:splan.ratings OpeningClosing:splan.websiteurls ImageUrl:splan.imageurls Favorite:@"1" DateName:splan.datenames DescriptionText:splan.descriptiontexts Day: splan.days Address:splan.addresss UserId:splan.userids PhoneNumber:splan.phnnumbers ReviewCount:splan.reviewcounts locationLat:splan.loclats locationLong:splan.loclongs];
                  
                  
              }
              else if ([_fromDB isEqualToString:@"completed"])
              {
                  arr=[[[DataBase sharedChatTableClass]getdataByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
                  
                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                  dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss a";
                  NSString *cDate=[dateFormatter stringFromDate:[NSDate date]];
                  for (SchedulePlan *splan in arr)
                  {
                      if ([splan.plandatetime compare:cDate] == NSOrderedDescending)
                      {
                          NSLog(@"date1 is later than date2");
                      } else if ([splan.plandatetime compare:cDate] == NSOrderedAscending)
                      {
                          NSLog(@"date1 is earlier than date2");
                          [array addObject:splan];
                          
                          
                      } else
                      {
                          NSLog(@"dates are the same");
                      }
                  }
                  splan=[array objectAtIndex:_indx.row];
                  
                  [[DataBase sharedChatTableClass]insertFavoriteWithPlaceId:splan.placeids WebsiteUrl:splan.websiteurls Rating:splan.ratings OpeningClosing:splan.websiteurls ImageUrl:splan.imageurls Favorite:@"1" DateName:splan.datenames DescriptionText:splan.descriptiontexts Day: splan.days Address:splan.addresss UserId:splan.userids PhoneNumber:splan.phnnumbers ReviewCount:splan.reviewcounts locationLat:splan.loclats locationLong:splan.loclongs];
                  
              }
              else if ([_fromDB isEqualToString:@"favorite"])
              {
                  
                  NSString *placeID;
                  arr=[[[DataBase sharedChatTableClass]getTagByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
                  
                  
                  
                  if (arr.count>0)
                  {
                      fav=[arr objectAtIndex:_indx.row];
                      
                      
                  }
//                  if ([_fromDB isEqualToString:@"favorite"])
//                  {
//                      placeID=fav.placeid;
//                  }
//                  else
//                  {
//                      placeID=[_catDetail valueForKey:@"id"];
//                  }
                  if ([isFav isEqualToString:@"yes"])
                  {
                      
                      [[DataBase sharedChatTableClass] deletefavoriteWithEntityName:@"Favorite" AndPlaceId:fav.placeid];
                      [favHeartImg setImage:[UIImage imageNamed:@"favourite"]];
                      isFav=@"no";
                  }
                  else
                  {
                  
                  arr=[[[DataBase sharedChatTableClass]getTagByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
                  
                  
                  
                  if (arr.count>0)
                  {
                      fav=[arr objectAtIndex:_indx.row];
                      
                      
                  }
                  
                  [[DataBase sharedChatTableClass]insertFavoriteWithPlaceId:fav.placeid WebsiteUrl:fav.websiteurl Rating:fav.rating OpeningClosing:fav.websiteurl ImageUrl:fav.imageurl Favorite:@"1" DateName:fav.datename DescriptionText:fav.descriptiontext Day: fav.day Address:fav.address UserId:fav.userid PhoneNumber:fav.phonenumber ReviewCount:fav.reviewcount locationLat:fav.locationlat locationLong:fav.locationlong];
                  }
                  
              }
              else
              {
                  
                  arr=[[[DataBase sharedChatTableClass]getTagByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
                  
                  if (arr.count>0)
                  {
                      fav=[arr objectAtIndex:_indx.row];
//                      for (NSDictionary *dict in arr)
//                      {
//                          if ([[dict valueForKey:@"placeid"]isEqualToString:fav.placeid])
//                          {
//                             // [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
//                              isFav=@"yes";
//                          }
//                          else
//                          {
//                             // [favHeartImg setImage:[UIImage imageNamed:@"favourite"]];
//                              isFav=@"no";
//                          }
//                          
//                      }
                      
                  }
                 // isFav=fav.isfavorite;
                  
                  if ([isFav isEqualToString:@"yes"])
                  {
                      
                      [[DataBase sharedChatTableClass] deletefavoriteWithEntityName:@"Favorite" AndPlaceId:[_catDetail valueForKey:@"id"]];
                       [favHeartImg setImage:[UIImage imageNamed:@"favourite"]];
                     
                     
                      isFav=@"no";
                  }
                  else
                  {
              [[DataBase sharedChatTableClass]insertFavoriteWithPlaceId:_catDetail[@"id"] WebsiteUrl:_catDetail[@"url"] Rating:[NSString stringWithFormat:@"%@",[_catDetail valueForKey:@"rating"]] OpeningClosing:[NSString stringWithFormat:@"%@",[_catDetail valueForKey:@"is_closed"]] ImageUrl:_catDetail[@"image_url"] Favorite:@"yes" DateName:_catDetail[@"name"] DescriptionText:_catDetail[@"snippet_text"] Day: [dateFormatter stringFromDate:[NSDate date]] Address:address UserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"] PhoneNumber:[NSString stringWithFormat:@"%@",[_catDetail valueForKey:@"display_phone"]] ReviewCount:[NSString stringWithFormat:@"%@",[_catDetail valueForKey:@"review_count"]] locationLat:[NSString stringWithFormat:@"%@",[[[_catDetail valueForKey:@"location"] valueForKey:@"coordinate"] valueForKey:@"latitude"]] locationLong:[NSString stringWithFormat:@"%@",[[[_catDetail valueForKey:@"location"] valueForKey:@"coordinate"] valueForKey:@"longitude"]]];
                       isFav=@"yes";
                    [favHeartImg setImage:[UIImage imageNamed:@"activeheart"]];
                  }
              }
            
    
    
}

-(void)getresponseonhitforAddToFavorite:(NSNotification *)notySignIn
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationForAddToFavourite object:nil ];
    
     [AppHelper hideActivityIndicator:self.view];
    if([[[notySignIn userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
    
    }
    else
    {
        
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignIn userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _businessReviewsArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
   
    UILabel *NameLbl=(UILabel*)[cell viewWithTag:1];
    UILabel *textLbl=(UILabel*)[cell viewWithTag:2];
   
    UIImageView *star1=(UIImageView *)[cell viewWithTag:7];
    UIImageView *star2=(UIImageView *)[cell viewWithTag:8];
    UIImageView *star3=(UIImageView *)[cell viewWithTag:9];
    UIImageView *star4=(UIImageView *)[cell viewWithTag:10];
    UIImageView *star5=(UIImageView *)[cell viewWithTag:11];
    UIImageView *placeImgView=(UIImageView *)[cell viewWithTag:12];
     UILabel *ratingLbl=(UILabel*)[cell viewWithTag:13];
    NSString *Oimage;
    NSString *rating;
    
    
    
    
   // rating=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[_businessReviewsArray objectAtIndex:indexPath.row]valueForKey:@"rating"]]];
                NameLbl.hidden=NO;
                Oimage=[[_businessReviewsArray objectAtIndex:indexPath.row]valueForKey:@"image"];
                NameLbl.text    = [[_businessReviewsArray objectAtIndex:indexPath.row]valueForKey:@"name"];
                
                rating=[[_businessReviewsArray objectAtIndex:indexPath.row]valueForKey:@"rating"];
                textLbl.text    =[[_businessReviewsArray objectAtIndex:indexPath.row]valueForKey:@"reviewtext"];
                ratingLbl.text=[[_businessReviewsArray objectAtIndex:indexPath.row]valueForKey:@"rating"];
    
   
   // Oimage= [Oimage stringByReplacingOccurrencesOfString:@"ms" withString:@"o"];
    NSURL *url = [NSURL URLWithString:Oimage]  ;
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                               cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                           timeoutInterval:60];
    
    [placeImgView setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         placeImgView.image= [AppHelper resizeImage:image newSize:CGSizeMake(image.size.width,image.size.height)];
         
     }
                                 failure:NULL];
    placeImgView.layer.cornerRadius=5;
    placeImgView.clipsToBounds=YES;
    
    if ([rating isEqualToString:@"1"] || [rating isEqualToString:@"1.0"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"blackstar"]];
        [star3 setImage:[UIImage imageNamed:@"blackstar"]];
        [star4 setImage:[UIImage imageNamed:@"blackstar"]];
        [star5 setImage:[UIImage imageNamed:@"blackstar"]];
    }
    else if ([rating isEqualToString:@"1.5"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"Whitehalfstar"]];
        [star3 setImage:[UIImage imageNamed:@"whitestar"]];
        [star4 setImage:[UIImage imageNamed:@"whitestar"]];
        [star5 setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"2"] || [rating isEqualToString:@"2.0"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"whitestar"]];
        [star4 setImage:[UIImage imageNamed:@"whitestar"]];
        [star5 setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"2.5"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"Whitehalfstar"]];
        [star4 setImage:[UIImage imageNamed:@"whitestar"]];
        [star5 setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"3"] || [rating isEqualToString:@"3.0"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"whitestar"]];
        [star5 setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"3.5"] )
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"Whitehalfstar"]];
        [star5 setImage:[UIImage imageNamed:@"whitestar"]];
    }
    else if ([rating isEqualToString:@"4"] || [rating isEqualToString:@"4.0"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"staryellow"]];
        [star5 setImage:[UIImage imageNamed:@"whitestar"]];
    }
    
    else if ([rating isEqualToString:@"4.5"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"staryellow"]];
        [star5 setImage:[UIImage imageNamed:@"Whitehalfstar"]];
    }
    else if ([rating isEqualToString:@"5"] || [rating isEqualToString:@"5.0"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"staryellow"]];
        [star5 setImage:[UIImage imageNamed:@"staryellow"]];
    }
    
    
    
    return cell;
    
}




-(void)makeaCall:(NSString*)phnNumber
{
    NSString *phoneNumber=[phnNumber stringByReplacingOccurrencesOfString:@"phone" withString:@""];
    phoneNumber = [@"tel://" stringByAppendingString:phnNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}




- (IBAction)websiteBtntap:(id)sender
{
    
    
    if (_fromDB)
    {
        NSArray *arr=[[[DataBase sharedChatTableClass]getTagByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
        Favorite *fav=[arr objectAtIndex:_indx.row];
        
        WebsiteVC *wsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"WebsiteVC"];
        wsVC.websiteUrl=fav.websiteurl;
        [self presentViewController:wsVC animated:YES completion:nil];
    }
    else
    {
    WebsiteVC *wsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"WebsiteVC"];
    wsVC.websiteUrl=[_catDetail objectForKey:@"mobile_url"];
    [self presentViewController:wsVC animated:YES completion:nil];
    }
}

- (IBAction)phnBtnTap:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                        message:[_phnNoLbl.text stringByReplacingOccurrencesOfString:@"phone" withString:@""]
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                otherButtonTitles:@"Call",nil];
           [alert show];
}

- (IBAction)scheduleaplanBtnTap:(id)sender
{
    
    
    
    PlanScheduleVC *placeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PlanScheduleVC"];
    if ([_fromDB isEqualToString:@"favorite"])
    {
        placeVC.fav=fav;
    }
    else if ([_fromDB isEqualToString:@"completed"])
    {
       placeVC.splan=splan;
    }
    else if ([_fromDB isEqualToString:@"future"])
    {
       placeVC.splan=splan;
    }
    else
    {
       placeVC.planDict=_catDetail;
    }
   
    placeVC.fromScrn=_fromDB;
    placeVC.placename=_datenameLbl.text;
    [self.navigationController pushViewController:placeVC animated:YES];
    
    
        
}

- (IBAction)reviewsdropdownBtnTap:(id)sender
{
    if (_reviewTV.frame.size.height>99)
    {
        
       
        [UIView animateWithDuration:0.5
                         animations:^{
                             _reviewTVHeigtConstraint.constant =99;
                             [self.view layoutIfNeeded];
                         }];
    }
    else
    {
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             _reviewTVHeigtConstraint.constant = _reviewTV.contentSize.height+40;
                             [self.view layoutIfNeeded];
                         }];
        
    }
}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        // do something here...
       
    }
    else
    {
        if (_fromDB)
        {
            [self makeaCall:_phnNoLbl.text];
        }
        else
        {
            [self makeaCall:[_catDetail valueForKey:@"display_phone"]];
        }  
    }
    
    
   
    
}

-(void)getBusinessDetailsbyID
{
    [YLPClient authorizeWithAppId:@"l7sgW2OtxTZHjdSQh0nuFw" secret:@"rOcACVJwwMmhTOuZsuNB5kM1hv7rKLdTg31jwkRO0BzaVuMnf2YG08P9kfzRqFfx" completionHandler:^
     (YLPClient *client, NSError *error) {
         // Save your newly authorized client
         self.client = client;
         
         [AppHelper showActivityIndicator:_reviewTV];
         [self.client reviewsForBusinessWithId:businessID completionHandler:^
          (YLPBusinessReviews *reviews, NSError *error) {
              // Perform any tasks you need to here
              _businessReviewsArray=[[NSMutableArray alloc]init];
              NSLog(@"Error = %@ ***************  Reviews = %@",error ,reviews.reviews);
              for (YLPReview *abc in reviews.reviews)
              {
                  NSLog(@"%.0f %@ %@",abc.rating,abc.user.name,abc.excerpt);
                  
                  NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                  [dict setObject:[NSString stringWithFormat:@"%.01f",abc.rating] forKey:@"rating"];
                  [dict setObject:[NSString stringWithFormat:@"%@",abc.user.name] forKey:@"name"];
                  [dict setObject:[NSString stringWithFormat:@"%@",abc.user.imageURL] forKey:@"image"];
                  [dict setObject:abc.excerpt forKey:@"reviewtext"];
                  
                  [_businessReviewsArray addObject:dict];
                  if (reviews.reviews.count==_businessReviewsArray.count)
                  {
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                          [_reviewTV reloadData];
                          
                          // now set the height constraint accordingly
                          
                          [UIView animateWithDuration:0.5 animations:^{
                              self.reviewTVHeigtConstraint.constant = _reviewTV.contentSize.height+56;
                              [self.view layoutIfNeeded];
                          }];
                          NSLog(@"Reviews Array Data  ====  %@",_businessReviewsArray);
                          //[_reviewTV setNeedsLayout];
                          [AppHelper hideActivityIndicator:_reviewTV];
                      });
                      
                  }
              }
              
          }];
         
     }];

}

@end
