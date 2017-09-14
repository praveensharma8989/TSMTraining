//
//  ScoreSecondVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 13/09/17.
//
//

#import "ScoreSecondVC.h"

@interface ScoreSecondVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScoreSecondVC{
    
    NSMutableArray *scores;
    
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

-(void)setupInitialScreen{
    
    [self setTitle:@"Session" isBold:YES];
    [self addGrayBackButton];
    [self addGrayLogOutButton];

    scores = [[NSMutableArray alloc] initWithCapacity:_scoreDataArray.data.count];
    
    for(int i = 0; i<_scoreDataArray.data.count; i++){
        
        [scores addObject:@{@"preScore":@"",@"postScore":@""}];
        
    }
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [MBAppInitializer keyboardManagerEnabled];
    
    
}

-(void) nibRegistration{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ScoreCustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_SCORE_CUSTOM_CELL];
}

- (IBAction)submitClick:(id)sender {
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _scoreDataArray.data.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScoreCustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_SCORE_CUSTOM_CELL forIndexPath:indexPath];
    
    ScoreData *scoreData = _scoreDataArray.data[indexPath.row];
    
    cell.CRMNameLbl.text = scoreData.trainer_name;
    cell.CRMIdLbl.text = scoreData.trainer_crm_id;
    
    [cell.preScoreTxt setBk_shouldChangeCharactersInRangeWithReplacementStringBlock:^BOOL(UITextField *textField, NSRange range, NSString *string) {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *postScore = [[scores objectAtIndex:indexPath.row] valueForKey:@"postScore"];
        
        [scores replaceObjectAtIndex:indexPath.row withObject:@{@"preScore":newString,@"postScore":postScore}];
        
        return YES;
        
    }];
    
    [cell.postCoreTxt setBk_shouldChangeCharactersInRangeWithReplacementStringBlock:^BOOL(UITextField *textField, NSRange range, NSString *string) {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *preScore = [[scores objectAtIndex:indexPath.row] valueForKey:@"preScore"];
        
        [scores replaceObjectAtIndex:indexPath.row withObject:@{@"preScore":preScore,@"postScore":newString}];
        
        return YES;
        
    }];
    
    return cell;
    
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
