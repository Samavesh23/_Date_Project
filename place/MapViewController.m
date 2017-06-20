//
//  MapViewController.m
//  place
//
//  Created by Yatharth Singh on 14/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "MapViewController.h"
#import <AddressBook/AddressBook.h>


@interface MapViewController (){

    NSString *latitude,*longitude;
    CLLocationManager *locationManager;
    CLLocation *location;
    CLLocationCoordinate2D currentCentre;

}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)actionBack:(id)sender;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    [self performSelector:@selector(zoomInToMyLocation)
//               withObject:nil
//               afterDelay:5];
    
    [self zoomInToMyLocation];
    
    CLLocationCoordinate2D pinlocation;
    pinlocation.latitude = [_latitude doubleValue] ;//set latitude of selected coordinate ;
    pinlocation.longitude = [_longitude doubleValue] ;//set longitude of selected coordinate;
    
    // Create Annotation point
    MKPointAnnotation *Pin = [[MKPointAnnotation alloc]init];
    Pin.coordinate = pinlocation;
//    Pin.title = @"Annotation Title";
//    Pin.subtitle = @"Annotation Subtitle";
    
    // add annotation to mapview
    [_mapView addAnnotation:Pin];
    

    
    // Do any additional setup after loading the view.
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

- (IBAction)actionBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)zoomInToMyLocation
{
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [_latitude floatValue] ;
    region.center.longitude = [_longitude floatValue];
    region.span.longitudeDelta = 0.03f;
    region.span.latitudeDelta = 0.03f;
    [self.mapView setRegion:region animated:YES];
    

}



-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationDistance distance = 1000;
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude = [_latitude floatValue];
    myCoordinate.longitude = [_longitude floatValue];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(myCoordinate,
                                                                   distance,
                                                                   distance);
    MKCoordinateRegion adjusted_region = [self.mapView regionThatFits:region];
    [self.mapView setRegion:adjusted_region animated:YES];
}


-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    
        self.mapView.showsUserLocation = YES;
        
        latitude=[NSString stringWithFormat:@"%f", self.mapView.centerCoordinate.latitude];
        longitude=[NSString stringWithFormat:@"%f", self.mapView.centerCoordinate.longitude];
    
        CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:self.mapView.centerCoordinate.latitude longitude:self.mapView.centerCoordinate.longitude];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:newLocation
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                           
                           NSString *address;
                           
                           if (error){
                               NSLog(@"Geocode failed with error: %@", error);
                               return;
                               
                           }
                           
                           CLPlacemark *placemark = [placemarks objectAtIndex:0];
                           if(placemark.locality==NULL)
                           {
                               if (placemark.subLocality==NULL){
                                   address=@"";
                               }
                               else{
                                   
                                   address=[NSString stringWithFormat:@"%@",placemark.subLocality];
                                   
                                   
                               }
                               
                           }
                           
                           else{
                               
                               address=[NSString stringWithFormat:@"%@, %@",placemark.subLocality,placemark.locality];
                           }
                           
                           
                          
                    }];
    
        MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
        
        [self.mapView addAnnotation:annotation1];
    
}



@end
