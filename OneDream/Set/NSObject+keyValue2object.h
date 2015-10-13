//
//  NSObject+keyValue2object.h
//  字典转模型(一)
//
//  Created by 叶 on 15/9/8.
//  Copyright (c) 2015年 six. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MJKeyValue <NSObject>

@optional
+ (NSDictionary *) objectClassInArray;
+ (NSDictionary *)replacedKeyFromPropertyName;

@end

@interface NSObject (keyValue2object) <MJKeyValue>

+ (instancetype)objectWithKeyValues:(id)keyValues;

@end
