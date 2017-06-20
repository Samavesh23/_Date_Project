//
//  SignInViewController.m
//  place
//
//  Created by Yatharth Singh on 05/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "SignInViewController.h"
#import "Define.h"



#define kOFFSET_FOR_KEYBOARD 160.0f


@interface SignInViewController (){

    NSString *loginType;
    NSMutableDictionary *dataDict;
    
}

@property (nonatomic, strong) ACAccountStore *accountStore;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayoutScreen];
    
   
    UITapGestureRecognizer *dissmiss=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:dissmiss];
    
    // Do any additional setup after loading the view.
    
    
    //NSString *myString = @"I have to replace text 'Dr Andrew Murphy, John Smith' ";
    NSString *myString = @"Not a member? Sign Up";
    
    //Create mutable string from original one
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
    
    //Fing range of the string you want to change colour
    //If you need to change colour in more that one place just repeat it
    NSRange range = [myString rangeOfString:@"Sign Up"];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(251/255.0) green:(49/255.0) blue:(79/255.0) alpha:1.0] range:range];
    
    //Add it to the label - notice its not text property but it's attributeText
    _notMemberlbl.attributedText = attString;
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



-(void)setLayoutScreen{

    
    _txtEmail.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Email Id" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _txtPassword.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    self.btnFacebook.layer.cornerRadius=4;
    self.btnSignIn.layer.cornerRadius=4;
    
}

-(void)hideKeyboard{

    [self.txtEmail resignFirstResponder];
    [self.txtPassword resignFirstResponder];

}


- (IBAction)actionBack:(id)sender {
    
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


- (IBAction)actionSignIn:(id)sender {
    
    [self hideKeyboard];
    loginType=@"0";
    NSRange whiteSpaceRangeEmail = [self.txtEmail.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];

    
    if ([self.txtEmail.text length]==0){
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Enter Email ID."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
    }else if ([self NSStringIsValidEmail:self.txtEmail.text]==NO)
    {
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please Enter Valid Email ID."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
    }else if (whiteSpaceRangeEmail.location != NSNotFound) {
        
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Email should not contain spaces."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
    }
    else if ([self.txtPassword.text length]==0){
    
        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password should not be blank"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }

    else
    {
        if ([[AppDelegate getAppDelegate] checkInternateConnection])
        {
          [AppHelper showActivityIndicator:self.view];
            
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:self.txtEmail.text forKey:@"email" ];
        [dict setObject:self.txtPassword.text forKey:@"password"];
        [dict setObject:@"iOS" forKey:@"device_type"];
        [dict setObject:@"kjdjkekw11832183hkbkuu12" forKey:@"device_token"];
        [dict setObject:loginType forKey:@"login_type"];
        [dict setObject:@"" forKey:@"social_id"];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforLogin:) name:NotificationSignInInfo object:nil ];
        [[ServiceClass sharedServiceClass]hitServiceForSighInByAF:dict];
        
        }
    
    }
    
}


-(void)getresponseonhitforLogin:(NSNotification *)notySignIn
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationSignInInfo object:nil ];
    
    
    if([[[notySignIn userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        [AppHelper hideActivityIndicator:self.view];

        NSDictionary *userData = [[notySignIn userInfo] valueForKey:@"Result"];
        [AppHelper saveToUserDefaults:userData withKey:@"userdata"];
        [AppHelper saveToUserDefaults:@"yes" withKey:@"registered"];
        IIViewDeckController *viewDeck = [[IIViewDeckController alloc] initWithCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"] leftViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MenuVC"]];
        [self.navigationController pushViewController:viewDeck animated:YES];
        
        
        
    }
    else
    {
        if ([[AppDelegate getAppDelegate] checkInternateConnection])
        {
             [AppHelper showActivityIndicator:self.view];
             if ([loginType isEqualToString:@"1"])
           {
               
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            [dict setObject:[dataDict valueForKey:@"name"] forKey:@"name"];
            [dict setObject:@"" forKey:@"email" ];
            [dict setObject:@"" forKey:@"mobile"];
            [dict setObject:@"" forKey:@"password"];
            [dict setObject:@"iOS" forKey:@"device_type"];
            [dict setObject:@"kjdjkekw11832183hkbkuu12" forKey:@"device_token"];
            [dict setObject:loginType forKey:@"login_type"];
            [dict setObject:[dataDict valueForKey:@"socialId"] forKey:@"social_id"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforFBSignUp:) name:NotificationSignUpInfo object:nil ];
            [[ServiceClass sharedServiceClass]hitServiceForSignUpByAF:dict];
            
           }
            else
            {
                 [AppHelper hideActivityIndicator:self.view];
                [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignIn userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
            }
        }
        else
        {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignIn userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        }
    }
    
}


- (IBAction)actionFacebook:(id)sender {
    
    
    if([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        loginType=@"1";
        FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
        [manager logOut];
        //[FBSDKAccessToken setCurrentAccessToken:nil];
//        [AppHelper saveToUserDefaults:@"fb" withKey:@"signwith"];

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getFacebookData:) name:FbDataNotification object:nil];
        [AppHelper getfb:_accountStore];
        
        
        
    }
    else
    {

        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Connection Error. Please check your internet connection and try again." cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
}

-(void)getFacebookData:(NSNotification *)fbData

{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FbDataNotification object:nil];
    
    dataDict= [[fbData userInfo]mutableCopy];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:@"" forKey:@"email" ];
    [dict setObject:@"" forKey:@"password"];
    [dict setObject:@"iOS" forKey:@"device_type"];
    [dict setObject:@"kjdjkekw11832183hkbkuu12" forKey:@"device_token"];
    [dict setObject:loginType forKey:@"login_type"];
    [dict setObject:[dataDict valueForKey:@"socialId"] forKey:@"social_id"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforLogin:) name:NotificationSignInInfo object:nil ];
    [[ServiceClass sharedServiceClass]hitServiceForSighInByAF:dict];
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        
        [AppHelper showActivityIndicator:self.view];
    }
    
    
    
}





- (IBAction)actionForgotPassword:(id)sender {
    
    ForgotPasswordViewController *fpvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:fpvc animated:YES];
    
}

- (IBAction)actionSignup:(id)sender
{
    SignUpViewController *SUvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:SUvc animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag !=0) {
        CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y-kOFFSET_FOR_KEYBOARD);
        
    }
    if (textField.tag==0) {
        
        [self.line1 setBackgroundColor:HeaderColor];
        
    }
    
    switch (textField.tag) {
        case 0:
            [self.line1 setBackgroundColor:HeaderColor];
            [self.line2 setBackgroundColor:[UIColor lightGrayColor]];
            break;
        case 1:
            [self.line1 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line2 setBackgroundColor:HeaderColor];
            break;
            
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            [self.txtPassword becomeFirstResponder];
            break;
        case 1:
            [self.txtPassword resignFirstResponder];
            break;
            
        default:
            break;
    }
    if (textField.tag==1)
        return YES;
    else
        return NO;
}




-(void)getresponseonhitforFBSignUp:(NSNotification *)notySignup
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationSignUpInfo object:nil ];
    
    [AppHelper hideActivityIndicator:self.view];
    if([[[notySignup userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        NSDictionary *userData = [[notySignup userInfo] valueForKey:@"Result"];
        
        [AppHelper saveToUserDefaults:userData withKey:@"userdata"];
         [AppHelper saveToUserDefaults:@"yes" withKey:@"registered"];
        IIViewDeckController *viewDeck = [[IIViewDeckController alloc] initWithCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"] leftViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MenuVC"]];
        
        [self.navigationController pushViewController:viewDeck animated:YES];
        
        
    }
    else
    {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignup userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
}



@end
