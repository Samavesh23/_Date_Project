//
//  MyAccountVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 01/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *namTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *genderTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *mobilenoTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
- (IBAction)bckBtntap:(id)sender;
- (IBAction)uploadBtntap:(id)sender;
- (IBAction)editBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editBtnoutlet;
- (IBAction)updateBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *updateBtnoutlet;

@end
