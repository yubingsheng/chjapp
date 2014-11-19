//
//  AllViewController.m
//  chjapp
//
//  Created by 小郁 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "AllViewController.h"
#import "GDataXMLNode.h"
#import "MyActivityCell.h"

#import "AddActivity ViewController.h"
#import "DayTableViewController.h"
#import "WeekTableViewController.h"
#import "Product.h"


@interface AllViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_meetings;
    NSInteger _tableTag;
    NSString *_strWhere;
}
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)DayTableViewController *dayViewControl;
@property (strong,nonatomic)WeekTableViewController *weekViewControl;
@end

@implementation AllViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    if (!_meetings)
    {
        _meetings=[[NSMutableArray alloc]init];
    }
    _strWhere=@"";
    [self addTableView];
    [self initNavigationBar];
    // Do any additional setup after loading the view.
}
#pragma mark -addViews
-(void)addTableView
{
    if (!_tableView)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50)];
        _tableView.tag=0;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tableView addFooterWithTarget:self action:@selector(footerRefresh)];
        [self.view addSubview:_tableView];
    }
    else
    {
        self.tableView.hidden=NO;
    }
    _strWhere=@"and 1=1";
    [_tableView headerBeginRefreshing];
}
-(void)addDayTable
{
    if (!_dayViewControl)
    {
        _dayViewControl=[[DayTableViewController alloc]init];
        _dayViewControl.tableView.frame=CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50);
        [self.view addSubview:_dayViewControl.tableView];
    }
    else
    {
        _dayViewControl.tableView.hidden=NO;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    _strWhere=[NSString stringWithFormat:@"and T.MDate='%@'",currentDateStr];
     [self getAllMeetingsBystartIndex:1 endIndext:10];
//    [_dayViewControl  dayTableReloadData:_meetings];
}
-(void)addWeekTable
{
    if (!_weekViewControl)
    {
        _weekViewControl=[[WeekTableViewController alloc]init];
        _weekViewControl.tableView.frame=CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50);
        [self.view addSubview:_weekViewControl.tableView];
    }
    else
    {
        _weekViewControl.tableView.hidden=NO;
    }
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",
                       nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                       fromDate:date];
    NSInteger week = [comps week];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    _strWhere=[NSString stringWithFormat:@"and T.WTID=47"];
    [self getAllMeetingsBystartIndex:1 endIndext:10];

    [_weekViewControl weekTableReloadData:_meetings];
}
-(void)hideTable:(NSInteger)index
{
    NSArray *tmpTables=[NSArray arrayWithObjects:_tableView,_dayViewControl,_weekViewControl, nil];
    for (int i=0; i<tmpTables.count; i++)
    {
        UITableView *table=[tmpTables objectAtIndex:i];
        if (i!=index)
        {
            table.hidden=YES;
        }
    }
}
-(void)headerRefresh
{
    [self getAllMeetingsBystartIndex:0 endIndext:10];
}

-(void)footerRefresh
{
    [_tableView headerEndRefreshing];
}
- (void)initNavigationBar
{
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"所有日程"withAlignment:NavigationBarTitleViewAlignmentCenter];
    
    self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(leftMeun) withImage:@"morex" withHighlightImage:@"morex"];
    
    UIBarButtonItem *shareBtn=[CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(addThing) withImage:@"addx" withHighlightImage:@"addx"];
    
    [self.navigationItem setRightBarButtonItem:shareBtn];
}
-(void)leftMeun
{
    __block AllViewController *vc=self;
    AppDelegate *app=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    app.LeftView.cellAction=^(id obj){
        DLog(@"obj==%@",obj);
        [vc tableViewChooseed:obj];
        [app hidedLeftView];
    };
    if (app.LeftView.tag==0)
    {
        [app showLeftMenu];
    }
    else
    {
        [app hidedLeftView];
    }
}
-(void)tableViewChooseed:(NSString*)index
{
    _tableTag=index.integerValue;
    if (_tableTag==0)
    {
        [self addTableView];
    }
    else if (_tableTag==1)
    {
        [self addDayTable];
    }
    else if (_tableTag==2)
    {
        [self addWeekTable];
    }
}
-(void)addThing
{
    
}
#pragma mark- TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  static NSString *str=@"cell";
    MyActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[MyActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell tableViewCellArray:_meetings Index:indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _meetings.count;
}
#pragma mark - Request
-(void)getAllMeetingsBystartIndex:(NSInteger)startIndex endIndext:(NSInteger)endIndex
{
    //GetListByPage3
    NSString* urlString = [NSString stringWithFormat:@"<GetListByPage3 xmlns=\"http://www.woowei.cn/\">\n"
                           "<strWhere>%@</strWhere>\n"
                           "<orderby></orderby>\n"
                           "<startIndex>%ld</startIndex>\n"
                           "<endIndex>%ld</endIndex>\n"
                           "</GetListByPage3>\n",_strWhere,(long)startIndex,(long)endIndex];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetListByPage3"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        
       [_tableView footerEndRefreshing];
        [_tableView headerEndRefreshing];
        NSString* request = (NSString*)result;
         //DLog(@" response== %@",request);
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
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetListByPage3Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetListByPage3Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"ds"];
    
    for (GDataXMLElement * note in ds){
        
        
        Product* productModel = [Product meetingModelWithXml:note];
        [_meetings addObject:productModel];
    }
    
    [_tableView reloadData];
}

#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
