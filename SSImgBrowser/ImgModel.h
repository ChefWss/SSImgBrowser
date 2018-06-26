//
//  ImgModel.h
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ImgSizeLayoutTypeByScreen) {
    ImgSizeLayoutByScreen_Screen,     //屏幕比
    ImgSizeLayoutByScreen_Horizontal, //横向比较长(胖)
    ImgSizeLayoutByScreen_Vertical    //竖向比较长(高)
};

@interface ImgModel : NSObject

@property (nonatomic, copy) NSString  *imgUrl;
@property (nonatomic, strong) UIImage *img;
@property(nonatomic, assign) CGSize imgSize;
@property(nonatomic, assign) CGFloat DoubleTap_ZoomInScaleValue;//双击放大比例
@property(nonatomic, assign) ImgSizeLayoutTypeByScreen imgLayoutTypeByScreen;
- (void)reckonImgSizeLayoutByScreenWithImgSize:(CGSize)imgSize;

@end


@interface InitialFrameModel : NSObject

@property (nonatomic, assign) CGRect placeholder_InitialFrame;
@property(nonatomic, strong) UICollectionView *collectionV;
@property(nonatomic, strong) NSIndexPath *indesPath;
@property(nonatomic, strong) UIView *onView;
- (instancetype)initWithcollectionView:(UICollectionView *)collectionV indexPath:(NSIndexPath *)indexPath onView:(UIView *)onView;
- (CGRect)getCloseFrameWithImageIndex:(NSInteger)imgIndex;

@end
