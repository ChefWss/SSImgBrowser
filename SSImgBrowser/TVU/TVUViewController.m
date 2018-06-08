//
//  TVUViewController.m
//  SSImgBrowser
//
//  Created by 王少帅 on 2018/6/7.
//  Copyright © 2018 王少帅. All rights reserved.
//

#import "TVUViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>

@interface TVUViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIVideoEditorControllerDelegate>

@property(nonatomic, strong) UIImagePickerController *pickerContr;

@end

@implementation TVUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //1.判断相机是否可用 视频是否可用
    if (![self isCramaAvialable]) {
        UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"相机不可用" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    else {
//        [self configPicker];
    }
    
    

}

//配置UIImagePickerController 并present出来
//我们需要在这里配置PickerController的资源类型/媒体类型等,闪光灯,录制时间,视频质量,都可以在这里设置.
-(void)configPicker{
    self.pickerContr = [[UIImagePickerController alloc]init];
    //设置资源类型
    [self.pickerContr setSourceType:UIImagePickerControllerSourceTypeCamera];
    if ([self isAvalableMediaType:kUTTypeMovie sourcType:UIImagePickerControllerSourceTypeCamera]) {
        //配置媒体类型
        [self.pickerContr setMediaTypes:@[(__bridge NSString *)kUTTypeMovie]];
        //配置视频质量
        [self.pickerContr setVideoQuality:UIImagePickerControllerQualityTypeHigh];
        //设置最大录制时间
        [self.pickerContr setVideoMaximumDuration:10];
        //设置代理
        self.pickerContr.delegate = self;
        [self presentViewController:self.pickerContr animated:YES completion:nil];
    }else{
        UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"视频不可用" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}



#pragma mark - 判断设备可用性
- (BOOL)isCramaAvialable{
    //相机是否可用
    return  [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    //    //后置相机是否可用
    //    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    //    //前置相机是否可用
    //    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    //    //后置闪光灯是否可用
    //    [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
    //    //前置闪光灯是否可用
    //    [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront];
}

//判断指定资源类型下的媒体类型是否可用
//这里的资源类型是指 相机还是图库等
//媒体类型是指 是图片还是视频 视频选用movie 而不是video 请注意
-(BOOL)isAvalableMediaType:(CFStringRef)mediaType sourcType:(UIImagePickerControllerSourceType)soureType{
    NSArray *array =  [UIImagePickerController availableMediaTypesForSourceType:soureType];
    NSLog(@"%@",array);
    return [array containsObject:(__bridge NSString *)mediaType];
}

#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    UIVideoEditorController *videoEditor = nil;
//    if ([info[UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
//        NSURL *URL =  info[UIImagePickerControllerMediaURL];
//        //ios 9.0废弃
//        //        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc]init];
//        //        [lib writeVideoAtPathToSavedPhotosAlbum:URL completionBlock:nil];
//        //        "Use creationRequestForAssetFromVideoAtFilePath: on PHAssetChangeRequest from the Photos framework to create a new asset instead"
//        
//        //ios 8.0+
//        NSError *error;
//        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//            [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:URL];
//            NSLog(@"%@",error);
//        } error:&error];
//        
//        if([UIVideoEditorController canEditVideoAtPath:URL.path]){
//            videoEditor = [[UIVideoEditorController alloc]init];
//            videoEditor.videoPath = URL.path;
//            videoEditor.delegate = self;
//        }
//    }
//    
//    [picker dismissViewControllerAnimated:YES completion:^{
//        [self presentViewController:videoEditor animated:YES completion:nil];
//    }];
    
}

//下面这个是视频编辑控制器的代理方法
- (void)videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath{
    NSLog(@"%@",editedVideoPath);
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL fileURLWithPath:editedVideoPath]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"保存成功");
        }
        
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
