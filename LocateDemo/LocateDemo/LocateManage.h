//
//  LocateManage.h
//  LocateDemo
//
//  Created by 党玉华 on 2018/12/19.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocateModel.h"

@protocol LocateManageDelegate;

@interface LocateManage : NSObject

@property (nonatomic, weak) id<LocateManageDelegate> delegate;

-(void)beginLocate;

@end

@protocol LocateManageDelegate <NSObject>

-(void)endLocate:(LocateModel *)location;

@end
