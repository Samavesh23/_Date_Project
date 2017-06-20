//
//  SignUpViewController.m
//  place
//
//  Created by Yatharth Singh on 05/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "SignUpViewController.h"
#import "Define.h"


#define kOFFSET_FOR_KEYBOARD 160.0f


@interface SignUpViewController ()
{
    AppHelper *appHelper;
    int loginType;
    NSString *userFirstName;
    NSString *userIdentifier;
    NSString *userEmail;
    NSMutableDictionary *dataDict;
    NSString *base64BannerImg;
}


@property (nonatomic, strong) ACAccountStore *accountStore;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayoutScreen];
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

-(void)setLayoutScreen{

    _btnSignup .layer.cornerRadius=5;
    _btnSignup.layer.borderWidth=1;
    _btnSignup.layer.borderColor=HeaderColor.CGColor;
    
   
    
    self.imgProfile.layer.cornerRadius=self.imgProfile.frame.size.height/2;
    self.imgProfile.clipsToBounds=YES;
    
    
    //NSString *myString = @"I have to replace text 'Dr Andrew Murphy, John Smith' ";
    NSString *myString = @"Allready have an Account? Log In";
    
    //Create mutable string from original one
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
    
    //Fing range of the string you want to change colour
    //If you need to change colour in more that one place just repeat it
    NSRange range = [myString rangeOfString:@"Log In"];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(251/255.0) green:(49/255.0) blue:(79/255.0) alpha:1.0] range:range];
    
    //Add it to the label - notice its not text property but it's attributeText
    _alreadyAmember.attributedText = attString;
    
    _txtName.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Name" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _txtEmail.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Email Id" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _txtPhoneNumber.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Mobile Number" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _txtPassword.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _txtConfirmPassword.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
}

-(void)hideKeyboard{

    [self.txtName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtPhoneNumber resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtConfirmPassword resignFirstResponder];

}




- (IBAction)actionBack:(id)sender {
    
    if (loginType==1) {
        
        self.line4.hidden=NO;
        self.line5.hidden=NO;
        
        self.txtPassword.hidden=NO;
        self.txtConfirmPassword.hidden=NO;
        
        
        self.lineOr.hidden=NO;
        
        self.txtEmail.text=@"";
        self.txtName.text=@"";
        self.txtPhoneNumber.text=@"";
        
        [self.btnSignup setBackgroundImage:[UIImage imageNamed:@"icon_signUp.png"] forState:UIControlStateNormal];
        
        
        loginType=0;
        
    }else if (loginType==2){
        
        self.line4.hidden=NO;
        self.line5.hidden=NO;
        
        self.txtPassword.hidden=NO;
        self.txtConfirmPassword.hidden=NO;
        
        
        self.lineOr.hidden=NO;
        
        self.txtEmail.text=@"";
        self.txtName.text=@"";
        self.txtPhoneNumber.text=@"";
        
        [self.btnSignup setBackgroundImage:[UIImage imageNamed:@"icon_signUp.png"] forState:UIControlStateNormal];
       
        
        loginType=0;
    
    }else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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


- (IBAction)actionSignUp:(id)sender {
    
    [self hideKeyboard];
    
    NSString *nameRegex = @"[A-Za-z]+[[\\s][A-Za-z]+]*";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    bool isCheckStringValid = [nameTest evaluateWithObject:self.txtName.text];

    NSString *phoneRegex = @"[+][0-9]{6,15}|[0-9]{6,15}";
    
    NSPredicate *phoneTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    NSString *foo = self.txtPassword.text;
    NSRange whiteSpaceRange = [foo rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSRange whiteSpaceRangeEmail = [self.txtEmail.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if (loginType==0) {
        
        [AppHelper removeSpaces:self.txtPassword.text];
        [AppHelper removeSpaces:self.txtConfirmPassword.text];
        
        if ([self.txtName.text length]==0) {
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Name Should not be blank."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if ([self.txtName.text length]<2)
        {
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Full Name should not be Less than 2 Alphabets." cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        }
//        if (isCheckStringValid!=YES) {
//        
//        [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Full Name can contain only Uppercase/lowercase letters."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            
//        }
        else if ([self.txtEmail.text length]==0){
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Enter Email ID."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }
    else if ([self NSStringIsValidEmail:self.txtEmail.text]==NO)
        {
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please Enter Valid Email ID."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if (whiteSpaceRangeEmail.location != NSNotFound) {
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Email should not contain spaces."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if ([self.txtPhoneNumber.text length]==0){
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please Enter Phone Number."   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if (![phoneTestPredicate evaluateWithObject:self.txtPhoneNumber.text] == YES)
        {
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Phone number should contain atleast 6 digits" cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
        else if ([self.txtPassword.text isEqualToString:@""])
        {
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password Should not be blank"   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if (self.txtPassword.text.length<8||self.txtPassword.text.length>16)
        {
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password Must contain 8 characters"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        }
        else if (whiteSpaceRange.location != NSNotFound) {
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password should not contain spaces."  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if ([self.txtConfirmPassword.text isEqualToString:@""]){
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Please enter Confirm Password"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }else if (![self.txtPassword.text isEqualToString:self.txtConfirmPassword.text]){
            
            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password does'nt match"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
        }
//        else if (self.txtConfirmPassword.text.length<8||self.txtConfirmPassword.text.length>16)
//        {
//            [[AppDelegate getAppDelegate] alert:APP_NAME message:@"Password Must contain 8 characters"  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        }
        else
        {
            if ([[AppDelegate getAppDelegate] checkInternateConnection])
            {
                [AppHelper showActivityIndicator:self.view];
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            [dict setObject:self.txtName.text forKey:@"name" ];
            [dict setObject:self.txtPassword.text forKey:@"password"];
            [dict setObject:self.txtEmail.text forKey:@"email"];
            [dict setObject:@"asdasd" forKey:@"device_token"];
            [dict setObject:@"iOS" forKey:@"device_type"];
            [dict setObject:@"0" forKey:@"login_type"];
            [dict setObject:@"" forKey:@"social_id"];
            [dict setObject:self.txtPhoneNumber.text forKey:@"mobile"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getresponseonhitforSignUp:) name:NotificationSignUpInfo object:nil ];
            [[ServiceClass sharedServiceClass]hitServiceForSignUpByAF:dict];
            
            
               
            }
            
        }
        
        
    }
    
    
}

-(void)getresponseonhitforSignUp:(NSNotification *)notySignup
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationSignUpInfo object:nil ];
    
    [AppHelper hideActivityIndicator:self.view];
    if([[[notySignup userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        NSDictionary *userData = [[notySignup userInfo] valueForKey:@"Result"];
          [AppHelper saveToUserDefaults:userData withKey:@"userdata"];
    [AppHelper saveToUserDefaults:@"yes" withKey:@"registered"];
//            HomeViewController *nextView = [[self storyboard] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//            [self.navigationController pushViewController:nextView animated:YES];
        
        IIViewDeckController *viewDeck = [[IIViewDeckController alloc] initWithCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"] leftViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MenuVC"]];
        
        [self.navigationController pushViewController:viewDeck animated:YES];
        
    }
    else
    {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notySignup userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag !=0) {
       // CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y-kOFFSET_FOR_KEYBOARD);
       
    }
    
    if (textField.tag==0) {
        
        [self.line1 setBackgroundColor:HeaderColor];
        
    }
    
    switch (textField.tag) {
        case 0:
            [self.line1 setBackgroundColor:HeaderColor];
            [self.line2 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line3 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line4 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line5 setBackgroundColor:[UIColor lightGrayColor]];
            break;
        case 1:
            [self.line1 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line2 setBackgroundColor:HeaderColor];
            [self.line3 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line4 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line5 setBackgroundColor:[UIColor lightGrayColor]];
            break;

            
        case 2:
            
            [self.line1 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line2 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line3 setBackgroundColor:HeaderColor];
            [self.line4 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line5 setBackgroundColor:[UIColor lightGrayColor]];
            break;

            
        case 3:
            
            [self.line1 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line2 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line3 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line4 setBackgroundColor:HeaderColor];
            [self.line5 setBackgroundColor:[UIColor lightGrayColor]];
            break;

            
        case 4:
            
            [self.line1 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line2 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line3 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line4 setBackgroundColor:[UIColor lightGrayColor]];
            [self.line5 setBackgroundColor:HeaderColor];
            break;

            
        default:
            break;
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            [self.txtEmail becomeFirstResponder];
            break;
        case 1:
            [self.txtPhoneNumber becomeFirstResponder];
            break;
            
        case 2:
            [self.txtPassword becomeFirstResponder];
            break;
        case 3:
            [self.txtConfirmPassword becomeFirstResponder];
            break;
        case 4:
            [self.txtConfirmPassword resignFirstResponder];
            break;
        default:
            break;
    }
    if (textField.tag==4)
        return YES;
    else
        return NO;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range     replacementString:(NSString *)string
{
    
    if (textField.tag==0) {
        if (self.txtName.text.length >= 30 && range.length == 0)
            return NO;
    }else if (textField.tag==2) {
        if (self.txtPhoneNumber.text.length >= 15 && range.length == 0)
            return NO;
    }else if (textField.tag==3){
        if (self.txtPassword.text.length >= 16 && range.length == 0)
            return NO;
    }else if (textField.tag==4){
        if (self.txtConfirmPassword.text.length >= 16 && range.length == 0)
            return NO;
    }
    
    return YES;
}

- (IBAction)actnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionSignIn:(id)sender
{
    SignInViewController *SIVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self.navigationController pushViewController:SIVC animated:YES];
}

@end
