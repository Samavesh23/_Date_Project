//
//  MapViewController.h
//  place
//
//  Created by Yatharth Singh on 14/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKAnnotation,CLLocationManagerDelegate>

@property(nonatomic, strong)NSString *latitude;
@property(nonatomic, strong)NSString *longitude;

@end
