//
//  Product.m
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "Product.h"

@implementation Product

+(id)meetingModelWithXml:(GDataXMLElement*)xmlElement
{
    
    
    return [[self alloc]initWithXml:xmlElement];;
}


- (id)initWithXml:(GDataXMLElement*)xmlElement
{
    if (self == [super init]) {
        
        self.MID = [[xmlElement elementsForName:@"MID"].lastObject stringValue];
        self.MName = [[xmlElement elementsForName:@"MName"].lastObject stringValue];
        self.MDate = [[xmlElement elementsForName:@"MDate"].lastObject stringValue];
        self.MSTIme = [[xmlElement elementsForName:@"MSTIme"].lastObject stringValue];
        self.METime = [[xmlElement elementsForName:@"METime"].lastObject stringValue];
        
//        NSMutableDictionary* dicItem = [[NSMutableDictionary alloc] init];
//        
//        [dicItem setValue:MID forKey:@"MID"];
//        [dicItem setValue:MName forKey:@"MName"];
//        [dicItem setValue:MDate forKey:@"MDate"];
//        [dicItem setValue:MSTIme forKey:@"MSTIme"];
//        [dicItem setValue:METime forKey:@"METime"];
        
        
        
    }
    
    return self;
}

@end
