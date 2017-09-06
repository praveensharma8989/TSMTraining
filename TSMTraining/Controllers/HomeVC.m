//
//  HomeVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "HomeVC.h"

@interface HomeVC ()

@property (weak, nonatomic) IBOutlet UILabel *CRMId;
@property (weak, nonatomic) IBOutlet UILabel *CRMName;
@property (weak, nonatomic) IBOutlet UILabel *StateOffice;

@end

@implementation HomeVC{

    CRMData *userData;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupInitialScreen{
    
    CRMDataArray *dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    
    _CRMId.text = userData.crm_id;
    _CRMName.text = userData.crm_name;
    _StateOffice.text = userData.state_office;
    
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
