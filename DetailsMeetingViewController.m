//
//  DetailsMeetingViewController.m
//  chjapp
//
//  Created by 启年信息 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "DetailsMeetingViewController.h"
#import "QNCustomDatePickerView.h"

@interface DetailsMeetingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    QNCustomDatePickerView* datePicker;
    UITextField* textf;
    
    UIButton* leftButt;
    UILabel* leftLab1;
    UILabel* leftLab2;
    
    
    UIButton* rightButt;
    UILabel* rightLab1;
    UILabel* rightLab2;
}
@end

@implementation DetailsMeetingViewController

@synthesize product;

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initNavigationBar];
    
    [self addTableView];
    
}


- (void)initNavigationBar
{
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"增加我和日程"withAlignment:NavigationBarTitleViewAlignmentCenter];
    
    self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(leftMeun) withImage:@"morex" withHighlightImage:@"morex"];
    
}

- (void)addTableView
{
    UITableView* myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64)];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [myTableView setBackgroundColor:RGBCOLOR(220, 220, 220)];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [myTableView setTableFooterView:view];
    [myTableView setTableFooterView:[self addTableFootView]];
    [self.view addSubview:myTableView];
    
    
    datePicker = [[QNCustomDatePickerView alloc]initWithFrame:self.view.frame];
    [datePicker.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.hidden = YES;
    [self.view addSubview:datePicker];
}


- (UIView*)addTableFootView
{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 80)];
    
    UIButton* footButt = [UIButton buttonWithType:UIButtonTypeCustom];
    [footButt setFrame:CGRectMake(0, 0, 210, 40)];
    [footButt setCenter:CGPointMake(footView.frame.size.width/2, 40)];
    [footButt setBackgroundImage:[UIImage imageNamed:@"savebtn.png"] forState:UIControlStateNormal];
    [footButt setBackgroundImage:[UIImage imageNamed:@"savebtnx.png"] forState:UIControlStateHighlighted];
    [footButt addTarget:self action:@selector(footButt:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:footButt];
    
    return footView;
    
}


- (void)leftMeun
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView* leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22-9, 18, 18)];
        
        [leftimg setImage:[UIImage imageNamed:@"thingicon.png"]];
        [cell.contentView addSubview:leftimg];
        
        
        
        
        //        cell setBackgroundColor:[UIColor ]
        switch (indexPath.section) {
            case 0:{
                textf = [[UITextField alloc]initWithFrame:CGRectMake(40, 8, Main_Screen_Width-50, 30)];
                textf.placeholder = [NSString stringWithFormat:@"事件名称:%@",product.MName];
                [cell.contentView addSubview:textf];
                
                
            }
                break;
            case 1:{
                leftButt = [UIButton buttonWithType:UIButtonTypeCustom];
                [leftButt setFrame:CGRectMake(40, 0, (Main_Screen_Width-90)/2, 44)];
                //                [leftButt setBackgroundColor:[UIColor yellowColor]];
//                [leftButt setTitle:@"开始时间" forState:UIControlStateNormal];
                [leftButt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                [leftButt addTarget:self action:@selector(leftbutt:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:leftButt];
                
                leftLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftButt.frame.size.width, leftButt.frame.size.height/2)];
                [leftLab1 setText:[NSString stringWithFormat:@"%@",product.MDate]];
                leftLab1.font = [UIFont systemFontOfSize:12];
                [leftButt addSubview:leftLab1];
                
                leftLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, leftButt.frame.size.height/2, leftButt.frame.size.width, leftButt.frame.size.height/2)];
                [leftLab2 setText:[NSString stringWithFormat:@"%@",product.MSTIme]];
                leftLab2.font = [UIFont systemFontOfSize:12];
                [leftButt addSubview:leftLab2];
                
                
                UIImageView * zhongimag = [[UIImageView alloc]initWithFrame:CGRectMake(leftButt.frame.origin.x+leftButt.frame.size.width+10, 8, 15, 28)];
                [zhongimag setImage:[UIImage imageNamed:@"timerarrow.png"]];
                [cell.contentView addSubview:zhongimag];
                
                rightButt = [UIButton buttonWithType:UIButtonTypeCustom];
                [rightButt setFrame:CGRectMake(zhongimag.frame.origin.x+zhongimag.frame.size.width+10, 0, (Main_Screen_Width-90)/2, 44)];
                //                [rightButt setBackgroundColor:[UIColor yellowColor]];
//                [rightButt setTitle:@"结束时间" forState:UIControlStateNormal];
                [rightButt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                [rightButt addTarget:self action:@selector(rightButt:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:rightButt];
                
                rightLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rightButt.frame.size.width, rightButt.frame.size.height/2)];
                [rightLab1 setText:[NSString stringWithFormat:@"%@",product.MDate]];
                rightLab1.font = [UIFont systemFontOfSize:12];
                [rightButt addSubview:rightLab1];
                
                rightLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, rightButt.frame.size.height/2, rightButt.frame.size.width, rightButt.frame.size.height/2)];
                [rightLab2 setText:[NSString stringWithFormat:@"%@",product.METime]];
                rightLab2.font = [UIFont systemFontOfSize:12];
                [rightButt addSubview:rightLab2];
                
            }
                break;
            case 2:{
                
                UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                label.textColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:label];
                if (indexPath.row == 0) {
                    label.text = [NSString stringWithFormat:@"参与人及部门:%@",product.MPeople];
                }else if (indexPath.row ==1){
                    label.text = [NSString stringWithFormat:@"会议联系人:%@",product.MLinkMan];
                }else if (indexPath.row ==2){
                    label.text = [NSString stringWithFormat:@"会议地点:%@",product.MWhere];
                }
                
            }
                break;
            case 3:
                if (indexPath.row == 0) {
                    
                    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                    label.text = @"个人安排";
                    label.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:label];
                    
                }else{
                    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                    label.text = @"闹铃设置";
                    label.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:label];
                    
                    
                    UILabel* rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 5, 60, 30)];
                    rightLabel.text = @"默认设置";
                    rightLabel.font = [UIFont systemFontOfSize:12];
                    rightLabel.textColor = [UIColor lightGrayColor];
                    [cell.contentView addSubview:rightLabel];
                    
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                }
                
                break;
                
            default:
                break;
        }
        
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==2) {
        return 3;
    }else if (section ==3) {
        return 2;
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 44;
    }else{
        return 44;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



- (void)leftbutt:(UIButton*)sender
{
    NSLog(@"左");
    datePicker.hidden = NO;
    datePicker.datePicker.tag = 10;
    
    
    //    UIDatePicker* leftdat
}

- (void)rightButt:(UIButton*)sender
{
    NSLog(@"右");
    datePicker.hidden = NO;
    datePicker.datePicker.tag = 20;
}

-(void)dateChanged:(UIDatePicker *)sender
{
    //  yyyy-MM-dd HH:mm:ss
    NSDate *laterDate = [sender.date laterDate:[NSDate date]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [formatter stringFromDate:laterDate];
    
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"HH:mm"];
    NSString *str1 = [formatter1 stringFromDate:laterDate];
    
    if (sender.tag == 10) {
        leftLab1.text = str;
        leftLab2.text = str1;
        [leftButt setTitle:@"" forState:UIControlStateNormal];
    }else if (sender.tag == 20){
        rightLab1.text = str;
        rightLab2.text = str1;
        [rightButt setTitle:@"" forState:UIControlStateNormal];
        
        
    }
    
    
}

- (void)footButt:(UIButton*)sender
{
    if (textf.text == nil||[textf.text isEqualToString:@""]) {
        [self addAlertView:@"请输入事件名称"];
    }else if (leftLab1.text.length==0){
        [self addAlertView:@"请选择开始时间"];
    }else if (rightLab1.text.length==0){
        [self addAlertView:@"请选择结束时间"];
    }else{
        NSLog(@"%@  %@  %@",textf.text,leftLab1.text,rightLab1.text);
        
        //        self addActivityRequest:textf.text BeginTime:<#(NSDate *)#> EndTime:<#(NSDate *)#>
    }
    
}



- (void)addActivityRequest:(NSString*)string BeginTime:(NSDate*)beginTime EndTime:(NSDate*)endTime
{
    //    NSString* urlString = [NSString stringWithFormat:@"<GetListByPage2 xmlns=\"http://www.woowei.cn/\">\n"
    //                           "<EName>%@</EName>\n"
    //                           "<orderby></orderby>\n"
    //                           "<startIndex>%d</startIndex>\n"
    //                           "<endIndex>%d</endIndex>\n"
    //                           "</GetListByPage2>\n",eName,startIndex,endIndex];
    //    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetListByPage2"];
    //    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
    //
    //        NSString* request = (NSString*)result;
    //        NSLog(@" == %@",request);
    //
    //        [self xmlString:request];
    //        
    //    } failure:^(NSError *error){
    //        NSLog(@"失败");
    //    }];
    //    [operation startWithHUD:@"正在加载" inView:self.view];
    
    
    
}
- (void)xmlString:(NSString*)string
{
    
}

- (void)addAlertView:(NSString*)string
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

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
