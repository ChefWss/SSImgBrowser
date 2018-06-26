//
//  ImgModel.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "ImgModel.h"

@implementation ImgModel

- (void)reckonImgSizeLayoutByScreenWithImgSize:(CGSize)imgSize
{
    if (HEIGHT == (WIDTH / imgSize.width * imgSize.height))
    {
        //图片为屏幕尺寸
        self.imgLayoutTypeByScreen = ImgSizeLayoutByScreen_Screen;
    }
    else if (HEIGHT > (WIDTH / imgSize.width * imgSize.height))
    {
        //图片横向扁
        self.imgLayoutTypeByScreen =  ImgSizeLayoutByScreen_Horizontal;
    }
    else
    {
        //图片竖向长
        self.imgLayoutTypeByScreen =  ImgSizeLayoutByScreen_Vertical;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end


@implementation InitialFrameModel

- (instancetype)initWithcollectionView:(UICollectionView *)collectionV indexPath:(NSIndexPath *)indexPath onView:(UIView *)onView
{
    self = [super init];
    if (self)
    {
        self.collectionV = collectionV;
        self.indesPath = indexPath;
        self.onView = onView;
    }
    return self;
}

- (CGRect)getCloseFrameWithImageIndex:(NSInteger)imgIndex
{
    _placeholder_InitialFrame = [Tool getImgFrameFromCollectionView:_collectionV indexPath:[NSIndexPath indexPathForRow:imgIndex inSection:0] onView:_onView];
    return _placeholder_InitialFrame;
}

@end
