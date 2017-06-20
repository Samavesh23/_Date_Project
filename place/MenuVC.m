//
//  MenuVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 20/01/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "MenuVC.h"
#import "Define.h"
#import "DemoVC.h"

@interface MenuVC ()
{
    NSMutableArray *menuOptions;
    NSMutableArray *images;
    NSIndexPath *selectedIndex;
}
@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    menuOptions=[[NSMutableArray alloc]initWithObjects:@"Home",@"Upgrade to Ad Free",@"Favorite",@"Future Dates",@"Completed Dates",@"Share with Friends",@"Rate app",@"Feedback", nil];
    images=[[NSMutableArray alloc]initWithObjects:@"home",@"upgrade",@"favourite",@"completedates",@"futuredates",@"share",@"rateapp",@"feedback", nil];
    //[self.delegate test:@"yes"];
    [self loadScreendata];
    
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


-(void)loadScreendata
{
    NSDictionary *dict=[AppHelper userDefaultsForKey:@"userdata"];
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"image_link"]]  ;
    NSURLRequest *Adrequest = [NSURLRequest requestWithURL:url
                                               cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                           timeoutInterval:60];
    
    [_imageView setImageWithURLRequest:Adrequest placeholderImage:[UIImage imageNamed:@"default"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         _imageView.image= [AppHelper resizeImage:image newSize:CGSizeMake(_imageView.frame.size.width,_imageView.frame.size.height)];
         
     }
                               failure:NULL];
    _imageView.layer.cornerRadius=_imageView.frame.size.width/2;
    _imageView.clipsToBounds=YES;
     _nameLable.text=[[AppHelper userDefaultsForKey:@"userdata" ] valueForKey:@"name"];
}

- (IBAction)logotBtntap:(id)sender
{
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Do u really want to logout ?"
                                                        message:nil delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Yes",@"No",nil];
    [alertView show];
   
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:1 animated:TRUE];
        [AppHelper saveToUserDefaults:@"no" withKey:@"registered"];
        ViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:view animated:YES];
        
        
    }
    else if (buttonIndex == 1)
    {
         [alertView dismissWithClickedButtonIndex:1 animated:TRUE];
    }
}

- (IBAction)uploadimageBtntap:(id)sender {
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuOptions.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (cell==nil)
    {
       cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    }
   __weak UIImageView *img=(UIImageView *) [cell viewWithTag:1];
    __weak UILabel *menuNameoptions=(UILabel *) [cell viewWithTag:2];
    menuNameoptions.text=[menuOptions objectAtIndex:indexPath.row];
    [img setImage:[UIImage imageNamed:[images objectAtIndex:indexPath.row]]];
    if (selectedIndex==indexPath)
    {
        menuNameoptions.textColor=HeaderColor ;
        img.image=[img.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [img setTintColor:HeaderColor];
    }
    else
    {
        menuNameoptions.textColor=[UIColor whiteColor] ;
        img.tintColor=[UIColor whiteColor];
        
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0)
    {
        HomeViewController *homeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        self.viewDeckController.centerController = homeVC;
        [self.viewDeckController toggleLeftViewAnimated:YES];
    }
//    else if (indexPath.row==1)
//    {
//       MyAccountVC  *myacVC=[self.storyboard instantiateViewControllerWithIdentifier:@"MyAccountVC"];
//        self.viewDeckController.centerController = myacVC;
//        [self.viewDeckController toggleLeftViewAnimated:YES];
//    }
    else if (indexPath.row==1)
    {
        
    }
    else if (indexPath.row==2)
    {
        FavoriteVC  *favVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteVC"];
       
        self.viewDeckController.centerController = favVC;
        [self.viewDeckController toggleLeftViewAnimated:YES];
    }
    else if (indexPath.row==3)
    {
       
         //FutureDatesVC
        
        FutureDatesVC  *favVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FutureDatesVC"];
       
         self.viewDeckController.centerController= favVC;
        [self.viewDeckController toggleLeftViewAnimated:YES];
    
    }
    else if (indexPath.row==4)
    {
        //CompletedDatesVC
        CompletedDatesVC  *shareVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CompletedDatesVC"];
        
        self.viewDeckController.centerController = shareVC;
        [self.viewDeckController toggleLeftViewAnimated:YES];
        
    }
    else if (indexPath.row==5)
    {
        ShareVC  *shareVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ShareVC"];
        self.viewDeckController.centerController = shareVC;
        [self.viewDeckController toggleLeftViewAnimated:YES];
 
    }
    else if (indexPath.row==6)
    {
//         DemoVC *shareVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DemoVC"];
//        self.viewDeckController.centerController = shareVC;
//        [self.viewDeckController toggleLeftViewAnimated:YES];
    }
    else if (indexPath.row==7)
    {
        
    }
    
    selectedIndex=indexPath;
    [_menuTV reloadData];
}
@end
