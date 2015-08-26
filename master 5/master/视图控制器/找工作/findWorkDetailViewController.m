//
//  findWorkDetailViewController.m
//  master
//
//  Created by jin on 15/8/26.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "findWorkDetailViewController.h"
#import "findWorkDetail.h"
@interface findWorkDetailViewController ()

@end

@implementation findWorkDetailViewController
{
    findWorkDetailModel*detailModel;
    findWorkDetail*view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self CreateFlow];
    [self requestInformation];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


-(void)initUI{

    view=[[findWorkDetail alloc]init];
    self.title=@"招工详情";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view=view;

}


-(void)requestInformation{
    
    [self flowShow];
    NSString*urlstring=[self interfaceFromString:interface_findWorkDetail];
    NSDictionary*dict=@{@"id":[NSString stringWithFormat:@"%lu",self.id]};
    [[httpManager share]POST:urlstring parameters:dict success:^(AFHTTPRequestOperation *Operation, id responseObject) {
        NSDictionary*dict=(NSDictionary*)responseObject;
        [self flowHide];
        
        if ([[dict objectForKey:@"rspCode"] integerValue]==200) {
            
            NSDictionary*inforDict=[[dict objectForKey:@"entity"] objectForKey:@"project"];
            detailModel=[[findWorkDetailModel alloc]init];
            [detailModel setValuesForKeysWithDictionary:inforDict];
            view.model=detailModel;
            [view.tableview reloadData];
        }else{
        
            NSString*temp=[[dict objectForKey:@"msg"]componentsSeparatedByString:@"."][0];
            [self.view makeToast:[NSString stringWithFormat:@"出现异常%@",temp] duration:1 position:@"center"];
        }
        
    } failure:^(AFHTTPRequestOperation *Operation, NSError *error) {
        
        [self flowHide];
        [self.view makeToast:@"网络异常" duration:1 position:@"center"];
        
    }];


}

@end
