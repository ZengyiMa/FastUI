//
//  FastUIModel.h
//  FastUI
//
//  Created by Damien on 2020/3/4.
//  Copyright © 2020 Damien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FastUIUIModel.h"
#import "FastUIDataModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface FastUIModel : NSObject
@property (nonatomic, strong) FastUIUIModel *ui;
@property (nonatomic, strong) NSDictionary<NSString *, NSDictionary<NSString *, NSString *>*> *data;
@end

NS_ASSUME_NONNULL_END
