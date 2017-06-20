//
//  ResetPasswordVC.m
//  place
//
//  Created by Yatharth Singh on 14/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "ServiceClass.h"
#import "Define.h"
#import "AppHelper.h"
#import "AppDelegate.h"

@interface ResetPasswordVC ()

@property (strong, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;



- (IBAction)actionBack:(id)sender;
- (IBAction)actionSubmit:(id)sender;

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *dissMiss=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:dissMiss];

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

-(void)hideKeyboard{

    [self.txtPassword resignFirstResponder];
    [self.txtMobileNumber resignFirstResponder];

}

- (IBAction)actionBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionSubmit:(id)sender {
    
    [self hideKeyboard];
    
    NSRange whiteSpaceRangeEmail = [self.txtMobileNumber.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([self.txtPassword.text length]==0){
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password should not be blank"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
    
    else{
        
        /*
         {
         "userId"                :       " "
         "newPassword"    :       " "
         }	         */
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:self.txtMobileNumber.text forKey:@"userId" ];
        [dict setObject:self.txtPassword.text forKey:@"newPassword"];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforResetPass:) name:NotificationChangePasswordInfo object:nil ];
        [[ServiceClass sharedServiceClass]hitServiceForChangePasswordByAF:dict];
        
        if ([[AppDelegate getAppDelegate] checkInternateConnection])
        {
            
            [AppHelper showActivityIndicator:self.view];
        }
        
    }
    
}

- (IBAction)actionSignIn:(id)sender {
    
    
    
    
//    if ([self.txtEmail.text length]==0){
//        
//        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Enter Email ID."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        
//    }else if ([self NSStringIsValidEmail:self.txtEmail.text]==NO)
//    {
//        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please Enter Valid Email ID."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        
//    }else if (whiteSpaceRangeEmail.location != NSNotFound) {
//        
//        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Email should not contain spaces."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        
//    }
     if ([self.txtPassword.text length]==0){
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password should not be blank"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
    
    else{
        
        /*
         {
         "userId"                :       " "
         "newPassword"    :       " "
         }	         */
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:self.txtMobileNumber.text forKey:@"userId" ];
        [dict setObject:self.txtPassword.text forKey:@"newPassword"];

        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforResetPass:) name:NotificationChangePasswordInfo object:nil ];
        [[ServiceClass sharedServiceClass]hitServiceForChangePasswordByAF:dict];
        
        if ([[AppDelegate getAppDelegate] checkInternateConnection])
        {
            
            [AppHelper showActivityIndicator:self.view];
        }
        
    }
    
}


-(void)getresponseonhitforResetPass:(NSNotification *)notySignup
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationChangePasswordInfo object:nil ];
    
    
    if([[[notySignup userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        NSArray *userData = [[notySignup userInfo] valueForKey:@"Result"];
        NSArray *fullName = [[NSArray alloc] initWithObjects:[userData valueForKey:@"firstName"],[userData valueForKey:@"lastName"], nil];
        NSString *joinedString = [fullName componentsJoinedByString:@" "];
//        [AppHelper saveToUserDefaults:[userData valueForKey:@"email"] withKey:@"email"];
//        [AppHelper saveToUserDefaults:[userData valueForKey:@"name"] withKey:@"name"];
//        [AppHelper saveToUserDefaults:[userData valueForKey:@"mobile"] withKey:@"mobile"];
//        [AppHelper saveToUserDefaults:[userData valueForKey:@"password"] withKey:@"password"];
        NSLog(@"%@", [AppHelper userDefaultsForKey:@"firstName"]);
        
        NSString *abc = [userData valueForKey:@"user_id"];
        [AppHelper hideActivityIndicator:self.view];
//        [AppHelper saveToUserDefaults:@"yes" withKey:@"registered"];
        
        
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignup userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
       
        
        
        
        
    }
    else
    {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignup userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
}



@end
