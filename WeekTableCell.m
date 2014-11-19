//
//  WeekTableCell.m
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "WeekTableCell.h"

@implementation WeekTableCell

+(id)loadNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WeekTableCell" owner:nil options:nil]lastObject];
}
-(void)addScrollView:(NSArray*)array
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
