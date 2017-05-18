//
//  CommentModel.h
//  autolayouttableviewcell
//
//  Created by jam on 17/5/17.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic,strong) NSDictionary* dictionary;

@property (nonatomic,strong) NSString* fromName;
@property (nonatomic,strong) NSString* toName;
@property (nonatomic,strong) NSString* content;

@property (nonatomic,strong,readonly) NSString* showingText;

+(CommentModel*)randomModel;

@end
