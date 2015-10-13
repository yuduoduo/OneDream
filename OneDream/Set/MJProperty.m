//
//  MJProperty.m
//  字典转模型(一)
//
//  Created by 叶 on 15/9/9.
//  Copyright (c) 2015年 six. All rights reserved.
//

#import "MJProperty.h"
#import "MJPropertyType.h"

@implementation MJProperty


+ (instancetype)propertyWithProperty:(objc_property_t)property{
    return  [[MJProperty alloc] initWithProperty:property];
}


- (instancetype)initWithProperty:(objc_property_t)property{
    if (self = [super init]) {
        _name = @(property_getName(property));

        _type = [MJPropertyType propertyTypeWithAttributeString:@(property_getAttributes(property))];;
    }
    return self;
}

@end
