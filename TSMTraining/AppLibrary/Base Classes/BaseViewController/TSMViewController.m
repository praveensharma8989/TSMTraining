//
//  TSMViewController.m
//  TSMTraining
//
//  Created by Praveen Sharma on 31/08/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import "TSMViewController.h"

@interface TSMViewController ()

@end

@implementation TSMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTitle:(NSString *)title isBold:(BOOL)isBold{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [label setFont:[UIFont TSM_AppFontWithType:(isBold) ? Bold :Regular WithSize:18]];
    [label setText:title];
    [label setShadowColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    if (self.tabBarController) {
        [self.tabBarController.navigationItem setTitleView:label];
    }else{
        [self.navigationItem setTitleView:label];
    }
    
    [self.navigationController.navigationBar setTranslucent:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
