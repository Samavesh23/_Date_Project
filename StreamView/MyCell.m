//
//  MyCell.m
//  StreamView
//
//  Created by Eli Wang on 1/16/12.
//  Copyright (c) 2012 ekohe.com. All rights reserved.
//

#import "MyCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyCell

@synthesize nameLbl, reuseIdentifier,imgView,addressLbl;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect bgFrame = CGRectInset(self.bounds, 0.0f, 0.0f);
        UIView *bgView = [[UIView alloc] initWithFrame:bgFrame];
       // bgView.layer.borderColor = [UIColor blackColor].CGColor;
       // bgView.layer.borderWidth = 2.0f;
        bgView.layer.cornerRadius=50.0f;
        
        [self addSubview:bgView];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        bgView.backgroundColor=[UIColor colorWithRed:0.255 green:0.255 blue:0.255 alpha:0.6];
        nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgFrame.size.width, 200)];
        addressLbl= [[UILabel alloc] initWithFrame:CGRectMake(0, nameLbl.frame.origin.y+nameLbl.frame.size.height, bgFrame.size.width, 200)];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height)];
       
        nameLbl.center = CGPointMake(self.frame.size.width/ 2, self.frame.size.height/2);
        addressLbl.center = CGPointMake(self.frame.size.width/ 2, self.frame.size.height/2+50);
        
        nameLbl.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
         addressLbl.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [nameLbl setNumberOfLines:2];
        [addressLbl setNumberOfLines:2];
       // [label sizeToFit];
        nameLbl.backgroundColor = [UIColor clearColor];
        nameLbl.textAlignment = UITextAlignmentLeft;
        addressLbl.backgroundColor = [UIColor clearColor];
        addressLbl.textAlignment = UITextAlignmentLeft;
       // imgView.layer.cornerRadius=5;
        
        imgView.layer.cornerRadius=50.0f;
         [bgView addSubview:imgView];
       
        imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [bgView addSubview:nameLbl];
         [bgView addSubview:addressLbl];
         [self addSubview:bgView];
       
       

        
    }
    
    return self;
}

-(CGFloat)heightForLabel:(UILabel *)label withText:(NSString *)text

{
        CGSize maximumLabelSize     = CGSizeMake(290, FLT_MAX);
        
        CGSize expectedLabelSize    = [text sizeWithFont:label.font
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:label.lineBreakMode];
        
        return expectedLabelSize.height;
}
    
    

@end
