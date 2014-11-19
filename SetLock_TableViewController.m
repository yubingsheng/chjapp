//
//  SetLock_TableViewController.m
//  chjapp
//
//  Created by susu on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "SetLock_TableViewController.h"

@interface SetLock_TableViewController ()<UIActionSheetDelegate>
{
    NSArray * nameArr;
    NSMutableArray *imageArr;
    NSString * time;

}

@end

@implementation SetLock_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1.];
    self.navigationItem.title = @"闹铃选项";
    nameArr = [[NSArray alloc] initWithObjects:@"事件闹钟提前提醒",@"全天事件提醒时间",@"全天事件提醒闹钟",@"铃声提醒",@"振动提醒", nil];
    imageArr = [[NSMutableArray alloc] init];
    time = @"8:00";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tableSampleIdentifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell ==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }
    else
    {
        [cell removeFromSuperview];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
        
    }
    
    UIImageView * chooseImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width -40, 5, 30, 30)];
    [cell.contentView addSubview:chooseImage];
    [imageArr addObject:chooseImage];
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [nameArr objectAtIndex:indexPath.row];
   
            break;
        case 1:
            
            cell.textLabel.text = [nameArr objectAtIndex:(indexPath.row + 1)];
            if (indexPath.row ==0) {///显示时间
//                cell.selectionStyle = UITableViewCellEditingStyleNone;
                UILabel * blueLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, 5, 100, 30) ];
                blueLable.textAlignment = NSTextAlignmentRight;
                blueLable.text = time;
                blueLable.textColor = [UIColor blueColor];
                [cell.contentView addSubview:blueLable];
            }
 
            break;
            
        case 2:
        {
            cell.textLabel.text= [nameArr objectAtIndex:(indexPath.row + 3)];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    switch (indexPath.section) {
        case 0:
        {
            UIImageView *view = [imageArr objectAtIndex:0];
            view.image = [UIImage imageNamed:@"okicon.png"];
        }
            break;
        case 1:
            if (indexPath.row ==1) {
                UIImageView *view = [imageArr objectAtIndex:2];
                view.image = [UIImage imageNamed:@"okicon.png"];
            }
            else
            {
//                //调用日期显示
//                UIDatePicker * datePicker = [[UIDatePicker alloc] init];
//                datePicker.tag = 101;
//                datePicker.datePickerMode = UIDatePickerModeTime;
//
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"
//                                                                               message:nil
//                                                                        preferredStyle:UIAlertControllerStyleActionSheet];
//                [alert.view addSubview:datePicker];
//                 UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                     formatter.dateFormat = @" h:mm a";
//                     time = [formatter stringFromDate:datePicker.date];
//                    //显示时间的变量
//                     //一个cell刷新
//                     NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
//                     [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//                    
//                 }];
//                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { }];
//                [alert addAction:ok];
//                [alert addAction:cancel];
//                    
//                
//                [self presentViewController:alert animated:YES completion:nil];
                
            }
            break;
        case 2:
            for (int i=0; i<2; i++) {
                 UIImageView *view = [imageArr objectAtIndex:i+3];
                if (i ==indexPath.row) {
                    view.image = [UIImage imageNamed:@"okicon.png"];

                }else
                {
                    view.image =nil;
                }
            }
            break;
            
        default:
            break;
    }
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    if (section == 1) {
        headerLabel.text = @"                                     全天事件默认提醒";
    }else if(section == 0)
    {
        headerLabel.text = @"                                            事件默认提醒";
    }
//    NSLog(@"section =%ld",(long)section);
//    headerLabel.textAlignment =  NSTextAlignmentRight;
    [headerLabel setFont:[UIFont systemFontOfSize:16.0]];
    [headerLabel setTextColor:[UIColor blackColor]];
    headerLabel.alpha = 0.8;
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    return headerLabel;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"默认事件持续时间";
    
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    return 40.0 ;
    if (section ==2) {
        return 10.0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView  heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
    
}

@end
