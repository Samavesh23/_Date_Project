//
//  ForgotPasswordViewController.h
//  place
//
//  Created by Yatharth Singh on 05/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UITextField *txtMobileNumber;




- (IBAction)actnBack:(id)sender;

- (IBAction)actionSubmit:(id)sender;



@end
