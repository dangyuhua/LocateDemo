//
//  LocateModel.m
//  LocateDemo
//
//  Created by 党玉华 on 2018/12/19.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import "LocateModel.h"

@implementation LocateModel

static LocateModel *model = nil;

+(LocateModel *)shareModel{
    static dispatch_once_t onceToken;
    dispatch_once(& onceToken, ^{
        if (model == nil) {
            model = [[LocateModel alloc]init];
        }
    });
    return model;
}

@end
