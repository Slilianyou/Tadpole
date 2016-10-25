//
//  MyInfoViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/11.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoTableViewCell.h"


#define COMPRESSED_RATE 0.8
@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImage *_image;
}
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)UIActionSheet *myActionSheet;
@end

@implementation MyInfoViewController
#pragma Delegate
#pragma mark - UIImagePickControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        //
       // UIImage *protraitImg
       _image = [info objectForKey:@"UIImagePickerControllerEditedImage"];

    // 保存文件到Document路径下  把图片转成NSData类型的数据来保存文件
        NSString *imageDocPath = [self getImageSavePath];
        NSString *imagePath = [imageDocPath stringByAppendingPathComponent:@"imageName"];
        NSData *data = nil;
        
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(_image)) {
            data = UIImagePNGRepresentation(_image);
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(_image, 1.0);
        }
        if ([[NSFileManager defaultManager]fileExistsAtPath:imagePath]) {
            [[NSFileManager defaultManager]removeItemAtPath:imagePath error:nil];
        }
        [[NSFileManager defaultManager] createFileAtPath:imagePath contents:data attributes:nil];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:imageDocPath]){
            NSLog(@"存在文件目录");
        }
     
       // NSLog(@"%@",imageDocPath);
  
        [self.myTableView reloadData];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIActionSheet  Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
       // 相机
       //界面修改成中文   项目的info.plist里面添加Localized resources can be mixed YES（表示是否允许应用程序获取框架库内语言）即可解决这个问题。特此记录下以便以后查看和别人解决问题
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos] ) {
            UIImagePickerController *controller = [[UIImagePickerController alloc]init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc]init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.allowsEditing = YES;
            controller.delegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
        
        
    } else if (buttonIndex == 1)
    {
      // 相册
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc]init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc]init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.allowsEditing = YES;
            controller.delegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
        
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 75;
    }
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoCell"];
    if (!cell) {
        cell = [[MyInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyInfoCell"];
    }
    if (indexPath.row == 0) {
        cell.protraitImage.hidden = NO;
        cell.nameLabel.hidden = YES;
        cell.protraitImage.image = [UIImage imageNamed:@"shoucang.png"];
        NSString *imagePath = [[self getImageSavePath] stringByAppendingPathComponent:@"imageName"];
        NSData *mydata =[[NSFileManager defaultManager] contentsAtPath:imagePath];
        if (!_image) {
            _image = [UIImage imageWithData:mydata];
        }
        cell.protraitImage.image = _image;
        cell.textLabel.text = @"头像";
    } else if (indexPath.row == 1){
        cell.protraitImage.hidden = YES;
        cell.nameLabel.hidden = NO;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.textLabel.text = @"昵称";
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        self.myActionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册",nil];
        [self.myActionSheet showInView:self.view];
    }
};

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self  addCustomView];
}
#pragma mark - Method
#pragma mark - SaveImage
- (void)initData
{
    NSString *imageDocPath = [self getImageSavePath];
    //创建imagFile文件夹
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imageDocPath]) {
        BOOL res = [fm createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (res) {
            NSLog(@"文件目录创建成功： %@",imageDocPath);
        }

    }
    
    // app 沙盒
    NSLog(@"%@",NSHomeDirectory());
}
- (NSString *)getImageSavePath
{
     //获取Documents文件夹目录
    // NSUserDomainMask 代表从用户文件夹下找
    // YES 代表展开路径中的波浪字符“~”
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"PhotoFile"];
    return imageDocPath;
}
#pragma mark - Camera utility(效用)
- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
  //  如果修改局部变量，需要加__block
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMeiaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMeiaTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}
- (BOOL)doesCameraSupportTakingPhotos
{
    // _bridge作用是类型转换 ,只是负责两者形式的转换，不涉及内存权限的转移
    return [self cameraSupportsMedia:(__bridge NSString*)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL)isFrontCameraAailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
#pragma mark - CustomView
- (void)addCustomView
{
   self.title = @"我的资料";
    // addTableView
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleWidth;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.opaque = NO;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.backgroundView = nil;
    self.myTableView.separatorColor = UITableViewCellSeparatorStyleNone;
    self.myTableView.bounces = NO;
    [self.view addSubview:self.myTableView];
    
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.myTableView setTableFooterView:view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
