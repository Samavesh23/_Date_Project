//
//  AddPlaceViewController.h
//  place
//
//  Created by Yatharth Singh on 29/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPlaceViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong, nonatomic)NSArray *arrCategory;

@end
