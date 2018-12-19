//
//  ViewController.m
//  LocateDemo
//
//  Created by 党玉华 on 2018/12/19.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import "ViewController.h"
#import "LocateManage.h"


@interface ViewController ()<LocateManageDelegate>
//设置成属性
@property (nonatomic, strong) LocateManage *locate;

@property(nonatomic,strong)UILabel *city;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.city = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    self.city.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.city];
    NSLog(@"开始时间");
    //开始更新定位
    self.locate = [[LocateManage alloc] init];
    self.locate.delegate = self;
    [self.locate beginLocate];
}


-(void)endLocate:(LocateModel *)location{
    NSLog(@"结束时间");
    //在此对需要的数据进行处理使用
    NSLog(@"省/直辖市：%@",location.administrativeArea);
    NSLog(@"地级市/直辖市区：%@",location.locality);
    NSLog(@"经度：%lf",location.longitude);
    NSLog(@"纬度：%lf",location.latitude);
    self.city.text = [NSString stringWithFormat:@"%@-%@-%f-%f",location.administrativeArea,location.locality,location.longitude,location.latitude];
    [[LocateModel shareModel]setLongitude:location.longitude];
    [[LocateModel shareModel]setLatitude:location.latitude];
    [[LocateModel shareModel]setLocality:location.locality];
    [[LocateModel shareModel]setAdministrativeArea:location.administrativeArea];
}

- (void)dealloc{
    self.locate.delegate = nil;
}

@end
