//
//  PlaceVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 01/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GooglePlaces/GooglePlaces.h>
#import <YelpAPI.h>
#import "YLPSortType.h"

@class YLPCoordinate;
@class YLPQuery;
@class YLPSearch;



@interface PlaceVC : UIViewController<CLLocationManagerDelegate,GMSAutocompleteViewControllerDelegate>

- (IBAction)backBtntap:(id)sender;



@end

