//
//  ImgModel.h
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgModel : NSObject

@property (nonatomic, copy) NSString  *imgUrl;
@property (nonatomic, strong) UIImage *img;
@property(nonatomic, assign) CGSize imgSize;
@property(nonatomic, assign) CGFloat DoubleTap_ZoomInScaleValue;//双击放大比例

@end


@interface InitialFrameModel : NSObject

@property (nonatomic, assign) CGRect placeholder_InitialFrame;
@property(nonatomic, strong) UICollectionView *collectionV;
@property(nonatomic, strong) NSIndexPath *indesPath;
@property(nonatomic, strong) UIView *onView;
- (instancetype)initWithcollectionView:(UICollectionView *)collectionV indexPath:(NSIndexPath *)indexPath onView:(UIView *)onView;
- (CGRect)getCloseFrameWithImageIndex:(NSInteger)imgIndex;

@end
