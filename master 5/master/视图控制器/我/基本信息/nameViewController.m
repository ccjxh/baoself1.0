//
//  nameViewController.m
//  master
//
//  Created by jin on 15/7/31.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "nameViewController.h"

@interface nameViewController ()<UITextFieldDelegate>

@end

@implementation nameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    if (self.origin) {
    self.name.text=self.origin;
        
        
        
    }
    
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:0 target:self action:@selector(confirm)];
    [self CreateFlow];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    // Dispose of any resources that can be recreated.
}


-(void)confirm{
    
    
     [self.name resignFirstResponder];
    
    if (self.type==1) {
        if (self.contentChange) {
            self.contentChange(self.name.text);
            [self popWithnimation:self.navigationController];
            return;
        }
        
    }
    
    if (self.type==2) {
        
        if ([self isValidateMobile:self.name.text]==NO) {
            [self.view makeToast:@"请输入正确的手机号码" duration:1 position:@"center"];
            return;
        }
        
        if (self.contentChange) {
            self.contentChange(self.name.text);
            [self popWithnimation:self.navigationController];
            return;
        }
    }
    
    
    [self flowShow];
    NSString*urlString=[self interfaceFromString:interface_updateRealName];
    NSDictionary*dict=@{@"realName":self.name.text};
    [[httpManager share]POST:urlString parameters:dict success:^(AFHTTPRequestOperation *Operation, id responseObject) {
        NSDictionary*dict=(NSDictionary*)responseObject;
        [self flowHide];
        if ([[dict objectForKey:@"rspCode"] intValue]==200) {
            [self.view makeToast:[dict objectForKey:@"msg"] duration:1 position:@"center" Finish:^{
                AppDelegate*delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
                PersonalDetailModel*model=[[dataBase share]findPersonInformation:delegate.id];
                model.realName=self.name.text;
                [[dataBase share]addInformationWithModel:model];
                if (self.contentChange) {
                    self.contentChange(self.name.text);
                }
                [self popWithnimation:self.navigationController];
                
            }];
        }else{
        
            [self.view makeToast:[dict objectForKey:@"msg"] duration:1 position:@"center"];
        }
                
    } failure:^(AFHTTPRequestOperation *Operation, NSError *error) {
       
        [self flowHide];
        
    }];

}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
//        for(int i=0; i< [temp length];i++){
//            int a = [temp characterAtIndex:i];
//            if( a > 0x4e00 && a < 0x9fff)
//            {
//                
//            }else{
//            [textField resignFirstResponder];
//            [self.view makeToast:@"请输入汉字" duration:1 position:@"center"];
//            return NO;
//                
//            }
//        
//    }
    
    if (temp.length>16) {
        
        
        return NO;
        
    }
    return YES;
}



-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

@end
