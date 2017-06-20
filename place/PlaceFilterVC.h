//
//  PlaceFilterVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 17/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@class PlaceFilterVC;
@protocol PlaceFilterVCDelegate <NSObject>

- (void)addItemVC:(PlaceFilterVC *)controller didFinishEnteringItem:(NSString *)item;

@end

@interface PlaceFilterVC : UIViewController<PlaceFilterVCDelegate>

@property (nonatomic, assign) id<PlaceFilterVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *categoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *pricerangeLbl;
@property (weak, nonatomic) IBOutlet UILabel *ratingLbl;

- (IBAction)backBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *distanceLbl;
- (IBAction)sortbysegmentTap:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sortbysegmentOutlet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSegmentCtrl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *distanceSegmentCtrl;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingView;
- (IBAction)priceSegmentTap:(id)sender;
- (IBAction)distancesegmentTap:(id)sender;


- (IBAction)popupClosebtnTap:(id)sender;



@end
