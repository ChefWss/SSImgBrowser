//
//  ViewController.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/5/29.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "ViewController.h"
#import "SSImgBrowserView.h"
#import "ImgModel.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, SSImgBrowserDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray            *imgUrlArray;
@property (nonatomic, strong) NSMutableArray   *modelArray;
@property (nonatomic, strong) SSImgBrowserView *imgBrowserView;
@end

static NSString *const cellID = @"Cell";

@implementation ViewController

- (SSImgBrowserView *)imgBrowserView {
    if (!_imgBrowserView) {
        _imgBrowserView = [[SSImgBrowserView alloc] init];
    }
    return _imgBrowserView;
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _imgUrlArray = @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1527585636&di=6b2399ac4de18c24dcdd5a5432b8d708&src=http://pic1.win4000.com/wallpaper/5/532931489604e.jpg",
                     @"https://img4.duitang.com/uploads/item/201602/07/20160207151120_zj5ES.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527595868888&di=98feddfb6ab196cc535a4ea3460ffb8f&imgtype=0&src=http%3A%2F%2Fs13.sinaimg.cn%2Fmw690%2F001pziIZgy6HYy5ciAY6c%26690",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527595869274&di=13bd696a67a91c609583d4ab0ce584a3&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201511%2F07%2F20151107231629_LJ4xC.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527595869273&di=ecf6be2374c939fd9ceb295fcdb0e829&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201406%2F23%2F20140623003759_AhnYr.thumb.700_0.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527653037400&di=364557ac9e57ca73241f9d6b80edcedd&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D4203875446%2C922454611%26fm%3D214%26gp%3D0.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527653089129&di=553fd97d47c13db78c326430ba2af915&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201310%2F11%2F20131011135225_vUPw5.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527653112908&di=b61051e69e7a6aeb9515226b5ad34130&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2Fd%2F5993edf46d3fb.jpg",
                     @"https://img2.woyaogexing.com/2018/05/29/2b17310c3719405eb5673305015ccc2c!400x400.jpeg",
                     @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1527585636&di=6b2399ac4de18c24dcdd5a5432b8d708&src=http://pic1.win4000.com/wallpaper/5/532931489604e.jpg",
                     @"https://img4.duitang.com/uploads/item/201602/07/20160207151120_zj5ES.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527595868888&di=98feddfb6ab196cc535a4ea3460ffb8f&imgtype=0&src=http%3A%2F%2Fs13.sinaimg.cn%2Fmw690%2F001pziIZgy6HYy5ciAY6c%26690",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527595869274&di=13bd696a67a91c609583d4ab0ce584a3&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201511%2F07%2F20151107231629_LJ4xC.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527595869273&di=ecf6be2374c939fd9ceb295fcdb0e829&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201406%2F23%2F20140623003759_AhnYr.thumb.700_0.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527653037400&di=364557ac9e57ca73241f9d6b80edcedd&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D4203875446%2C922454611%26fm%3D214%26gp%3D0.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527653089129&di=553fd97d47c13db78c326430ba2af915&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201310%2F11%2F20131011135225_vUPw5.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527653112908&di=b61051e69e7a6aeb9515226b5ad34130&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2Fd%2F5993edf46d3fb.jpg",
                     @"https://img2.woyaogexing.com/2018/05/29/2b17310c3719405eb5673305015ccc2c!400x400.jpeg"];
    
    [self createModelArray];
    [self createUI];
}

- (void)createModelArray
{
    for (int i = 0; i < _imgUrlArray.count; i++) {
        ImgModel *model = [[ImgModel alloc] init];
        model.imgUrl = _imgUrlArray[i];
        [self.modelArray addObject:model];
    }
}

- (void)createUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat sizeWH = (WIDTH - ImgSpacing) / ImgCountEachLine - ImgSpacing;
    layout.itemSize = CGSizeMake(sizeWH, sizeWH);
    layout.minimumLineSpacing = ImgSpacing;
    layout.minimumInteritemSpacing = ImgSpacing;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT-20) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:_collectionView];
}

#pragma mark - collectionview delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = kRandomColor;
    UIImageView *imgV =  [[UIImageView alloc] init];
    ImgModel *model = self.modelArray[indexPath.row];
    [imgV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:GetImgWithName(@"placeHolderImg")];
    imgV.contentMode = UIViewContentModeScaleAspectFill;//设置填充渲染
    imgV.clipsToBounds = YES;//把超出部分裁减掉。
    cell.backgroundView = imgV;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(ImgSpacing, ImgSpacing, ImgSpacing, ImgSpacing);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImgModel *model = self.modelArray[indexPath.row];    
    model.imgFrame = [Tool getImgFrameWithIndex:indexPath.row];
    [self.imgBrowserView showImgBrowserInViewController:self initialFrame:model.imgFrame modelArr:self.modelArray imgIndex:indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
