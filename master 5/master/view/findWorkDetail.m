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
    
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-54)];
    self.tableview.separatorStyle=0;
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self addSubview:self.tableview];
    self.tableview.backgroundColor=COLOR(240, 241, 242, 1);
    self.backgroundColor=self.tableview.backgroundColor;
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-54+1, SCREEN_WIDTH, 1)];
    view.backgroundColor=COLOR(203, 203, 203, 1);
    [self addSubview:view];
    UIView*backView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44)];
    backView.backgroundColor=[UIColor whiteColor];
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(13, 0, 200, 44)];
    label.tag=10;
    AppDelegate*delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    PersonalDetailModel*model=[[dataBase share]findPersonInformation:delegate.id];
    if (self.model) {
    label.text=[NSString stringWithFormat:@"%@  %@",model.realName,model.mobile];
    }
    label.textColor=COLOR(0, 0, 0, 1);
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:14];
    [backView addSubview:label];
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-140, 0, 140, 44)];
    [button setTitle:@"拨打电话" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    button.backgroundColor=COLOR(22, 168, 234, 1);
    [button addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    backView.userInteractionEnabled=YES;
    [self addSubview:backView];
}


//拨打电话
-(void)phone{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.model.phone];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    UILabel*label=(id)[self viewWithTag:10];
    if (self.model) {
        if (self.model) {
            label.text=[NSString stringWithFormat:@"%@  %@",self.model.contacts,self.model.phone];
        }
    }
    return 4;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==2) {
        return 2;
    }
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section==0) {
        
        return 0;
        
    }
    
    if (section==3) {
        return 14;
    }
    
    return 33;

}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray*array=@[@"",@"职位描述",@"发布人信息",@"",@"",@""];
    if (section==1||section==2) {
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(30, 20, SCREEN_WIDTH, 16)];
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(13, 14, SCREEN_WIDTH, 16)];
    label.textColor=COLOR(114, 114, 114, 1);
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:12];
    label.text=array[section];
    [view addSubview:label];
    return view;
    }
    
    return nil;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.section==0) {
        
        findWorkDetailTableViewCell*Cell=[tableView dequeueReusableCellWithIdentifier:@"findWorkDetailTableViewCell"];
        if (!Cell) {
            Cell=[[[NSBundle mainBundle]loadNibNamed:@"findWorkDetailTableViewCell" owner:nil options:nil]lastObject];
        }
        if (self.model) {
            
        Cell.title.text=self.model.title;
            Cell.title.textColor=COLOR(0, 0, 0, 1);
        Cell.date.text=self.model.publishTime;
            Cell.address.text=[NSString stringWithFormat:@"%@%@",[self.model.workSite objectForKey:@"name"],self.model.address];
        Cell.count.text=[NSString stringWithFormat:@"浏览量：%lu",self.model.pageView];
        Cell.pay.textColor=COLOR(238, 103, 29, 1);
        Cell.unit.textColor=COLOR(238, 103, 29, 1);
        Cell.addressHeight.constant=[self accountStringHeightFromString:[NSString stringWithFormat:@"%@%@",[self.model.workSite objectForKey:@"name"],self.model.address] Width:SCREEN_WIDTH-100]+5;
        Cell.peopleCount.text=[NSString stringWithFormat:@"%lu",self.model.peopleNumber];
        if ([[self.model.payType objectForKey:@"name"] isEqualToString:@"面议"]==YES) {
            Cell.pay.text=@"面议";
            Cell.unit.hidden=YES;
        }else{
        
            Cell.pay.text=[NSString stringWithFormat:@"%lu",[self.model.pay integerValue]];
            Cell.payWidth.constant=Cell.pay.text.length*13;
            Cell.unit.text=[self.model.payType objectForKey:@"name"];
            }
           
        }
        
        [Cell reloadData];
        return Cell;
    }
    
    if (indexPath.section==1) {
        findWorkDetailSecondTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"findWorkDetailSecondTableViewCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"findWorkDetailSecondTableViewCell" owner:nil options:nil]lastObject];
            
        }
        if (self.model) {
        
        cell.content.text=self.model.workRequire;
    
        }
        return cell;
    }
    NSArray*array=@[@"联  系  人",@"联系电话"];
    NSArray*placeArray;
    if (self.model) {
    placeArray=@[self.model.contacts,self.model.phone];
    }
    if (indexPath.section==2) {
            commendTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"commendTableViewCell" owner:nil options:nil] lastObject];
                cell.name.text=array[indexPath.row];
                if (self.model) {
                cell.content.text=placeArray[indexPath.row];
                }
                cell.content.font=[UIFont systemFontOfSize:15];
                cell.content.textColor=[UIColor blackColor];
                cell.content.textAlignment=NSTextAlignmentLeft;
                cell.name.textColor=COLOR(114, 114, 114, 1);
                return cell;
        }
        
    }
    if (indexPath.section==3) {
        
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
        cell.textLabel.textColor=COLOR(114, 114, 114, 1);
        return cell;
    }
    
    return nil;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        if (self.model) {
            return 150+[self accountStringHeightFromString:[NSString stringWithFormat:@"%@%@",[self.model.workSite objectForKey:@"name"],self.model.address] Width:SCREEN_WIDTH-100]-17+30;
        }
        return 150+15;
    }
    if (indexPath.section==1) {
        if (self.model) {
            
            CGFloat height=[self accountStringHeightFromString:self.model.workRequire Width:SCREEN_WIDTH-30];
            return height;
        }
        
    }
    
    if (indexPath.section==2) {
        
        return 30;
        
    }
    
    return 40;

}

-(void)report{

    if (self.reportBlock) {
        self.reportBlock();
    }

}
@end
