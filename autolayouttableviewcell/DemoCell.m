//
//  DemoCell.m
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "DemoCell.h"
#import "Masonry.h"

@interface DemoCell()

@property (nonatomic,strong) UIImageView* head;
@property (nonatomic,strong) UILabel* title;
@property (nonatomic,strong) UILabel* detail;
@property (nonatomic,strong) UILabel* date;
@property (nonatomic,strong) PhotosView* photos;

@end

@implementation DemoCell
{
    UIEdgeInsets insets;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        insets=UIEdgeInsetsMake(10, 12, 10, 12);
        
        self.head=[[UIImageView alloc]init];
        self.head.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:self.head];
        
        self.title=[[UILabel alloc]init];
        self.title.backgroundColor=[UIColor cyanColor];
        [self.contentView addSubview:self.title];
        
        self.detail=[[UILabel alloc]init];
        self.detail.backgroundColor=[UIColor magentaColor];
        self.detail.numberOfLines=20;
        [self.contentView addSubview:self.detail];
        
        self.date=[[UILabel alloc]init];
        self.date.backgroundColor=[UIColor greenColor];
        self.date.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:self.date];
        
        self.photos=[[PhotosView alloc]init];
        self.photos.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:self.photos];
        
        [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).insets(insets).key(@"head_top_left");
            make.width.height.equalTo(@(40)).key(@"head_width_height");
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.head.mas_top).key(@"title_top");
            make.left.equalTo(self.head.mas_right).insets(insets).key(@"title_left");
            make.right.equalTo(self.contentView).offset(-40).key(@"title_right");
        }];
        
        [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_left).key(@"detail_left");
            make.right.equalTo(self.title.mas_right).key(@"detail_right");
            make.top.equalTo(self.title.mas_bottom).insets(insets).key(@"detail_top");
        }];
        
        [self.photos mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_left).key(@"photos_left");
            make.right.equalTo(self.title.mas_right).key(@"photos_right");
        }];
        
        [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.photos.mas_bottom).insets(insets).key(@"date_top");
            make.bottom.equalTo(self.contentView.mas_bottom).insets(insets).key(@"date_bottom");
            make.right.equalTo(self.title.mas_right).key(@"date_right");
        }];
    }
    return self;
}

-(void)updateConstraints
{
    [self.detail mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.detail.text.length>0) {
            make.top.equalTo(self.title.mas_bottom).insets(insets);
        }
        else{
            make.top.equalTo(self.title.mas_bottom).offset(0);
        }
    }];

    [self.photos mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.photos.height)).key(@"photos_height");
        if (self.photos.photoCount>0) {
            make.top.equalTo(self.detail.mas_bottom).insets(insets).priorityLow();
        }
        else
        {
            make.top.equalTo(self.detail.mas_bottom).priorityLow();
        }
    }];
    
    [super updateConstraints];
}

-(void)setModel:(Model1 *)model
{
    _model=model;
    self.head.image=[UIImage imageNamed:_model.imageName];
    self.title.text=_model.title;
    self.detail.text=_model.detail;
    self.date.text=@"today";
    self.photos.photoCount=_model.photoCount;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    NSLog(@"cell %@",self.contentView.description);
//    NSLog(@"layout subviews TITLE %@ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>",self.model.title);
//}

@end


///////////////////////
///////////////////////
///////////////////////
///////////////////////
///////////////////////
///////////////////////
///////////////////////
///////////////////////
///////////////////////
///////////////////////
///////////////////////
///////////////////////


@implementation PhotosView
{
    CGFloat hh;
}
-(void)setPhotoCount:(NSInteger)photoCount
{
    _photoCount=photoCount;
    
    NSArray* subViews=self.subviews;
    
    //remove and create again if needs
    if (subViews.count!=9)
    {
        for (UIView *v in subViews) {
            [v removeFromSuperview];
        }
        for (int i=0;i<9; i++) {
            UILabel* php=[[UILabel alloc]init];
            php.text=[NSString stringWithFormat:@"photo%d",i+1];
            php.textAlignment=NSTextAlignmentCenter;
            php.layer.borderColor=[UIColor blackColor].CGColor;
            php.layer.borderWidth=0.5;
            [self addSubview:php];
        }
    }
    
    //hide those useless
    subViews=self.subviews;
    
    CGFloat m=2;
    if (_photoCount<=0)
    {
    }
    else if(_photoCount<=1)
    {
        CGFloat w=80;
        for (int i=0; i<subViews.count; i++) {
            UIView* v=[subViews objectAtIndex:i];
            v.frame=CGRectMake(0, 0, w, w);
        }
    }
    else if(_photoCount<=4)
    {
        CGFloat w=70;
        for (int i=0; i<subViews.count; i++) {
            UIView* v=[subViews objectAtIndex:i];
            v.frame=CGRectMake((i%2)*(w+m), (i/2)*(w+m), w, w);
        }
    }
    else
    {
        CGFloat w=60;
        for (int i=0; i<subViews.count; i++) {
            UIView* v=[subViews objectAtIndex:i];
            v.frame=CGRectMake((i%3)*(w+m), (i/3)*(w+m), w, w);
        }
    }
    
    CGFloat maxHeight=0;
    for (int i=0; i<subViews.count; i++) {
        UIView* v=[subViews objectAtIndex:i];
        v.hidden=(i>=photoCount);
        if (v.hidden==NO) {
            CGFloat maxy=CGRectGetMaxY(v.frame);
            if (maxy>=maxHeight) {
                maxHeight=maxy;
            }
        }
    }
    
    hh=maxHeight;
    
    self.clipsToBounds=NO;
}

-(CGFloat)height
{
    return hh;
}

@end
