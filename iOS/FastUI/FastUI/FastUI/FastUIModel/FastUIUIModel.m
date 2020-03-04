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
    return @{@"isStatic" : @"static"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"children" : [FastUIUIModel class]};
}
@end
