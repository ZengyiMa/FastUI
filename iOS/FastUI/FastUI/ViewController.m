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



@interface ViewController ()<SRWebSocketDelegate>
@property (nonatomic, strong) SRWebSocket *ws;
@property (nonatomic, strong) UIView *container;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.container = [[UIView alloc]initWithFrame:self.view.bounds];
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
    [self.view addSubview:self.container];
    [self buildUI:model.ui rootView:self.container];
}

- (void)buildUI:(FastUIUIModel *)model rootView:(UIView *)rootView {
    if ([model.tag isEqualToString:@"view"]) {
        
    }
}



@end
