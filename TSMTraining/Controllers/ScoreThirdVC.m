//
//  ScoreThirdVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 13/09/17.
//
//

#import "ScoreThirdVC.h"
#import "ScoreUpdateTV.h"

@interface ScoreThirdVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScoreThirdVC

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
    
    [self setTitle:@"Score List" isBold:YES];
    [self addGrayBackButton];
    [self addGrayLogOutButton];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [MBAppInitializer keyboardManagerEnabled];
    
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _scoreDataArray.data.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScoreStatickTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_SCORE_STATIC_CELL forIndexPath:indexPath];
    
    ScoreData *scoreData = _scoreDataArray.data[indexPath.row];
    
    cell.CRMNameLbl.text = scoreData.trainer_name;
    cell.CRMIdLbl.text = scoreData.trainer_crm_id;
    cell.preScoreLbl.text = scoreData.pre_test_score;
    cell.postScoreLbl.text = scoreData.post_test_score;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScoreUpdateTV *VC = [self.storyboard instantiateViewControllerWithIdentifier:K_UPDATE_SECOND_VC];
    ScoreData *scoreData = _scoreDataArray.data[indexPath.row];
    
    VC.scoreData = scoreData;
    VC.onCompletion = ^(ScoreData *score){
        
            [_scoreDataArray.data replaceObjectAtIndex:[indexPath row] withObject:score];
            
            [self.navigationController popViewControllerAnimated:NO];
            
            [self.tableView reloadData];
        
    };
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (IBAction)submitClick:(id)sender {
    
    ScoreDataArray *scoreDataArrayFromDB = [MBDataBaseHandler getScoreDataArray];
    
    if(scoreDataArrayFromDB){
        ScoreData *dataID = _scoreDataArray.data[0];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.score_session_name != %@)", dataID.score_session_name];
        NSArray *array = [scoreDataArrayFromDB.data filteredArrayUsingPredicate:predicate];
        
        NSArray *data = [ScoreData arrayOfDictionariesFromModels:array];
        
        ScoreDataArray *newData = [[ScoreDataArray alloc] initWithDictionary:@{@"data":data} error:nil];
        
        [newData.data addObjectsFromArray:_scoreDataArray.data];
        
        [MBDataBaseHandler saveScoredataArray:newData];
        
    }else{
        
        [MBDataBaseHandler saveScoredataArray:_scoreDataArray];
        
    }
    [self MB_showSuccessMessageWithText:@"Score Create Successfully!"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
