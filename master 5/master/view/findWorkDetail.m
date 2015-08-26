//
//  findWorkDetail.m
//  master
//
//  Created by jin on 15/8/25.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "findWorkDetail.h"
#import "findWorkDetailTableViewCell.h"
#import "findWorkDetailSecondTableViewCell.h"
#import "commendTableViewCell.h"
@implementation findWorkDetail

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        
        [self initUI];
        
    }
    
    return self;
}


-(void)initUI{
    
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-54)];
    self.tableview.separatorStyle=0;
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self addSubview:self.tableview];
    self.tableview.backgroundColor=COLOR(240, 241, 242, 1);
    self.backgroundColor=self.tableview.backgroundColor;
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-54+1, SCREEN_WIDTH, 1)];
    view.backgroundColor=COLOR(203, 203, 203, 1);
    [self addSubview:view];
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(13, SCREEN_HEIGHT-44, 200, 44)];
    AppDelegate*delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    PersonalDetailModel*model=[[dataBase share]findPersonInformation:delegate.id];
    label.text=[NSString stringWithFormat:@"%@  %@",model.realName,model.mobile];
    label.textColor=COLOR(4, 4, 4, 1);
    label.font=[UIFont systemFontOfSize:14];
    [self addSubview:label];
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-140, SCREEN_HEIGHT-44, 140, 44)];
    [button setTitle:@"拨打电话" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    button.backgroundColor=COLOR(22, 168, 234, 1);
    [button addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

}


//拨打电话
-(void)phone{



}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArray.count;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.section==0) {
        
        findWorkDetailTableViewCell*Cell=[tableView dequeueReusableCellWithIdentifier:@"findWorkDetailTableViewCell"];
        if (!Cell) {
            Cell=[[[NSBundle mainBundle]loadNibNamed:@"findWorkDetailTableViewCell" owner:nil options:nil]lastObject];
        }
        
        return Cell;
    }
    
    if (indexPath.section==1) {
        findWorkDetailSecondTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"findWorkDetailSecondTableViewCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"findWorkDetailSecondTableViewCell" owner:nil options:nil]lastObject];
            
        }
        
        return cell;
    }
    NSArray*array=@[@"联系人",@"联系电话"];
    if (indexPath.section==2) {
            commendTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"commendTableViewCell" owner:nil options:nil] lastObject];
                cell.name.text=array[indexPath.row];
                return cell;
                
        }
        
    }
    if (indexPath.row==3) {
        
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"CELL"];
            UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, cell.frame.size.height/2-10, 60, 20)];
            [button setTitle:@"举报" forState:UIControlStateNormal];
            [button setTitleColor:COLOR(22, 168, 234, 1) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(report) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
        }
        cell.textLabel.text=@"内容信息不符?";
        return cell;
    }
    
    return nil;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        return 100;
    }
    if (indexPath.section==1) {
//        CGFloat height=[self accountStringHeightFromString:<#(NSString *)#> Width:<#(CGFloat)#>]
    }
    
    return 40;

}

-(void)report{



}
@end
