//
//  MJProperty.h
//  字典转模型(一)
//
//  Created by 叶 on 15/9/9.
//  Copyright (c) 2015年 six. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class MJPropertyType;
@interface MJProperty : NSObject

/** 成员属性的名字 */
@property (nonatomic, readonly) NSString *name;
/** 成员属性的类型 */
@property (nonatomic, readonly) MJPropertyType *type;

+ (instancetype)propertyWithProperty:(objc_property_t)property;

@end
