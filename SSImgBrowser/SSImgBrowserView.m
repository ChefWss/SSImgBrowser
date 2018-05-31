//
//  SSImgBrowserView.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/29.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "SSImgBrowserView.h"
#import "ImgModel.h"
#import "SSCollectionImgCell.h"

@interface SSImgBrowserView()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, assign) CGRect            initialFrame;
@property (nonatomic, strong) UICollectionView *collectionview;
@end

static NSString *const cellID = @"ImgCell";

@implementation SSImgBrowserView

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (instancetype)init  {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithRed:0.13 green:0.12 blue:0.11 alpha:1.00];
//        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(WIDTH, HEIGHT);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionview.contentOffset = CGPointMake(0, 0);
    _collectionview = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.pagingEnabled = YES;
    _collectionview.backgroundColor = [UIColor redColor];
    [_collectionview registerClass:[SSCollectionImgCell class] forCellWithReuseIdentifier:cellID];
    [self addSubview:_collectionview];
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SSCollectionImgCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.modelArray[indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    self.imgIndex = x / WIDTH;
}


#pragma mark - closeAction
- (void)closeAction
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:AnimationTime animations:^{
        
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.frame = [Tool getImgFrameWithIndex:self.imgIndex];
        self.collectionview.frame = self.bounds;

    } completion:^(BOOL finished) {
        
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
        
    }];
}

#pragma mark - show & dismiss
- (void)showImgBrowserInViewController:(UIViewController<SSImgBrowserDelegate> *)viewController
                          initialFrame:(CGRect)initialFrame
                              modelArr:(NSMutableArray *)modelArr
                              imgIndex:(NSInteger)index
{
    self.modelArray = modelArr;
    self.imgIndex = index;
    self.initialFrame = initialFrame;
    self.delegate = viewController;
    
    [viewController.view addSubview:self];
    self.frame = self.initialFrame;
    self.collectionview.frame = self.bounds;
    [self.collectionview reloadData];
    
    self.collectionview.contentOffset = CGPointMake(self.imgIndex * WIDTH, 0);
    [UIView animateWithDuration:AnimationTime animations:^{
        self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.collectionview.frame = self.bounds;
    }];

    
    //背景灰色添加轻拍手势
    UITapGestureRecognizer *gester = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:gester];
    [gester addTarget:self action:@selector(closeAction)];
 
}

@end
