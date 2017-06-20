//
//  WebsiteVC.h
//  Its a Date
//
//  Created by Yatharth Singh on 22/03/17.
//  Copyright © 2017 Yatharth Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsiteVC : UIViewController
- (IBAction)bkbtnTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (strong,nonatomic) NSString *websiteUrl;
@end
