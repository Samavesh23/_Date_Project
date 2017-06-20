//
//  HomeViewController.h
//  place
//
//  Created by Yatharth Singh on 06/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMobileAds/DFPBannerView.h>
#import <GooglePlaces/GooglePlaces.h>


@interface HomeViewController : UIViewController<UIActionSheetDelegate,CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,GMSAutocompleteViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property(strong, nonatomic)NSString *flag;
- (IBAction)menuBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet DFPBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCV;
- (IBAction)locationBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *datesTV;
- (IBAction)searchClearBtntap:(id)sender;

@end
