//
//  SSCollectionImgCell.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "SSCollectionImgCell.h"
#import "ImgModel.h"

@interface SSCollectionImgCell()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property(nonatomic, strong) UIImageView *imgV;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, assign) BOOL zoomOut_In;//out-1 in-0
//@property(nonatomic, assign) CGFloat min_ScrollViewZoomScale; //捏合手势最小比例
//@property(nonatomic, assign) CGFloat max_ScrollViewZoomScale;
@end

@implementation SSCollectionImgCell

- (void)setModel:(ImgModel *)model {
    _model = model;
    __weak typeof(self) weakSelf = self;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.scrollView.contentSize = image.size;
        strongSelf.model.img = image;
//        [weakSelf reckonTapGestureScaleWithImage:image];
        
    }];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:_scrollView];
        //设置代理scrollview的代理对象
        _scrollView.delegate = self;
        //设置最大伸缩比例
        _scrollView.maximumZoomScale = 3.0;
        //设置最小伸缩比例
        _scrollView.minimumZoomScale = 0.5;
        //打开多指触控
        _scrollView.multipleTouchEnabled = YES;

        
        _imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgV.userInteractionEnabled = YES;
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imgV];
        
        
        _zoomOut_In = YES;//控制点击图片放大或缩小
        
        
        UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapOne.numberOfTouchesRequired = 1;
        singleTapOne.numberOfTapsRequired = 1;
        singleTapOne.delegate = self;
        
        UITapGestureRecognizer *doubleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapOne.numberOfTouchesRequired = 1;
        doubleTapOne.numberOfTapsRequired = 2;
        doubleTapOne.delegate = self;
        
        [singleTapOne requireGestureRecognizerToFail:doubleTapOne];
        
        [_scrollView addGestureRecognizer:singleTapOne];
        [_scrollView addGestureRecognizer:doubleTapOne];
        
    }
    return self;
}

#pragma mark - 手势代理
- (void)handleSingleTap:(UITapGestureRecognizer *)sender {
    if (sender.numberOfTouchesRequired == 1) {
        [self.delegate delegateCellCloseAction];
    }
    
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)sender {
    if (sender.numberOfTouchesRequired == 1) {
        float newscale=0.0;
        
        if (_zoomOut_In) {
            newscale = 2*1.5;
            _zoomOut_In = NO;
        }
        else {
            newscale = 1.0;
            _zoomOut_In = YES;
        }
        
        CGRect zoomRect = [self zoomRectForScale:newscale withCenter:[sender locationInView:sender.view]];
        NSLog(@"zoomRect:%@",NSStringFromCGRect(zoomRect));
        [_scrollView zoomToRect:zoomRect animated:YES];//重新定义其cgrect的x和y值
    }
}

//缩放代理
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imgV;
}

//当缩放完毕的时候调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"结束缩放 - %f", scale);
}

//当正在缩放的时候调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"正在缩放.....");
}



- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    
    
    zoomRect.size.height = [_scrollView frame].size.height / scale;
    
    zoomRect.size.width  = [_scrollView frame].size.width  / scale;
    
    
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    
    
    
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    
    
    return zoomRect;
    
}

#pragma mark - 计算捏合比例
//- (void)reckonTapGestureScaleWithImage:(UIImage *)img
//{
//    CGFloat w = img.size.width;
//    CGFloat h = img.size.height;
//
//    if ((h*1.00 / w) > (HEIGHT*1.00 / WIDTH)) {
//
//    }
//}

@end
