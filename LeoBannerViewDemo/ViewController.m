//
//  ViewController.m
//  LeoBannerViewDemo
//
//  Created by MAC on 2017/9/14.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "LeoBannerView.h"

#define Main_Screen_Height          [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width           [[UIScreen mainScreen] bounds].size.width

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *data = @[@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=734785968,647592903&fm=27&gp=0.jpg",
                      @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1586967258,929379923&fm=27&gp=0.jpg",
                      @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3264922099,1283377187&fm=27&gp=0.jpg",
                      @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3465689303,2387367277&fm=11&gp=0.jpg"];
    
    
    LeoBannerView *banner1 = [[LeoBannerView alloc] initWithSize:CGSizeMake(Main_Screen_Width, 280)];
    [self.view addSubview:banner1];
    [banner1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(280);
        make.left.top.mas_equalTo(0);
        
    }];
    banner1.dataArray = data;
    [banner1 startTimer];
    banner1.blockTouch = ^(LeoBannerView *view, NSString *image_url, NSInteger index) {
        
        NSLog(@"index1 = %ld", index);
        
    };
    
    
    
    
    LeoBannerView *banner2 = [[LeoBannerView alloc] initWithSize:CGSizeMake(Main_Screen_Width, 280)];
    banner2.pageIndexType = LeoBannerViewPageIndexLabel;
    banner2.placeholderImage = [UIImage imageNamed:@"ic_placeholder_image"];
    [self.view addSubview:banner2];
    [banner2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(280);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(banner1.mas_bottom).offset(20);
        
    }];
    banner2.dataArray = data;
    [banner2 startTimer];
    banner2.blockTouch = ^(LeoBannerView *view, NSString *image_url, NSInteger index) {
        
        NSLog(@"index2 = %ld", index);
        
    };
    
}









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
