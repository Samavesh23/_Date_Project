//
//  CategoryVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 31/01/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "CategoryVC.h"
#import "Define.h"



@interface CategoryVC ()
{
   BOOL isRowHidden;
   
}
@property (nonatomic, strong) YelpClient  *client;
//@property (nonatomic, assign)FTFoldingSectionHeaderArrowPosition arrowPosition;


@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Category Data  ===  %@",_categoriesArray);
   
   NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
   NSSortDescriptor *sortDescriptors = [[NSArray arrayWithObject:brandDescriptor]mutableCopy];
    _categoriesArray = [[_categoriesArray sortedArrayUsingDescriptors:sortDescriptors]mutableCopy];
    
    isRowHidden=YES;
    _addBanner.adUnitID = ADUNIT_320x50_ROS;
    _addBanner.rootViewController = self;
    [_addBanner loadRequest:[DFPRequest request]];
   // [self getHomeData];
  
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


#pragma TableView Implementation


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _categoriesArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
      return 200;
    }
    
    return 100;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return [[_categoriesArray objectAtIndex:section] valueForKey:@"name"];
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height=0.0;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        if (isRowHidden)
        {
         height = 0.0;
         }
        else
        {
        height = 88.0;
        
       }
       
    }
    else
    {
        if (isRowHidden)
        {
            height = 0.0;
        }
        else
        {
            height = 44.0;
            
        }
    }
    
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    CGFloat headerHeight;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        headerHeight=199;
    }
    else
    {
        headerHeight=99;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    
    /* Create custom view to display section header... */
    UIImageView *imageVW=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, tableView.frame.size.width, headerHeight)];
    UIImageView *dwopDwown=[[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width-50,35, 25, 25)];
    [dwopDwown setImage:[UIImage imageNamed:@"Arrowhead.png"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, headerHeight-1, tableView.frame.size.width, 1)];
    
    //HelveticaNeue-Medium
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]];
     [label setBackgroundColor:[UIColor clearColor]];
    NSString *string =[[_categoriesArray objectAtIndex:section] valueForKey:@"name"];
    /* Section header is in 0th index... */
    [label setText:string];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:view.frame];
    button.tag = section;
    button.titleLabel.shadowOffset = CGSizeMake(10.0, 10.0);
    [button setTitleShadowColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(detectSection:) forControlEvents:UIControlEventTouchUpInside];
   
    NSString *imageUrlwitoutSpace=[[[_categoriesArray objectAtIndex:section] valueForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *url = [NSURL URLWithString:imageUrlwitoutSpace]  ;
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                               cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                           timeoutInterval:60];
    //imageVW.hidden=YES;
    [label setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [AppHelper showActivityIndicator:imageVW];
    [imageVW setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             imageVW.image= [AppHelper resizeImage:image newSize:CGSizeMake(view.frame.size.width,view.frame.size.height+50)];
             [AppHelper hideActivityIndicator:imageVW];
         });
         //imageVW.hidden=NO;
         // [label setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
     }
                            failure:NULL];
   // [imageVW setContentMode:UIViewContentModeCenter];
    imageVW.clipsToBounds = YES;
    
    NSArray *sectionAnimals = [[_categoriesArray objectAtIndex:section]valueForKey:@"child"];
    [view addSubview:imageVW];
    [view addSubview:label];
    [view addSubview:line];
    [view addSubview:button];
    if (sectionAnimals.count>0)
    {
        [view addSubview:dwopDwown];
    }
//    else
//    {
//        
//    }
    label.textColor=[UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    //[view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    line.backgroundColor=[UIColor whiteColor];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    
    
    return view;
}


-(void)detectSection:(UIButton *)sender
{
    
    NSArray *sectionAnimals = [[_categoriesArray objectAtIndex:sender.tag]valueForKey:@"child"];
    
    if (sectionAnimals.count>0)
    {
        if (isRowHidden==YES)
        {
            isRowHidden=NO;
            [_SubCatTV beginUpdates];
            [_SubCatTV endUpdates];
        }
        else
        {
            isRowHidden=YES;
            [_SubCatTV beginUpdates];
            [_SubCatTV endUpdates];
        }
        
    }
    else
    {
        PlacelistVC *placeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PlacelistVC"];
        placeVC.selectedtext=[[_categoriesArray objectAtIndex:sender.tag]valueForKey:@"name"];
        [self.navigationController pushViewController:placeVC animated:YES];
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSString *sectionTitle = [_categoriesArray objectAtIndex:section];
    NSArray *sectionAnimals = [[_categoriesArray objectAtIndex:section]valueForKey:@"child"];
    
    if (sectionAnimals.count>0)
    {
    return [sectionAnimals count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *lbl1=(UILabel*)[cell viewWithTag:1];
    UIImageView *imgView=(UIImageView*)[cell viewWithTag:2];
    
     NSArray *datesArray=[[_categoriesArray objectAtIndex:indexPath.section] valueForKey:@"child"];
    // Configure the cell...
   // NSString *sectionTitle = [[_categoriesArray objectAtIndex:indexPath.section]valueForKey:@"name"];
    NSString *animal = [[datesArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    lbl1.text = animal;
   
    NSString *imageUrlwitoutSpace=[[[datesArray objectAtIndex:indexPath.row] valueForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *url = [NSURL URLWithString:imageUrlwitoutSpace]  ;
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                               cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                           timeoutInterval:60];
    //imageVW.hidden=YES;
    [lbl1 setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [AppHelper showActivityIndicator:imgView];
    [imgView setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"defaultbg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             imgView.image= [AppHelper resizeImage:image newSize:CGSizeMake(cell.frame.size.width,cell.frame.size.height)];
             [AppHelper hideActivityIndicator:imgView];
         });
         //imageVW.hidden=NO;
         // [label setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
     }
                            failure:NULL];
    [imgView setContentMode:UIViewContentModeCenter];
    imgView.clipsToBounds = YES;
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *datesArray=[[_categoriesArray objectAtIndex:indexPath.section] valueForKey:@"child"];
    
    
    PlacelistVC *placeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PlacelistVC"];
    placeVC.selectedtext=[[datesArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    [self.navigationController pushViewController:placeVC animated:YES];
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
   // [_catCV reloadData];
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.layer.borderColor = HeaderColor.CGColor; // highlight selection
    datasetCell.layer.borderWidth=1;
    DetailVC *detailVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailVC.catDetail=[_categoriesArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (IBAction)bckBtntap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
