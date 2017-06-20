//
//  ForgotPasswordViewController.m
//  place
//
//  Created by Yatharth Singh on 05/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "Define.h"


@interface ForgotPasswordViewController ()




@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnSubmit.layer.cornerRadius=5;
    self.btnSubmit.layer.borderWidth=1;
    self.btnSubmit.layer.borderColor=HeaderColor.CGColor;
    
     _txtMobileNumber.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Email Id" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    UITapGestureRecognizer *dissmiss=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:dissmiss];
    
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

    [self.txtMobileNumber resignFirstResponder];
}

- (IBAction)actnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    
    
    return [emailTest evaluateWithObject:checkString];
}


- (IBAction)actionSubmit:(id)sender {
    
    [self hideKeyboard];
    
    NSRange whiteSpaceRangeEmail = [self.txtMobileNumber.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([self.txtMobileNumber.text length]==0){
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Enter Email ID."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
    }else if ([AppHelper validEmail:self.txtMobileNumber.text]==NO)
    {
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please Enter Valid Email ID."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
    }else if (whiteSpaceRangeEmail.location != NSNotFound) {
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Email should not contain spaces."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
    }else {
        if ([[AppDelegate getAppDelegate] checkInternateConnection])
        {
            
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:self.txtMobileNumber.text forKey:@"email"];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforForgotPassword:) name:NotificationForgotPSWRD object:nil ];
        [[ServiceClass sharedServiceClass]hitServiceForgotPSWRDByAF:dict];
        
        
            
            [AppHelper showActivityIndicator:self.view];
        }
 
    
    }
}

-(void)getresponseonhitforForgotPassword:(NSNotification *)notySignup
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationForgotPSWRD object:nil ];
    
     [AppHelper hideActivityIndicator:self.view];
    if([[[notySignup userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {

        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password was sent successfully to your email ID"  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
        [self.navigationController popViewControllerAnimated:YES];
       // [self actnBack:nil];
        
    }
    else
    {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignup userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
}
@end
