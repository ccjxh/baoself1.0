//
//  NSObject+tool.h
//  master
//
//  Created by jin on 15/8/6.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (tool)<UITextFieldDelegate>

//技能显示cell
-(UITableViewCell*)getSkillCellWithTableview:(UITableView*)tableView  SkillArray:(NSMutableArray*)skillArray;

//计算技能高度
-(CGFloat)accountSkillWithAllSkill:(NSMutableArray*)skillArray;

//计算图片高度
-(CGFloat)accountPictureFromArray:(NSMutableArray*)pictureArray;

//图片展示   
-(void)displayPhotosWithIndex:(NSInteger)index Tilte:(NSString*)title describe:(NSString*)describe ShowViewcontroller:(UIViewController*)vc UrlSarray:(NSMutableArray*)UrlArray ImageView:(UIImageView*)imageview;



@end
