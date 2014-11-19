//
//  WeekTableViewController.h
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekTableViewController : UITableViewController
@property (strong,nonatomic) NSArray *dataArray;//外部数据的接口
-(void)weekTableReloadData:(NSArray*)array;
@end
