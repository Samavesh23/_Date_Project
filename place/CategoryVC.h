//
//  CategoryVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 31/01/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
//#import "FTFoldingTableView.h"

@interface CategoryVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
- (IBAction)bckBtntap:(id)sender;

@property (strong,nonatomic) NSString *selectedCat;
@property (strong,nonatomic) NSMutableArray *categoriesArray;
@property (weak, nonatomic) IBOutlet UIImageView *imagView;
@property (weak, nonatomic) IBOutlet UITableView *SubCatTV;
@property (weak, nonatomic) IBOutlet DFPBannerView *addBanner;

@end
