//
//  worksList.m
//  master
//
//  Created by jin on 15/8/21.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "worksList.h"
#import "workListTableViewCell.h"

@implementation worksList


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        
                self.tableview.isSupportPulldown=YES;
                self.tableview.isSupportPullup=YES;
                __weak typeof(self)WeSelf=self;
                [self.tableview tablePullDownWithBlock:^(UITableView *self) {
        
                    //上拉刷新
                    if (WeSelf.tableviewPullDown) {
                        WeSelf.tableviewPullDown(0);
                    }
        
                }];
        
                [self.tableview tablePullUpWithBlock:^(UITableView *self) {
                   //下拉加载
                    if (WeSelf.tableviewPullup) {
                        WeSelf.tableviewPullup();
                    }
                    
                }];

       
        [self initUI];
       
    }
    
    return self;

}



-(void)initUI{

    _menue=[[DOPDropDownMenu alloc]initWithOrigin:CGPointMake(0,64) andHeight:44];
    _menue.dataSource=self;
    _menue.type=1;
    _menue.textColor=COLOR(67, 67, 67, 1);
    _menue.textSelectedColor=COLOR(67, 67, 67, 1);
    _menue.indicatorColor=[UIColor clearColor];
    _menue.delegate=self;
    __weak typeof(self)weSelf=self;
    __weak typeof(DOPDropDownMenu*)menu=_menue;
    _menue.backgroundColor=[UIColor clearColor];
    _menue.block=^(NSMutableDictionary*dict){

    
    
    };
    _menue.areablock=^(NSInteger status){

        
    };
    _menue.rankblock=^(NSInteger status){

        
        
    };
    
    [self addSubview:_menue];
    self.tableview=[[RefershTableview alloc]initWithFrame:CGRectMake(0, menu.frame.origin.y+menu.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-menu.frame.size.height-10-49)];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor=COLOR(240, 241, 242, 1);
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
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

    if (self.tableDidSelected) {
        self.tableDidSelected(tableView,indexPath);
    }

}


#pragma mark-选择菜单的delegate
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}


- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
        if (column == 0) {
            
            NSLog(@"%lu",self.firstArray.count);
            return self.firstArray.count;
            
        }else if (column == 1){
            [self.secondArray removeAllObjects];
            NSMutableArray*Array=[[dataBase share]findAllPay];
            for (NSInteger i=0;i<Array.count; i++) {
                payModel*model=Array[i];
                [self.secondArray addObject:model.name];
            }
            
        return self.secondArray.count;
    }else {
        return self.thirdArray.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
        if (indexPath.column == 0) {
            if (_firstArray.count!=0) {
                AreaModel*model=_firstArray[indexPath.row];
                return model.name;
            }
            else
            {
                return @"全市区";
            }
        }else
    if (indexPath.column == 1){
        
        if (_secondArray.count==0) {
            return @"待遇";
        }
        return self.secondArray[indexPath.row];
        
        
    } else {
       
        if (self.thirdArray.count==0) {
            return @"信誉";
        }
        return self.thirdArray[indexPath.row];
    }
    
    
    return @"ss";
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 0) {
            return 0;
        } else if (row == 2){
            return 0;
        } else if (row == 3){
            return 0;
        }
    }
    return 0;
}



@end
