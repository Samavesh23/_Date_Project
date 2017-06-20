//
//  TagCell.m
//  FlowLayout
//
//  Created by Grigory Avdyushin on 20.07.16.
//  Copyright © 2016 Grigory Avdyushin. All rights reserved.
//

#import "TagCell.h"
#import "Define.h"

@implementation TagCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderColor =HeaderColor.CGColor;
   // self.layer.borderWidth = 2.0f;
    //self.backgroundColor  = HeaderColor.CGColor ;
    self.textLabel.textColor=[UIColor whiteColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = 5;
}

@end
