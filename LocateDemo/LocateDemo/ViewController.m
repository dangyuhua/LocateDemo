//
//  ViewController.m
//  LocateDemo
//
//  Created by 党玉华 on 2018/12/19.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import "ViewController.h"
#import "LocateManage.h"


@interface ViewController ()
//设置成属性
@property (nonatomic, strong) LocateManage *locate;

@property(nonatomic,strong)UILabel *city;
@property (nonatomic,assign)BOOL isChange;//是否修改过

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.city = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    self.city.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.city];
    __weak typeof(self) weakSelf = self;
    NSLog(@"开始时间");
    //开始更新定位
    self.locate = [[LocateManage alloc] init];
    [self.locate beginLocate];
    self.locate.locateSucceedBlcok = ^(LocateModel *location) {
        NSLog(@"结束时间");
        //在此对需要的数据进行处理使用
        NSLog(@"省/直辖市：%@",location.administrativeArea);
        NSLog(@"地级市/直辖市区：%@",location.locality);
        NSLog(@"经度：%lf",location.longitude);
        NSLog(@"纬度：%lf",location.latitude);
        weakSelf.city.text = [NSString stringWithFormat:@"%@-%@-%f-%f",location.administrativeArea,location.locality,location.longitude,location.latitude];
        [[LocateModel shareModel]setLongitude:location.longitude];
        [[LocateModel shareModel]setLatitude:location.latitude];
        [[LocateModel shareModel]setLocality:location.locality];
        [[LocateModel shareModel]setAdministrativeArea:location.administrativeArea];
    };
    self.locate.locateFailBlcok = ^{
//        [weakSelf fail];
    };
}

-(void)fail{
    //判断是否授权
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
        [[LocateModel shareModel]setIsAccredit:YES];
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        [[LocateModel shareModel]setIsAccredit:NO];
    }
    if (![LocateModel shareModel].isAccredit) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act1];
        UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alert addAction:act2];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
