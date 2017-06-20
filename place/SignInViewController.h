//
//  SignInViewController.h
//  place
//
//  Created by Yatharth Singh on 05/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
//#import <Google/SignIn.h>

@interface SignInViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UIButton *btnFacebook;

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIImageView *line1;
@property (strong, nonatomic) IBOutlet UIImageView *line2;
@property (strong, nonatomic) IBOutlet UILabel *notMemberlbl;


- (IBAction)actionBack:(id)sender;
- (IBAction)actionSignIn:(id)sender;
- (IBAction)actionFacebook:(id)sender;
- (IBAction)actionSignup:(id)sender;
- (IBAction)actionForgotPassword:(id)sender;
@end
