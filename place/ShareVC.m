//
//  ShareVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 01/02/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "ShareVC.h"
#import "Define.h"

@interface ShareVC ()

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self shareOptions];
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

- (IBAction)bckBtntap:(id)sender {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}


-(void)shareOptions :(CGFloat)Yaxis
{
    NSString *textToShare;
    NSURL *myWebsite;
    
        textToShare =@"Check out this New App.";
        myWebsite = [NSURL URLWithString:@"https://www.appsquadz.com"];
   
    
    NSArray *activity =@[textToShare,myWebsite];
    
    
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc]initWithActivityItems:activity applicationActivities:nil];
    
    
    
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    
    [activityController setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         
     }];
    NSArray *excludeActivities =@[UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo];
    activityController.excludedActivityTypes = excludeActivities;
    activityController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:activityController animated:YES completion:nil];
     }
         //if iPad
         else {
             // Change Rect to position Popover
             UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityController];
             [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2,Yaxis, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
         }
}




- (IBAction)facebookBtnTap:(id)sender
{
    [self shareOptions:_facebookBtnOutlet.frame.origin.y+80];
}

- (IBAction)whatsappBtntap:(id)sender
{
  [self shareOptions:_whatsappBtnOutlet.frame.origin.y+80];
}

- (IBAction)twitterBtntap:(id)sender
{
   [self shareOptions:_twitterBtnOutlet.frame.origin.y+80];
}

- (IBAction)linkedinBtntap:(id)sender
{
   [self shareOptions:_linkedInBtnOutlet.frame.origin.y+80];
}
@end
