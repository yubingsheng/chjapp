//
//  SettingTableViewController.m
//  chjapp
//
//  Created by susu on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SetAttention_TableViewController.h"
#import "SetLock_TableViewController.h"
#import "SetRemind_TableViewController.h"
#import "SetAbout_ViewController.h"

@interface SettingTableViewController ()<UIAlertViewDelegate>
{
    UIWebView *phoneCallWebView;
}
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1.];
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {//提醒设置
                SetRemind_TableViewController * remind = [[SetRemind_TableViewController alloc] init];
                [self.navigationController pushViewController:remind animated:YES];
                
            }else if(indexPath.row ==1){//关注设置
                SetAttention_TableViewController * attention = [[SetAttention_TableViewController alloc] init];
                [self.navigationController pushViewController:attention animated:YES];
            }else{//铃声设置
                SetLock_TableViewController * lock = [[SetLock_TableViewController alloc] init];
                [self.navigationController pushViewController:lock animated:YES];
            }
        }
            
            break;
        case 1:
        {
            if(indexPath.row ==0){//关于程序
                SetAbout_ViewController * ablout = [[SetAbout_ViewController alloc] init];
                [self.navigationController pushViewController:ablout animated:YES];
  
            }else{//技术支持
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拨打电话" message:@"技术电话:4008202293" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
                [alert show];
            }
        }
            
            
            break;
        case 2://退出程序
        {
            [UIView beginAnimations:@"exitApplication" context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            self.view.window.bounds = CGRectMake(0, 0, 0, 0);
            [UIView commitAnimations];

        }
            
            break;
            
        default:
            break;
    }
    
}

-(void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1) {
        NSString *phoneNum = @"4008202293";// 电话号码
        
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
        
        if (!phoneCallWebView ) {
            phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
        }
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }
}


@end
