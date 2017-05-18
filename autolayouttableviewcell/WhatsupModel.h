//
//  WhatsupModel.h
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface WhatsupModel : NSObject

@property(nonatomic,strong) NSDictionary* dictionary;

@property(nonatomic,strong) NSString* fromName;
@property(nonatomic,strong) NSString* imageName;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* detail;

/**
 UIImage;
 */
@property(nonatomic,strong) NSArray* photos;
/**
 CommentModel;
 */
@property(nonatomic,strong) NSArray* comments;
@property(nonatomic,assign) NSString* date;

+(WhatsupModel*)randomModel;

@end
