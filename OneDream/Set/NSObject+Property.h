//
//  NSObject+Property.h
//  字典转模型(一)
//
//  Created by 叶 on 15/9/9.
//  Copyright (c) 2015年 six. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Property)

+ (NSArray *)properties;
+ (BOOL)isClassFromFoundation:(Class) c;

@end
