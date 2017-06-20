//
//  HomeViewController.m
//  place
//
//  Created by Yatharth Singh on 06/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "HomeViewController.h"
#import "Define.h"
#import "DataBase.h"



@import GooglePlacePicker;


@interface HomeViewController ()

{

    NSMutableArray *arrResponse;
    NSMutableArray *arrDropDown;
    NSMutableArray *filterserachArray;
    NSMutableArray *placesearchArray;
    NSMutableArray *categoriesArray;
    NSMutableArray *categoryImageArray;
    NSString *selectedLoc;
    UIImageView *dwopDwown;
    
    CGFloat lat;
    CGFloat lng;
    NSArray *colorArray;
    bool isSerching;
    BOOL isRowHiDn;
        
   
}




@property (nonatomic) GMSPlacesClient *placesClient;
@property (nonatomic, strong) YelpClient  *client;
@property (nonatomic) CLLocationManager *locationManager;



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    isRowHiDn=YES;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    
    _placesClient = [GMSPlacesClient sharedClient];
    [self.locationManager requestAlwaysAuthorization];
   
   
    _bannerView.adUnitID = ADUNIT_320x50_ROS;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[DFPRequest request]];
    
   
    categoryImageArray=[[NSMutableArray alloc]initWithObjects:@"imageone",@"imagetwo",@"imagethree",@"imagefour",@"imageone",@"imagetwo",@"imagethree",@"imagefour",@"imageone",@"imagetwo",@"imagethree",@"imagefour",@"imageone", nil];
    
     _searchTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Search" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
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
    _searchTF.attributedPlaceholder = placeholderImageString;
 
    

    
    
    [self getCategory];
    [self getAllDates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCategory
{
     [AppHelper showActivityIndicator:self.view];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforGetCategory:) name:NotificationGetallCategories object:nil ];
    [[ServiceClass sharedServiceClass]hitServiceForGetCategories:nil];
}

-(void)getresponseonhitforGetCategory:(NSNotification *)notySignIn
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationGetallCategories object:nil ];
    
    
    if([[[notySignIn userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        [AppHelper hideActivityIndicator:self.view];
        
       
        categoriesArray=[[notySignIn userInfo] valueForKey:@"Result"];
        [_categoryCV reloadData];
        
    }
    else
    {
        
            [AppHelper hideActivityIndicator:self.view];
            [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignIn userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
}


-(void)getAllDates
{
    [AppHelper showActivityIndicator:self.view];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforGetAllDates:) name:NotificationForGetAllDates object:nil ];
    [[ServiceClass sharedServiceClass]hitServiceForGetAllDates:nil];
}

-(void)getresponseonhitforGetAllDates:(NSNotification *)notySignIn
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationForGetAllDates object:nil ];
    
    
    if([[[notySignIn userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        [AppHelper hideActivityIndicator:self.view];
        
        
        
        placesearchArray=[[NSMutableArray alloc]init];
        NSLog(@"response: %@", [[notySignIn userInfo] valueForKey:@"Result"]);
        placesearchArray=[[notySignIn userInfo] valueForKey:@"Result"];
        [_datesTV reloadData];
        [AppHelper hideActivityIndicator:self.view];
        
    }
    else
    {
        
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignIn userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma TableView Implementation




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return placesearchArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 200;
    }
    return 100;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [[placesearchArray objectAtIndex:section] valueForKey:@"date_name"];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0.0;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        if (isRowHiDn)
        {
            height = 0.0;
        }
        else
        {
            height = 88.0;
            
        }
        
    }
    else
    {
        if (isRowHiDn)
        {
            height = 0.0;
        }
        else
        {
            height = 44.0;
            
        }
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        headerHeight=199;
    }
    else
    {
        headerHeight=99;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    /* Create custom view to display section header... */
     UIImageView *imageVW=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, tableView.frame.size.width, headerHeight)];
    dwopDwown=[[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width-50,35, 25, 25)];
    [dwopDwown setImage:[UIImage imageNamed:@"Arrowhead.png"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, headerHeight-1, tableView.frame.size.width, 1)];
    
    //HelveticaNeue-Medium
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]];
    [label setBackgroundColor:[UIColor clearColor]];
    NSString *string =[[placesearchArray objectAtIndex:section] valueForKey:@"date_name"];
    /* Section header is in 0th index... */
    [label setText:string];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:view.frame];
    button.tag = section;
    button.titleLabel.shadowOffset = CGSizeMake(10.0, 10.0);
    [button setTitleShadowColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(detectSection:) forControlEvents:UIControlEventTouchUpInside];

    NSString *imageUrlwitoutSpace=[[[placesearchArray objectAtIndex:section] valueForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url = [NSURL URLWithString:imageUrlwitoutSpace]  ;
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                               cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                           timeoutInterval:60];
    //imageVW.hidden=YES;
    [label setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [AppHelper showActivityIndicator:imageVW];
    [imageVW setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             imageVW.image= [AppHelper resizeImage:image newSize:CGSizeMake(view.frame.size.width,view.frame.size.height+50)];
             [AppHelper hideActivityIndicator:imageVW];
         });
         //imageVW.hidden=NO;
         // [label setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
     }
                            failure:NULL];
   // [imageVW setContentMode:UIViewContentModeCenter];
    imageVW.clipsToBounds = YES;
    
    
    NSArray *datesArray=[[placesearchArray objectAtIndex:section] valueForKey:@"sub"];
    
    
    
    
    
    [view addSubview:imageVW];
    [view addSubview:label];
    [view addSubview:line];
    [view addSubview:button];
    if (datesArray.count>0)
    {
        [view addSubview:dwopDwown];
    }
    //    else
    //    {
    //
    //    }
    label.textColor=[UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    //[view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    line.backgroundColor=[UIColor whiteColor];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    
    
    return view;
}


-(void)detectSection:(UIButton *)sender
{
    
    NSArray *datesArray=[[placesearchArray objectAtIndex:sender.tag] valueForKey:@"sub"];
    
    if (datesArray.count>0)
    {
        if (isRowHiDn==YES)
        {
            isRowHiDn=NO;
           // sender.transform = CGAffineTransformScale(kCAValueFunctionScaleX, 0.6, 0.6);//CGAffineTransform(scaleX: 0.6, y: 0.6);
            sender.transform = CGAffineTransformMakeRotation(M_PI_2);
            [_datesTV beginUpdates];
            [_datesTV endUpdates];
        }
        else
        {
             sender.transform = CGAffineTransformMakeRotation(M_PI);
            isRowHiDn=YES;
            [_datesTV beginUpdates];
            [_datesTV endUpdates];
        }
        
    }
    else
    {
        PlacelistVC *placeListVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PlacelistVC"];
        placeListVC.selectedtext=[[placesearchArray objectAtIndex:sender.tag]valueForKey:@"date_name" ];
        [self.navigationController pushViewController:placeListVC animated:YES];
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSString *sectionTitle = [_categoriesArray objectAtIndex:section];
    NSArray *sectionAnimals = [[placesearchArray objectAtIndex:section]valueForKey:@"sub"];
    
   
        return [sectionAnimals count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *lbl1=(UILabel*)[cell viewWithTag:4];
    UIImageView *imgView=(UIImageView*)[cell viewWithTag:3];
    
    NSArray *datesArray=[[placesearchArray objectAtIndex:indexPath.section] valueForKey:@"sub"];
    // Configure the cell...
    // NSString *sectionTitle = [[_categoriesArray objectAtIndex:indexPath.section]valueForKey:@"name"];
    NSString *animal = [[datesArray objectAtIndex:indexPath.row]valueForKey:@"date_name"];
    lbl1.text = animal;
   
    
     NSString *imageUrlwitoutSpace=[[[placesearchArray objectAtIndex:indexPath.row] valueForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
     NSURL *url = [NSURL URLWithString:imageUrlwitoutSpace]  ;
   
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                               cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                           timeoutInterval:60];
    //imageVW.hidden=YES;
    [lbl1 setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [AppHelper showActivityIndicator:imgView];
    [imgView setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             imgView.image= [AppHelper resizeImage:image newSize:CGSizeMake(imgView.frame.size.width,imgView.frame.size.height)];
             [AppHelper hideActivityIndicator:imgView];
         });
         //imageVW.hidden=NO;
         // [label setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
     }
                            failure:NULL];
    
    
    
    [imgView setContentMode:UIViewContentModeCenter];
    imgView.clipsToBounds = YES;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSArray *datesArray=[[placesearchArray objectAtIndex:indexPath.section] valueForKey:@"sub"];
    
    
    PlacelistVC *placeListVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PlacelistVC"];
    placeListVC.selectedtext=[[datesArray objectAtIndex:indexPath.row]valueForKey:@"date_name" ];
    [self.navigationController pushViewController:placeListVC animated:YES];
    
}


- (IBAction)menuBtntap:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
    [self.view endEditing:YES];
}


#pragma CollectionView Implementation

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (isSerching ==YES)
    {
    return filterserachArray.count;
    }
    else
    {
        return categoriesArray.count;
 
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImageView *img=(UIImageView*)[cell viewWithTag:1];
    UILabel *catName=(UILabel *) [cell viewWithTag:2];
     UIView *bgView=(UIView *)[cell viewWithTag:5];

    img.layer.cornerRadius=img.frame.size.width/2;
    img.clipsToBounds=YES;
    bgView.layer.cornerRadius=bgView.frame.size.width/2;
    bgView.layer.borderWidth=1;
    bgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    bgView.clipsToBounds=YES;
    if (isSerching==YES)
    {
        catName.text=[[[filterserachArray objectAtIndex:indexPath.row]valueForKey:@"name"]stringByReplacingOccurrencesOfString:@"Category" withString:@""];
       
        if ([[[filterserachArray objectAtIndex:indexPath.row]valueForKey:@"image"]isEqualToString:@""])
        {
           img.image =[UIImage imageNamed:@"imageone"];
        }
        else
        {
            
            NSString *imageUrlwitoutSpace=[[[filterserachArray objectAtIndex:indexPath.row] valueForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSURL *url = [NSURL URLWithString:imageUrlwitoutSpace]  ;
            
            NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                                       cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                   timeoutInterval:60];
        
        [img setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
         {
             img.image= [AppHelper resizeImage:image newSize:CGSizeMake(image.size.width,image.size.height)];
             
         }
                                     failure:NULL];
        }
    }
    else
    {
    catName.text=[[[categoriesArray objectAtIndex:indexPath.row]valueForKey:@"name"] stringByReplacingOccurrencesOfString:@"Category" withString:@""];
        
        if ([[[categoriesArray objectAtIndex:indexPath.row]valueForKey:@"image"]isEqualToString:@""])
        {
            img.image =[UIImage imageNamed:@"imageone"];
        }
        else
        {
            NSString *imageUrlwitoutSpace=[[[categoriesArray objectAtIndex:indexPath.row] valueForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSURL *url = [NSURL URLWithString:imageUrlwitoutSpace]  ;
            NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                                       cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                   timeoutInterval:60];
            
            [img setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
             {
                 img.image= [AppHelper resizeImage:image newSize:CGSizeMake(image.size.width,image.size.height)];
                 
             }
                                failure:NULL];
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    [self.view endEditing:YES];
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    
    CategoryVC *catVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CategoryVC"];
    if (isSerching==YES)
    {
    catVC.selectedCat=[[filterserachArray objectAtIndex:indexPath.row]valueForKey:@"category_name"];
    catVC.categoriesArray=[[filterserachArray objectAtIndex:indexPath.row]valueForKey:@"sub"];
    }
    else
    {
        catVC.selectedCat=[[categoriesArray objectAtIndex:indexPath.row]valueForKey:@"category_name"];
        catVC.categoriesArray=[[categoriesArray objectAtIndex:indexPath.row]valueForKey:@"sub"];
    }
    [self.navigationController pushViewController:catVC animated:YES];
}



-(void)getResponseforHomeYelpData:(NSNotification *)YelpRes
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationForHomeVC_SearchAPI_Yelp object:nil];
    [AppHelper hideActivityIndicator:self.view];
}





- (IBAction)locationBtntap:(id)sender
{
    [self.view endEditing:YES];
    [self getPlaces];
}
- (IBAction)searchClearBtntap:(id)sender
{
    
}


#pragma Google Place Autocomplete

-(void)getPlaces
{
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %f,%f", place.coordinate.latitude,place.coordinate.longitude);
    
    NSString *latLong=[NSString stringWithFormat:@"%f,%f",place.coordinate.latitude,place.coordinate.longitude];
    [AppHelper saveToUserDefaults:latLong withKey:@"selectedLocationlatlong"];
    
     
    NSLog(@"Place name %@", place.name);
    [AppHelper saveToUserDefaults:place.name withKey:@"selectedplace"];
    selectedLoc=place.name;
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
   // [self getHomeData:latLong];
    
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}



// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    
    
    if (textField==_searchTF)
    {
       
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fetchSearchRslt) object:nil];
        [self performSelector:@selector(fetchSearchRslt) withObject:nil afterDelay:0.1];
    }
    return YES;
}

-(void)fetchSearchRslt
{
    filterserachArray=[[NSMutableArray alloc]init];
    if([_searchTF.text isEqualToString:@""])
    {
        isSerching=NO;
        [_categoryCV reloadData];
        
        
    }
    else
    {
        isSerching=YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",_searchTF.text];
        filterserachArray =[[categoriesArray filteredArrayUsingPredicate:predicate]mutableCopy];
        [_categoryCV reloadData];
        
    }
}



@end
