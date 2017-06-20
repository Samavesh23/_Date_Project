//
//  MyAccountVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 01/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "MyAccountVC.h"
#import "Define.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface MyAccountVC ()
{
    UIActionSheet *actionSheet;
     NSString *imaGe;
}
@end

@implementation MyAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self loadScreendata];
    
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


-(void)loadScreendata
{
    imaGe=@"";
    _editBtnoutlet.layer.cornerRadius=5;
    _editBtnoutlet.layer.borderWidth=1;
    _editBtnoutlet.layer.borderColor=HeaderColor.CGColor;
    _updateBtnoutlet.layer.cornerRadius=5;
    _updateBtnoutlet.layer.borderWidth=1;
    _updateBtnoutlet.layer.borderColor=HeaderColor.CGColor;
    _userImgView.layer.cornerRadius=_userImgView.frame.size.width/2;
    
    NSDictionary *dict=[AppHelper userDefaultsForKey:@"userdata"];
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"image_link"]]  ;
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url];
    
    [_userImgView setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"default"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         // UIImage *imag= [AppHelper resizeImage:image newSize:CGSizeMake(image.size.width,image.size.height)];
         _userImgView.image=image;
         //[_userImgView sizeToFit];
     }
                                 failure:NULL];
    _userImgView.clipsToBounds=YES;
    _namTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Name" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _ageTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Age" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _genderTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _emailTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _mobilenoTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Mobile" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _passwordTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    _namTF.text=[[AppHelper userDefaultsForKey:@"userdata"]valueForKey:@"name"];
    _ageTF.text=[[AppHelper userDefaultsForKey:@"userdata"]valueForKey:@"age"];
    _genderTF.text=[[AppHelper userDefaultsForKey:@"userdata"]valueForKey:@"gender"];
    _emailTF.text=[[AppHelper userDefaultsForKey:@"userdata"]valueForKey:@"email"];
    _mobilenoTF.text=[[AppHelper userDefaultsForKey:@"userdata"]valueForKey:@"mobile"];
    _passwordTF.text=[[AppHelper userDefaultsForKey:@"userdata"]valueForKey:@"password"];
    
}

- (IBAction)bckBtntap:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (IBAction)uploadBtntap:(id)sender
{
    actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                              delegate: self
                                     cancelButtonTitle: @"Cancel"
                                destructiveButtonTitle: nil
                                     otherButtonTitles: @"Take a new photo", @"Choose from existing", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self takeNewPhotoFromCamera];
            break;
        case 1:
            [self choosePhotoFromExistingImages];
        default:
            break;
    }
}

- (void)takeNewPhotoFromCamera
{
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.allowsEditing = NO;
        // controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        controller.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        controller.delegate = self;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                
                
                [self.navigationController presentViewController: controller animated: YES completion: nil];
            }];
            
        }
        else
        {
            
            [self.navigationController presentViewController: controller animated: YES completion: nil];
        }
    }
    
}
-(void)choosePhotoFromExistingImages
{
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;
        // controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        controller.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        controller.delegate = self;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self.navigationController presentViewController: controller animated: YES completion: nil];
                
            }];
            
        }
        else
        {
            
            [self.navigationController presentViewController: controller animated: YES completion: nil];
        }
    }
    
    
    
    
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // imaGe = [info valueForKey:UIImagePickerControllerOriginalImage];
    
   // imgType=@"image";
    
    UIImage *newImage = [AppHelper scaleAndRotateImage:[info valueForKey:UIImagePickerControllerOriginalImage]];
    _userImgView.image = newImage;
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data=UIImageJPEGRepresentation(newImage,0.5);
        imaGe = [NSString base64StringFromData:data length:[data length]];
        
    });
    
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)editBtntap:(id)sender
{
    _editBtnoutlet.hidden=YES;
    _updateBtnoutlet.hidden=NO;
    
}

-(void)updateProfile
{
    NSString *nameRegex = @"[A-Za-z]+[[\\s][A-Za-z]+]*";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    bool isCheckStringValid = [nameTest evaluateWithObject:self.namTF.text];
    
    NSString *phoneRegex = @"[+][0-9]{6,15}|[0-9]{6,15}";
    
    NSPredicate *phoneTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    NSString *foo = self.passwordTF.text;
    NSRange whiteSpaceRange = [foo rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSRange whiteSpaceRangeEmail = [self.emailTF.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
        [AppHelper removeSpaces:self.passwordTF.text];
    
        
        if ([self.namTF.text length]==0) {
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Name Should not be blank."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if ([self.namTF.text length]<2)
        {
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Full Name should not be Less than 2 Alphabets." cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        }
    
        else if ([self.emailTF.text length]==0){
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Enter Email ID."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }
        else if ([AppHelper validEmail:self.emailTF.text]==NO)
        {
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please Enter Valid Email ID."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if (whiteSpaceRangeEmail.location != NSNotFound) {
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Email should not contain spaces."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if ([self.mobilenoTF.text length]==0){
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please Enter Phone Number."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if (![phoneTestPredicate evaluateWithObject:self.mobilenoTF.text] == YES)
        {
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Phone number should contain atleast 6 digits" cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
        else if ([self.passwordTF.text isEqualToString:@""])
        {
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password Should not be blank"   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if (self.passwordTF.text.length<8||self.passwordTF.text.length>16)
        {
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password Must contain 8 characters"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        }
        else if (whiteSpaceRange.location != NSNotFound) {
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password should not contain spaces."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }
    
        else
        {
            if ([[AppDelegate getAppDelegate] checkInternateConnection])
            {
                NSDictionary *userData=[AppHelper userDefaultsForKey:@"userdata"];
                
                [AppHelper showActivityIndicator:self.view];
                NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                [dict setObject:[userData objectForKey:@"id"] forKey:@"id" ];
                [dict setObject:self.namTF.text forKey:@"name" ];
                [dict setObject:self.ageTF.text forKey:@"age" ];
                [dict setObject:self.passwordTF.text forKey:@"password"];
                [dict setObject:self.emailTF.text forKey:@"email"];
                [dict setObject:@"asdasddddecdececed123e32312" forKey:@"device_token"];
                [dict setObject:@"iOS" forKey:@"device_type"];
                [dict setObject:[userData objectForKey:@"login_type"] forKey:@"login_type"];
                [dict setObject:imaGe forKey:@"image_link"];
                [dict setObject:self.mobilenoTF.text forKey:@"mobile"];
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforUpdateprofile:) name:NotificationForUpdateProfile object:nil ];
                [[ServiceClass sharedServiceClass]hitServiceForUpdateProfile:dict];
                
                
                
            }
            
        }
        
        
    

}

-(void)getresponseonhitforUpdateprofile:(NSNotification *)notySignup
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationForUpdateProfile object:nil ];
    
    [AppHelper hideActivityIndicator:self.view];
    if([[[notySignup userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        NSDictionary *userData = [[notySignup userInfo] valueForKey:@"Result"];
        [AppHelper saveToUserDefaults:userData withKey:@"userdata"];
        [AppHelper saveToUserDefaults:@"yes" withKey:@"registered"];
        //            HomeViewController *nextView = [[self storyboard] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        //            [self.navigationController pushViewController:nextView animated:YES];
        
       
        
    }
    else
    {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignup userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
}

- (IBAction)updateBtntap:(id)sender
{
    [self updateProfile];
}
@end
