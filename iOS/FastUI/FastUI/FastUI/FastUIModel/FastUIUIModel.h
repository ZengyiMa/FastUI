//
//  FastUIUIModel.h
//  FastUI
//
//  Created by Damien on 2020/3/4.
//  Copyright © 2020 Damien. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface FastUIUIModel : NSObject
// 1：页面元素 
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSArray *attrsList;
@property (nonatomic, copy) NSDictionary *attrsMap;
@property (nonatomic, copy) NSArray *rawAttrsMap;
@property (nonatomic, copy) NSArray *text;
@property (nonatomic, copy) NSArray<FastUIUIModel *> *children;
@property (nonatomic, assign) BOOL plain;
@property (nonatomic, assign) BOOL isStatic;
@property (nonatomic, assign) BOOL staticRoot;
@property (nonatomic, copy) NSString *innerText;
@property (nonatomic, strong) NSDictionary *staticStyle;
@property (nonatomic, strong) NSDictionary *dynamicAttrs;
@property (nonatomic, copy) NSString *dynamicInnerText;

// if表达式
@property (nonatomic, copy) NSString *ifExp;
// if判断的值
@property (nonatomic, assign) BOOL ifValue;

// if为False的值
@property (nonatomic, strong) FastUIUIModel *elseElement;


- (void)applayData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
