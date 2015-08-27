//
//  worksList.h
//  master
//
//  Created by jin on 15/8/21.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOPDropDownMenu.h"
@interface worksList : UIView<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)DOPDropDownMenu*menue;
@property(nonatomic)NSMutableArray*firstArray;
@property(nonatomic)NSMutableArray*secondArray;
@property(nonatomic)NSMutableArray*thirdArray;
@property (nonatomic) RefershTableview *tableview;
@property(nonatomic)NSMutableArray*dataArray;//tableview数据源
@property(nonatomic,copy)void(^menueDidSelect)(DOPIndexPath*indexpath);//筛选菜单点击事件
@property(nonatomic,copy)void(^tableDidSelected)(UITableView*tableview,NSIndexPath*indexpath);
@property(nonatomic,copy)void(^tableviewPullDown)(NSInteger current);
@property(nonatomic,copy)void(^tableviewPullup)();
@property(nonatomic,copy)void(^personBlock)(BOOL isYesOrNo);
@end
