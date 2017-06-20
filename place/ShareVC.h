//
//  ShareVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 01/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareVC : UIViewController
- (IBAction)bckBtntap:(id)sender;
- (IBAction)facebookBtnTap:(id)sender;
- (IBAction)whatsappBtntap:(id)sender;
- (IBAction)twitterBtntap:(id)sender;
- (IBAction)linkedinBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *facebookBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *whatsappBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *twitterBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *linkedInBtnOutlet;

@end
