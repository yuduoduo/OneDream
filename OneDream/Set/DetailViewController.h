//
//  DetailViewController.h
//  BCHFrameworkTest
//
//  Created by 赵亮 on 15/10/10.
//  Copyright © 2015年 赵亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface DetailViewController : BaseViewController
//@property (strong, nonatomic) NSString *name;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;

-(void)setMyValue:(id)id;
@end
