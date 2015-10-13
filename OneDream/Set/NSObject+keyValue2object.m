//
//  NSObject+keyValue2object.m
//  字典转模型(一)
//
//  Created by 叶 on 15/9/8.
//  Copyright (c) 2015年 six. All rights reserved.
//

#import "NSObject+keyValue2object.h"
#import "NSObject+Property.h"
#import "MJProperty.h"
#import "MJPropertyType.h"



@implementation NSObject (keyValue2object)

+ (instancetype)objectWithKeyValues:(id)keyValues{
    if (!keyValues) return nil;
    return [[[self alloc] init] setKeyValues:keyValues];
}

+ (NSString *)propertyKey:(NSString *)propertyName{
    NSString *key;
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self replacedKeyFromPropertyName][propertyName];
    }
    return key?:propertyName;
}

- (instancetype)setKeyValues:(id)keyValues{
    keyValues = [keyValues JSONObject];
    NSArray *propertiesArray = [self.class properties];
    for (MJProperty *property in propertiesArray) {
        MJPropertyType *type = property.type;
        Class typeClass = type.typeClass;
        
        id value = [keyValues valueForKey:[self.class propertyKey:property.name]];
        if (!value) continue;

        if (!type.isFromFoundation && typeClass) {
            value = [typeClass objectWithKeyValues:value];
        }else if ([self.class respondsToSelector:@selector(objectClassInArray)]){
            id objectClass;
            objectClass = [self.class objectClassInArray][property.name];
            
            // 如果是NSString类型
            if ([objectClass isKindOfClass:[NSString class]]) {
                objectClass = NSClassFromString(objectClass);
            }
            
            if (objectClass) {
                // 返回一个装了模型的数组
                value = [objectClass objectArrayWithKeyValuesArray:value];
            }

        }else if (type.isNumberType){
            NSString *oldValue = value;
            // 字符串->数字
            if ([value isKindOfClass:[NSString class]]){
                value = [[[NSNumberFormatter alloc] init] numberFromString:value];
                if (type.isBoolType) {
                    NSString *lower = [oldValue lowercaseString];
                    if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"true"] ) {
                        value = @YES;
                    } else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"]) {
                        value = @NO;
                    }
                }
            }
        }
        else{
            if (typeClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    if (type.isNumberType)
                        // NSNumber -> NSString
                        value = [value description];
                }else if ([value isKindOfClass:[NSURL class]]){
                    // NSURL -> NSString
                    value = [value absoluteString];
                }
            }
        }
        [self setValue:value forKey:property.name];
    }

    return self;
}


/**
 *  根据字典/JSON返回模型数组
 *
 *  @param keyValuesArray 字典/JSON数组
 *
 *  @return 模型数组
 */
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray{
    
    if ([self isClassFromFoundation:self])
        return keyValuesArray;
    
    keyValuesArray = [keyValuesArray JSONObject];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    
    // 遍历
    for (NSDictionary *keyValues in keyValuesArray) {
        id model;
        model = [self objectWithKeyValues:keyValues];
        if (model) {
            [modelArray addObject:model];
        }
    }
    
    return modelArray;

}

- (id)JSONObject{
    id foundationObj;
    if ([self isKindOfClass:[NSString class]]) {
        foundationObj = [NSJSONSerialization JSONObjectWithData:[(NSString *)self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }else if ([self isKindOfClass:[NSData class]]){
        foundationObj = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    return foundationObj?:self;
}

@end
