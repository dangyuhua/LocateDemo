//
//  LocateManage.h
//  LocateDemo
//
//  Created by 党玉华 on 2018/12/19.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocateModel.h"

@interface LocateManage : NSObject

@property(nonatomic,strong)void (^locateSucceedBlcok)(LocateModel * location);
@property(nonatomic,strong)void (^locateFailBlcok)(void);

-(void)beginLocate;

@end
