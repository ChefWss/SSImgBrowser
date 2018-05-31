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
@property (nonatomic, assign) CGRect  imgFrame;
@end
