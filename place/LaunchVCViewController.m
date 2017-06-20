//
//  LaunchVCViewController.m
//  Its Date
//
//  Created by Yatharth Singh on 13/01/17.
//  Copyright © 2017 Pradeep Kumar. All rights reserved.
//

#import "LaunchVCViewController.h"
#import "Define.h"
@interface LaunchVCViewController ()


@end

@implementation LaunchVCViewController
{
    UIView *tempUIView;
    NSTimer *AnimationTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(setAnimation)
                                   userInfo:nil
                                    repeats:NO];
    //[self setAnimation];
    
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
-(void)setAnimation
{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [animation setAutoreverses:YES];
//    [animation setFromValue:[NSNumber numberWithFloat:1.0f]];
//    [animation setToValue:[NSNumber numberWithFloat:4.f]];
//    [animation setDuration:2.f];
//    [animation setRemovedOnCompletion:YES];
//    
//    [animation setFillMode:kCAFillModeBackwards];
//    [[self.imageView layer] addAnimation:animation forKey:@"scale"];
    
    [NSTimer scheduledTimerWithTimeInterval:1.2
                                     target:self
                                   selector:@selector(nextPage)
                                   userInfo:nil
                                    repeats:NO];
    
    tempUIView=[[UIView alloc]initWithFrame:self.imageView.bounds];
    // tempUIView.backgroundColor=HeaderColor;
    [UIView animateWithDuration:1.0
                     animations:^{
                         CATransition *animation = [CATransition animation];
                         [animation setDuration:1.2];
                         [animation setTimingFunction:[CAMediaTimingFunction functionWithName:@"default"]];
                         animation.fillMode = kCAFillModeForwards;
                         [animation setRemovedOnCompletion:NO];
                         animation.startProgress = 0.0;
                         animation.endProgress   = 0.80;
                         animation.type = @"pageCurl";
                         [[self.imageView layer] addAnimation:animation
                                                            forKey:@"pageFlipAnimation"];
                         [self.imageView addSubview:tempUIView];
                         
                     }
     
     ];
 

    
//    ViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//    [self.navigationController pushViewController:VC animated:YES];

    
}

-(void)nextPage
{
    ViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
       [self.navigationController pushViewController:VC animated:NO];
}

@end
