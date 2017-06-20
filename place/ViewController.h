//
//  ViewController.h
//  place
//
//  Created by Yatharth Singh on 04/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

//IBOulets

@property (strong, nonatomic) IBOutlet UIButton *signupBtnoutlet;
@property (strong, nonatomic) IBOutlet UIButton *loginBtnoutlet;

//Actions

- (IBAction)actionSignUp:(id)sender;
- (IBAction)actionSignIn:(id)sender;

@end

