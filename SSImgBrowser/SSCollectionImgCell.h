//
//  SSCollectionImgCell.h
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellCloseActionDelegate <NSObject>
- (void)delegateCellCloseAction;
@end

@class ImgModel;
@interface SSCollectionImgCell : UICollectionViewCell
@property (nonatomic, weak) id<CellCloseActionDelegate> delegate;
@property(nonatomic, strong) ImgModel *model;
@end
