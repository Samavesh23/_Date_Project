//
//  DemoVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 03/05/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *demoTV;
- (IBAction)menuBtnTap:(id)sender;

@end
