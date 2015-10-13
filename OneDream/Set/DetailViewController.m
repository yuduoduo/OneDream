//
//  DetailViewController.m
//  BCHFrameworkTest
//
//  Created by 赵亮 on 15/10/10.
//  Copyright © 2015年 赵亮. All rights reserved.
//

#import "DetailViewController.h"
#import <objc/runtime.h>
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",self.nameLabel);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   //
    //NSLog(NSStringFromClass([self class]));
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setMyValue:self];
    unsigned int outCount = 0;
    Ivar *members = class_copyIvarList([self class], &outCount);
    for (int i = 0 ; i < outCount; i++) {
Ivar var = members[i];
        //[self copyProperties:var];
        const char *memberName = ivar_getName(var);
        id t = [self valueForKeyPath:@(memberName)];
        ((UILabel*)t).text=@"das";
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"%s----%s", memberName, memberType);
    }
    Ivar m_name = members[0];
    
  // NSLog(@"after runtime:%@", [father description]);
    for (UIView *v in [self.view subviews]) {
        if ([v class] == [UILabel class]){
            UILabel *lable = (UILabel*)v;
            
           // [lable setText:@"qqq"];
            
           NSString *str =  @(object_getClassName(lable));
            NSLog(str);
        }
        
        
       
    }
    object_setIvar(self , m_name, @"zhanfen");
}
//-(void)setMyValue:(id)id
//{
//    
//}
-(void)get
{
    
}
-(void)post
{
    
}
@end

