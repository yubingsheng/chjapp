//
//  FollowViewController.m
//  chjapp
//
//  Created by 小郁 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "FollowViewController.h"
#import "MeetingDetailsViewController.h"
#import "MJRefresh.h"
#import "GDataXMLNode.h"


@interface FollowViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *followTableView;
    NSArray *imageArr;
    NSMutableArray *allArr;

}

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"关注人的会议"withAlignment:NavigationBarTitleViewAlignmentCenter];
    imageArr = [[NSArray alloc] initWithObjects:@"personicon.png",@"timeicon.png",@"thingicon.png", nil];
    allArr = [[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    followTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,Main_Screen_Width, Main_Screen_Height-64-49)style:UITableViewStyleGrouped];
    followTableView.delegate = self;
    followTableView.dataSource = self;
    followTableView.backgroundColor = [UIColor clearColor];
    [followTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [followTableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [followTableView addFooterWithTarget:self action:@selector(footerRefresh)];

    [self.view addSubview:followTableView];
    [self GetList:@"方银儿"];
    
}

- (void)GetList:(NSString*)eName
{
    //http://www.woowei.cn/WebService/Attention.asmx关注人信息
    
    NSString* urlString = [NSString stringWithFormat:@"<GetMyAttentionPeopleMeetings3_2 xmlns=\"http://www.woowei.cn/\">\n"
                           "<EName>%@</EName>\n"
                           "<pageSize>%d</pageSize>\n"
                           "<pageIndex>%d</pageIndex>\n"
                           "</GetMyAttentionPeopleMeetings3_2>\n",eName,10,1];
    CHJRequestUrl *request=[CHJRequest GetMyAttentionPeopleMeetings2:urlString soapUrl:@"GetMyAttentionPeopleMeetings3_2"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        
//        NSLog(@"成功");
        
        NSString* request = (NSString*)result;
        NSLog(@"request == %@",request);
        [self xmlString:request];
        
    } failure:^(NSError *error){
        NSLog(@"失败");
    }];
    [operation startWithHUD:@"正在加载" inView:self.view];

}

- (void)xmlString:(NSString*)xmlString
{

    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    //    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:self.reciveData options:0 error:nil];
    
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetMyAttentionPeopleMeetings3_2Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetMyAttentionPeopleMeetings3_2Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"ds"];
    NSLog(@"ds =%@",ds);
    for (GDataXMLElement * note in ds){
        
        NSString* MName = [[note elementsForName:@"MName"].lastObject stringValue];
        NSString* MDate = [[note elementsForName:@"MDate"].lastObject stringValue];
        NSString* MSTIme = [[note elementsForName:@"MSTIme"].lastObject stringValue];
        NSString* METime = [[note elementsForName:@"METime"].lastObject stringValue];//会议估计结束时间
        NSString* PAName = [[note elementsForName:@"PAName"].lastObject stringValue];
        NSString* MLinkMan = [[note elementsForName:@"MLinkMan"].lastObject stringValue];//会议联系人
        NSString* MPeople = [[note elementsForName:@"MPeople"].lastObject stringValue];//会议其他参与人或部门或
        NSString* MWhere = [[note elementsForName:@"MWhere"].lastObject stringValue];//会议地点(已有的会议室加上其它地点)
        NSMutableDictionary* dicItem = [[NSMutableDictionary alloc] init];
        
        [dicItem setValue:MName forKey:@"MName"];
        [dicItem setValue:MDate forKey:@"MDate"];
        [dicItem setValue:MSTIme forKey:@"MSTIme"];
        [dicItem setValue:PAName forKey:@"PAName"];
        [dicItem setValue:METime forKey:@"METime"];
        [dicItem setValue:MLinkMan forKey:@"MLinkMan"];
        [dicItem setValue:MPeople forKey:@"MPeople"];
        [dicItem setValue:MWhere forKey:@"MWhere"];
//        [dicItem setValue:METime forKey:@"METime"];
        
        [allArr addObject:dicItem];
        NSLog(@"allarr =%@",allArr);
    }
    
    [followTableView reloadData];
}


-(void)headerRefresh
{
    [followTableView footerEndRefreshing];
}
-(void)footerRefresh
{
    [followTableView headerEndRefreshing];
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
    //三个view
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, 85, 30)];
    [self.leftView setBackgroundColor:[UIColor whiteColor]];
    self.leftView.layer.borderWidth = 1;  // 给图层添加一个有色边框
    self.leftView.layer.borderColor = [UIColor grayColor].CGColor;
    [cell.contentView addSubview:self.leftView];
    
    
    self.rightView = [[UIView alloc]initWithFrame:CGRectMake(self.leftView.frame.size.width+20, 5, Main_Screen_Width -self.leftView.frame.size.width-30, 30)];
    [self.rightView setBackgroundColor:[UIColor whiteColor]];
    self.rightView.layer.borderWidth = 1;  // 给图层添加一个有色边框
    self.rightView.layer.borderColor = [UIColor grayColor].CGColor;
    [cell.contentView addSubview:self.rightView];

    self.downView = [[UIView alloc]initWithFrame:CGRectMake(10, 40, Main_Screen_Width -20, 50)];
    [self.downView setBackgroundColor:[UIColor whiteColor]];
    self.downView.layer.borderWidth = 1;  // 给图层添加一个有色边框
    self.downView.layer.borderColor = [UIColor grayColor].CGColor;
    [cell.contentView addSubview:self.downView];
//三个image
    for(int i = 0 ;i<3 ;i++)
    {
        UIImageView *image = [[UIImageView alloc] init];
        image.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArr objectAtIndex:i]]] ;
        if (i==0) {
            image.frame = CGRectMake(10, 7, 15, 15);
            [self.leftView addSubview:image];
        }else if(i==1)
        {
            image.frame = CGRectMake(90, 6, 18, 18);
            [self.rightView addSubview:image];
        }
        else
        {
             image.frame = CGRectMake(10, 15, 18, 18);
            [self.downView addSubview:image];
        }
    }
    
//四个lable
    UILabel * lableLeft = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 65, 30)];
    lableLeft.textColor = [UIColor orangeColor];
    lableLeft.font = [UIFont systemFontOfSize:14.];
    lableLeft.text = [NSString stringWithFormat:@"%@",[[allArr objectAtIndex:indexPath.row] objectForKey:@"PAName"]];
    [self.leftView addSubview:lableLeft];
    
    UILabel *rightLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 85, 30)];
    rightLable.text = [NSString stringWithFormat:@"%@",[[allArr objectAtIndex:indexPath.row] objectForKey:@"MDate"]];
    rightLable.font = [UIFont systemFontOfSize:14.];
    [self.rightView addSubview:rightLable];
    
    UILabel * rightLableR = [[UILabel alloc] initWithFrame:CGRectMake(110,0,  self.rightView.frame.size.width-105, 30)];
    NSString *str1 =[self time:indexPath.row];
    NSString *str2 = [self time:indexPath.row];
    rightLableR.text = [NSString stringWithFormat:@"%@→%@",str1,str2];
    rightLableR.font = [UIFont systemFontOfSize:14.];
    rightLableR.textColor = [UIColor blueColor];
    [self.rightView addSubview:rightLableR];
    
    UILabel *downLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, self.downView.frame.size.width-30,30)];
    downLable.text = [NSString stringWithFormat:@"%@",[[allArr objectAtIndex:indexPath.row] objectForKey:@"MName"]];
    [self.downView addSubview:downLable];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return allArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    MeetingDetailsViewController * meet = [[MeetingDetailsViewController alloc] init];
    [meet setHidesBottomBarWhenPushed:YES];
    meet.DetailDic =[allArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:meet animated:YES];


}


-(NSString *)time:(NSInteger)num
{
    NSString *String1 =[[allArr objectAtIndex:num] objectForKey:@"MSTIme"];
    [String1 hasPrefix:@"PT"] == 1 ?String1 =[String1 stringByReplacingOccurrencesOfString:@"PT" withString:@""] : NSLog(@"NO");
    [String1 hasSuffix:@"H"] == 1 ?String1 =[String1 stringByReplacingOccurrencesOfString:@"H" withString:@":"] : NSLog(@"NO");
    [String1 hasSuffix:@"M"] == 1 ?String1 =[String1 stringByReplacingOccurrencesOfString:@"M" withString:@""] : (String1 =[String1 stringByReplacingOccurrencesOfString:@"M" withString:@"00"]);
    
    //    [String1 hasSuffix:@""] == 1 ?String1 =[String1 stringByReplacingOccurrencesOfString:@"H" withString:@"时"] : NSLog(@"NO");
    
    return String1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
