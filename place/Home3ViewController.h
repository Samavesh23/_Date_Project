//
//  Home3ViewController.h
//  place
//
//  Created by Yatharth Singh on 13/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home3ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong, nonatomic)NSMutableArray *arrReview;
@property(strong, nonatomic)NSArray *arrCategory;
@property(strong, nonatomic)NSString *strId;
@property(strong, nonatomic)NSString *strPlaceId;
@property(strong, nonatomic)NSString *flag;
@property(strong, nonatomic)NSString *imageBanner;

@end
