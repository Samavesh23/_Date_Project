//
//  PlaceVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 01/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "PlaceVC.h"
#import "Define.h"
#import <YelpAPI/YelpAPI.h>
#import "YLPClient+Search.h"
#import "YLPCoordinate.h"
#import "YLPQuery.h"
#import "YelpClient.h"

@import GooglePlacePicker;

@interface PlaceVC ()

{
    GMSPlacesClient *_placesClient;
    GMSPlacePicker *_placePicker;
    
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic) YLPSearch *search;
@property (nonatomic) YLPCoordinate *cordinate;
@property (nonatomic, strong) YelpClient  *client;
@end

@implementation PlaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [[YLPAppDelegate sharedClient] searchWithLocation:@"San Francisco, CA" term:nil limit:5 offset:0 sort:YLPSortTypeDistance completionHandler:^
//     (YLPSearch *search, NSError* error) {
//         self.search = search;
//         dispatch_async(dispatch_get_main_queue(), ^{
//             [self.tableView reloadData];
//         });
//     }];
   
   
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
   
    _placesClient = [GMSPlacesClient sharedClient];
    
   
    
    
    
    [self getPlaces];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)getPlaces
{
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    
    
   /* CLLocationCoordinate2D center = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001);
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    
    [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            NSLog(@"Place name %@", place.name);
            NSLog(@"Place address %@", place.formattedAddress);
            NSLog(@"Place attributions %@", place.attributions.string);
    
        } else {
            NSLog(@"No place selected");
        }
    }];*/
}


// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    [self getdataBylocationYelp:place.name];
   
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}



// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (IBAction)backBtntap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getdataBylocationYelp:(NSString *)location
{
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
    [dictionary setObject:location forKey:@"location"];
   
    
    [self .client searchWithDictionary:dictionary success:^(AFHTTPRequestOperation *operation, id response)
     {
         NSLog(@"Yelp response ====== %@",response);
         
     }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         NSLog(@"error: %@", [error description]);
     }];

}

@end
