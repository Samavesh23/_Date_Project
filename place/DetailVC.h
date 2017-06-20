//
//  DetailVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 01/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import <MapKit/MapKit.h>


@class DetailVC;

@protocol DetailVCDelegate <NSObject>
- (void)addItemViewController:(DetailVC *)controller didFinishEnteringItem:(NSString *)item;

@end

@interface DetailVC : UIViewController<MKMapViewDelegate>

- (IBAction)bckBtntap:(id)sender;

@property (weak, nonatomic) IBOutlet DFPBannerView *addView1;
@property (weak, nonatomic) IBOutlet MKMapView *mapKitView;
@property (nonatomic, strong) id <DetailVCDelegate> delegate;
@property (strong,nonatomic) NSMutableDictionary *catDetail;
@property (strong,nonatomic) NSString *fromDB;
@property (strong,nonatomic) NSIndexPath *indx;
@property (strong,nonatomic) NSMutableArray *businessReviewsArray;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reviewTVHeigtConstraint;


- (IBAction)favBtnatp:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ratingLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UIImageView *staroneImgView;
@property (weak, nonatomic) IBOutlet UIImageView *star2ImgView;
@property (weak, nonatomic) IBOutlet UIImageView *star3ImgView;
@property (weak, nonatomic) IBOutlet UIImageView *star4ImgView;
@property (weak, nonatomic) IBOutlet UIImageView *star5ImgView;
@property (weak, nonatomic) IBOutlet UILabel *daysLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *favLbl;
@property (weak, nonatomic) IBOutlet UILabel *websiteLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;

@property (weak, nonatomic) IBOutlet UITableView *reviewTV;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *phnNoLbl;
- (IBAction)websiteBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *datenameLbl;

- (IBAction)phnBtnTap:(id)sender;
- (IBAction)scheduleaplanBtnTap:(id)sender;
- (IBAction)reviewsdropdownBtnTap:(id)sender;

@end
