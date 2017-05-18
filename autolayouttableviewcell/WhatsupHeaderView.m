//
//  WhatsupHeaderView.m
//  autolayouttableviewcell
//
//  Created by jam on 17/5/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "WhatsupHeaderView.h"
#import "Masonry.h"

@implementation WhatsupHeaderView
{
    UIImageView* largeimageview;
    UIImageView* headimageview;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor lightGrayColor];
        
        UIView* white=[[UIView alloc]init];
        white.backgroundColor=[UIColor whiteColor];
        [self addSubview:white];
        [white mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(64));
        }];
        
        largeimageview=[[UIImageView alloc]init];
        largeimageview.image=self.backgroundImage;
        largeimageview.contentMode=UIViewContentModeScaleAspectFill;
        largeimageview.clipsToBounds=YES;
        [self addSubview:largeimageview];
        [largeimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(self);
            make.bottom.equalTo(white.mas_top);
        }];
        
        headimageview=[[UIImageView alloc]init];
        headimageview.layer.borderColor=[UIColor whiteColor].CGColor;
        headimageview.layer.borderWidth=2;
        headimageview.backgroundColor=[UIColor grayColor];
        headimageview.image=self.headImage;
        [self addSubview:headimageview];
        [headimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(white.mas_top);
            make.width.height.equalTo(@(80));
            make.right.equalTo(self).offset(-10);
        }];
        
    }
    return self;
}

-(void)setHeadImage:(UIImage *)headImage
{
    _headImage=headImage;
    headimageview.image=headImage;
}

-(void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage=backgroundImage;
    largeimageview.image=backgroundImage;
}

@end
