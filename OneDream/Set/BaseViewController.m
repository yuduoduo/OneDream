//
//  BaseViewController.m
//  BCHFrameworkTest
//
//  Created by 赵亮 on 15/10/10.
//  Copyright © 2015年 赵亮. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>
#import "NSObject+Property.h"
#import "DetailViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    //类名
    NSLog(NSStringFromClass([self class]));
    
    //请求
    
    //返回Model 
    //赋值
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"setTheControllerValues"  object:nil];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(setMyValue:)) {
        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self, id viewController) {
            
//            unsigned int outCount = 0;
//            objc_property_t *properties = class_copyPropertyList(self, &outCount);
            
            NSArray *propertyArray = [[self class] properties];
            
           // ((DetailViewController*)self).nameLabel.text=@"fsdf";
            //((DetailViewController*)viewController).nameLabel.text = @"aa";
            //[self setValue:@"ttt" forKey:@"nameLabel.text"];
            
        }), "v@*");
    }
    return YES;
}
@end
