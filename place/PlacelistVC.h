//
//  PlacelistVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 15/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/DFPBannerView.h>

#import "Define.h"




@interface PlacelistVC : UIViewController
- (IBAction)backBtntap:(id)sender;
- (IBAction)filterBtntap:(id)sender;



@property (weak, nonatomic) IBOutlet DFPBannerView *addBannerV;
@property (weak, nonatomic) IBOutlet UITextField *searchNearbyTF;
@property (weak, nonatomic) IBOutlet UITableView *placeListTV;
@property (strong,nonatomic) NSString *selectedtext;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
- (IBAction)searchClearbtnTap:(id)sender;
@property (strong,nonatomic) NSString *selectedLocat;
@end


