//
//  MyActivityCell.m
//  chjapp
//
//  Created by 启年信息 on 14-11-11.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "MyActivityCell.h"
#import "Product.h"

@implementation MyActivityCell
{
    UILabel* leftTopLab;
    UILabel* leftDownLab;
    UILabel* rightLab;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 75, 50)];
        [self.leftView setBackgroundColor:[UIColor whiteColor]];
        self.leftView.layer.borderWidth = 1;  // 给图层添加一个有色边框
        self.leftView.layer.borderColor = [UIColor redColor].CGColor;
        [self addSubview:self.leftView];
        
        
        leftTopLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.leftView.frame.size.width, self.leftView.frame.size.height/2)];
//        leftTopLab.text = @"11 -11 周二";
        leftTopLab.font = [UIFont systemFontOfSize:10];
        [leftTopLab setTextAlignment:NSTextAlignmentCenter];
        [self.leftView addSubview:leftTopLab];
        
        
        leftDownLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.leftView.frame.size.height/2, self.leftView.frame.size.width, self.leftView.frame.size.height/2)];
//        leftDownLab.text = @"11:12-12.30";
        leftDownLab.font = [UIFont systemFontOfSize:10];
        [leftDownLab setTextAlignment:NSTextAlignmentCenter];
        [leftDownLab setTextColor:[UIColor blueColor]];
        [self.leftView addSubview:leftDownLab];
        
        
        
        
        
        
        
        
        CGFloat rightFloat = self.frame.size.width -self.leftView.frame.origin.x-self.leftView.frame.size.width-20;
        
        self.rightView = [[UIView alloc]initWithFrame:CGRectMake(self.leftView.frame.size.width+20, 10, rightFloat, 50)];
        [self.rightView setBackgroundColor:[UIColor whiteColor]];
        self.rightView.layer.borderWidth = 1;  // 给图层添加一个有色边框
        self.rightView.layer.borderColor = [UIColor redColor].CGColor;
        [self addSubview:self.rightView];
        
        rightLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.rightView.frame.size.width-20, self.rightView.frame.size.height)];
//        rightLab.text = @"agagsghdshdf";
        rightLab.font = [UIFont systemFontOfSize:10];
//        [rightLab setTextAlignment:NSTextAlignmentCenter];
        rightLab.numberOfLines = 0;
        [rightLab setTextColor:[UIColor blueColor]];
        [self.rightView addSubview:rightLab];
        
    }
    return self;
}


- (void)tableViewCellArray:(NSMutableArray*)array Index:(int)index
{
    Product* model = [array objectAtIndex:index];
    
    leftTopLab.text = model.MDate;
    leftDownLab.text = model.MSTIme;
    rightLab.text = model.MName;

}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
