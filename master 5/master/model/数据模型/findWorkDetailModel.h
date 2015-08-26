//
//  findWorkDetailModel.h
//  master
//
//  Created by jin on 15/8/26.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "model.h"
/**找师傅详情*/
@interface findWorkDetailModel : model
@property(nonatomic)NSInteger id;
@property(nonatomic)NSString*title;
@property(nonatomic)NSInteger peopleNumber;
@property(nonatomic)NSString*pay;
@property(nonatomic)NSDictionary*payType;//支付后面的单位
@property(nonatomic)NSString*address;//详细地址
@property(nonatomic)NSString*workRequire;//职位要求
@property(nonatomic)NSString*contacts;//联系人
@property(nonatomic)NSString*phone;//联系电话
@property(nonatomic)NSString*publishTime;//发布时间
@property(nonatomic)NSDictionary*publisher;//发布人相关信息
@property(nonatomic)NSInteger pageView;//浏览量
@property(nonatomic)NSDictionary*workSite;//工作地点
@end
