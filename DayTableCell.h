//
//  DayTableCell.h
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
+(id)loadNib;
@end
