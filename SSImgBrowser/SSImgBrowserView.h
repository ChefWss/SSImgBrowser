//
//  SSImgBrowserView.h
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/29.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class SSImgBrowserView;
@protocol SSImgBrowserDelegate <NSObject>
//- (void)passwordKeybordDidEdit:(SSImgBrowserView *)keybord;
@end

@interface SSImgBrowserView : UIView
@property (nonatomic, assign) NSInteger                 imgIndex;
@property (nonatomic, strong) NSMutableArray           *modelArray;
@property (nonatomic, weak) id<SSImgBrowserDelegate> delegate;
- (void)showImgBrowserInViewController:(UIViewController<SSImgBrowserDelegate> *)viewController
                          initialFrame:(CGRect)initialFrame
                              modelArr:(NSMutableArray *)modelArr
                              imgIndex:(NSInteger)index;
- (void)closeAction;
@end
