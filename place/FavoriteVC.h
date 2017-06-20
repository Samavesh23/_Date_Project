//
//  FavoriteVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 09/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "CHTCollectionViewWaterfallLayout.h"



@interface FavoriteVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>
{
    NSMutableArray *randomHeights;
    int page;
}

//@property ( nonatomic) IBOutlet EKStreamView *stream;

- (IBAction)bckBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet DFPBannerView *bannerAddView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end
