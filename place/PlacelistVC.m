//
//  PlacelistVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 15/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "PlacelistVC.h"

@interface PlacelistVC ()<DetailVCDelegate,PlaceFilterVCDelegate>
{
    NSMutableArray *placeArray;
    NSMutableArray *filterArray;
    CGFloat rowHeigt;
     bool isSearching;
}
@property (nonatomic, strong) YelpClient  *client;


@end


@implementation PlacelistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _addBannerV.adUnitID = ADUNIT_320x50_ROS;
    self.addBannerV.rootViewController = self;
    [self.addBannerV loadRequest:[DFPRequest request]];
    
    

    _searchBar.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Search" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    // Create a NSTextAttachment with your image
    NSTextAttachment*   placeholderImageTextAttachment = [[NSTextAttachment alloc] init];
    placeholderImageTextAttachment.image = [UIImage imageNamed:@"search"];
    
    // Use 'bound' to adjust position and size
    placeholderImageTextAttachment.bounds = CGRectMake(0, -10, 30, 30);
    NSMutableAttributedString*  placeholderImageString = [[NSAttributedString attributedStringWithAttachment:placeholderImageTextAttachment] mutableCopy];
    
    // Append the placeholder text
    NSMutableAttributedString*  placeholderString = [[NSMutableAttributedString alloc]initWithString:@"Search" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [placeholderImageString appendAttributedString:placeholderString];
    
    // set as (attributed) placeholder
    _searchBar.attributedPlaceholder = placeholderImageString;
   
    self.placeListTV.rowHeight = UITableViewAutomaticDimension;
    self.placeListTV.estimatedRowHeight = 44.0; //
    
    [self getNerbyPlacesData:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Filter View Controller Delegate Methods

- (void)addItemVC:(PlaceFilterVC *)controller didFinishEnteringItem:(NSString *)item
{
    [self getNerbyPlacesData:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)addItemViewController:(DetailVC *)controller didFinishEnteringItem:(NSString *)item
{
    NSLog(@"This was returned from ViewControllerB %@",item);
    [self getNerbyPlacesData:NO];
    
}


- (IBAction)backBtntap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)filterBtntap:(id)sender
{
   
       // [self.searchBar resignFirstResponder];
    
         PlaceFilterVC *pfvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PlaceFilterVC"];
       // pfvc.selectedCategoryLbl.text=_selectedtext;
          pfvc.delegate=self;
        [self presentViewController:pfvc animated:YES completion:^{}];
    
}


#pragma YelpAPI

-(void)getNerbyPlacesData :(BOOL)withloader
{
    if (withloader ==YES)
    {
       [AppHelper showActivityIndicator:self.view];
    }
    
    
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
        NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
        
       // [filters setValue:[AppHelper userDefaultsForKey:@"currentLatLong"] forKey:@"location"];
        [filters setObject:@"1" forKey:@"sort"];
        [filters setObject:[AppHelper userDefaultsForKey:@"selectedLocationlatlong"] forKey:@"ll"];
    
    if ([AppHelper userDefaultsForKey:@"price"]==nil)
    {
        [AppHelper saveToUserDefaults:@"1,2,3,4" withKey:@"price"];
    }
        [filters setObject:[AppHelper userDefaultsForKey:@"price"] forKey:@"price"];
    
    if ([AppHelper userDefaultsForKey:@"distance"]==nil)
    {
        [AppHelper saveToUserDefaults:@"100" withKey:@"distance"];
    }
        [filters setObject:[AppHelper userDefaultsForKey:@"distance"] forKey:@"distance"];
    
        [filters setObject:_selectedtext forKey:@"term"];
        //[filters setObject:[NSNumber numberWithInt:5] forKey:@"review_count"];
    
        [self.client searchWithDictionary:filters success:^(AFHTTPRequestOperation *operation, id response) {
            // Passing API results to the YelpListing model for creation
            placeArray=[[NSMutableArray alloc]init];
            NSLog(@"response: %@", response);
           // placeArray=[[response valueForKey:@"businesses"]mutableCopy];
            NSMutableArray *dataArray=[[NSMutableArray alloc]init];
            
              dataArray =[[response valueForKey:@"businesses"]mutableCopy];
            
            if ([AppHelper userDefaultsForKey:@"rating"]==nil)
            {
                [AppHelper saveToUserDefaults:@"5.0" withKey:@"rating"];
            }
            
            if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"1.0"])
            {
                for (NSDictionary *dict in dataArray)
                {
                    if ([[dict objectForKey:@"rating"] floatValue] <=1.0)
                    {
                        [placeArray addObject:dict];
                    }
                    
                }
            }
          else if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"1.5"])
          {
              for (NSDictionary *dict in dataArray)
              {
                  if ([[dict objectForKey:@"rating"] floatValue] <= 1.5)
                  {
                      [placeArray addObject:dict];
                  }
                  
              }
          }
          else if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"2.0"])
          {
              for (NSDictionary *dict in dataArray)
              {
                  if ([[dict objectForKey:@"rating"] floatValue] <=2.0)
                  {
                      [placeArray addObject:dict];
                  }
                  
              }
          }
          else if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"2.5"])
          {
              for (NSDictionary *dict in dataArray)
              {
                  if ([[dict objectForKey:@"rating"] floatValue] <= 2.5)
                  {
                      [placeArray addObject:dict];
                  }
                  
              }
          }
          else if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"3.0"])
          {
              for (NSDictionary *dict in dataArray)
              {
                  if ([[dict objectForKey:@"rating"] floatValue] <=3.0)
                  {
                      [placeArray addObject:dict];
                  }
                  
              }
          }
          else if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"3.5"])
          {
              //placeArray=[[NSMutableArray alloc]init];
              for (NSDictionary *dict in dataArray)
              {
                  if ([[dict objectForKey:@"rating"] floatValue] <= 3.5)
                  {
                      [placeArray addObject:dict];
                  }
                  
              }

          }
          else if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"4.0"])
          {
              for (NSDictionary *dict in dataArray)
              {
                  if ([[dict objectForKey:@"rating"] floatValue] <=4.0)
                  {
                      [placeArray addObject:dict];
                  }
                  
              }
          }
          else if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"4.5"])
          {
              for (NSDictionary *dict in dataArray)
              {
                  if ([[dict objectForKey:@"rating"] floatValue] <= 4.5)
                  {
                      [placeArray addObject:dict];
                  }
                  
              }
          }
          else if ([[AppHelper userDefaultsForKey:@"rating"]isEqualToString:@"5.0"])
          {
              for (NSDictionary *dict in dataArray)
              {
                  if ([[dict objectForKey:@"rating"] floatValue] <=5.0)
                  {
                      [placeArray addObject:dict];
                  }
                  
              }
          }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                 [AppHelper hideActivityIndicator:self.view];
            });
          
            [self.placeListTV reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"error: %@", [error description]);
            [AppHelper hideActivityIndicator:self.view];
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"No Data Found"  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        }];
    

    
}

#pragma TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching==YES)
    {
       return filterArray.count;
    }
    else
    {
    return placeArray.count;
    }
    return 0;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
     UIImageView *placeImgView=(UIImageView *)[cell viewWithTag:1];
     UILabel *placeNameLbl=(UILabel*)[cell viewWithTag:2];
     UILabel *placeAddressLbl=(UILabel*)[cell viewWithTag:3];
     UILabel *priceLbl=(UILabel*)[cell viewWithTag:4];
     UILabel *distanceLbl=(UILabel*)[cell viewWithTag:5];
     UILabel *rateLbl=(UILabel*)[cell viewWithTag:6];
     UIImageView *star1=(UIImageView *)[cell viewWithTag:7];
     UIImageView *star2=(UIImageView *)[cell viewWithTag:8];
     UIImageView *star3=(UIImageView *)[cell viewWithTag:9];
     UIImageView *star4=(UIImageView *)[cell viewWithTag:10];
     UIImageView *star5=(UIImageView *)[cell viewWithTag:11];
    
    NSDictionary *dict;
    if (isSearching==YES)
    {
       dict=[filterArray objectAtIndex:indexPath.row];
    }
    else
    {
    dict=[placeArray objectAtIndex:indexPath.row];
    }
    NSString *Oimage=[dict valueForKey:@"image_url"];
    Oimage= [Oimage stringByReplacingOccurrencesOfString:@"ms" withString:@"o"];
    NSURL *url = [NSURL URLWithString:Oimage]  ;
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                               cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                           timeoutInterval:60];
    
    [placeImgView setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         placeImgView.image= [AppHelper resizeImage:image newSize:CGSizeMake(image.size.width,image.size.height)];
         
     }
                        failure:NULL];
    
    placeNameLbl.text    = [dict valueForKey:@"name"];
    NSArray *adress=[[dict valueForKey:@"location"] valueForKey:@"display_address"];
    NSLog(@"Address ==== %@",adress);
    placeAddressLbl.text    = [adress componentsJoinedByString:@","] ;
     priceLbl.text    = [dict valueForKey:@"name"];
   // rowHeigt= [self getLabelHeight:placeAddressLbl];
    
    //Calculate Distance
    
    CLLocation *itemLoc = [[CLLocation alloc] initWithLatitude:[[[[dict valueForKey:@"location"] valueForKey:@"coordinate"] valueForKey:@"latitude"] doubleValue] longitude:[[[[dict valueForKey:@"location"] valueForKey:@"coordinate"] valueForKey:@"longitude"] doubleValue]];
    
    NSString *str=[AppHelper userDefaultsForKey:@"selectedLocationlatlong"];
    NSArray *arr=[str componentsSeparatedByString:@","];
    CLLocation *current = [[CLLocation alloc] initWithLatitude:[[arr objectAtIndex:0]doubleValue]  longitude:[[arr objectAtIndex:1] doubleValue]];
   
    CLLocationDistance itemDist = [itemLoc distanceFromLocation:current];
    distanceLbl.text    =[NSString stringWithFormat:@"%.1f miles",(itemDist/1609.344)];
    NSString *rating=[NSString stringWithFormat:@"%@",[dict valueForKey:@"rating"]];
    rateLbl.text    =rating;
   
    if ([rating isEqualToString:@"1"])
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
        [star2 setImage:[UIImage imageNamed:@"halfstar"]];
        [star3 setImage:[UIImage imageNamed:@"blackstar"]];
        [star4 setImage:[UIImage imageNamed:@"blackstar"]];
        [star5 setImage:[UIImage imageNamed:@"blackstar"]];
    }
    else if ([rating isEqualToString:@"2"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"blackstar"]];
        [star4 setImage:[UIImage imageNamed:@"blackstar"]];
        [star5 setImage:[UIImage imageNamed:@"blackstar"]];
    }
    else if ([rating isEqualToString:@"2.5"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"halfstar"]];
        [star4 setImage:[UIImage imageNamed:@"blackstar"]];
        [star5 setImage:[UIImage imageNamed:@"blackstar"]];
    }
    else if ([rating isEqualToString:@"3"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"blackstar"]];
        [star5 setImage:[UIImage imageNamed:@"blackstar"]];
    }
    else if ([rating isEqualToString:@"3.5"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"halfstar"]];
        [star5 setImage:[UIImage imageNamed:@"blackstar"]];
    }
    else if ([rating isEqualToString:@"4"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"staryellow"]];
        [star5 setImage:[UIImage imageNamed:@"blackstar"]];
    }
    
    else if ([rating isEqualToString:@"4.5"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"staryellow"]];
        [star5 setImage:[UIImage imageNamed:@"halfstar"]];
    }
    else if ([rating isEqualToString:@"5"])
    {
        [star1 setImage:[UIImage imageNamed:@"staryellow"]];
        [star2 setImage:[UIImage imageNamed:@"staryellow"]];
        [star3 setImage:[UIImage imageNamed:@"staryellow"]];
        [star4 setImage:[UIImage imageNamed:@"staryellow"]];
        [star5 setImage:[UIImage imageNamed:@"staryellow"]];
    }
    
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearching==YES)
    {
        DetailVC *detailVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        detailVC.delegate =self;
        detailVC.catDetail=[filterArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else
    {
    DetailVC *detailVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailVC.delegate =self;
    detailVC.catDetail=[placeArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height;
}




#pragma SearchBar

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str;
    
    
    if (string.length > 0) {
        str = [NSString stringWithFormat:@"%@%@",textField.text, string];
    } else {
        str = [textField.text substringToIndex:[textField.text length] - 1];
    }
    
    
    if (textField==_searchBar)
    {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fetchSearchRslt) object:nil];
        [self performSelector:@selector(fetchSearchRslt) withObject:nil afterDelay:0.1];
    }
    return YES;
}

-(void)fetchSearchRslt
{
    filterArray=[[NSMutableArray alloc]init];
    if([_searchBar.text isEqualToString:@""])
    {
        isSearching=NO;
        [_placeListTV reloadData];
        
        
    }
    else
    {
        isSearching=YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",_searchBar.text];
        filterArray =[[placeArray filteredArrayUsingPredicate:predicate]mutableCopy];
        [_placeListTV reloadData];
        
    }
}


//- (IBAction)searchClearbtnTap:(id)sender
//{
//    
//}


-(NSDictionary *) getAddressfromlatlong: (NSString* ) lat :(NSString *)lonng//will return only in english device language can be any
{
    NSString *CityString;
    NSString *CountryString;
    NSString *PostalCode;
    NSMutableDictionary *addressDict=[[NSMutableDictionary alloc]init];
    
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true&language=en", lat,lonng];
    
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    
    NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return addressDict;
}
//
//-(void)getdata:(NSString *)text
//{
//    
//}
@end
