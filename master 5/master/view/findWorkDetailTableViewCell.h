//
//  findWorkDetailTableViewCell.h
//  master
//
//  Created by jin on 15/8/25.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface findWorkDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *peopleCount;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *pay;
@property (weak, nonatomic) IBOutlet UILabel *count;

@end
