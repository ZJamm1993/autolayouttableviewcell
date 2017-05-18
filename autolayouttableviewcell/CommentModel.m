//
//  CommentModel.m
//  autolayouttableviewcell
//
//  Created by jam on 17/5/17.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(NSString*)showingText
{
    NSString* names=self.fromName;
    if (self.toName.length>0) {
        names=[NSString stringWithFormat:@"%@ @ %@",self.fromName,self.toName];
    }
    NSString* text=[NSString stringWithFormat:@"%@ : %@",names,self.content];
    return text;
}

+(CommentModel*)randomModel
{
    CommentModel* m=[[CommentModel alloc]init];
    m.fromName=(arc4random()%2==0)?@"Jam":@"Mia";
    if (arc4random()%2==0) {
        m.toName=[m.fromName isEqualToString:@"Jam"]? @"Mia":@"Jam";
    }
    NSString* dett=@"旧评论";
    int laps=arc4random()%4;
    for (int i=0; i<laps; i++) {
        dett=[NSString stringWithFormat:@"%@评论评论,",dett];
    }
    m.content=dett;
    return m;
}

@end
