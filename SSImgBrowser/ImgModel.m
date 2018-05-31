//
//  ImgModel.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "ImgModel.h"

@implementation ImgModel

//- (UIImage *)img
//{
//    __block NSData *imageData = nil;
//    if (!_img) {
//        __weak typeof(self) weakSelf = self;
//        [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:_imgUrl] completion:^(BOOL isInCache) {
//            __strong typeof(self) strongSelf = weakSelf;
//            if (isInCache) {
//                NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:strongSelf.imgUrl]];
//                if (cacheImageKey.length) {
//                    NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
//                    if (cacheImagePath.length) {
//                        imageData = [NSData dataWithContentsOfFile:cacheImagePath];
//                    }
//                }
//            }
//            if (!imageData) {
//                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strongSelf.imgUrl]];
//            }
//        }];
//    }
//    return [UIImage imageWithData:imageData];
//}

@end
