//
//  DemoCell.h
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model1.h"

@interface DemoCell : UITableViewCell
@property (nonatomic,strong) Model1* model;
@end

@interface PhotosView : UIView
@property (nonatomic,assign,readonly) CGFloat height;
@property (nonatomic,assign) NSInteger photoCount;
@property (nonatomic,strong) UIColor* photoBackgroundColor;
@end
