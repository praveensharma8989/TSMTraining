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
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;

@end

@implementation HomeVC{

    CRMData *userData;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialScreen];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"Home" isBold:YES];
}

-(void)setupInitialScreen{
    
    [self setTitle:@"Home" isBold:YES];
    
    [self addGrayLogOutButton];
    CRMDataArray *dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    
    _CRMName.text = userData.crm_name;
    _CRMId.text = [NSString stringWithFormat:@"CRM ID : %@", userData.crm_id];
    _StateOffice.text = [NSString stringWithFormat:@"State Office : %@", userData.state_office];
    _appVersionLabel.text = [NSString stringWithFormat:@"APP VERSION %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
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
