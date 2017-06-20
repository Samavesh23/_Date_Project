//
//  MenuVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 20/01/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MenuVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

- (IBAction)logotBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UITableView *menuTV;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)uploadimageBtntap:(id)sender;



@end
