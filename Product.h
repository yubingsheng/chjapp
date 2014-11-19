//
//  Product.h
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface Product : NSObject

@property (strong,nonatomic)NSString* MID; // 会议ID
@property (strong,nonatomic)NSString* MName; // 会议名称
@property (strong,nonatomic)NSString* MWhere; // 会议地点
@property (strong,nonatomic)NSString* WTID; // 会议
@property (strong,nonatomic)NSString* MDate; // 会议日期
@property (strong,nonatomic)NSString* MSTIme; // 会议开始时间
@property (strong,nonatomic)NSString* METime; // 会议结束
@property (strong,nonatomic)NSString* MPeople; // 会议人员
@property (strong,nonatomic)NSString* MLinkMan; // 会议联系人
@property (strong,nonatomic)NSString* MProposer; // 会议
@property (strong,nonatomic)NSString* MChecked; // 会议
//@property (strong,nonatomic)NSString* MProposer; // 会议
//@property (strong,nonatomic)NSString* MProposer; // 会议
//@property (strong,nonatomic)NSString* MProposer; // 会议


+(id)meetingModelWithXml:(GDataXMLElement*)xmlElement;

@end
