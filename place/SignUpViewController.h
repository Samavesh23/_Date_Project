//
//  SignUpViewController.h
//  place
//
//  Created by Yatharth Singh on 05/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Google/SignIn.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong)NSString *backFlag;


@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirmPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnSignup;
@property (strong, nonatomic) IBOutlet UIImageView *line1;
@property (strong, nonatomic) IBOutlet UIImageView *line2;
@property (strong, nonatomic) IBOutlet UIImageView *line3;
@property (strong, nonatomic) IBOutlet UIImageView *line4;
@property (strong, nonatomic) IBOutlet UIImageView *line5;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *lineOr;
@property (strong, nonatomic) IBOutlet UILabel *alreadyAmember;
- (IBAction)actnBack:(id)sender;
- (IBAction)actionSignUp:(id)sender;
- (IBAction)actionSignIn:(id)sender;


@end
