//
//  Home3ViewController.m
//  place
//
//  Created by Yatharth Singh on 13/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "Home3ViewController.h"
#import "MapViewController.h"
#import "AppDelegate.h"
#import "AppHelper.h"
#import "Define.h"
#import "ServiceClass.h"
#import "HCSStarRatingView.h"
#import "UIImageView+WebCache.h"
#import "SignUpViewController.h"
#import "SignInViewController.h"
#import "ResetPasswordVC.h"
#import "UIImageView+AFNetworking.h"
#import "ViewController.h"

//@import GoogleMaps;

@interface Home3ViewController (){

    NSMutableArray *arrResponse;
    NSMutableArray *arrImages;
    NSString *isImage;
    UIImageView *img;
    NSString *latitude,*longitude;
    NSString *apiType;
    float rateValue;
    NSString *categoryid;
    NSString *placeid;
    

}
@property (strong, nonatomic) IBOutlet UILabel *lblTime;

@property (strong, nonatomic) IBOutlet UIImageView *imgBanner;
@property (strong, nonatomic) IBOutlet UICollectionView *collView;

@property (strong, nonatomic) IBOutlet UITextField *txtSearch;

@property (strong, nonatomic) IBOutlet UITextField *txtComment;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UILabel *lblPlaceTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblOpeningT;
@property (strong, nonatomic) IBOutlet UILabel *lblClosingT;
@property (strong, nonatomic) IBOutlet UILabel *lblRemainingT;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *viewRating;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblHeightConstraint;
@property (strong, nonatomic) IBOutlet UIView *viewReview;
@property (strong, nonatomic) IBOutlet UILabel *lblCount;
@property (strong, nonatomic) IBOutlet UIButton *actionSignUp;
@property (strong, nonatomic) IBOutlet UIView *viewBlack;
@property (strong, nonatomic) IBOutlet UIView *viewRatePopup;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *viewRate;

- (IBAction)actionSubmit:(id)sender;
- (IBAction)actionSignUp:(id)sender;
- (IBAction)actionSignIn:(id)sender;

- (IBAction)actionBack:(id)sender;
- (IBAction)actionMap:(id)sender;
- (IBAction)actionSearch:(id)sender;
- (IBAction)actionPostReview:(id)sender;
- (IBAction)actionDropDown:(id)sender;
- (IBAction)actionRateView:(id)sender;

@end

@implementation Home3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrReview=[[NSMutableArray alloc]init];
    arrImages=[[NSMutableArray alloc]init];
    isImage=@"yes";
    
    self.collView.delegate=self;
    self.collView.dataSource=self;
    
    self.viewBlack.hidden=YES;
    self.viewRatePopup.hidden=YES;
    
    self.viewRatePopup.layer.cornerRadius=4;
    
//    NSURL *url=[NSURL URLWithString:[AppHelper userDefaultsForKey:@"image"]];
//    [_imgView sd_setImageWithURL:url];
    
    [self hitApiforLocationDetails];
    
//    [self setScreenLayout];
    // Do any additional setup after loading the view.
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


-(void)viewWillAppear:(BOOL)animated{

    NSString *email=[AppHelper userDefaultsForKey:@"userId"];
    
    if ([email length]>0) {
        
//        [self.btnSignIn setTitle:@"" forState:UIControlStateNormal];
        [self.btnSignIn setTitleColor:HeaderColor forState:UIControlStateNormal];
        [self.btnSignIn setImage:[UIImage imageNamed:@"icon_settings"] forState:UIControlStateNormal];
        self.viewReview.layer.cornerRadius=2;
        self.viewReview.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.viewReview.layer.borderWidth=1;
        self.imgView.layer.cornerRadius=self.imgView.bounds.size.height/2;
        self.imgView.clipsToBounds=YES;
        self.btnSignUp.hidden=YES;
        
        NSMutableAttributedString *titleSignIn = [[NSMutableAttributedString alloc] initWithString:@""];
        
        // making text property to underline text-
        
        UIColor* textColorSignIn = [UIColor colorWithRed:0.84 green:0.24 blue:0.21 alpha:1.0];
        
        
        [titleSignIn setAttributes:@{NSForegroundColorAttributeName:textColorSignIn} range:NSMakeRange(0,[titleSignIn length])];
        
        // using text on button
        [self.btnSignIn setAttributedTitle: titleSignIn forState:UIControlStateNormal];
        

        
    }else{
        
        [self setScreenLayout];
        
        
    }

}

#pragma mark - Custom Methods

-(void)setScreenLayout{

    self.viewReview.layer.cornerRadius=2;
    self.viewReview.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.viewReview.layer.borderWidth=1;
    self.imgView.layer.cornerRadius=self.imgView.bounds.size.height/2;
    self.imgView.clipsToBounds=YES;
    
//    self.txtComment.rightViewMode = UITextFieldViewModeAlways;
//    self.txtComment.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_back"]];
//    
    NSMutableAttributedString *titleSignUp = [[NSMutableAttributedString alloc] initWithString:@"SIGN UP"];
    
    // making text property to underline text-

    UIColor* textColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.0];
    
    
    [titleSignUp setAttributes:@{NSForegroundColorAttributeName:textColor} range:NSMakeRange(0,[titleSignUp length])];
    
    // using text on button
    [self.btnSignUp setAttributedTitle: titleSignUp forState:UIControlStateNormal];


    NSMutableAttributedString *titleSignIn = [[NSMutableAttributedString alloc] initWithString:@"SIGN IN"];
    
    // making text property to underline text-
    
    UIColor* textColorSignIn = [UIColor colorWithRed:0.84 green:0.24 blue:0.21 alpha:1.0];
    
    
    [titleSignIn setAttributes:@{NSForegroundColorAttributeName:textColorSignIn} range:NSMakeRange(0,[titleSignIn length])];
    
    // using text on button
    [self.btnSignIn setAttributedTitle: titleSignIn forState:UIControlStateNormal];
    
    
    NSString *boldFontName = [[UIFont boldSystemFontOfSize:13] fontName];
    NSRange boldedRange = NSMakeRange(0, 13);
    
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.lblOpeningT.text];
    
//    [attrString beginEditing];
    
//    UIColor* lblFontColor = [UIColor blackColor];
    

//    [attrString addAttribute:NSFontAttributeName value:boldFontName range:boldedRange];
    
    
//    [attrString setAttributes:@{NSForegroundColorAttributeName:lblFontColor} range:boldedRange];

    
//    [attrString endEditing];
    
//    [self.lblOpeningT setAttributedText:attrString];
    
}


#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrReview.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 70.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellReview"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReview"];
    }

    UIImageView *imgV=(UIImageView *)[cell viewWithTag:101];
    UILabel *lblName=(UILabel *)[cell viewWithTag:102];
    UILabel *lblReview=(UILabel *)[cell viewWithTag:103];
    UILabel *lblDate=(UILabel *)[cell viewWithTag:104];
    UILabel *lblTime=(UILabel *)[cell viewWithTag:105];
    
    NSDictionary *dict=[_arrReview objectAtIndex:indexPath.row];
    
    self.viewRating.value=[[dict valueForKey:@"ratings"] floatValue];
    
//    NSURL *url=[NSURL URLWithString:[dict valueForKey:@"image"]];
//    [imgV sd_setImageWithURL:url];
    
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"image"] ] ;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [imgV setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"default_Placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         // UIImage *imag= [AppHelper squareImageFromImage:image scaledToSize:90];
         // UIImage *imag= [self squareImageFromImage:image scaledToSize:(90)];
         imgV.image=image;
     }
                                failure:NULL];
    
    
    imgV.layer.cornerRadius=imgV.bounds.size.height/2;
    imgV.clipsToBounds=YES;

    lblName.text=[dict valueForKey:@"name"];
    lblReview.text=[dict valueForKey:@"review"];
    NSArray *date=[[dict valueForKey:@"reviewDate"] componentsSeparatedByString:@" "];
    
    lblTime.text=[self changeDateIntoTwelveHourFormat:[date objectAtIndex:1]];
    
    NSString *urDateString=[dict valueForKey:@"reviewDate"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateString = [dateFormatter dateFromString:urDateString];
    [dateFormatter setDateFormat:@"MMM dd,yyy"];
    NSString *formattedDateString = [dateFormatter stringFromDate:dateString];
    

    lblDate.text=formattedDateString;
//    lblTime.text=[date objectAtIndex:1];
    
    if (indexPath.row%2==0) {
        
        cell.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
        
    }else{
    
        cell.backgroundColor=[UIColor whiteColor];
    }
    
    
    return cell;
    
}


- (IBAction)actionBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)actionMap:(id)sender {
    
    MapViewController *mvc=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    mvc.latitude=latitude;
    mvc.longitude=longitude;
    [self.navigationController pushViewController:mvc animated:YES];
}

#pragma mark - Location Details Api Methods


-(void)hitApiforLocationDetails{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
//    {
//        "locationId"   :  13,
//        "categoryId"   : 10,
//        "userId"      :  12
//    }
    [dict setObject:_strId forKey:@"categoryId"];
    [dict setObject:@"" forKey:@"userId"];
    [dict setObject:_strPlaceId forKey:@"locationId"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforLocationDetails:) name:NotificationLocationDetails object:nil ];
    [[ServiceClass sharedServiceClass]hitServiceForLocationDetailsByAF:dict];
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        
        [AppHelper showActivityIndicator:self.view];
    }
    
    
}




-(NSString*)changeDateIntoTwelveHourFormat:(NSString*)time{

    NSArray *stringArray = [time componentsSeparatedByString: @":"];
    
    int num1=[[stringArray objectAtIndex:0] intValue];
    int num2=[[stringArray objectAtIndex:1] intValue];
    
    int comp=num1;
     NSString *str1;
    if (num1<12) {
        
        str1=[NSString stringWithFormat:@"%d:%d AM",num1,num2 ];
//        _txtTime.text=str;
    }else if (num1>12){
        
        num1=num1-12;
        NSString *addZero;
        NSString *addZeroMinute;
       
        if (num1<10) {
            
            addZero=[NSString stringWithFormat:@"0%d",num1];
            
            if (num2<10) {
                addZeroMinute=[NSString stringWithFormat:@"0%d",num2];
                str1=[NSString stringWithFormat:@"%@:%@ PM",addZero,addZeroMinute ];
//                currentTime=str1;
//                _txtTime.text=str1;
            }else{
                
                str1=[NSString stringWithFormat:@"%@:%d PM",addZero,num2];
//                _txtTime.text=str1;
//                currentTime=str1;
            }
        }else{
            
            str1=[NSString stringWithFormat:@"%d:%d PM",num1,num2];
//            _txtTime.text=str1;
//            currentTime=str1;
            
        }
    }
    
    return str1;

}



#pragma mark - Methods for getting Open and Close time from Google and FourSquare


-(void)hitApiforOpenAndCloseTime:(NSString *)placeId andSource:(NSString*)source{
    
    NSString *fullURl;
    
    if ([source isEqualToString:@"1"]) {
        
        fullURl=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyCe4S6h4o95udvN7jqZggoCDbJDf_J2Q4k",placeId];
        apiType=@"1";
        
    }else{
        
        fullURl=[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?client_id=YCHJ3Y0T31TDLH4JGID3MMURSTW3QO2EYXRKEDRMXWLEZEE5&client_secret=JWIWEWRXE3IUGW3QVVECVUFZLQ1Z0KEAMPUNS3I0VLNM5BIT&v=20130815",placeId];
        apiType=@"2";
    
    }
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:placeId forKey:@"place_id"];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforOpenAndCloseTime:) name:NotificationForOpenClose object:nil ];
    [[ServiceClass sharedServiceClass]hitServiceForOpenAndCloseTime:dict andUrl:fullURl];
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        
        [AppHelper showActivityIndicator:self.view];
    }
    
    
}

-(void)getresponseonhitforOpenAndCloseTime:(NSNotification *)notifyInfo
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationForOpenClose object:nil ];
    
    

    if ([apiType isEqualToString:@"1"]) {
    
    arrResponse=[[NSMutableArray alloc]init];
    NSDictionary *dict = [[notifyInfo userInfo] valueForKey:@"result"];
    
    NSArray *arrTime=[dict valueForKey:@"opening_hours"];
    NSArray *arrWeedDay=[arrTime valueForKey:@"weekday_text"];
    
    
    if (arrWeedDay.count==0 ||arrWeedDay==nil) {
        
        self.lblTime.text=@"Timings: Not Available";
        
    }else{
       
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
        int weekday = [comps weekday];
        
        
        NSString *day;
        if (weekday==1) {
            day=@"Sunday";
            
            
        }
        else if (weekday==2){
            day=@"Monday";

        }
        else if (weekday==3){
            day=@"Tuesday";
  
        }
        else if (weekday==4){
            day=@"Wednesday";
            
        }
        else if (weekday==5){
            day=@"Thursday";
            
        }
        else if (weekday==6){
            day=@"Friday";

        }
        else if (weekday==7){
            day=@"Saturday";
            
        }


        
            for (int i=0; i<arrWeedDay.count; i++) {
            
                NSArray *dat=[[arrWeedDay objectAtIndex:i] componentsSeparatedByString:@" "];
                NSString *strDay=[dat objectAtIndex:0];
                NSArray *arrDay=[strDay componentsSeparatedByString:@":"];
            
                if ([day isEqualToString:[arrDay objectAtIndex:0]]) {
                
                    self.lblTime.text=[NSString stringWithFormat:@"Timings: %@",[arrWeedDay objectAtIndex:i] ];
                
                }
            
        
            }


    
    }
    }else{
    
        
        arrResponse=[[NSMutableArray alloc]init];
        NSDictionary *dict = [[notifyInfo userInfo] valueForKey:@"response"];
    
        
    }
    
    
    
    
    [AppHelper hideActivityIndicator:self.view];
    
//    if (arrImages.count==0) {
//        isImage=@"No";
//        [arrImages addObject:@"icon_dummy_banner.png"];
//        [self.collView reloadData];
//    }
    
//    [self.collView reloadData];
//    [self hitApiforBannerImage:[arrImages objectAtIndex:0]];

    
}

#pragma mark - Methods for review

- (IBAction)actionSubmit:(id)sender {
    
    self.viewBlack.hidden=YES;
    self.viewRatePopup.hidden=YES;
    
    if (rateValue==0) {
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please enter rating!!"  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }else{
    
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
        NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
        NSString *dateTime=[dateFormatter stringFromDate:[NSDate date]];
        
        [self hitApiForAddReview:self.txtComment.text anduserId:[AppHelper userDefaultsForKey:@"userId"] andCategoryId:categoryid andLocationId:_strPlaceId andRatings:[NSString stringWithFormat:@"%f",rateValue] andReviewDate:dateTime];
        
    }
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:[AppHelper userDefaultsForKey:@"name"],@"name",self.txtComment.text,@"review",[AppHelper userDefaultsForKey:@"image"],@"image",[dateFormatter stringFromDate:[NSDate date]],@"reviewDate", nil];
    
    [self.arrReview addObject:dict];
    self.tblHeightConstraint.constant=self.arrReview.count*70;
    
    [self.tblView reloadData];
    self.txtComment.text=@"";
    
}


- (IBAction)actionPostReview:(id)sender {
    
    NSString *email=[AppHelper userDefaultsForKey:@"userId"];
    
    if ([email length]>0) {
        
        [self.txtComment resignFirstResponder];
        
        if ([self.txtComment.text length]==0) {
            
        }else{
            
            self.viewBlack.hidden=NO;
            self.viewRatePopup.hidden=NO;
            
        }
        
        
        
    }else{
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please login for review !!"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
    }
    
    
}


-(void)hitApiForAddReview:(NSString *)review anduserId:(NSString*)userid andCategoryId:(NSString *)categoryId andLocationId:(NSString*)locationId andRatings:(NSString*)rating andReviewDate:(NSString*)reviewDate{
    
    
    /*
     {
     "userId" : 1,
     "categoryId" : 1,
     "locationId" : 12,
     "review" : "Working fine",
     "ratings" : 3,
     "reviewDate" :"2016-07-15",
     "ratingDate" :"2016-07-15"
     
     }
    
    */
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:review forKey:@"review"];
    [dict setObject:userid forKey:@"userId"];
    [dict setObject:locationId forKey:@"locationId"];
    [dict setObject:categoryId forKey:@"categoryId"];
    [dict setObject:reviewDate forKey:@"reviewDate"];
    [dict setObject:rating forKey:@"ratings"];
    [dict setObject:reviewDate forKey:@"ratingDate"];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforReview:) name:NotificationForReview object:nil ];
    [[ServiceClass sharedServiceClass]hitServiceForReviewByAF:dict];
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        
        [AppHelper showActivityIndicator:self.view];
    }
    
    
}


-(void)getresponseonhitforReview:(NSNotification *)notifyInfo
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationForReview object:nil ];
    
    
    arrResponse=[[NSMutableArray alloc]init];
    NSDictionary *dict = [[notifyInfo userInfo] valueForKey:@"result"];
    
    [AppHelper hideActivityIndicator:self.view];
    [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notifyInfo userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];

}


#pragma mark - CollectionView Delegate Methods for showing banner image


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return arrImages.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
    
    return CGSizeMake(self.view.frame.size.width, 155);
}



-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"collImages";
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    _lblCount.text=[NSString stringWithFormat:@"%lu", indexPath.row+1 ];
    img=(UIImageView*)[cell viewWithTag:101];
    _collView.userInteractionEnabled=YES;
    
    if ([isImage isEqualToString:@"yes"]) {
        
    
        //img.image=[UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
        NSURL *url = [NSURL URLWithString:[arrImages objectAtIndex:indexPath.row]] ;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [img setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"icon_dummy_banner"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
         {
             // UIImage *imag= [AppHelper squareImageFromImage:image scaledToSize:90];
             // UIImage *imag= [self squareImageFromImage:image scaledToSize:(90)];
             img.image=image;
         }
                             failure:NULL];
        
        _lblCount.text=@"";
        
    }else if ([isImage isEqualToString:@"y"])
    {
        
        //[img sd_setImageWithURL:[arrImages objectAtIndex:indexPath.row]];
        NSURL *url = [NSURL URLWithString:[arrImages objectAtIndex:indexPath.row]] ;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [img setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"icon_dummy_banner"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
         {
             // UIImage *imag= [AppHelper squareImageFromImage:image scaledToSize:90];
             // UIImage *imag= [self squareImageFromImage:image scaledToSize:(90)];
             img.image=image;
         }
                            failure:NULL];

    }
    else{
    
        //img.image=[arrImages objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[arrImages objectAtIndex:indexPath.row]] ;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [img setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"icon_dummy_banner"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
         {
             // UIImage *imag= [AppHelper squareImageFromImage:image scaledToSize:90];
             // UIImage *imag= [self squareImageFromImage:image scaledToSize:(90)];
             img.image=image;
         }
                            failure:NULL];

    }
    
    
    return cell;
    
}


#pragma mark - SignIn and SignUp Methods



- (IBAction)actionSignUp:(id)sender{
    
    SignUpViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    svc.backFlag=@"1";
    [self.navigationController pushViewController:svc animated:YES];
    
    
    
}

- (IBAction)actionSignIn:(id)sender {
    
    NSString *email=[AppHelper userDefaultsForKey:@"userId"];
    
    if ([email length]>0) {
        
        UIAlertController *actionSheet=[UIAlertController alertControllerWithTitle:@"Setting" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Reset Password" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            ResetPasswordVC *rpv=[self.storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordVC"];
            [self.navigationController pushViewController:rpv animated:YES];
            
            // Distructive button tapped.
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self logout:nil];
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
        }]];
        
        
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }else{
        
        SignInViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        //svc.backFlag=@"1";
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
    
}

- (IBAction)logout:(id)sender {
    
    [AppHelper removeFromUserDefaultsWithKey:@"userId"];
    
    
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    
    ViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"view"];
    [self.navigationController pushViewController:view animated:YES];
}



- (IBAction)actionRateView:(id)sender {
    
    rateValue=self.viewRate.value;
    
    NSLog(@"%f",self.viewRate.value);
    
}
@end
