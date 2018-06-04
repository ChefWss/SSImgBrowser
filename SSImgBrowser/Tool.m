//
//  Tool.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+ (CGRect)getImgFrameFromCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath onView:(UIView *)onView
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //获取cell在当前collection的位置
    CGRect cellInCollection = [collectionView convertRect:cell.frame toView:collectionView];
    CGRect cellInSuperview = [collectionView convertRect:cellInCollection toView:onView];
    return cellInSuperview;
}

+ (CGRect)getImgFrameWithIndex:(NSInteger)index
{
    CGFloat w = (WIDTH - ImgSpacing) / ImgCountEachLine - ImgSpacing;
    CGFloat h = (WIDTH - ImgSpacing) / ImgCountEachLine - ImgSpacing;
    CGFloat x = (index % ImgCountEachLine + 1) * (w + ImgSpacing) - w;
    CGFloat y = (index / ImgCountEachLine) * (h + ImgSpacing) + ImgSpacing;
    return CGRectMake(x, y, w, h);
}

@end

