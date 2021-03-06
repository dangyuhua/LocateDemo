//
//  LocateModel.h
//  LocateDemo
//
//  Created by 党玉华 on 2018/12/19.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocateModel : NSObject
//省 直辖市
@property (nonatomic, copy) NSString * administrativeArea;
//地级市 直辖市区 如果是直辖市，只能通过省份来获取
@property (nonatomic, copy) NSString * locality;
//经度
@property (nonatomic, assign) CLLocationDegrees longitude;
//纬度
@property (nonatomic, assign) CLLocationDegrees latitude;

//是否授权
@property (nonatomic, assign) BOOL isAccredit;

+(LocateModel *)shareModel;

@end
