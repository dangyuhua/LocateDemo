//
//  LocateManage.m
//  LocateDemo
//
//  Created by 党玉华 on 2018/12/19.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import "LocateManage.h"

@interface LocateManage ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;

@end

@implementation LocateManage

#pragma mark - public
- (void)beginLocate{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];//ios8以上版本使用。
    [self.locationManager startUpdatingLocation];
}

#pragma mark - location delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //定位成功后，及时关闭
    [manager stopUpdatingLocation];
    CLLocation * locate = locations.lastObject;
    LocateModel * location = [[LocateModel alloc] init];
    location.longitude = locate.coordinate.longitude;
    location.latitude = locate.coordinate.latitude;
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locate completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark * placemark = placemarks.firstObject;
            location.administrativeArea = placemark.administrativeArea;
            location.locality = placemark.locality;
            if ([self.delegate respondsToSelector:@selector(endLocate:)]) {
                [self.delegate endLocate:location];
            }
        }
    }];
}

-(void)remove{
    
}

@end
