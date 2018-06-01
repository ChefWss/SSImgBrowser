//
//  Tool.h
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject
+ (CGRect)getImgFrameFromCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath onView:(UIView *)onView;
//+ (CGRect)getImgFrameWithIndex:(NSInteger)index;
@end
