//
//  AppDelegate.h
//  master
//
//  Created by jin on 15/5/5.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import "TencentOpenAPI/QQApiInterface.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic)NSInteger userPost;//职位类型
@property(nonatomic)NSInteger id;//用户id
@property(nonatomic)UIImageView*adimage;
@property(nonatomic)UINavigationController*nc;
@property(nonatomic)NSMutableArray*pictureArray;//广告栏数组
@property(nonatomic)NSString*city;//定位大地区
@property(nonatomic)NSString*detailAdress;//定位小地区
@property(nonatomic)BOOL pullTokenFinish;//是否接收到信鸽数据
@property(nonatomic)BOOL isLogin;//是否登录
@property(nonatomic)NSString*pullToken;//从信鸽服务器获得的token
@property(nonatomic)BOOL isSend;//是否已经发送了请求
@property(nonatomic)CLLocationManager*mapManager;
@property(nonatomic)CLGeocoder*geocoder;


@property(nonatomic,copy)void(^cityChangeBlock)(NSString*cityName);
@property(nonatomic)BOOL sendMessage;
-(void)requestInformation;
-(void)setupHome;
-(void)setHomeView;
-(void)setupLoginView;
-(void) setLogout;
-(void)requestAdImage;
-(void)setupPushWithDictory;
-(NSString*)getPhoneType;
-(void)setupRootView;
-(void)sendData:(NSString*)pull;
-(void)setupMap;
@end

