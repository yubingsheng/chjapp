//
//  DayTableCell.m
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "DayTableCell.h"

@implementation DayTableCell
+(id)loadNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DayTableCell" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
