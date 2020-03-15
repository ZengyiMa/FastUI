//
//  FastUIUIModel.m
//  FastUI
//
//  Created by Damien on 2020/3/4.
//  Copyright © 2020 Damien. All rights reserved.
//

#import "FastUIUIModel.h"
#import "YYModel.h"

@implementation FastUIUIModel


- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }



+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"isStatic" : @"static", @"ifExp": @"if"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"children" : [FastUIUIModel class]};
}


// 设置for循环的值
- (void)setupForItemValue:(NSDictionary *)dict model:(FastUIUIModel *)model {
    if (model == nil) {
        return;
    }
    model.forItemValue = dict;
    NSMutableArray *children = [NSMutableArray array];
    [model.children enumerateObjectsWithOptions:kNilOptions usingBlock:^(FastUIUIModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FastUIUIModel *newObject = [obj yy_modelCopy];
        [self setupForItemValue:dict model:newObject];
        [children addObject:newObject];
    }];
    model.children = children;
}


- (void)applayData:(NSDictionary *)data {
    
    // 处理for，展开内部逻辑处理
    if (self.isFor && self.dynamicAttrs[@"@for"]) {
        // 也是循环并且有for变量，这时候展开内部元素
        NSMutableArray *childArray = [NSMutableArray array];
        NSMutableArray *forItemArray = data[self.dynamicAttrs[@"@for"]][@"value"];
        [forItemArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull forItem, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.children enumerateObjectsWithOptions:kNilOptions usingBlock:^(FastUIUIModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FastUIUIModel *newObject = [obj yy_modelCopy];
                [self setupForItemValue:forItem model:newObject];
                [childArray addObject:newObject];
            }];
        }];
        self.children = childArray;
    }
    
    NSMutableDictionary *attrsDict = [NSMutableDictionary dictionary];
    // 变量处理
    [self.dynamicAttrs enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        if (self.forValue && [obj hasPrefix:@"item."]) {
            // 使用到循环变量
            obj = [obj stringByReplacingOccurrencesOfString:@"item." withString:@""];
            attrsDict[key] = self.forItemValue[obj];
        }
        else {
            NSDictionary<NSString *, NSString *> *dataValue = data[obj];
            if (dataValue) {
                NSString *type = dataValue[@"type"];
                if ([type isEqualToString:@"bool"]) {
                    BOOL value = dataValue[@"value"].boolValue;
                    attrsDict[key] = @(value);
                } else if ([type isEqualToString:@"string"]) {
                    NSString *value = dataValue[@"value"];
                    attrsDict[key] = value;
                }
            }
        }
        
    }];
    [attrsDict addEntriesFromDictionary:self.attrsMap];
    self.attrsMap = [attrsDict copy];
    if (self.dynamicInnerText) {
        if (self.forValue && [self.dynamicInnerText hasPrefix:@"item."]) {
                   // 使用到循环变量
            self.innerText = self.forItemValue[[self.dynamicInnerText stringByReplacingOccurrencesOfString:@"item." withString:@""]];
        } else {
            self.innerText = data[self.dynamicInnerText][@"value"];
        }
    }
    
    if (self.ifExp) {
       self.ifValue = [data[self.ifExp][@"value"] boolValue];
    } else {
        self.ifValue = YES;
    }
}





@end
