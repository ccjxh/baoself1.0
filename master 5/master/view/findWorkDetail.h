//
//  findWorkDetail.h
//  master
//
//  Created by jin on 15/8/25.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface findWorkDetail : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UITableView*tableview;
@property(nonatomic)NSMutableArray*dataArray;
@property(nonatomic)findWorkDetailModel*model;
@property(nonatomic,copy)void(^reportBlock)();
@end
