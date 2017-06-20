//
//  FavoriteVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 09/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "FavoriteVC.h"
#import "MyCell.h"
#import "DataBase.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"


//static int MaxPage = 1;
@interface FavoriteVC ()
@property (nonatomic, strong) NSMutableArray *cellSizes;
@property (nonatomic, strong) NSArray *cats;
@end

@implementation FavoriteVC
{
    NSMutableArray *favoriteArray;
}

#pragma mark - Accessors

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.headerHeight = 0;
        layout.footerHeight = 0;
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 115, self.view.bounds.size.width, self.view.bounds.size.height-115) collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                   withReuseIdentifier:HEADER_IDENTIFIER];
        [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:FOOTER_IDENTIFIER];
        _collectionView.backgroundColor=[UIColor clearColor];
    }
    return _collectionView;
}




#pragma mark - Life Cycle

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    _bannerAddView.adUnitID = ADUNIT_320x50_ROS;
    self.bannerAddView.rootViewController = self;
    [self.bannerAddView loadRequest:[DFPRequest request]];
}

-(void)viewDidAppear:(BOOL)animated
{
     [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation]; 
    favoriteArray=[[NSMutableArray alloc]init];
    favoriteArray=[[[DataBase sharedChatTableClass]getTagByUserId:[[AppHelper userDefaultsForKey:@"userdata"] valueForKey:@"id"]]mutableCopy];
    
    
    _cellSizes=[[NSMutableArray alloc]init];
    CGFloat h;
    CGFloat w;
    for (int i = 0; i < favoriteArray.count; i++) {
        // CGFloat h = arc4random() % 150 + 150.f;
        if (i%2)
        {
            h=400;
            w=300;
        }
        else
        {
            h=600;
            w=500;
        }
        // CGFloat w = arc4random() % 150 + 150.f;
        
        [_cellSizes addObject:[NSValue valueWithCGSize:CGSizeMake(w, h)]];
    }
    
    [self.view addSubview:self.collectionView];
    [_collectionView reloadData];
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


- (IBAction)bckBtntap:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
    [self.view endEditing:YES];
}



- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (favoriteArray.count>0)
    {
        [self setTableViewBackground:NO];
        return favoriteArray.count;
        
    }
    else
    {
        
        [self setTableViewBackground:YES];
    }
    return favoriteArray.count;
}



-(void)setTableViewBackground:(BOOL)show
{
    UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height)];
    noDataLabel.text             = @"No data available";
    noDataLabel.textColor        = [UIColor whiteColor];
    noDataLabel.textAlignment    = NSTextAlignmentCenter;
    //yourTableView.backgroundView = noDataLabel;
    //yourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.collectionView.backgroundView = noDataLabel;
    if (show==YES)
    {
        noDataLabel.hidden=NO;
    }
    else
    {
       noDataLabel.hidden=YES;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
 
     Favorite *fav=[favoriteArray objectAtIndex:indexPath.row];
    NSString *Oimage=fav.imageurl;
    Oimage= [Oimage stringByReplacingOccurrencesOfString:@"ms" withString:@"o"];
    NSURL *url = [NSURL URLWithString:Oimage]  ;
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                               cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                           timeoutInterval:60];
    
    [cell.imageView setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         cell.imageView.image= image;//[AppHelper resizeImage:image newSize:CGSizeMake(image.size.width,image.size.height)];
         
     }
                                 failure:NULL];
   
    if (!cell.nameLbl)
    {
     cell.nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.contentView.frame.size.height/2, cell.contentView.frame.size.width-10, 40)];
     cell.nameLbl.center = CGPointMake(cell.contentView.frame.size.width/ 2, 20);
     cell.addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.nameLbl.frame.origin.y+cell.nameLbl.frame.size.height-15, cell.contentView.frame.size.width-10, 40)];
    }
     [cell.nameLbl setNumberOfLines:1];
     [cell.addressLbl setNumberOfLines:3];
    cell.nameLbl.text=fav.datename;
    cell.addressLbl.text=fav.address;
    cell.nameLbl.textColor = [UIColor whiteColor];
    cell.addressLbl.textColor = [UIColor whiteColor];
    cell.addressLbl.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    cell.nameLbl.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    
    
    [cell.imageView addSubview:cell.shadeview];
    [cell.shadeview addSubview:cell.addressLbl];
    [cell.shadeview addSubview:cell.nameLbl];
    cell.layer.cornerRadius=10;
    cell.clipsToBounds=YES;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_cellSizes[indexPath.row ] CGSizeValue];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected Index %ld",(long)indexPath.row);
    
    DetailVC *detailVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailVC.indx=indexPath;
    detailVC.fromDB=@"favorite";
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
