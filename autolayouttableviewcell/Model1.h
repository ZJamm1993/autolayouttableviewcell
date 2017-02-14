//
//  Model1.h
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model1 : NSObject
@property(nonatomic,strong) NSString* imageName;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* detail;
@property(nonatomic,assign) NSInteger photoCount;
@property(nonatomic,assign) NSString* date;
+(Model1*)randomModel;
@end
