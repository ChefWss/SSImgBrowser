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

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray            *imgUrlArray;
@property (nonatomic, strong) NSMutableArray   *modelArray;
@property (nonatomic, strong) SSImgBrowserView *imgBrowserView;

@end

static NSString *const cellID = @"Cell";
static CGFloat ImgCountEachLine = 3;  //每行n张图
static CGFloat ImgSpacing = 10.00f;   //距离

@implementation ViewController


- (SSImgBrowserView *)imgBrowserView
{
    if (!_imgBrowserView)
    {
        _imgBrowserView = [[SSImgBrowserView alloc] init];
    }
    return _imgBrowserView;
}


- (NSMutableArray *)modelArray
{
    if (!_modelArray)
    {
        _modelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _modelArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _imgUrlArray = @[
                     @"http://upload-images.jianshu.io/upload_images/1455933-e20b26b157626a5d.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-cb2abcce977a09ac.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-92be2b34e7e9af61.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-edd183910e826e8c.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-198c3a62a30834d6.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-e9e2967f4988eb7f.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-ce55e894fff721ed.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-642e217fcdf15774.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-7245174910b68599.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-e74ae4df495938b7.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-ee53be08d63a0d22.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-412255ddafdde125.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-cee5618e9750de12.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-5d5d6ba05853700a.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-6dd4d281027c7749.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-5d3417fa034eafab.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"http://upload-images.jianshu.io/upload_images/1455933-5d5d6ba05853700a.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528107682396&di=f1dcd63555681b51e4aa85845b5c9c14&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01e7ce5979aabea8012193a38ab69d.jpg%402o.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530002174027&di=eb1cbf46ef769f20d8cdbdf1879201fb&imgtype=0&src=http%3A%2F%2Fimg.banbaow.com%2Fuploadfile%2F2015%2F0302%2F15%2F201503021512583260.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530002940636&di=28a872443fa0937d1020205f14e4ea3f&imgtype=0&src=http%3A%2F%2Fthumb.niutuku.com%2F960x1%2F43%2Fc4%2F43c4876c9c9575147a87836da5419aaf.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530003036953&di=852da0997a8531183754a6de0937f8f4&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201406%2F12%2F20140612211118_YYXAC.jpeg"
                     ];
    
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
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:_collectionView];
}


#pragma mark - collectionview delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = kRandomColor;
    UIImageView *imgV =  [[UIImageView alloc] init];
    ImgModel *model = self.modelArray[indexPath.row];
    [imgV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:GetImgWithName(@"placeHolderImg") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        model.imgSize = image.size;
    }];
    imgV.contentMode = UIViewContentModeScaleAspectFill;//设置填充渲染
    imgV.clipsToBounds = YES;//把超出部分裁减掉。
    cell.backgroundView = imgV;
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(ImgSpacing, ImgSpacing, ImgSpacing, ImgSpacing);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imgBrowserView showImageBrowserInViewController:self collectionView:collectionView imgIndexPath:indexPath modelArr:self.modelArray];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
