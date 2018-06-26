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

@end

static CGFloat thresholdScaleValue = 0.6f;        //比例临界值
static CGFloat Default_DoubleTap_ZoomInScaleValue = 2.5f; //常规双击放大比例

@implementation SSCollectionImgCell


- (void)setModel:(ImgModel *)model
{
    _model = model;
    __weak typeof(self) weakSelf = self;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.model.img = image;
        strongSelf.model.DoubleTap_ZoomInScaleValue = [strongSelf reckonDoubleTapZoomInScaleValueWithImgSize:image.size];
        
    }];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:_scrollView];
        //设置代理scrollview的代理对象
        _scrollView.delegate = self;
        //设置最大伸缩比例
        _scrollView.maximumZoomScale = 3.0f;
        //设置最小伸缩比例
        _scrollView.minimumZoomScale = 1.0f;
        //打开多指触控
        _scrollView.multipleTouchEnabled = YES;

        
        _imgV = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        _imgV.userInteractionEnabled = YES;
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imgV];
        
        
        _zoomOut_In = YES;//控制点击图片放大或缩小
        
        
        UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapOne.numberOfTouchesRequired = 1; //单指
        singleTapOne.numberOfTapsRequired = 1;    //单击
        singleTapOne.delegate = self;
        
        UITapGestureRecognizer *doubleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapOne.numberOfTouchesRequired = 1; //单指
        doubleTapOne.numberOfTapsRequired = 2;    //双击
        doubleTapOne.delegate = self;
        
        [singleTapOne requireGestureRecognizerToFail:doubleTapOne];
        
        [_scrollView addGestureRecognizer:singleTapOne];
        [_scrollView addGestureRecognizer:doubleTapOne];
        
    }
    return self;
}


#pragma mark - 手势代理
//单击
- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTouchesRequired == 1)
    {
        [self.delegate delegateCellCloseAction];
    }
}


//双击
- (void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTouchesRequired == 1)
    {
        float newscale = 0.0;
        
        if (_zoomOut_In)
        {
            newscale = self.model.DoubleTap_ZoomInScaleValue;
            _zoomOut_In = NO;
        }
        else
        {
            newscale = 1.0f;
            _zoomOut_In = YES;
        }
        
        CGRect zoomRect = [self zoomRectForScale:newscale withCenter:[sender locationInView:sender.view]];
        NSLog(@"zoomRect:%@",NSStringFromCGRect(zoomRect));
        [_scrollView zoomToRect:zoomRect animated:YES];//重新定义其cgrect的x和y值
    }
}


//缩放代理
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgV;
}


//当缩放完毕的时候调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"结束缩放 - %f", scale);
    
//    scrollView.contentSize = _model.imgSize;
//    _imgV.frame = _scrollView.bounds;
}


//当正在缩放的时候调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"正在缩放.....");
    
//    scrollView.contentSize = _model.imgSize;
//    _imgV.frame = _scrollView.bounds;
}


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = [_scrollView frame].size.height / scale;
    zoomRect.size.width = [_scrollView frame].size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.00);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.00);

    return zoomRect;
}


#pragma mark - 计算双击放大比例
- (CGFloat)reckonDoubleTapZoomInScaleValueWithImgSize:(CGSize)imgSize
{
    if (HEIGHT / (WIDTH / imgSize.width * imgSize.height) < thresholdScaleValue)
    {
        return (WIDTH / imgSize.width * imgSize.height) / HEIGHT;
    }
    else if (WIDTH / (HEIGHT / imgSize.height * imgSize.width) < thresholdScaleValue)
    {
        return (HEIGHT / imgSize.height * imgSize.width) / WIDTH;
    }
    else return Default_DoubleTap_ZoomInScaleValue;
}


#pragma mark - 计算ScrollView.ContentSize
//- (CGSize)reckonScrollViewContentSizeWithImgSize:(CGSize)imgSize
//{
//    if (HEIGHT == (WIDTH / imgSize.width * imgSize.height))
//    {
//        //图片为屏幕尺寸
//        return CGSizeMake(WIDTH, HEIGHT);
//    }
//    else if (HEIGHT > (WIDTH / imgSize.width * imgSize.height))
//    {
//        //图片横向扁
//    }
//    else
//    {
//        //图片竖向长
//
//    }
//}

@end
