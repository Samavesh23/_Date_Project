//
//  AddPlaceViewController.m
//  place
//
//  Created by Yatharth Singh on 29/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "AddPlaceViewController.h"
#import "Define.h"
#import "ServiceClass.h"
#import "AppHelper.h"
#import "AppDelegate.h"
#import "Base64.h"




@interface AddPlaceViewController ()
{
    NSString *latitude,*longitude;
    NSString *base64LogoImg,*base64BannerImg;
    CGFloat lat;
    CGFloat lng;
    NSString *cat_id;
    NSMutableArray *arrBannerImg;
    NSMutableArray *arrDataBannerImage;
    NSArray *arrResponse;
    NSString *flatImg;
    BOOL isLogoImage,isTime;
}

@property (strong, nonatomic) IBOutlet UILabel *lblLine1;
@property (strong, nonatomic) IBOutlet UILabel *lblLine2;
@property (strong, nonatomic) IBOutlet UILabel *lblLine3;
@property (strong, nonatomic) IBOutlet UILabel *lblLine4;
@property (strong, nonatomic) IBOutlet UILabel *lblLine5;
@property (strong, nonatomic) IBOutlet UILabel *lblLine6;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *txtPlaceName;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnCategory;
@property (strong, nonatomic) IBOutlet UIButton *btnOpenTime;
@property (strong, nonatomic) IBOutlet UIButton *btnCloseTime;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *viewImageBanner;
@property (strong, nonatomic) IBOutlet UIView *viewDropDown;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *viewBlack;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

- (IBAction)actionBack:(id)sender;
- (IBAction)actionCategoryDropDown:(id)sender;
- (IBAction)actionOpenTimeDD:(id)sender;
- (IBAction)actionCloseTimeDD:(id)sender;
- (IBAction)actionOpenCameraLibrary:(id)sender;
- (IBAction)actionSave:(id)sender;


@end

@implementation AddPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewDropDown.hidden=YES;
    self.viewBlack.hidden=YES;
    
    arrBannerImg=[[NSMutableArray alloc]init];
    arrDataBannerImage=[[NSMutableArray alloc]init];
    
    [self setLayoutScreen];
    
    [arrBannerImg addObject:@"icon_add.png"];
    flatImg=@"";
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideBlackView)];
    [self.viewBlack addGestureRecognizer:tap];
    
    
    [self.datePicker addTarget:self action:@selector(pickTime) forControlEvents:UIControlEventValueChanged];
    
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


-(void)hideBlackView{

    self.viewBlack.hidden=YES;
    self.viewDropDown.hidden=YES;

}


-(void)setLayoutScreen{

    
//    self.viewDropDown = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,30)];
    
    self.viewImageBanner.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.viewImageBanner.layer.borderWidth=1;
}

- (IBAction)actionBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionCategoryDropDown:(id)sender {
    
    self.datePicker.hidden=YES;
    self.pickerView.hidden=NO;
    
    self.viewDropDown.hidden=NO;
    self.viewBlack.hidden=NO;
   
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewDropDown.frame  = CGRectMake(0,self.view.frame.size.height-self.viewDropDown.frame.size.height,self.view.frame.size.width,200);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.5 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            self.viewDropDown.frame  = CGRectMake(0, -30, 320,20);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];

    
}


#pragma mark- Method for Time pick

- (IBAction)actionOpenTimeDD:(id)sender {
    
    self.datePicker.hidden=NO;
    self.pickerView.hidden=YES;
    
    self.viewDropDown.hidden=NO;
    self.viewBlack.hidden=NO;
    
    isTime=YES;
    
//    [self.btnOpenTime setTitle:@"" forState:UIControlStateNormal];
//    
//    if ([self.btnOpenTime.titleLabel.text isEqualToString:@"Opening Time"]) {
//        
//        [self.btnOpenTime setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        
//    }else{
//        
//        [self.btnOpenTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }
//
    
    
}

- (IBAction)actionCloseTimeDD:(id)sender {
    
    self.datePicker.hidden=NO;
    self.pickerView.hidden=YES;
    
    self.viewDropDown.hidden=NO;
    self.viewBlack.hidden=NO;
    
    isTime=NO;
    
//    [self.btnCloseTime setTitle:@"" forState:UIControlStateNormal];
//    
//    if ([self.btnCloseTime.titleLabel.text isEqualToString:@"Closing Time"]) {
//        
//        [self.btnCloseTime setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        
//    }else{
//        
//        [self.btnCloseTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }

    
}

-(void)pickTime{

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"hh:mm a"]; //12hr time format
    NSString *dateString = [outputFormatter stringFromDate:self.datePicker.date];
    
    if (isTime==YES) {
        
        [self.btnOpenTime setTitle:dateString forState:UIControlStateNormal];
        [self.btnOpenTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }else{
    
        [self.btnCloseTime setTitle:dateString forState:UIControlStateNormal];
        [self.btnCloseTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    

}




- (IBAction)actionOpenCameraLibrary:(id)sender {
    
    isLogoImage=YES;
    [self OpenCameraLibraryAlert];
    
}

- (IBAction)actionSave:(id)sender {
    
    NSString *userId=[AppHelper userDefaultsForKey:@"userId"];
    
    [self connectionforAddPlace:_txtPlaceName.text andAddress:self.txtAddress.text andCategory:cat_id andPlaceLatitude:latitude andPlaceLongitude:longitude andOpenTime:self.btnOpenTime.titleLabel.text andCloseTime:self.btnCloseTime.titleLabel.text andLogoImage:@"" andBannerImage:base64BannerImg andUserId:userId];
    
}


#pragma mark Method for Image pick from Camera and library

-(void)OpenCameraLibraryAlert{

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:APP_NAME message:@"Pick image from" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *camera=[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init] ;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        [picker setDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
        
//        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *library=[UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self handleImageGallery];
//        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:camera];
    [alert addAction:library];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)handleImageGallery
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSUInteger wrapWidth = 8;
            
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],0.5);
    UIImage *img = [[UIImage alloc] initWithData:dataImage];
    
    if (isLogoImage==YES) {
        
        base64LogoImg = [dataImage base64EncodedStringWithWrapWidth:wrapWidth];
        
//        base64LogoImg=[self encodeToBase64String:img];
    }else{
    
//        base64BannerImg=[dataImage base64EncodedStringWithWrapWidth:wrapWidth];
        [arrDataBannerImage addObject:dataImage];
    }
    
    
    
    
    
    if ([flatImg isEqualToString:@"coll"]) {
        
        int count= arrBannerImg.count;
        
        [arrBannerImg insertObject:img atIndex:count-1];

        [self.collectionView reloadData];
    }
    
    //    [self.imageView setImage:img];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    flatImg=@"";
    [self dismissModalViewControllerAnimated:YES];

}



// Encode and Decode Image in base64

-(NSString *)encodeToBase64String:(UIImage *)image {
    
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}




#pragma mark - Picker View Data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [_arrCategory count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSDictionary *dict=[_arrCategory objectAtIndex:row];
    NSString *title=[dict valueForKey:@"name"];
    NSString* string2 = [title stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    NSString *str= [string2 stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[string2 substringToIndex:1] uppercaseString]];
    [self.btnCategory setTitle:str forState:UIControlStateNormal];
    
    cat_id=[dict valueForKey:@"id"];
    [self.btnCategory setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSDictionary *dict=[_arrCategory objectAtIndex:row];
    NSString *title=[dict valueForKey:@"name"];
    NSString* string2 = [title stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    NSString *str= [string2 stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[string2 substringToIndex:1] uppercaseString]];
    
    
    return str;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return arrBannerImg.count;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier=@"collAdd";
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImageView *img=[cell viewWithTag:101];
    
    int num=arrBannerImg.count;
    
    
    if (indexPath.row==num-1) {
        
        img.image=[UIImage imageNamed:[arrBannerImg objectAtIndex:indexPath.row]];
    }else{
    
        [img setImage:[arrBannerImg objectAtIndex:indexPath.row]];
    }
    
    
    return cell;

}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    int count=arrBannerImg.count;
    
    if (indexPath.row==count-1) {
        flatImg=@"coll";
        isLogoImage=NO;
        [self OpenCameraLibraryAlert];
        
    }

}



// Search Google Address


- (IBAction)actionSearch:(id)sender {
    
    
   
    
}




#pragma Mark - Method for add place api

-(void)connectionforAddPlace:(NSString*)placeName andAddress:(NSString *)address andCategory:(NSString *)categoryId andPlaceLatitude:(NSString *)p_latitude andPlaceLongitude:(NSString *)p_longitude andOpenTime:(NSString *)openT andCloseTime:(NSString*)closeT andLogoImage:(NSString*)logoImg andBannerImage:(NSString*)bannerImg andUserId:(NSString*)user_id{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    
    [dict setObject:user_id forKey:@"userId"];
    [dict setObject:categoryId forKey:@"cat_id"];
    [dict setObject:placeName forKey:@"name"];
    [dict setObject:@"3" forKey:@"source"];
    [dict setObject:@"yes" forKey:@"own_created"];
    
    [dict setObject:address forKey:@"address"];
    [dict setObject:p_latitude forKey:@"lattitude"];
    [dict setObject:p_longitude forKey:@"longitude"];
    [dict setObject:openT forKey:@"opening_time"];
    [dict setObject:closeT forKey:@"closing_time"];
    [dict setObject:@"" forKey:@"image"];
//    [dict setObject:bannerImg forKey:@"image_banner"];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforAddPlace:) name:NotificationForAddPlace object:nil ];
    [[ServiceClass sharedServiceClass]hitServiceForAddPlaceByAF:dict];
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        
        [AppHelper showActivityIndicator:self.view];
    }
    
    
}

-(void)getresponseonhitforAddPlace:(NSNotification *)notifyInfo{


    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationForAddPlace object:nil ];
    
    
    if([[[notifyInfo userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        
        arrResponse=[[NSMutableArray alloc]init];
        arrResponse = [[notifyInfo userInfo] valueForKey:@"Result"];
        NSDictionary *dict=[[notifyInfo userInfo] valueForKey:@"Result"];
        [AppHelper hideActivityIndicator:self.view];
        
//        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notifyInfo userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
        if ([[[notifyInfo userInfo] valueForKey:@"isSuccess"] boolValue]==true) {
            
            [self connectionforImageUpload:arrDataBannerImage andLocationId:[dict valueForKey:@"id"]];
        }
        
        
    }
    else
    {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notifyInfo userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }


}


-(void)connectionforImageUpload:(NSMutableArray*)imageBanner andLocationId:(NSString*)locationId{

//    int count=[NSString stringWithFormat:@"%ld", arrDataBannerImage.count];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:locationId forKey:@"location_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld", arrDataBannerImage.count] forKey:@"totalImages"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getImageUploadResponse:) name:NotificationForAddImages object:nil ];
    [[ServiceClass sharedServiceClass]hitserviceForUploadImage:dict andImages:imageBanner];
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        
        [AppHelper showActivityIndicator:self.view];
    }


}

-(void)getImageUploadResponse:(NSNotification *)notifyInfo{


    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationForAddImages object:nil ];
    
    
    if([[[notifyInfo userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        
        arrResponse=[[NSMutableArray alloc]init];
        arrResponse = [[notifyInfo userInfo] valueForKey:@"Result"];
        [AppHelper hideActivityIndicator:self.view];
        
        [self actionBack:nil];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Place added successfully"  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
        
    }
    else
    {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notifyInfo userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }

}

@end
