//
//  findAddNewWork.h
//  master
//
//  Created by jin on 15/8/24.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface findAddNewWork : UIView<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray*_dataArray;
   
}

@property(nonatomic)UITableView*tableview;
@property(nonatomic) NSMutableArray*secondArrayPlace;
@property(nonatomic) NSMutableArray*firstArrayPlacea;
@property(nonatomic,copy)void(^didSelect)(NSIndexPath*indexPath);
@property(nonatomic,copy)void(^issiueBlok)();
@end