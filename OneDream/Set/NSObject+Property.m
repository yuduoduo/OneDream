
//
//  NSObject+Property.m
//  字典转模型(一)
//
//  Created by 叶 on 15/9/9.
//  Copyright (c) 2015年 six. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>
#import "MJProperty.h"
#import "MJPropertyType.h"
#import "NSObject+keyValue2object.h"

typedef struct property_t {
    const char *name;
    const char *attributes;
} *propertyStruct;

@implementation NSObject (Property)
static NSSet *foundationClasses_;

static NSMutableDictionary *cachedProperties_;
+ (void)load
{
    cachedProperties_ = [NSMutableDictionary dictionary];
}


+ (NSSet *)foundationClasses
{
    if (foundationClasses_ == nil) {
        
        foundationClasses_ = [NSSet setWithObjects:
                              [NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return foundationClasses_;
}

+ (BOOL)isClassFromFoundation:(Class)c{
    if (c == [NSObject class]) return YES;
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([c isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

+ (NSArray *)properties
{
    NSMutableArray *cachedProperties = cachedProperties_[NSStringFromClass(self)];
    
    if (!cachedProperties) {
        
//        NSLog(@"%@调用了properties方法",[self class]);
        
        cachedProperties = [NSMutableArray array];
        // 1.获得所有的属性
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(self, &outCount);
        
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            
            MJProperty *propertyObj = [MJProperty propertyWithProperty:property];
            
            [cachedProperties addObject:propertyObj];
        }
        
        free(properties);
        
        cachedProperties_[NSStringFromClass(self)] = cachedProperties;
    }

    return cachedProperties;
}



@end
