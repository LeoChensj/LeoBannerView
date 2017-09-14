//
//  LeoBannerView.m
//  LeoBannerViewDemo
//
//  Created by MAC on 2017/9/14.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "LeoBannerView.h"
#import "UIImageView+WebCache.h"

@implementation LeoBannerView

- (instancetype)initWithSize:(CGSize)size
{
    if(self = [super init])
    {
        _sizeImage = size;
        
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        
        
        
        _imgv1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _imgv1.contentMode = UIViewContentModeScaleAspectFill;
        _imgv1.clipsToBounds = YES;
        [_scrollView addSubview:_imgv1];
        
        _imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(size.width, 0, size.width, size.height)];
        _imgv2.userInteractionEnabled = YES;
        _imgv2.contentMode = UIViewContentModeScaleAspectFill;
        _imgv2.clipsToBounds = YES;
        [_scrollView addSubview:_imgv2];
        _currentImageView = _imgv2;
        
        _imgv3 = [[UIImageView alloc] initWithFrame:CGRectMake(size.width*2, 0, size.width, size.height)];
        _imgv3.contentMode = UIViewContentModeScaleAspectFill;
        _imgv3.clipsToBounds = YES;
        [_scrollView addSubview:_imgv3];
        
        
        
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, size.height-20, 0, 20)];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        
        _lbIndex = [[UILabel alloc] initWithFrame:CGRectMake(size.width-50-15, size.height-20-10, 50, 20)];
        _lbIndex.layer.masksToBounds = YES;
        _lbIndex.layer.cornerRadius = 3;
        _lbIndex.textColor = [UIColor whiteColor];
        _lbIndex.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _lbIndex.textAlignment = NSTextAlignmentCenter;
        _lbIndex.font = [UIFont systemFontOfSize:12];
        [self addSubview:_lbIndex];
        _lbIndex.hidden = YES;
        
        
        
        
        //tap
        UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageFunc)];
        [_imgv2 addGestureRecognizer:tapImage];
        
        
        
        _index = 0;
        _interval = 5;
    }
    
    return self;
}

- (void)startTimer
{
    if(!_timer.valid)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(timerFunc:) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}







#pragma mark - Set
- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    _dataArray = dataArray;
    
    _pageCount = dataArray.count;
    _pageControl.numberOfPages = _pageCount;
    _scrollView.contentSize = CGSizeMake(_sizeImage.width*_pageCount, _sizeImage.height);
    self.index = _index;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    if(_dataArray && _dataArray.count)
    {
        _index = index%_pageCount;
        
        _pageControl.currentPage = index;
        _scrollView.contentOffset = CGPointMake(_sizeImage.width, 0);
        _lbIndex.text = [NSString stringWithFormat:@"%ld/%ld", _index+1, _pageCount];
        
        
        [_imgv1 sd_setImageWithURL:[NSURL URLWithString:_dataArray[(index+_pageCount-1)%_pageCount]] placeholderImage:_placeholderImage];
        [_imgv2 sd_setImageWithURL:[NSURL URLWithString:_dataArray[(index)%_pageCount]] placeholderImage:_placeholderImage];
        [_imgv3 sd_setImageWithURL:[NSURL URLWithString:_dataArray[(index+1)%_pageCount]] placeholderImage:_placeholderImage];
    }
    else
    {
        NSLog(@"先设置dataArray");
    }
}

- (void)setPageIndexType:(LeoBannerViewPageIndexType)pageIndexType
{
    _pageIndexType = pageIndexType;
    
    if(pageIndexType==LeoBannerViewPageIndexPageControl)
    {
        _pageControl.hidden = NO;
        _lbIndex.hidden = YES;
    }
    else if(pageIndexType==LeoBannerViewPageIndexLabel)
    {
        _pageControl.hidden = YES;
        _lbIndex.hidden = NO;
    }
}






#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x<self.frame.size.width)
    {
        self.index = (_index+_pageCount-1)%_pageCount;
    }
    else
    {
        self.index = (_index+1)%_pageCount;
    }
    
    [self startTimer];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    if(_pageCount>0)
    {
        self.index = (_index+1)%_pageCount;
        
        [self startTimer];
    }
}




- (void)timerFunc:(NSTimer *)timer
{
    [_scrollView setContentOffset:CGPointMake(_sizeImage.width*2, 0) animated:YES];
}






#pragma mark - tap
- (void)tapImageFunc
{
    if(self.blockTouch)
    {
        self.blockTouch(self, self.dataArray[self.index], self.index);
    }
}






@end













