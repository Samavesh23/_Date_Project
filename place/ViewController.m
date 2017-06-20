//
//  ViewController.m
//  place
//
//  Created by Yatharth Singh on 04/07/16.
//  Copyright © 2016 Yatharth Singh. All rights reserved.
//

#import "ViewController.h"
#import "Define.h"

@interface ViewController ()





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    [self setLayoutScreen];
    _loginBtnoutlet .layer.cornerRadius=5;
    _signupBtnoutlet .layer.cornerRadius=5;
    _loginBtnoutlet.layer.borderWidth=1;
    _loginBtnoutlet.layer.borderColor=HeaderColor.CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLayoutScreen{

        NSMutableAttributedString *titleSignUp = [[NSMutableAttributedString alloc] initWithString:@"SIGN UP"];
        
        // making text property to underline text-
        
        UIColor* textColor = [UIColor grayColor];
    
        [titleSignUp setAttributes:@{NSForegroundColorAttributeName:textColor,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[titleSignUp length])];
        
        // using text on button
    
        NSMutableAttributedString *titleSignIn = [[NSMutableAttributedString alloc] initWithString:@"SIGN IN"];
        
        // making text property to underline text-
        
        UIColor* textColorSignIn = [UIColor redColor];
        
        
        [titleSignIn setAttributes:@{NSForegroundColorAttributeName:textColorSignIn,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[titleSignIn length])];
        
        // using text on button
    
}

- (IBAction)actionSignUp:(id)sender
{
    
    SignUpViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:svc animated:YES];
    
}

- (IBAction)actionSignIn:(id)sender
{
    
    SignInViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self.navigationController pushViewController:svc animated:YES];
    
}


@end
