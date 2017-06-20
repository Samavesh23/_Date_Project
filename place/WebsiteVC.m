//
//  WebsiteVC.m
//  Its a Date
//
//  Created by Yatharth Singh on 22/03/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import "WebsiteVC.h"
#import "Define.h"

@interface WebsiteVC ()

@end

@implementation WebsiteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _webview.scalesPageToFit = YES;
  
   
     NSURL *url = [NSURL URLWithString:_websiteUrl];
    
    [_webview loadRequest:[NSURLRequest requestWithURL:url] ];
    
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

-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
     [AppHelper showActivityIndicator:self.view];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish");
     [AppHelper hideActivityIndicator:self.view];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    NSLog(@"Error for WEBVIEW: %@", [error description]);
    
}

- (IBAction)bkbtnTap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
