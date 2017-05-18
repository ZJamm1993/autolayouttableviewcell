//
//  DemoCell.h
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhatsupModel.h"
#import "CommentModel.h"

@interface DemoCell : UITableViewCell
@property (nonatomic,strong) WhatsupModel* model;
@end

@interface PhotosView : UIView
@property (nonatomic,assign,readonly) CGFloat height;
@property (nonatomic,strong) NSArray* photos;
@end

@interface CommentsView : UIView
@property (nonatomic,strong) NSArray* comments;
@end
