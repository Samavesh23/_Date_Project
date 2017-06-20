//
//  DemoVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 03/05/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "DemoVC.h"
#import "Define.h"
#import "DemoCell.h"

@interface DemoVC ()
@property (nonatomic, strong) YelpClient  *client;
@end

@implementation DemoVC
{
    NSMutableArray *demodata;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.demoTV.rowHeight = UITableViewAutomaticDimension;
    self.demoTV.estimatedRowHeight = 44.0; //
    
    [self getNerbyPlacesData:YES];
   
    
}
-(void)viewDidAppear:(BOOL)animated
{
    //[_demoTV reloadData];
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

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return demodata.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"DemoCell";
    
    __weak DemoCell *cell = (DemoCell *)[_demoTV dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
//    if (cell == nil)
//    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
//     }
    [cell viewWithTag:indexPath.row];
    NSDictionary *dict;
    dict=[demodata objectAtIndex:indexPath.row];
    NSString *Oimage=[dict valueForKey:@"image_url"];
    Oimage= [Oimage stringByReplacingOccurrencesOfString:@"ms" withString:@"o"];
    NSURL *url = [NSURL URLWithString:Oimage]  ;
   
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    [cell.imageview setImageWithURLRequest:Adrequest placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
        
   
    dispatch_async(dispatch_get_main_queue(), ^(){
    
    cell.imageview.image = image;
    
    float oldWidth = image.size.width;
    float scaleFactor = cell.frame.size.width / oldWidth;
    float newHeight = image.size.height * scaleFactor;
    cell.imageHeightConstraint.constant=newHeight;
    [cell setNeedsLayout];
    });
   
    
     }
                                 failure:NULL];
    
    
    
   /* [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:Oimage]
                                                        options:0
                                                       progress:nil
                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
     {
         if (cell.tag == indexPath.row && image && finished)
         {
             dispatch_async(dispatch_get_main_queue(), ^(){
                 
                 cell.imageview.image = image;
                 
                 float oldWidth = image.size.width;
                 float scaleFactor = cell.frame.size.width / oldWidth;
                 float newHeight = image.size.height * scaleFactor;
                 cell.imageHeightConstraint.constant=newHeight;
                  [cell setNeedsLayout];
             });
             
         }
         else
         {
             dispatch_async(dispatch_get_main_queue(), ^(){
                 cell.imageHeightConstraint.constant=0;
                  [cell setNeedsLayout];
             });
         }
     }];*/

    
    
    
    cell.lbl1.text    = [dict valueForKey:@"name"];
    NSArray *adress=[[dict valueForKey:@"location"] valueForKey:@"display_address"];
    NSLog(@"Address ==== %@",adress);
    cell.lbl2.text    = [adress componentsJoinedByString:@","] ;
    cell.lbl3.text    = [dict valueForKey:@"snippet_text"];
   
     [cell setNeedsUpdateConstraints];
    return cell;
    
}



-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
    
    [filters setObject:@"" forKey:@"term"];
    //[filters setObject:[NSNumber numberWithInt:5] forKey:@"review_count"];
    
    [self.client searchWithDictionary:filters success:^(AFHTTPRequestOperation *operation, id response) {
        // Passing API results to the YelpListing model for creation
        demodata=[[NSMutableArray alloc]init];
        NSLog(@"response: %@", response);
        // placeArray=[[response valueForKey:@"businesses"]mutableCopy];
        NSMutableArray *dataArray=[[NSMutableArray alloc]init];
        
        demodata =[[response valueForKey:@"businesses"]mutableCopy];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [AppHelper hideActivityIndicator:self.view];
            
           
             [self.demoTV reloadData];
            [_demoTV beginUpdates];
             [_demoTV endUpdates];
            
        });
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", [error description]);
         [AppHelper hideActivityIndicator:self.view];
         [[AppDelegate getAppDelegate] alert:APP_NAME message:@"No Data Found"  cancelButtonTitle:@"ok" otherButtonTitles: nil];
     }];
    
    
    
}



- (IBAction)menuBtnTap:(id)sender {
}
@end
