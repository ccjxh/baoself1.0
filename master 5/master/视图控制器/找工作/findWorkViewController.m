//
//  findWorkViewController.m
//  master
//
//  Created by jin on 15/8/21.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "findWorkViewController.h"
#import "worksList.h"
#import "cityViewController.h"
#import "findAddNewWorkViewController.h"
#import "findWorkDetailViewController.h"


@interface findWorkViewController ()

@end

@implementation findWorkViewController
{

    worksList*view;
    NSMutableArray*_dataArray;
    NSMutableArray*_townArray;//地区信息数组
    NSMutableArray*secondArray;//筛选菜单第二个数组
    NSMutableArray*thirdArray;//筛选菜单第三个数组
    NSString*_currentCity;//当前选择城市
    NSString*_currentCityName;
    NSInteger _currentPage;
    NSString*keyWord;
    NSInteger filterCertification;//信誉度
    NSInteger firstLocation;//一级区域id
    NSInteger secordLocation;//二级区域id
    NSInteger payType;//待遇
    NSMutableArray * keyArray;
    NSMutableArray * objectArray;
    NSInteger _totalResults;//总共有多少条数据
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage=1;
    _currentCityName=@"深圳市";
    [self initData];
    [self initUI];
    [self request];
    [self customLeftNavigation];
    [self customRightavigation];
    [self CreateFlow];
    [self requestListInformation];
   
    
    // Do any additional setup after loading the view.
}



-(void)customLeftNavigation{
    
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, self.navigationController.navigationBar.frame.size.height)];
    button.tag=10;
    [button addTarget:self action:@selector(changecity) forControlEvents:UIControlEventTouchUpInside];
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 14, 14, 18)];
    imageview.image=ImageNamed(@"2.png");
    imageview.tag=11;
    [button addSubview:imageview];
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(17, 9, 60, 30)];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:16];
    label.text=_currentCityName;
    [button addSubview:label];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
}



-(void)changecity
{
    AppDelegate*delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    cityViewController*cvc=[[cityViewController alloc]init];
    if (delegate.city) {
        
        cvc.city=delegate.city;
        
    }
    cvc.TBlock=^(AreaModel*CityModel){
        _currentCityName=CityModel.name;
        [self customLeftNavigation];
    };
    [self pushWinthAnimation:self.navigationController Viewcontroller:cvc];
    
}


-(void)customRightavigation{

    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 71, 28)];
    [button setTitle:@"发布招工" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:16];
    button.layer.borderColor=COLOR(99, 206, 243, 1).CGColor;
    button.layer.borderWidth=1;
    button.layer.cornerRadius=5;
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}


//发布工作
-(void)add{
    
    findAddNewWorkViewController*fvc=[[findAddNewWorkViewController alloc]init];
    fvc.hidesBottomBarWhenPushed=YES;
    [self pushWinthAnimation:self.navigationController Viewcontroller:fvc];
    
}


-(void)initUI{
    
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    view=[[[NSBundle mainBundle]loadNibNamed:@"worksList" owner:nil options:nil]lastObject];
    __weak typeof(self)WeSelf=self;
    __weak typeof(NSMutableArray*)tempArray=_dataArray;
    view.tableDidSelected=^(UITableView*tableview,NSIndexPath*indexPath){
       
        findWorkListModel*model=tempArray[indexPath.section];
        findWorkDetailViewController*fvc=[[findWorkDetailViewController alloc]init];
        fvc.id=model.id;
        fvc.hidesBottomBarWhenPushed=YES;
        [WeSelf pushWinthAnimation:WeSelf.navigationController Viewcontroller:fvc];
    
    };
    NSMutableArray*temp=[self request];
    view.firstArray=temp;
    view.secondArray=secondArray;
    view.thirdArray=thirdArray;
    self.view=view;
    
}



-(void)initData{

    if (!secondArray) {
        secondArray=[[NSMutableArray alloc]initWithObjects:@"待遇",@"sssss",@"dsad",nil];
    }

    if (!thirdArray) {
        thirdArray=[[NSMutableArray alloc]initWithObjects:@"信誉", nil];
    }
    
    if (!keyArray) {
        keyArray=[[NSMutableArray alloc]init];
    }
    
    [keyArray addObject:@"pageNo"];
    [keyArray addObject:@"pageSize"];
    [keyArray addObject:@"firstLocation"];
    
    if (!objectArray) {
        objectArray=[[NSMutableArray alloc]init];
    }
    [objectArray addObject:[NSString stringWithFormat:@"%lu",_currentPage]];
    [objectArray addObject:@"10"];
    AreaModel*model= [[dataBase share]findWithCity:_currentCityName];
    [objectArray addObject:[NSString stringWithFormat:@"%lu",model.id]];
    
}


//城市数据请求
-(NSMutableArray*)request
{
    
    [self flowShow];
    if (!_townArray) {
        _townArray=[[NSMutableArray alloc]init];
    }
    [_townArray removeAllObjects];
    AreaModel*initModel=[[AreaModel alloc]init];
    initModel.id=400000;
    initModel.name=@"全市区";
    [_townArray addObject:initModel];
    AreaModel*model=[[dataBase share]findWithCity:_currentCityName];
    NSMutableArray*array=[[dataBase share]findWithPid:model.id];
    if (array.count==0) {
        NSString*urlString=[self interfaceFromString:interface_resigionList];
        NSDictionary*dict=@{@"cityId":[NSString stringWithFormat:@"%ld",(long)model.id]};
        [[httpManager share]POST:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary*dict=(id)responseObject;
            NSArray*Arrar=[dict objectForKey:@"entities"];
            [[dataBase share]addCityToDataBase:Arrar Pid:model.id];
            NSArray*newArray=[[dataBase share]findWithPid:model.id];
            for (NSInteger i=0; i<newArray.count; i++) {
                AreaModel*tempModel=[[AreaModel alloc]init];
                tempModel=newArray[i];
                [_townArray addObject:tempModel];
            }
            view.firstArray=_townArray;
            
            [view.menue.leftTableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
        }];
    }
    else
    {
        NSArray*newArray=[[dataBase share]findWithPid:model.id];
        for (NSInteger i=0; i<newArray.count; i++) {
            AreaModel*tempModel=[[AreaModel alloc]init];
            tempModel=newArray[i];
            [_townArray addObject:tempModel];
        }
        
        view.firstArray=_townArray;
        [view.menue.leftTableView reloadData];
    }
    return _townArray;
}


//列表网络数据请求
-(void)requestListInformation{

    [self flowShow];
    __block NSMutableArray*temp=[[NSMutableArray alloc]init];
    NSString*urlString=[self interfaceFromString:interface_findWorkList];
    NSMutableDictionary*dict=[[NSMutableDictionary alloc]init];
    [self flowHide];

    for (NSInteger i=0; i<keyArray.count; i++) {
        NSString*Str=keyArray[i];
        [dict setObject:objectArray[i] forKey:Str];
    }
    
    [[httpManager share]POST:urlString parameters:dict success:^(AFHTTPRequestOperation *Operation, id responseObject) {
        NSDictionary*dict=(NSDictionary*)responseObject;
        if ([[dict objectForKey:@"rspCode"] integerValue]==200) {
            _totalResults=[[dict objectForKey:@"totalResults"] integerValue];
            NSArray*array=[dict objectForKey:@"entities"] ;
            for (NSInteger i=0; i<array.count; i++) {
                findWorkListModel*model=[[findWorkListModel alloc]init];
                NSDictionary*inforDict=array[i];
                [model setValuesForKeysWithDictionary:[inforDict objectForKey:@"project"]];
                [_dataArray addObject:model];
            }
            view.dataArray=_dataArray;
            [view.tableview reloadData];
            
            
        }else{
        
            [self.view makeToast:[dict objectForKey:@"msg"] duration:1 position:@"center"];
        }
       
    } failure:^(AFHTTPRequestOperation *Operation, NSError *error) {
        
        [self flowHide];
        [self.view makeToast:@"网络异常" duration:1 position:@"center"];
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
