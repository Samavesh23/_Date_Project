//
//  PlanScheduleVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 28/03/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FSCalendar.h>
#import "DataBase.h"
@interface PlanScheduleVC : UIViewController

- (IBAction)bckBtnTap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bottomLbl;
@property (weak, nonatomic) IBOutlet UIDatePicker *timepickeroutlet;
@property (strong, nonatomic) IBOutlet FSCalendar *calender;
@property (strong, nonatomic) IBOutlet NSCalendar *gregorian;
- (IBAction)planascheduleBtnTap:(id)sender;
@property (strong,nonatomic) NSMutableDictionary *planDict;
@property (strong,nonatomic) NSString *placename;
@property (strong,nonatomic) NSString *fromScrn;
@property (weak, nonatomic) IBOutlet UIButton *savebtnOutlet;
- (IBAction)shareDateBtnTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shreBtnOutlet;
@property (strong,nonatomic) SchedulePlan *splan;
@property (strong,nonatomic) Favorite *fav;
@property (weak, nonatomic) IBOutlet UIView *shareviewOutlet;

@end
