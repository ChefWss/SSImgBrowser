//
//  SScollectionImageCellFlowLayout.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/6/5.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "SScollectionImageCellFlowLayout.h"



@implementation SScollectionImageCellFlowLayout


/*
 UICollectionViewLayoutAttributes:确定cell的尺寸
 一个UICollectionViewLayoutAttributes对象就对应一个cell
 拿到UICollectionViewLayoutAttributes相当于拿到cell
 */

// 重写它方法,扩展功能

// 什么时候调用:collectionView第一次布局,collectionView刷新的时候也会调用
// 作用:计算cell的布局,条件:cell的位置是固定不变
// - (void)prepareLayout
//{
//    [super prepareLayout];
//
//    NSLog(@"%s",__func__);
//
//}

// 作用:指定一段区域给你这段区域内cell的尺寸
// 可以一次性返回所有cell尺寸,也可以每隔一个距离返回cell
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //    NSLog(@"%s",__func__);
    // 设置cell尺寸 => UICollectionViewLayoutAttributes
    // 越靠近中心点,距离越小,缩放越大
    // 求cell与中心点距离
    
    // 1.获取当前显示cell的布局
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        // 2.计算中心点距离
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width * 0.5);
        
        // 3.计算比例
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5) * (ImgCellSpacing / WIDTH);
        
        attr.transform = CGAffineTransformMakeScale(scale, 1);//(x,y)
    }
    
    return attrs;
}

// 什么时候调用:用户手指一松开就会调用
// 作用:确定最终偏移量
// 定位:距离中心点越近,这个cell最终展示到中心点
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
//
//    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
//    CGFloat collectionW = self.collectionView.bounds.size.width;
//
//    // 最终偏移量
//    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
//
//    // 0.获取最终显示的区域
//    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);
//
//    // 1.获取最终显示的cell
//    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
//
//    // 获取最小间距
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attr in attrs) {
//        // 获取距离中心点距离:注意:应该用最终的x
//        CGFloat delta = (attr.center.x - targetP.x) - self.collectionView.bounds.size.width * 0.5;
//
//        if (fabs(delta) < fabs(minDelta)) {
//            minDelta = delta;
//        }
//    }
//
//    // 移动间距
//    targetP.x += minDelta;
//
//    if (targetP.x < 0) {
//        targetP.x = 0;
//    }
//
//    return targetP;
//}

// Invalidate:刷新
// 在滚动的时候是否允许刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

// 计算collectionView滚动范围
//- (CGSize)collectionViewContentSize{
//    return [super collectionViewContentSize];
//}


@end
