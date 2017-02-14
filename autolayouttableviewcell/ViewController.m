//
//  ViewController.m
//  autolayouttableviewcell
//
//  Created by iMac206 on 17/2/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ViewController.h"
#import "DemoCell.h"
#import "Model1.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray* models;
@property (nonatomic,strong) UITableView* tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"AutoLayout TableViewCell";
    
//    self.edgesForExtendedLayout=UIRectEdgeNone;
//    self.view.backgroundColor=[UIColor whiteColor];
    
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=1000;
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.view addSubview:self.tableView];
}

-(NSMutableArray*)models
{
    if (_models==nil) {
        _models=[NSMutableArray array];
        for (int i=0 ; i<100; i++) {
            Model1* m=[Model1 randomModel];
            if (m!=nil) {
                [_models addObject:m];
            }
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
