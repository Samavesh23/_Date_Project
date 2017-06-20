//
//  PlaceFilterVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 17/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "PlaceFilterVC.h"
#import "Define.h"

@interface PlaceFilterVC ()

@end

@implementation PlaceFilterVC
{
    NSString *priceFilter;
    NSString *distancefilter;
    NSMutableArray *category;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    category=[[NSMutableArray alloc]init];
    _categoryLbl.layer.cornerRadius=5;
    _categoryLbl.layer.masksToBounds = YES;
    
    _pricerangeLbl.layer.cornerRadius=5;
    _pricerangeLbl.layer.masksToBounds = YES;
    
    _distanceLbl.layer.cornerRadius=5;
    _distanceLbl.layer.masksToBounds = YES;
    
    _ratingLbl.layer.cornerRadius=5;
    _ratingLbl.layer.masksToBounds = YES;
    
    [_ratingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    
    if ([AppHelper userDefaultsForKey:@"price"]==nil)
    {
        [AppHelper saveToUserDefaults:@"1,2,3,4" withKey:@"price"];
    }
    else
    {
        if ([[AppHelper userDefaultsForKey:@"price"]isEqualToString:@"1"])
        {
            _priceSegmentCtrl.selectedSegmentIndex=0;
        }
        else if ([[AppHelper userDefaultsForKey:@"price"]isEqualToString:@"1,2"])
        {
             _priceSegmentCtrl.selectedSegmentIndex=1;
        }
        else if ([[AppHelper userDefaultsForKey:@"price"]isEqualToString:@"1,2,3"])
        {
             _priceSegmentCtrl.selectedSegmentIndex=2;
        }
        else if ([[AppHelper userDefaultsForKey:@"price"]isEqualToString:@"1,2,3,4"])
        {
             _priceSegmentCtrl.selectedSegmentIndex=3;
        }
    }
    
        if ([[AppHelper userDefaultsForKey:@"distance"]isEqualToString:@"100"])
        {
            _priceSegmentCtrl.selectedSegmentIndex=0;
        }
        else if ([[AppHelper userDefaultsForKey:@"distance"]isEqualToString:@"500"])
        {
            _distanceSegmentCtrl.selectedSegmentIndex=1;
        }
        else if ([[AppHelper userDefaultsForKey:@"distance"]isEqualToString:@"1000"])
        {
            _distanceSegmentCtrl.selectedSegmentIndex=2;
        }
        else if ([[AppHelper userDefaultsForKey:@"distance"]isEqualToString:@"10000"])
        {
            _distanceSegmentCtrl.selectedSegmentIndex=3;
        }
        else if ([[AppHelper userDefaultsForKey:@"distance"]isEqualToString:@"20000"])
        {
            _distanceSegmentCtrl.selectedSegmentIndex=4;
        }
    
//    if ([AppHelper userDefaultsForKey:@"category"]==nil)
//    {
//      [AppHelper saveToUserDefaults:@"Acai Bowl" withKey:@"category"];
//    }
//    else
//    {
//        
//    }
    if ([AppHelper userDefaultsForKey:@"rating"]==nil)
    {
        [AppHelper saveToUserDefaults:@"5.0" withKey:@"rating"];
        _ratingView.value=[[AppHelper userDefaultsForKey:@"rating"]floatValue];
    }
    else
    {
      _ratingView.value=[[AppHelper userDefaultsForKey:@"rating"]floatValue];
    }
    
    
    if ([[AppHelper userDefaultsForKey:@"sort"]isEqualToString:@"0"])
    {
        _sortbysegmentOutlet.selectedSegmentIndex=0;
    }
    else  if ([[AppHelper userDefaultsForKey:@"sort"]isEqualToString:@"1"])
    {
        _sortbysegmentOutlet.selectedSegmentIndex=1;
    }
    else  if ([[AppHelper userDefaultsForKey:@"sort"]isEqualToString:@"2"])
    {
        _sortbysegmentOutlet.selectedSegmentIndex=2;
    }
    else
    {
        [AppHelper saveToUserDefaults:@"0" withKey:@"sort"];
         _sortbysegmentOutlet.selectedSegmentIndex=0;
    }

    
    
    
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



- (IBAction)backBtntap:(id)sender
{
    [AppHelper saveToUserDefaults:@"yes" withKey:@"placefilter"]; 
    
    [self .delegate addItemVC:self didFinishEnteringItem:@"filter"];
   
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}


- (IBAction)sliderValueChanged:(UISlider *)sender {
    
   // [self.distanceLbl setValue:sender.value];
    
    self.distanceLbl.text = [@((int)sender.value) stringValue];
   
    
   //NSString *totalDistanceBetween =+ (self.distanceLbl.text * 0.000621371192);
   NSString *totalDistanceimMeters= [NSString stringWithFormat:@"Distance %.f",(sender.value* 1609.344)];
     NSLog(@"%@",totalDistanceimMeters);
    [AppHelper saveToUserDefaults:totalDistanceimMeters withKey:@"placeradius"];
    [AppHelper saveToUserDefaults:@"yes" withKey:@"placefilter"];
    
}
- (IBAction)priceSegmentTap:(id)sender
{
    if (_priceSegmentCtrl.selectedSegmentIndex==0)
    {
        [AppHelper saveToUserDefaults:@"1" withKey:@"price"];
    }
    else if (_priceSegmentCtrl.selectedSegmentIndex==1)
    {
        [AppHelper saveToUserDefaults:@"1,2" withKey:@"price"];
    }
    else if (_priceSegmentCtrl.selectedSegmentIndex==2)
    {
        [AppHelper saveToUserDefaults:@"1,2,3" withKey:@"price"];
    }
    else if (_priceSegmentCtrl.selectedSegmentIndex==3)
    {
        [AppHelper saveToUserDefaults:@"1,2,3,4" withKey:@"price"];
    }
    
}
- (IBAction)distancesegmentTap:(id)sender
{
     if (_distanceSegmentCtrl.selectedSegmentIndex==0)
    {
        [AppHelper saveToUserDefaults:@"100" withKey:@"distance"];
    }
    else if (_distanceSegmentCtrl.selectedSegmentIndex==1)
    {
       [AppHelper saveToUserDefaults:@"500" withKey:@"distance"];
    }
    else if (_distanceSegmentCtrl.selectedSegmentIndex==2)
    {
        [AppHelper saveToUserDefaults:@"1000" withKey:@"distance"];
    }
    else if (_distanceSegmentCtrl.selectedSegmentIndex==3)
    {
        [AppHelper saveToUserDefaults:@"10000" withKey:@"distance"];
    }
    else if (_distanceSegmentCtrl.selectedSegmentIndex==4)
    {
        [AppHelper saveToUserDefaults:@"20000" withKey:@"distance"];
    }
    
}

-(void)didChangeValue:(HCSStarRatingView *)sender
{
    NSString *value=[NSString stringWithFormat:@"%.01f",sender.value];
    [AppHelper saveToUserDefaults:value withKey:@"rating"];
    NSLog(@"Selected Rating %@",value);
}


- (IBAction)sortbysegmentTap:(id)sender
{
    if (_sortbysegmentOutlet.selectedSegmentIndex==0)
    {
        [AppHelper saveToUserDefaults:@"0" withKey:@"sort"];
    }
    else if (_sortbysegmentOutlet.selectedSegmentIndex==1)
    {
       [AppHelper saveToUserDefaults:@"1" withKey:@"sort"];
    }
    else if (_sortbysegmentOutlet.selectedSegmentIndex==2)
    {
       [AppHelper saveToUserDefaults:@"2" withKey:@"sort"];
    }
    
}
@end
