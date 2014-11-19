//
//  MeetingDetailsViewController.m
//  chjapp
//
//  Created by susu on 14-11-12.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "MeetingDetailsViewController.h"
#import "GDataXMLNode.h"

@interface MeetingDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *meetTable;
    NSArray *imageArr;
    NSArray *lableArr;
}
@end

@implementation MeetingDetailsViewController
@synthesize DetailDic;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"会议详情"withAlignment:NavigationBarTitleViewAlignmentCenter];
    self.view.backgroundColor = [UIColor whiteColor];
    imageArr = [[NSArray alloc] initWithObjects:@"timeicon.png",@"thingicon.png", nil];
    lableArr = [[NSArray alloc] initWithObjects:@"会议名称:", @"会议时间:",@"参与人及部门:",@"会议联系人:",@"会议地点:",nil];
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    meetTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,Main_Screen_Width, Main_Screen_Height-64)style:UITableViewStyleGrouped];
    meetTable.delegate = self;
    meetTable.dataSource = self;
    [self.view addSubview:meetTable];

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }else{
        [cell removeFromSuperview];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArr objectAtIndex:0]]];
    [cell.contentView addSubview:image];
    
  
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, Main_Screen_Width-40, 50)];
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.numberOfLines = 0;
    lable.font = [UIFont systemFontOfSize:16.];
    if(indexPath.section == 0)
    {   if(indexPath.row ==0)
        {//会议名称
            lable.text = [NSString stringWithFormat:@"%@ %@",[lableArr objectAtIndex:indexPath.row],[DetailDic objectForKey:@"MName"]];
        }else
        {//先截取下时间
            NSString *strDate = [[DetailDic objectForKey:@"MDate"]substringToIndex:10];
            lable.text = [NSString stringWithFormat:@"%@ %@→%@ %@",[lableArr objectAtIndex:indexPath.row],[DetailDic objectForKey:@"MSTIme"],[DetailDic objectForKey:@"METime"],strDate];
        }
        
    }else if(indexPath.section ==1)
    {
        if(indexPath.row ==0)
        {//会议参与人及部门
            lable.text = [NSString stringWithFormat:@"%@ %@",[lableArr objectAtIndex:indexPath.row+2],[DetailDic objectForKey:@"MPeople"]];
        }else if(indexPath.row ==1)
        {
            lable.text = [NSString stringWithFormat:@"%@ %@",[lableArr objectAtIndex:indexPath.row+2],[DetailDic objectForKey:@"MLinkMan"]];

        }else
        {
            lable.text = [NSString stringWithFormat:@"%@ %@",[lableArr objectAtIndex:indexPath.row+2],[DetailDic objectForKey:@"MWhere"]];

        }
        
    }
    else
    {
        lable.text = @"公司会议";
    }
    [cell.contentView addSubview:lable];
      return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 2;
    }else if(section ==1)
    {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}
@end
