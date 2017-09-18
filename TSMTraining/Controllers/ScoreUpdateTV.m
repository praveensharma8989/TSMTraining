//
//  ScoreUpdateTV.m
//  TSMTraining
//
//  Created by Praveen Sharma on 18/09/17.
//
//

#import "ScoreUpdateTV.h"

@interface ScoreUpdateTV ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *DSEIDLbl;

@property (weak, nonatomic) IBOutlet UILabel *DSENameLbl;
@property (weak, nonatomic) IBOutlet UITextField *PreTestTxt;
@property (weak, nonatomic) IBOutlet UITextField *PostTestTxt;
@end

@implementation ScoreUpdateTV

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInitialScreen];
    // Do any additional setup after loading the view.
}

-(void)setupInitialScreen{
    
    [self setTitle:@"DSE Information" isBold:YES];
    [self addGrayBackButton];
    [self addGrayLogOutButton];
    
    
    [MBAppInitializer keyboardManagerEnabled];
    
    _PreTestTxt.delegate = self;
    _PostTestTxt.delegate = self;
    _DSEIDLbl.text = _scoreData.trainer_crm_id;
    _DSENameLbl.text = _scoreData.trainer_name;
    _PreTestTxt.text = _scoreData.pre_test_score;
    _PostTestTxt.text = _scoreData.post_test_score;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if(newString.length > 3 || [newString integerValue] > 100){
        return NO;
    }
    return YES;
    
}

- (IBAction)submitBtn:(id)sender {
    
    _scoreData.pre_test_score = _PreTestTxt.text;
    _scoreData.post_test_score = _PostTestTxt.text;
    
    if(_onCompletion){
        _onCompletion(_scoreData);
    }
    
    
    
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
