//
//  Home2ViewController.h
//  place
//
//  Created by Yatharth Singh on 15/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home2ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)NSString *strId;
@property(strong, nonatomic)NSString *lat;
@property(strong, nonatomic)NSString *lon;
@property(strong, nonatomic)NSString *catImageUrl;

@end
