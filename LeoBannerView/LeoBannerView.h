//
//  LeoBannerView.h
//  LeoBannerViewDemo
//
//  Created by MAC on 2017/9/14.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>


//显示当前页的类型
typedef NS_ENUM(NSInteger , LeoBannerViewPageIndexType) {
    
    LeoBannerViewPageIndexPageControl = 0,
    LeoBannerViewPageIndexLabel
    
};




@class LeoBannerView;
typedef void(^LeoBannerViewTouchImageBlock)(LeoBannerView *view, NSString *image_url, NSInteger index);



@interface LeoBannerView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)UIImageView *currentImageView;
@property (nonatomic, strong, readonly)UIPageControl *pageControl;
@property (nonatomic, strong, readonly)UILabel *lbIndex;
@property (nonatomic, strong, readonly)UIImageView *imgv1;
@property (nonatomic, strong, readonly)UIImageView *imgv2;
@property (nonatomic, strong, readonly)UIImageView *imgv3;
@property (nonatomic, strong, readonly)NSTimer *timer;

@property (nonatomic, assign, readonly)NSInteger pageCount;
@property (nonatomic, assign, readonly)CGSize sizeImage;

/*
 图片加载的缺省图
 */
@property (nonatomic, strong)UIImage *placeholderImage;

/*
 滚动间隔时间
 默认5s
 */
@property (nonatomic, assign)NSTimeInterval interval;

/*
 显示当前页的类型
 默认PageControl
 */
@property (nonatomic, assign)LeoBannerViewPageIndexType pageIndexType;

/*
 数据源
 图片链接数组
 */
@property (nonatomic, strong)NSArray <NSString *>*dataArray;

/*
 显示第几页的图片
 */
@property (nonatomic, assign)NSInteger index;

/*
 点击图片回调
 */
@property (nonatomic, strong)LeoBannerViewTouchImageBlock blockTouch;



- (instancetype)initWithSize:(CGSize)size;

- (void)startTimer;
- (void)stopTimer;

@end
