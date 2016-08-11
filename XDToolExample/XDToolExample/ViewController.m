//
//  ViewController.m
//  XDToolExample
//
//  Created by 邢迪 on 16/8/10.
//  Copyright © 2016年 dylan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建文件夹
    [[XDTool sharedXDTool]getWriteablePathWithSubCreate:@"1",@"2",@"3",@"hello.txt",nil];
    
    //在固定目录创建文件并写入内容；
    NSData *readyToWrite = [@"我要写字符串2" dataUsingEncoding:NSUTF8StringEncoding ];
    [[XDTool sharedXDTool] writeContents:readyToWrite withFileName:@"保存document" forSaveType:SAVETYPE_document toFolderWithSubCreate:@"1", nil];
    
    //在缓冲目录创建缓存文件
    [[XDTool sharedXDTool]writeContents:[@"我要写cache" dataUsingEncoding:NSUTF8StringEncoding ] withFileName:@"保存cache" forSaveType:SAVETYPE_cache toFolderWithSubCreate:@"2",@"3" ,nil];
    
    //创建tmp文件
    [[XDTool sharedXDTool]writeContents:[@"tmp准备删除" dataUsingEncoding:NSUTF8StringEncoding] withFileName:@"tmp" forSaveType:SAVETYPE_tmp toFolderWithSubCreate:@"2",@"fs", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
