//
//  Home2ViewController.m
//  place
//
//  Created by Yatharth Singh on 15/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "Home2ViewController.h"
#import "ServiceClass.h"
#import "Define.h"
#import "AppDelegate.h"
#import "AppHelper.h"
#import "Home3ViewController.h"
#import "UIImageView+WebCache.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "ResetPasswordVC.h"
#import "ViewController.h"

@interface Home2ViewController ()
{

    NSMutableArray *arrLocation;
}
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;

- (IBAction)actionSignIn:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UITableView *tblView;

- (IBAction)actionBack:(id)sender;
- (IBAction)actionSignup:(id)sender;


@end

@implementation Home2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    [self hitApiForCategoryLocation:self.strId andLat:self.lat andLong:self.lon];
    
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

-(void)viewWillAppear:(BOOL)animated{

    NSString *email=[AppHelper userDefaultsForKey:@"userId"];
    
    if ([email length]>0) {
        
//        [self.btnSignIn setTitle:@"" forState:UIControlStateNormal];
        [self.btnSignIn setTitleColor:HeaderColor forState:UIControlStateNormal];
        [self.btnSignIn setImage:[UIImage imageNamed:@"icon_settings"] forState:UIControlStateNormal];
        self.btnSignUp.hidden=YES;
        
        NSMutableAttributedString *titleSignIn = [[NSMutableAttributedString alloc] initWithString:@""];
        
        // making text property to underline text-
        
        UIColor* textColorSignIn = [UIColor colorWithRed:0.84 green:0.24 blue:0.21 alpha:1.0];
        
        
        [titleSignIn setAttributes:@{NSForegroundColorAttributeName:textColorSignIn} range:NSMakeRange(0,[titleSignIn length])];
        
        // using text on button
        [self.btnSignIn setAttributedTitle: titleSignIn forState:UIControlStateNormal];
        

        
    }else{
        
        [self setScreenLayout];
        
        
    }

}

-(void)setScreenLayout{
    
    NSMutableAttributedString *titleSignUp = [[NSMutableAttributedString alloc] initWithString:@"SIGN UP"];
    
    // making text property to underline text-
    
    UIColor* textColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.0];
    
    
    [titleSignUp setAttributes:@{NSForegroundColorAttributeName:textColor} range:NSMakeRange(0,[titleSignUp length])];
    
    // using text on button
    [self.btnSignUp setAttributedTitle: titleSignUp forState:UIControlStateNormal];
    
    
    NSMutableAttributedString *titleSignIn = [[NSMutableAttributedString alloc] initWithString:@"SIGN IN"];
    
    // making text property to underline text-
    
    UIColor* textColorSignIn = [UIColor colorWithRed:0.84 green:0.24 blue:0.21 alpha:1.0];
    
    //    [titleSignIn setAttributes:@{NSForegroundColorAttributeName:textColorSignIn,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[titleSignIn length])];
    
    [titleSignIn setAttributes:@{NSForegroundColorAttributeName:textColorSignIn} range:NSMakeRange(0,[titleSignIn length])];
    
    // using text on button
    [self.btnSignIn setAttributedTitle: titleSignIn forState:UIControlStateNormal];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrLocation.count;
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier=@"cellSubCategory";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled=YES;
    
            NSDictionary *dict=[arrLocation objectAtIndex:indexPath.row];
            
            UIImageView *img=(UIImageView*)[cell viewWithTag:101];
            UILabel *lblTitle=(UILabel*)[cell viewWithTag:102];
            UILabel *lblAddress=(UILabel*)[cell viewWithTag:103];
            UILabel *lblOtime=(UILabel*)[cell viewWithTag:104];
            UILabel *lblCtime=(UILabel*)[cell viewWithTag:105];
            
            img.layer.cornerRadius=img.bounds.size.height/2;
            img.clipsToBounds=YES;
            
            NSURL *url=[NSURL URLWithString:_catImageUrl];
            [img sd_setImageWithURL:url];
            lblTitle.text=[dict valueForKey:@"name"];
            lblAddress.text=[dict valueForKey:@"address"];
            lblOtime.text=[dict valueForKey:@"opening_time"];
            lblCtime.text=[dict valueForKey:@"closing_time"];
            
            
    
    
    
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160.0f;
            
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
            
    NSDictionary *dict =[arrLocation objectAtIndex:indexPath.row];
            
    Home3ViewController *hvc=[self.storyboard instantiateViewControllerWithIdentifier:@"Home3ViewController"];
    hvc.strId=[dict valueForKey:@"cat_id"];
    hvc.strPlaceId=[dict valueForKey:@"id"];
    [self.navigationController pushViewController:hvc animated:YES];
            
    
    
}


-(void)hitApiForCategoryLocation:(NSString *)catId andLat:(NSString *)latitude andLong:(NSString *)longitude{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:latitude forKey:@"lattitude"];
    [dict setObject:longitude forKey:@"longitude"];
    [dict setObject:catId forKey:@"cat_id"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getResponseforLocation:) name:NotificationLocation object:nil ];
    [[ServiceClass sharedServiceClass]hitServiceForLocationByAF:dict];
    
    if ([[AppDelegate getAppDelegate] checkInternateConnection])
    {
        
        [AppHelper showActivityIndicator:self.view];
    }
    
    
}

-(void)getResponseforLocation:(NSNotification *)notifyLocation{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationLocation object:nil ];
    
    
    if([[[notifyLocation userInfo] valueForKey:@"isSuccess"] boolValue]==true)
    {
        
        arrLocation=[[NSMutableArray alloc]init];
        arrLocation = [[notifyLocation userInfo] valueForKey:@"Result"];
        
        //        cellIdentifier=@"cellSubCategory";
        [self.tblView reloadData];
        
        [AppHelper hideActivityIndicator:self.view];
        
        
    }
    else
    {
        [AppHelper hideActivityIndicator:self.view];
        [[AppDelegate getAppDelegate] alert:APP_NAME message:[[notifyLocation userInfo] valueForKey:@"message"]  cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
    }
    
    
}



- (IBAction)actionBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)actionSignup:(id)sender{
    
    SignUpViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    svc.backFlag=@"1";
    [self.navigationController pushViewController:svc animated:YES];
    
    
    
}

- (IBAction)actionSignIn:(id)sender {
    
    NSString *email=[AppHelper userDefaultsForKey:@"userId"];
    
    if ([email length]>0) {
        
        UIAlertController *actionSheet=[UIAlertController alertControllerWithTitle:@"Setting" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Reset Password" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            ResetPasswordVC *rpv=[self.storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordVC"];
            [self.navigationController pushViewController:rpv animated:YES];
            
            // Distructive button tapped.
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self logout:nil];
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
        }]];
        
        
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }else{
        
        SignInViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        //svc.backFlag=@"1";
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
    
}

- (IBAction)logout:(id)sender {
    
//    [AppHelper saveToUserDefaults:@"" withKey:@"userId"];
    [AppHelper removeFromUserDefaultsWithKey:@"userId"];
    
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    
    ViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"view"];
    [self.navigationController pushViewController:view animated:YES];
}

@end
