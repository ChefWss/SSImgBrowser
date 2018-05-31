//
//  SSCollectionImgCell.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "SSCollectionImgCell.h"
#import "ImgModel.h"

@interface SSCollectionImgCell()<UIScrollViewDelegate>
@property(nonatomic, strong) UIImageView *imgV;
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SSCollectionImgCell

- (void)setModel:(ImgModel *)model {
    _model = model;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

        _scrollView = [[UIScrollView alloc] init];
        self.backgroundView = _scrollView;
        
        _imgV = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        _imgV.userInteractionEnabled = YES;
        _imgV.backgroundColor = [UIColor yellowColor];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imgV];
        
        // 设置放大缩小的比例
        _scrollView.multipleTouchEnabled = YES;//打开多指触控
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.zoomScale = 3.0;
        _scrollView.delegate = self;

        
        
    }
    return self;
}

// *** 必须实现的代理方法

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imgV;
}
// ***是图片保持位于视图中心

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    self.imgV.center = self.center;
}

@end
