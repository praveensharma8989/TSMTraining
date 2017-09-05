//
//  TSMLandingTabBar.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "TSMLandingTabBar.h"

@interface TSMLandingTabBar ()

@end

@implementation TSMLandingTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.delegate = self;
    [self initialSetUp];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialSetUp{
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor grayColor];
    shadow.shadowOffset = CGSizeMake(0.0, 0.5);
    
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont fontWithName:@"Geogrotesque-Medium" size:9.0f], NSFontAttributeName,
                               [UIColor darkGrayColor], NSForegroundColorAttributeName,
                               shadow,NSShadowAttributeName,nil];
    [[UITabBarItem appearance] setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
    self.tabBar.tintColor = [UIColor whiteColor];
    self.selectedIndex = 0;
    self.tabBar.autoresizesSubviews = YES;
    self.tabBar.clipsToBounds = YES;
    self.tabBar.translucent=NO;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    long int barItem = [[tabBar items] indexOfObject:item];
    _firstItemview =self.tabBar.subviews[barItem + 1];
    [self BounceAnimation];
}

#pragma mark - Bounce animation
-(void)BounceAnimation{
    CATransform3D twentyOercent = CATransform3DMakeScale(0.80f, 0.80f, 1.00f);
    
    [UIView animateWithDuration:0.2f animations:^{
        _firstItemview.subviews[1].layer.transform=twentyOercent;
    } completion:^(BOOL finished) {
        
        
        CATransform3D percent= CATransform3DMakeScale(1.05f, 1.05f, 1.00f);
        CATransform3D percent1 = CATransform3DMakeScale(0.95f, 0.9f, 1.00f);
        
        [UIView animateWithDuration:0.3f animations:^{
            _firstItemview.subviews[0].layer.transform = percent;
            _firstItemview.subviews[1].layer.transform = percent;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2f animations:^{
                _firstItemview.subviews[0].layer.transform=percent1;
                _firstItemview.subviews[1].layer.transform=percent1;
            } completion:^(BOOL finished) {
            }];
        }];
    }];
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
