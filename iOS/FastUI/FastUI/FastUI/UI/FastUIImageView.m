//
//  FastUIImageView.m
//  FastUI
//
//  Created by Damien on 2020/3/8.
//  Copyright © 2020 Damien. All rights reserved.
//

#import "FastUIImageView.h"
#import "UIView+FastUI.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FastUIImageView


- (void)fastui_applyAttribute:(NSDictionary *)attribute {
    if (attribute[@"source"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:attribute[@"source"]]];
    }
}


@end
