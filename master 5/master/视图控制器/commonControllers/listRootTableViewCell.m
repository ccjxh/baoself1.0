//
//  listRootTableViewCell.m
//  master
//
//  Created by jin on 15/5/20.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "listRootTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation listRootTableViewCell





-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)creatUI{

    
    headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 60, 60)];
    [headImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    headImageView.contentMode =  UIViewContentModeScaleAspectFill;
    headImageView.clipsToBounds=YES;
    headImageView.layer.cornerRadius=headImageView.frame.size.width/2;
    headImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:headImageView];
    nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(85, 8, 60, 20)];
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.font=[UIFont systemFontOfSize:17];
    [self.contentView addSubview:nameLabel];
    workType=[[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+10, 8, 60, 20)];
    workType.textColor=[UIColor lightGrayColor];
    workType.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:workType];
    personalImageview=[[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+10+workType.frame.size.width, 10, 15, 15)];
    [self.contentView addSubview:personalImageview];
    phoneButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-45, self.frame.size.height/2, 30, 30)];
    [phoneButton addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:phoneButton];
    skillLabel=[[UILabel alloc]initWithFrame:CGRectMake(85, 30, SCREEN_WIDTH-70-60, 20)];
    skillLabel.textColor=[UIColor lightGrayColor];
    skillLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:skillLabel];
    moneyImage=[[UIImageView alloc]initWithFrame:CGRectMake(85, 55, 13, 13)];
    moneyImage.image=[UIImage imageNamed:@"money"];
    [self.contentView addSubview:moneyImage];
    exterLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 52, 100, 20)];
    exterLabel.font=[UIFont systemFontOfSize:15];
    exterLabel.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:exterLabel];
    experienceLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 52, 100, 20)];
    experienceLabel.font=[UIFont systemFontOfSize:15];
    experienceLabel.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:experienceLabel];
    
}




-(void)reloadData{
    
    nameLabel.text=self.model.realName;
    if (self.model.realName.length!=0) {
        CGFloat width=self.model.realName.length;
        if (width<1) {
            width=2;
        }
        if (width>7) {
            width=7;
        }
        nameLabel.frame=CGRectMake(85, 8, width*17, 20);
        
    }
    
    [self reloadFrame];
    NSString*urlString;
    if (self.model.icon) {
       urlString =[changeURL stringByAppendingString:self.model.icon];
    }
   
    [headImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:headImageName]];
    
       if ([[self.model.certification objectForKey:@"personal"] integerValue]==1) {
           personalImageview.image=[UIImage imageNamed:@"skill.png"];
       }else{
       
           personalImageview.hidden=YES;
       
       }
       if ([[self.model.certification objectForKey:@"company"] integerValue]==1) {
           personalImageview.image=[UIImage imageNamed:@"ic_compay"];
       }

    [phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    NSString*skillStr;
    for (NSInteger i=0; i<[[self.model.service objectForKey:@"servicerSkills"] count]; i++) {
        skillModel*model=[[skillModel alloc]init];
        [model setValuesForKeysWithDictionary:[self.model.service objectForKey:@"servicerSkills"][i]];
        if (i==0) {
            skillStr=model.name;
        }else{
        
            skillStr=[NSString stringWithFormat:@"%@、%@",skillStr,model.name];
        }
    }
    
    
    
    skillLabel.text=skillStr;
    
    if ([self.model.service objectForKey:@"payType"]) {
        if ([[[self.model.service objectForKey:@"payType"] objectForKey:@"name"] isEqualToString:@"面议"]==YES) {
            exterLabel.text=@"面议";
        }else{
        
            exterLabel.text=[NSString stringWithFormat:@"%.2f%@",[[self.model.service objectForKey:@"expectPay"] floatValue],[[self.model.service objectForKey:@"payType"] objectForKey:@"name"]];
    
        }
        
    }else{
    
        exterLabel.text=@"";
    }
    
    
    
    if ([self.model.service objectForKey:@"workExperience"]) {
        experienceLabel.text=[NSString stringWithFormat:@"%ld年",[[self.model.service objectForKey:@"workExperience"] integerValue]]
        ;
        
    }
    
//    [self setupColor];
//    [self setupSkill];
//    if (self.model.icon!=nil) {
//       NSString*urlString=[changeURL stringByAppendingString:self.model.icon];
//        [self.headImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"ic_icon_default"]];
//        
//    }else{
//    
//        self.headImage.image=[UIImage imageNamed:@"ic_icon_default"];
//    }
//        self.nameLabel.text=self.model.realName;
//        NSInteger exAge=[[self.model.service objectForKey:@"workExperience"] integerValue];
//    
//    self.exLabel.text=[NSString stringWithFormat:@"%ld年",(long)exAge];
//    if (self.type==1) {
//        self.exLabel.textColor=[UIColor clearColor];
//    }
//    if ([[self.model.certification objectForKey:@"personal"] integerValue]==1) {
//        self.typeImage.backgroundColor=[UIColor blackColor];
//        self.typeImage.image=[UIImage imageNamed:@"ic_personal"];
//    }
//    if ([[self.model.certification objectForKey:@"company"] integerValue]==1) {
//        self.typeImage.image=[UIImage imageNamed:@"ic_compay"];
//    }
//    if ([[self.model.certification objectForKey:@"skill"] integerValue]==1) {
//        self.skillImage.image=[UIImage imageNamed:@"ic_skill"];
//    }
//    NSInteger starCount=[[self.model.service objectForKey:@"star"] integerValue];
//    NSString*imagename=[NSString stringWithFormat:@"ic_star_%ld",(long)starCount];
//    self.statImage.image=[UIImage imageNamed:imagename];
//    
//    
//    
//    self.orderLabel.text=[NSString stringWithFormat:@"%ld人预定",(long)[[self.model.service objectForKey:@"orderCount"] integerValue]];
//    if (self.type==1) {
//        self.phoneButton.hidden=YES;
//        self.Backimageview.hidden=YES;
//    }
    
}



-(void)phone{
    
    if (self.model.mobile.length!=0) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.model.mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    AppDelegate*delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString*urlString=[self interfaceFromString:interface_phonerecommend];
    NSDictionary*dict=@{@"fromId":[NSString stringWithFormat:@"%lu",delegate.id],@"targetId":[NSString stringWithFormat:@"%u",self.model.id],@"targetMobile":self.model.mobile};
        [[httpManager share]POST:urlString parameters:dict success:^(AFHTTPRequestOperation *Operation, id responseObject) {
            NSDictionary*dict=(NSDictionary*)responseObject;
            NSLog(@"%@",dict);
            
            
            
        } failure:^(AFHTTPRequestOperation *Operation, NSError *error) {
            
        }];
    
}

-(void)reloadFrame{
    
    if (self.type==2||self.type==3) {
      workType.frame=CGRectMake(80+nameLabel.frame.size.width+10, 8, 40, 20);
        if (self.type==2) {
            workType.text=@"师傅";
        }else if (self.type==3){
            
        workType.text=@"工长";
            
        }
        
    }else{
    
        workType.frame=CGRectMake(0, 0, 0, 0);
    
    }
   
    personalImageview.frame=CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+workType.frame.size.width+5, 10, 15, 15);

}

-(void)setupColor
{
//    self.nameLabel.font=[UIFont boldSystemFontOfSize:15];
//    self.typeLabel.font=[UIFont systemFontOfSize:15];
    self.typeLabel.textColor=COLOR(153, 153, 153, 1);
    self.nameLabel.textColor=COLOR(51, 51, 51, 1);
    self.exLabel.textColor=COLOR(153, 153, 153, 1);
    self.orderLabel.textColor=COLOR(51, 51, 51, 1);
    self.phoneButton.backgroundColor=COLOR(245, 245, 245, 1);
    self.headImage.layer.masksToBounds=YES;
    self.headImage.layer.cornerRadius=self.headImage.frame.size.width/2;
}

-(void)setupSkill
{
    NSInteger width=(SCREEN_WIDTH-60-self.phoneButton.frame.size.width-25-20)/4;
    NSArray*Array=[self.model.service objectForKey:@"servicerSkills"];
    for (NSInteger i=0; i<Array.count; i++) {
        if (i<4) {
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(75+i%4*(width+5), 55+i/4*25, width, 20)];
            label.text=[[self.model.service objectForKey:@"servicerSkills"][i] objectForKey:@"name"];
            label.textColor=[UIColor orangeColor];
            label.font=[UIFont systemFontOfSize:12];
            label.layer.borderColor=[[UIColor orangeColor]CGColor];
            label.textAlignment=NSTextAlignmentCenter;
            label.lineBreakMode=NSLineBreakByTruncatingTail;
            label.layer.cornerRadius=10;
            label.layer.borderWidth=1;
            [self addSubview:label];
        }
    }

}



@end
