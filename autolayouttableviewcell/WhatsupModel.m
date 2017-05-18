//
//  WhatsupModel.m
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "WhatsupModel.h"

@implementation WhatsupModel
+(WhatsupModel*)randomModel
{
    WhatsupModel* m=[[WhatsupModel alloc]init];
    
    m.imageName=@"stig";
    
    m.title=@"Jam";
    
    NSString* dett=@"";
    int laps=arc4random()%4;
    for (int i=0; i<laps; i++) {
        dett=[NSString stringWithFormat:@"%@正文正文正文正文正文,",dett];
    }
    m.detail=dett;
    
    NSMutableArray* phs=[NSMutableArray array];
    int counts=arc4random()%10;
    for (int i=0; i<counts; i++) {
        [phs addObject:[UIImage imageNamed:@"whatsupimage"]];
    }
    m.photos=phs;
    
    NSMutableArray* coms=[NSMutableArray array];
    counts=arc4random()%4;
    for (int i=0; i<counts; i++) {
        [coms addObject:[CommentModel randomModel]];
    }
    m.comments=coms;
    
    m.date=[[NSDate date]description];
    
//    m.title=[NSString stringWithFormat:@"%d图片 %d评论",(int)m.photos.count,(int)m.comments.count];
    
    return m;
}
@end
