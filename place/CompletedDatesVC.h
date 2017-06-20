//
//  CompletedDatesVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 17/04/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface CompletedDatesVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>
{
    NSMutableArray *randomHeights;
    int page;
}
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
- (IBAction)menuBtnTap:(id)sender;
@property (weak, nonatomic) IBOutlet DFPBannerView *addBanrrrr;

@end