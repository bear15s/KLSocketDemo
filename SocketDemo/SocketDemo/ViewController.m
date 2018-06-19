//
//  ViewController.m
//  SocketDemo
//
//  Created by zbmy on 2018/6/19.
//  Copyright © 2018年 HakoWaii. All rights reserved.
//

#import "ViewController.h"
#import <SocketRocket.h>

@interface ViewController ()<SRWebSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (weak, nonatomic) IBOutlet UITextView *responseTextView;
@property (strong, nonatomic) SRWebSocket * webSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.addressTextField.text = @"ws://118.24.74.84";
    self.portTextField.text = @"8282";
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)connectBtnClick:(UIButton *)sender {
    NSString* fullURLString = [NSString stringWithFormat:@"%@:%@",self.addressTextField.text,self.portTextField.text];
    self.webSocket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:fullURLString]];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

- (IBAction)disconnectBtnClick:(UIButton *)sender {
    [self.webSocket close];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"open!");
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"读取数据 string = %@",message);
    self.responseTextView.text = message;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"读取数据 data = %@",str);
    
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"failCode = %zd,Reson = %@",code,reason);
    self.webSocket.delegate = nil;
    self.responseTextView.text = @"断开连接";
}


@end
