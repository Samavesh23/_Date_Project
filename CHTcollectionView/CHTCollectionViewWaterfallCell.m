//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallCell.h"

@implementation CHTCollectionViewWaterfallCell
BOOL isyes;
#pragma mark - Accessors
- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
   // _imageView.contentMode = UIViewContentModeScaleAspectFit;
  }
  return _imageView;
}

-(UIView*)shadeview
{
     if (!_shadeview)
     {
         if (isyes)
         {
             _shadeview = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height/2+50, self.contentView.frame.size.width, self.contentView.frame.size.height/2)];
             _shadeview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
             [_shadeview setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
             isyes=NO;
         }
         else
         {
             _shadeview = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height/2+40, self.contentView.frame.size.width, self.contentView.frame.size.height/2)];
             _shadeview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
             [_shadeview setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
             isyes=YES;
         }
    
     }
    return _shadeview;
}


-(UILabel *)nameLbl
{
    if (!_nameLbl)
    {
       // _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height/2, self.contentView.frame.size.width, 40)];
       // _nameLbl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _nameLbl;
}
-(UILabel *)addressLbl
{
    if (!_addressLbl)
    {
       // _addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height/2+40, self.contentView.frame.size.width, 40)];
       // _addressLbl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _addressLbl;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self.contentView addSubview:self.imageView];
  }
  return self;
}

@end
