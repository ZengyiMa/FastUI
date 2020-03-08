//
//  ViewController.m
//  FastUI
//
//  Created by Damien on 2020/3/3.
//  Copyright © 2020 Damien. All rights reserved.
//

#import "ViewController.h"
#import "SRWebSocket.h"
#import "YYModel.h"
#import "FastUIModel.h"
#import "UIView+Yoga.h"
#import "UIView+FastUI.h"
#import "FastUIImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ViewController ()<SRWebSocketDelegate>
@property (nonatomic, strong) SRWebSocket *ws;
@property (nonatomic, strong) UIView *container;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.container = [[UIView alloc]initWithFrame:self.view.bounds];
    self.container.yoga.isEnabled = YES;
    self.container.yoga.width = YGPointValue(self.view.bounds.size.width);
    self.container.yoga.height = YGPointValue(self.view.bounds.size.height);
    [self.view addSubview:self.container];
    self.ws = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:@"ws://localhost:8080"]];
    self.ws.delegate = self;
    [self.ws open];

    // Do any additional setup after loading the view.
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"webSocketDidOpen");
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string {
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    FastUIModel *model =  [FastUIModel yy_modelWithJSON:jsonObject];
    [self updateUI:model];
}


- (void)updateUI:(FastUIModel *)model {
    [self.container removeFromSuperview];
    self.container = [[UIView alloc]initWithFrame:self.view.bounds];
   self.container.yoga.isEnabled = YES;
   self.container.yoga.width = YGPointValue(self.view.bounds.size.width);
   self.container.yoga.height = YGPointValue(self.view.bounds.size.height);
   [self.view addSubview:self.container];
    [self buildUI:model.ui rootView:self.container data:model];
    [self.container.yoga applyLayoutPreservingOrigin:NO];
}

- (void)buildUI:(FastUIUIModel *)model rootView:(UIView *)rootView data:(FastUIModel *)uimodel {
    if (model == nil) {
        return;
    }
   
    [model applayData:uimodel.data];
    if (!model.ifValue) {
           return;
    }
    UIView *view;
    if ([model.tag isEqualToString:@"view"]) {
        // View
        view = [UIView new];
    } else if ([model.tag isEqualToString:@"text"]) {
        view = [UILabel new];
        ((UILabel *)view).text = model.innerText;
    } else if ([model.tag isEqualToString:@"image"]) {
        view = [FastUIImageView new];
    }
    view.yoga.isEnabled = YES;
    [view fastui_applyStyle:model.staticStyle];
    [view fastui_applyAttribute:model.attrsMap];
    [model.children enumerateObjectsUsingBlock:^(FastUIUIModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self buildUI:obj rootView:view data:uimodel];
    }];
    [rootView addSubview:view];
}

@end
