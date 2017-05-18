//
//  ViewController.m
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ViewController.h"
#import "DemoCell.h"
#import "WhatsupHeaderView.h"
#import "WhatsupModel.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray* models;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) UIRefreshControl* refresh;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"TableViewCell";
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=200;
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    self.refresh=[[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refresh];
    [self.refresh addTarget:self action:@selector(reloadDataSource) forControlEvents:UIControlEventValueChanged];
    
    WhatsupHeaderView* header=[[WhatsupHeaderView alloc]initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.width)];
    header.headImage=[UIImage imageNamed:@"stig"];
    header.backgroundImage=[UIImage imageNamed:@"headerimage"];
    self.tableView.tableHeaderView=header;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(writeNewCommentNoti:) name:@"writeNewComment" object:nil];
}

-(void)writeNewCommentNoti:(NSNotification*)noti
{
    WhatsupModel* m=[[noti userInfo]valueForKey:@"whatsup"];
    NSMutableArray* comments=[NSMutableArray arrayWithArray:m.comments];
    CommentModel* newComment=[CommentModel randomModel];
    newComment.content=@"新新新评论";
    [comments addObject:newComment];
    m.comments=comments;
    [self.tableView reloadData];
}

-(void)reloadDataSource
{
    self.models=nil;
    [self.tableView reloadData];
    [self.refresh performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
}

-(NSMutableArray*)models
{
    if (_models==nil) {
        _models=[NSMutableArray array];
        int ran=arc4random()%20;
        for (int i=0 ; i<10+ran; i++) {
            WhatsupModel* m=[WhatsupModel randomModel];
            [_models addObject:m];
        }
    }
    return _models;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* iid=@"cell";
    DemoCell* cell=[tableView dequeueReusableCellWithIdentifier:iid];
    if (cell==nil) {
        cell=[[DemoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iid];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell setModel:[self.models objectAtIndex:indexPath.row]];
    return cell;
}

@end
