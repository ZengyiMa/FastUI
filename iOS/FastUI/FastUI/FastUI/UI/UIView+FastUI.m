//
//  UIView+FastUI.m
//  FastUI
//
//  Created by Damien on 2020/3/7.
//  Copyright © 2020 Damien. All rights reserved.
//

#import "UIView+FastUI.h"
#import "UIView+Yoga.h"


@implementation UIView (FastUI)

- (void)fastui_applyStyle:(NSDictionary *)style {
    [style enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
           if ([key isEqualToString:@"flex"]) {
               self.yoga.flex = obj.floatValue;
           } else if ([key isEqualToString:@"background-color"]) {
               self.backgroundColor = UIColor.whiteColor;
           } else if ([key isEqualToString:@"justify-content"]) {
               self.yoga.justifyContent = YGJustifyCenter;
           } else if ([key isEqualToString:@"align-items"]) {
               self.yoga.alignItems = YGAlignCenter;
           } else if ([key isEqualToString:@"text-align"]) {
               if ([obj isEqualToString:@"center"]) {
                   ((UILabel *)self).textAlignment = NSTextAlignmentCenter;
               } else if ([obj isEqualToString:@"left"]) {
                   ((UILabel *)self).textAlignment = NSTextAlignmentLeft;
               } else if ([obj isEqualToString:@"right"]) {
                   ((UILabel *)self).textAlignment = NSTextAlignmentRight;
               }
           }  else if ([key isEqualToString:@"width"]) {
               self.yoga.width = YGPointValue(obj.floatValue);
           } else if ([key isEqualToString:@"height"]) {
               self.yoga.height = YGPointValue(obj.floatValue);
           }
       }];
}

- (void)fastui_applyAttribute:(NSDictionary *)attribute {
    
}

- (void)fastui_applyInnerText:(NSString *)text {
    
}

- (void)fastui_ifConditions {
    
}

@end
