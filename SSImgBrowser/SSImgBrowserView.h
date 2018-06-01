//
//  SSImgBrowserView.h
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/29.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSImgBrowserView : UIView
- (void)showImageBrowserInViewController:(UIViewController *)viewController
                          collectionView:(UICollectionView *)collectionView
                            imgIndexPath:(NSIndexPath *)indexPath
                                modelArr:(NSMutableArray *)modelArr;

- (void)closeAction;
@end
