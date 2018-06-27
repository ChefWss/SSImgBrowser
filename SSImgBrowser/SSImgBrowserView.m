//
//  SSImgBrowserView.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/29.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "SSImgBrowserView.h"
#import "SSCollectionImgCell.h"
#import "ImgModel.h"
#import "SScollectionImageCellFlowLayout.h"

@interface SSImgBrowserView()<UICollectionViewDelegate, UICollectionViewDataSource, CellCloseActionDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) InitialFrameModel *initialFrameModel;
@property (nonatomic, strong) UIImageView       *placeholderImgV;
@property (nonatomic, assign) NSInteger          imgIndex;
@property (nonatomic, strong) NSMutableArray    *modelArray;
@property (nonatomic, strong) UICollectionView  *collectionview;
@property(nonatomic, strong) UILabel *tipLabel;

@end

static NSString *const cellID = @"ImgCell";

@implementation SSImgBrowserView


- (NSMutableArray *)modelArray
{
    if (!_modelArray)
    {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}


- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor blackColor];
        
        [self createUI];
    }
    return self;
}


- (void)createUI
{
    SScollectionImageCellFlowLayout *layout = [[SScollectionImageCellFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(WIDTH, HEIGHT);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; 
    
    _collectionview = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionview.decelerationRate = 10.0f;//速度衰减
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.pagingEnabled = YES;
    _collectionview.showsHorizontalScrollIndicator = NO;
    _collectionview.backgroundColor = self.backgroundColor;
    [_collectionview registerClass:[SSCollectionImgCell class] forCellWithReuseIdentifier:cellID];
    [self addSubview:_collectionview];
    
    //假的占位图
    _placeholderImgV = [[UIImageView alloc] init];
    _placeholderImgV.backgroundColor = [UIColor clearColor];
    _placeholderImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_placeholderImgV];
    
    //标签
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.textAlignment = 1;
    self.tipLabel.backgroundColor = [UIColor colorWithWhite:0.05 alpha:0.7];
    self.tipLabel.textColor = [UIColor whiteColor];
    self.tipLabel.font = [UIFont systemFontOfSize:kPERCENT(15)];
    self.tipLabel.layer.masksToBounds = YES;
    self.tipLabel.layer.cornerRadius = 3.0f;
    [self addSubview:self.tipLabel];
    
    //
}


#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSCollectionImgCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.modelArray[indexPath.row];
    cell.delegate = self;
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark scrollview滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.imgIndex = self.collectionview.contentOffset.x / WIDTH;
    self.tipLabel.text = [NSString stringWithFormat:@"%ld / %ld", _imgIndex+1, _modelArray.count];
}


#pragma mark - closeAction
- (void)delegateCellCloseAction
{
    [self closeAction];
}


- (void)closeAction
{
    ImgModel *model = self.modelArray[self.imgIndex];
    [self.placeholderImgV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    
    
    self.collectionview.hidden = YES;
    self.placeholderImgV.hidden = NO;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:AnimationTime animations:^{
        
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.placeholderImgV.frame = [strongSelf.initialFrameModel getCloseFrameWithImageIndex:strongSelf.imgIndex];
        
    } completion:^(BOOL finished) {
        
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
        
    }];
}


#pragma mark - show & dismiss
- (void)showImageBrowserInViewController:(UIViewController *)viewController
                          collectionView:(UICollectionView *)collectionView
                            imgIndexPath:(NSIndexPath *)indexPath
                                modelArr:(NSMutableArray *)modelArr
{
    self.modelArray = modelArr;
    self.imgIndex = indexPath.row;
    self.initialFrameModel = [[InitialFrameModel alloc] initWithcollectionView:collectionView indexPath:indexPath onView:viewController.view];
    self.initialFrameModel.placeholder_InitialFrame = [Tool getImgFrameFromCollectionView:collectionView indexPath:indexPath onView:viewController.view];
    
    [viewController.view addSubview:self];
    self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    self.collectionview.frame = self.bounds;
    self.collectionview.contentOffset = CGPointMake(self.imgIndex * WIDTH, 0);
    self.collectionview.hidden = YES;
    
    self.tipLabel.frame = CGRectMake(WIDTH / 2.00 - 35, HEIGHT - 40, 35*2, 28);
    self.tipLabel.text = [NSString stringWithFormat:@"%ld / %ld", indexPath.row+1, modelArr.count];
    
    ImgModel *model = (ImgModel *)self.modelArray[indexPath.row];
    [self.placeholderImgV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    self.placeholderImgV.frame = self.initialFrameModel.placeholder_InitialFrame;
    
    
    [UIView animateWithDuration:AnimationTime animations:^{
        self.placeholderImgV.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    } completion:^(BOOL finished) {
        self.collectionview.frame = self.bounds;
        self.collectionview.hidden = NO;
        self.placeholderImgV.hidden = YES;
    }];
}


@end
