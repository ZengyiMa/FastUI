//
//  UIView+FastUI.h
//  FastUI
//
//  Created by Damien on 2020/3/7.
//  Copyright © 2020 Damien. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FastUI)


- (void)fastui_applyStyle:(NSDictionary *)style;
- (void)fastui_applyAttribute:(NSDictionary *)attribute;
- (void)fastui_applyInnerText:(NSString *)text;
- (void)fastui_ifConditions;

@end

NS_ASSUME_NONNULL_END
