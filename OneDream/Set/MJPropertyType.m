//
//  MJPropertyType.m
//  字典转模型(一)
//
//  Created by 叶 on 15/9/10.
//  Copyright (c) 2015年 six. All rights reserved.
//

#import "MJPropertyType.h"
#import "MJExtensionConst.h"
#import "NSObject+Property.h"
#import "MJProperty.h"

@implementation MJPropertyType

static NSMutableDictionary *cachedTypes_;
+ (void)load
{
    cachedTypes_ = [NSMutableDictionary dictionary];
}

+ (instancetype)propertyTypeWithAttributeString:(NSString *)string{
    return [[MJPropertyType alloc] initWithTypeString:string];
}

- (instancetype)initWithTypeString:(NSString *)string
{
    NSUInteger loc = 1;
    NSUInteger len = [string rangeOfString:@","].location - loc;
    NSString *typeCode = [string substringWithRange:NSMakeRange(loc, len)];
    
    if (!cachedTypes_[typeCode])
    {
        NSLog(@"%@",typeCode);
        self = [super init];
        [self getTypeCode:typeCode];
        cachedTypes_[typeCode] = self;
    }
    return self;
}

- (void)getTypeCode:(NSString *)code
{
    if ([code isEqualToString:MJPropertyTypeId]) {
        _idType = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
        // 去掉@"和"，截取中间的类型名称
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        _numberType = (_typeClass == [NSNumber class] || [_typeClass isSubclassOfClass:[NSNumber class]]);
        _fromFoundation = [NSObject isClassFromFoundation:_typeClass];
    }
    
    // 是否为数字类型
    NSString *lowerCode = code.lowercaseString;
    NSArray *numberTypes = @[MJPropertyTypeInt, MJPropertyTypeShort, MJPropertyTypeFloat,MJPropertyTypeBOOL1,MJPropertyTypeBOOL2, MJPropertyTypeDouble, MJPropertyTypeLong, MJPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        if ([lowerCode isEqualToString:MJPropertyTypeBOOL1]
            || [lowerCode isEqualToString:MJPropertyTypeBOOL2]) {
            
            _boolType = YES;
        }
    }
}
@end
