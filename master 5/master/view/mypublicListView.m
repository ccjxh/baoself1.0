//
//  mypublicListView.m
//  master
//
//  Created by jin on 15/8/27.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "mypublicListView.h"
#import "workListTableViewCell.h"
#import "CustomDialogView.h"
@implementation mypublicListView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        
        [self initUI];
        
    }
    
    return self;

}


-(void)initUI{

    self.userInteractionEnabled=YES;
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=0;
    [self addSubview:self.tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 96;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    label.backgroundColor=COLOR(240, 241, 242, 1);
    return label;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    findWorkListModel*model=_dataArray[indexPath.section];
    workListTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"workListTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.title.text=model.title;
    cell.width.constant=model.title.length*16+5;
    cell.personCount.text=[NSString stringWithFormat:@"人数：%lu",model.peopleNumber];
    if ([[model.payType objectForKey:@"name"] isEqualToString:@"面议"]==YES) {
        cell.payMoney.text=@"面议";
    }else{
        
        cell.payMoney.text=[NSString stringWithFormat:@"%@%@",model.pay,[model.payType objectForKey:@"name"]];
    }
    cell.address.text=[NSString stringWithFormat:@"地点：%@",[model.workSite objectForKey:@"name"]];
    cell.date.text=[model.publishTime componentsSeparatedByString:@" "][0];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.listDidSelect) {
        self.listDidSelect(indexPath);
    }

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataArray.count!=0) {
        
    findWorkListModel*model=_dataArray[indexPath.section];
    if (model.autitState ==1) {
        return NO;
        }
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CustomDialogView*cvc=[[CustomDialogView alloc]initWithTitle:@"" message:@"发布的信息删除后无法恢复，请谨慎选择。是否删除？" buttonTitles:@"确定",@"取消", nil];
        __weak typeof(self)WeSelf=self;
        [cvc showInView:self completion:^(NSInteger selectIndex) {
            if (selectIndex==0) {
                if (WeSelf.deleBlock) {
                    WeSelf.deleBlock(indexPath);
                }
            }else{
            
                [WeSelf.tableview reloadData];
            
            }
            
            
        }];
//        [_dataArray removeObjectAtIndex:indexPath.section];
//        // Delete the row from the data source.
//        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
    
}

@end
