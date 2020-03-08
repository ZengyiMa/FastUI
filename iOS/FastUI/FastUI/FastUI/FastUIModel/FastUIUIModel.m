//
//  FastUIUIModel.m
//  FastUI
//
//  Created by Damien on 2020/3/4.
//  Copyright © 2020 Damien. All rights reserved.
//

#import "FastUIUIModel.h"

@implementation FastUIUIModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"isStatic" : @"static", @"ifExp": @"if"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"children" : [FastUIUIModel class]};
}


- (void)applayData:(NSDictionary *)data {
    NSMutableDictionary *attrsDict = [NSMutableDictionary dictionary];
    // 变量处理
    [self.dynamicAttrs enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
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
    }];
    [attrsDict addEntriesFromDictionary:self.attrsMap];
    self.attrsMap = [attrsDict copy];
    
    if (self.dynamicInnerText) {
        self.innerText = data[self.dynamicInnerText][@"value"];
    }
    
    if (self.ifExp) {
       self.ifValue = [data[self.ifExp][@"value"] boolValue];
    } else {
        self.ifValue = YES;
    }
}


@end
