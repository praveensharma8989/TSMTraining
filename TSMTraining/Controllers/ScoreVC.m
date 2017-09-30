//
//  ScoreVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "ScoreVC.h"
#import "ScoreSecondVC.h"

@interface ScoreVC ()<UITableViewDelegate, UITableViewDataSource, IQActionSheetPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *updateScoreBtn;

@end

@implementation ScoreVC{

    CRMDataArray *dataArray;
    CRMData *userData;
    SessionData *sessionData;
    AttendanceData *attendanceData;
    ScoreData *scoreData;
    NSString *dealerNameSelect, *sessionSelect;
    NSMutableArray *CRMNameArray, *CRMIDArray, *filterDataArray, *dropDownSelectValue;
    NSArray *dealerNameArray, *picketHeading;
    BOOL showSession;
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
    
    [self setTitle:@"Score" isBold:YES];
    
    [self addGrayBackButton];
    [self addGrayLogOutButton];
    [self nibRegistration];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [MBAppInitializer keyboardManagerEnabled];
    
    dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    sessionData = [MBDataBaseHandler getSessionData];
    attendanceData = [MBDataBaseHandler getAttendanceData];
    scoreData = [MBDataBaseHandler getScoreData];
    
    CRMNameArray = [NSMutableArray new];
    CRMIDArray = [NSMutableArray new];
    filterDataArray = [NSMutableArray new];
    
    showSession = NO;
    
    dealerNameArray = [self getValueFromDataArray:dataArray withKey:@"dealer_name" withValue:@""];
    
    dropDownSelectValue = [[NSMutableArray alloc] initWithObjects:@"Select Dealer Name", @"Select Session ID", nil];
    picketHeading = [[NSArray alloc] initWithArray:dropDownSelectValue];

    
}

-(void) nibRegistration{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([selectTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_SELECT_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserSelectTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_USER_SELECT];
}

-(NSArray *)getValueFromDataArray :(CRMDataArray *)data withKey:(NSString *)key withValue:(NSString *)value{
    
    NSPredicate *predicate;
    
    if([key isEqualToString:@"crm_name"]){
        NSArray *idsToLookFor = [attendanceData.present_crm_ids componentsSeparatedByString:@","];
        predicate = [NSPredicate predicateWithFormat:@"crm_id IN %@", idsToLookFor];
    }else if([key isEqualToString:@"crm_id"]){
        predicate = [NSPredicate predicateWithFormat:@"(SELF.crm_name == %@)", value];
    }else{
        predicate = [NSPredicate predicateWithFormat:@"(SELF.dealer_name != %@)", @""];
    }
    
    
    NSArray *array =[data.data filteredArrayUsingPredicate:predicate];
    
    NSString *valueForKey = [NSString stringWithFormat:@"@distinctUnionOfObjects.%@",key];
    
    NSArray *uniqueGenres = [array valueForKeyPath:valueForKey];
    
    NSArray *arraysort = [uniqueGenres sortedArrayUsingSelector:@selector(compare:)];

    return arraysort;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(CRMNameArray.count > 0){
        return 2;
    }else{
        return 1;
    }
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 2;
    }else{
        return CRMNameArray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            selectTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_SELECT_CELL forIndexPath:indexPath];
            cell.selectValue.text = dropDownSelectValue[indexPath.row];
            return cell;
            
        }
            break;
            
        case 1:{
            
            UserSelectTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_USER_SELECT forIndexPath:indexPath];
            
            if(CRMNameArray.count >0){
                cell.nameLbl.text = CRMNameArray[indexPath.row];
                if([CRMIDArray[indexPath.row] isEqualToString:@""]){
                    [cell.selectTick setImage:[UIImage imageNamed:@"blankTick"]];
                }else{
                    [cell.selectTick setImage:[UIImage imageNamed:@"selectTick"]];
                }
            }
            return cell;
            
        }
            break;
            
        default:
            break;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            [self selectValueFromPicker:indexPath.row];
            
            break;
            
        case 1:
            [self selectCrmNameWithID:indexPath];
            break;
            
        default:
            break;
    }
    
}

-(void)selectValueFromPicker :(NSInteger)row{
    
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:picketHeading[row] delegate:self];
    picker.actionToolbar.titleButton.titleFont = [UIFont systemFontOfSize:12];
    picker.actionToolbar.titleButton.titleColor = [UIColor blackColor];
    
    if(row == 0){
        [picker setTitlesForComponents:@[dealerNameArray]];
    }else if(row == 1){
        if(sessionData && showSession){
            [picker setTitlesForComponents:@[@[sessionData.session_name]]];
        }
    }
    
    
    [picker setTag:row];
    
    if(row == 1 && !showSession){
        
    }else{
        [picker show];
    }
    
    
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray<NSString *> *)titles{
    
    [dropDownSelectValue replaceObjectAtIndex:pickerView.tag withObject:titles[0]];
    
    switch (pickerView.tag) {
        case 0:{
            dealerNameSelect = titles[0];
            if([dealerNameSelect isEqualToString:sessionData.dealer_name]){
                showSession = YES;
            }else{
                [dropDownSelectValue replaceObjectAtIndex:1 withObject:@"Select Session ID"];
                showSession = NO;
                sessionSelect = nil;
                CRMNameArray = [NSMutableArray new];
            }
        }
            
            break;
        case 1:{
            sessionSelect = titles[0];
            CRMNameArray = [[self getValueFromDataArray:dataArray withKey:@"crm_name" withValue:@""] copy];
            
            if(CRMNameArray.count >0){
                for(int i = 0; i<CRMNameArray.count;i++){
                    [CRMIDArray addObject:@""];
                }
            }else{
                [self MB_showErrorMessageWithText:@"Please create attendance for this session"];
            }
    
        }
            
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
    
}

-(void)selectCrmNameWithID:(NSIndexPath *)crmNamePosition{
    
    if(![CRMIDArray[crmNamePosition.row] isEqualToString:@""]){
        
        [CRMIDArray replaceObjectAtIndex:crmNamePosition.row withObject:@""];
        
    }else{
        NSArray *crmids = [self getValueFromDataArray:dataArray withKey:@"crm_id" withValue:CRMNameArray[crmNamePosition.row]];
        
        NSString *crmid = crmids[0];
        
        [CRMIDArray replaceObjectAtIndex:crmNamePosition.row withObject:crmid];
    }
    
    
    
    
    [self.tableView reloadRowsAtIndexPaths:@[crmNamePosition] withRowAnimation:NO];
    
}
- (IBAction)updateScore:(id)sender {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length > 0"];
    NSArray *anotherArray = [CRMIDArray filteredArrayUsingPredicate:predicate];
    
    if([dealerNameSelect isEqualToString:@""] || !dealerNameSelect){
        [self MB_showErrorMessageWithText:@"Please Select Dealer Name!"];
    }else if([sessionSelect isEqualToString:@""] || !sessionSelect){
        [self MB_showErrorMessageWithText:@"Please Select session ID!"];
    }else if(CRMNameArray.count == 0 || !CRMNameArray){
        [self MB_showErrorMessageWithText:@"Please create attendance for this session"];
    }else if(anotherArray.count==0 || !anotherArray){
        [self MB_showErrorMessageWithText:@"Please Select CRM Names"];
    }else{
        
        ScoreDataArray *setScoreDataArray = [ScoreDataArray new];
        for (NSString *ids in  anotherArray) {
            
            NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(SELF.crm_id == %@)", ids];
            NSArray *anotherNameArray =[dataArray.data filteredArrayUsingPredicate:predicate1];
            
            CRMData *dataAr = anotherNameArray[0];
            
            ScoreData *setScoreData = [ScoreData new];
            setScoreData.crm_id = ids;
            setScoreData.crm_name = dataAr.crm_name;
            
            setScoreData.trainer_crm_id = GET_USER_DEFAULTS(CRMID);
            setScoreData.trainer_name = userData.crm_name;
            
            NSDateFormatter *formatter = [NSDateFormatter MB_defaultFormatter:@"yyyy-MM-dd HH:mm:ss"];
            NSDateFormatter *formatter1 = [NSDateFormatter MB_defaultFormatter:@"yyyy-MM-dd"];
            NSDate *date = [NSDate date];
            NSString *stringDate = [formatter stringFromDate:date];
            NSString *stringDate1 = [formatter1 stringFromDate:date];
            setScoreData.last_scroe_update = stringDate;
            setScoreData.date_of_test = stringDate1;
            setScoreData.training_LOB = sessionData.LOB_training;
            setScoreData.training_type = sessionData.training_type;
            setScoreData.training_product_line = sessionData.product_line;
            setScoreData.score_status = @"Active";
            setScoreData.score_session_name = attendanceData.session_name;
            
            [setScoreDataArray.data addObject:setScoreData];
        }
        
        ScoreSecondVC *vwNav = [self.storyboard instantiateViewControllerWithIdentifier:K_SCORE_SECOND_VC];
        
        vwNav.scoreDataArray = setScoreDataArray;
        
        [self.navigationController pushViewController:vwNav animated:YES];
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
