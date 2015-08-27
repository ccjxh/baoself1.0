//
//  mypublicListView.h
//  master
//
//  Created by jin on 15/8/27.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mypublicListView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)UITableView*tableview;
@property(nonatomic)NSMutableArray*dataArray;//tableview数据源
@property(nonatomic,copy)void(^listDidSelect)(NSIndexPath*indexPath);
@property(nonatomic,copy)void(^deleBlock)(NSIndexPath*indexPath);
@end
