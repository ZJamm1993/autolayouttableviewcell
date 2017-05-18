//
//  DemoCell.m
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "DemoCell.h"
#import "Masonry.h"

#define graybgcolor [UIColor colorWithWhite:0.95 alpha:1]

@interface DemoCell()

@property (nonatomic,strong) UIImageView* head;
@property (nonatomic,strong) UILabel* title;
@property (nonatomic,strong) UILabel* detail;
@property (nonatomic,strong) UILabel* date;
@property (nonatomic,strong) UIButton* write;
@property (nonatomic,strong) PhotosView* photosview;
@property (nonatomic,strong) CommentsView* commentsview;

@end

@implementation DemoCell
{
    UIEdgeInsets insets;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        insets=UIEdgeInsetsMake(10, 10, 10, 10);
        
        self.head=[[UIImageView alloc]init];
        [self.contentView addSubview:self.head];
        
        self.title=[[UILabel alloc]init];
        self.title.textColor=[UIColor colorWithRed:0.5 green:0.6 blue:0.8 alpha:1];
        [self.contentView addSubview:self.title];
        
        self.detail=[[UILabel alloc]init];
        self.detail.numberOfLines=0;
        [self.contentView addSubview:self.detail];
        
        self.photosview=[[PhotosView alloc]init];
        [self.contentView addSubview:self.photosview];
        
        self.commentsview=[[CommentsView alloc]init];
        self.commentsview.backgroundColor=graybgcolor;
        [self.contentView addSubview:self.commentsview];
        
        self.date=[[UILabel alloc]init];
        self.date.font=[UIFont systemFontOfSize:12];
        self.date.textColor=[UIColor grayColor];
        self.date.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.date];
        
        self.write=[[UIButton alloc]init];
        [self.write setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.write setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.write setBackgroundColor:self.title.textColor];
        [self.write setTitle:@"∙∙" forState:UIControlStateNormal];
        [self.write addTarget:self action:@selector(writeNewComment) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.write];
        
//        self.head.backgroundColor=[UIColor redColor];
//        self.title.backgroundColor=[UIColor cyanColor];
//        self.detail.backgroundColor=[UIColor magentaColor];
//        self.date.backgroundColor=[UIColor greenColor];
//        self.photos.backgroundColor=[UIColor orangeColor];
        
        [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).insets(insets).key(@"head_top_left");
            make.width.height.equalTo(@(40)).key(@"head_width_height");
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.head.mas_top).key(@"title_top");
            make.left.equalTo(self.head.mas_right).insets(insets).key(@"title_left");
            make.right.equalTo(self.contentView).offset(-10).key(@"title_right");
        }];
        
        [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_left).key(@"detail_left");
            make.right.equalTo(self.title.mas_right).key(@"detail_right");
        }];
        
        [self.photosview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_left).key(@"photos_left");
            make.right.equalTo(self.title.mas_right).key(@"photos_right");
        }];
        
        [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.photosview.mas_bottom).insets(insets).key(@"date_top");
            make.left.equalTo(self.title.mas_left).key(@"date_left");
        }];
        
        [self.write mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.date);
            make.right.equalTo(self.title.mas_right);
            make.width.equalTo(@(22));
            make.height.equalTo(@(20));
        }];
        
        [self.commentsview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_left).key(@"comments_left");
            make.right.equalTo(self.title.mas_right).key(@"comments_right");
            make.bottom.equalTo(self.contentView.mas_bottom).insets(insets).key(@"comments_bottom");
        }];
    }
    return self;
}

-(void)writeNewComment
{
    NSDictionary* d=[NSDictionary dictionaryWithObject:self.model forKey:@"whatsup"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"writeNewComment" object:nil userInfo:d];
}

-(void)updateConstraints
{
    [self.detail mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(self.detail.text.length>0?insets.top:0);
    }];

    [self.photosview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.photosview.height)).key(@"photos_height");
        make.top.equalTo(self.detail.mas_bottom).offset(self.photosview.photos.count>0?insets.top:0).priorityLow();
    }];
    
    [self.commentsview mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(self.commentsview.height)).key(@"comments_height");
        make.top.equalTo(self.date.mas_bottom).offset(self.commentsview.comments.count>0?insets.top:0).priorityLow();
    }];
    
    [super updateConstraints];
}

-(void)setModel:(WhatsupModel *)model
{
    _model=model;
    self.head.image=[UIImage imageNamed:model.imageName];
    self.title.text=model.title;
    self.detail.text=model.detail;
    self.date.text=@"today";
    self.photosview.photos=model.photos;
    self.commentsview.comments=model.comments;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

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

-(void)setPhotos:(NSArray *)photos
{
    _photos=photos;
    NSArray* subViews=self.subviews;
    
    NSInteger _photoCount=photos.count;
    
    //remove and create again if needs
    if (subViews.count!=9)
    {
        for (UIView *v in subViews) {
            [v removeFromSuperview];
        }
        for (int i=0;i<9; i++) {
            UIImageView* php=[[UIImageView alloc]init];
            php.contentMode=UIViewContentModeScaleAspectFill;
            php.clipsToBounds=YES;
            php.backgroundColor=graybgcolor;
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
        BOOL hidden=(i>=_photoCount);
        v.hidden=hidden;
        if (hidden==NO) {
            UIImage* phot=[photos objectAtIndex:i];
            UIImageView* php=(UIImageView*)v;
            php.image=phot;
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

@implementation CommentsView
{
    CGFloat hh;
}

-(void)setComments:(NSArray *)comments
{
    _comments=comments;
    
    NSArray* subViews=self.subviews;
    
    NSInteger counts=comments.count;
    
    //remove and create again if needs
    for (UIView *v in subViews) {
        [v removeFromSuperview];
    }
    
    CGFloat my=4;
    
    UIView* lastView=self;
    for (int i=0; i<counts; i++) {
        UILabel* lab=[[UILabel alloc]init];
        [self addSubview:lab];
        
        lab.numberOfLines=0;
        lab.font=[UIFont systemFontOfSize:13];
        
        CommentModel* co=[comments objectAtIndex:i];
        
        lab.text=co.showingText;
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(i==0?lastView.mas_top:lastView.mas_bottom).offset(my);
            make.left.equalTo(self).offset(my);
            make.right.equalTo(self).offset(-my);
            if (i==counts-1) {
                make.bottom.lessThanOrEqualTo(self).offset(-my);  //!!!!!!
            }
        }];
        lastView=lab;
    }
    
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
    
//    CGFloat hei=[self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
////        if (counts==0) {
////            make.height.equalTo(@(0)).priorityHigh();
////        }
////        else
////        {
////            make.bottom.equalTo(lastView.mas_bottom).offset(my).priorityHigh();
////        }
//        make.height.equalTo(@(hei)).priorityHigh();
//    }];
    
}

@end
