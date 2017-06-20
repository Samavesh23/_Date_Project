//
//  DemoCell.h
//  Its a Date
//
//  Created by Yatharth Singh on 03/05/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;

@end
