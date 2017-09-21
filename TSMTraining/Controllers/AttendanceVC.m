//
//  AttendanceVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "AttendanceVC.h"

@interface AttendanceVC ()<UITabBarDelegate,UITableViewDataSource, IQActionSheetPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *updateAttendanceBtn;

@end

@implementation AttendanceVC{
    
    CRMDataArray *dataArray;
    CRMData *userData;
    SessionData *sessionData;
    AttendanceData *attendanceData;
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


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

-(void)setupInitialScreen{
    
    [self setTitle:@"Attendance" isBold:YES];
    
    [self addGrayBackButton];
    [self addGrayLogOutButton];
    [self nibRegistration];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [MBAppInitializer keyboardManagerEnabled];
    
    dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    sessionData = [MBDataBaseHandler getSessionData];
    attendanceData = [MBDataBaseHandler getAttendanceData];
    
    CRMNameArray = [NSMutableArray new];
    CRMIDArray = [NSMutableArray new];
    filterDataArray = [NSMutableArray new];
    
    if(sessionData){
        [self.updateAttendanceBtn setHidden:NO];
    }else{
        [self.updateAttendanceBtn setHidden:YES];
    }
    
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
        NSArray *idsToLookFor = [sessionData.trainees_crm_ids componentsSeparatedByString:@","];
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
            for(int i = 0; i<CRMNameArray.count;i++){
                [CRMIDArray addObject:@""];
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
- (IBAction)updateAttendance:(id)sender {
    
    if(!attendanceData){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length > 0"];
        NSArray *anotherArray = [CRMIDArray filteredArrayUsingPredicate:predicate];
        
        if([dealerNameSelect isEqualToString:@""] || !dealerNameSelect){
            [self MB_showErrorMessageWithText:@"Please Select Dealer Name!"];
        }else if([sessionSelect isEqualToString:@""] || !sessionSelect){
            [self MB_showErrorMessageWithText:@"Please Select session!"];
        }else if(anotherArray.count==0 || !anotherArray){
            [self MB_showErrorMessageWithText:@"Please Select CRM Names"];
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attendance" message:@"The attendance for this session cannot be updated later. Are you sure you want to proceed?" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Okey" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self submitAttendance];
                
            }];
            
            UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:yes];
            [alert addAction:no];
            
            [self presentViewController:alert animated:yes completion:nil];
            
        }

    }else{
        [self MB_showErrorMessageWithText:@"Attendace already updated!"];
    }
}

-(void)submitAttendance{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length > 0"];
    NSArray *anotherArray = [CRMIDArray filteredArrayUsingPredicate:predicate];
    
    AttendanceData *setAttendanceData = [AttendanceData new];
    setAttendanceData.trainer_id = GET_USER_DEFAULTS(CRMID);
    setAttendanceData.trainer_name = userData.crm_name;
    setAttendanceData.session_name = sessionData.session_name;
    setAttendanceData.dealer_code = sessionData.dealer_code;
    setAttendanceData.dealer_name = sessionData.dealer_name;
    
    NSDateFormatter *formatter = [NSDateFormatter MB_defaultFormatter:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate date];
    
    NSString *stringDate = [formatter stringFromDate:date];
    
    setAttendanceData.last_att_update = stringDate;
    setAttendanceData.attendance_date = stringDate;
    
    setAttendanceData.present_crm_ids = [anotherArray componentsJoinedByString:@","];
    setAttendanceData.att_status = @"active";
    
    [MBDataBaseHandler saveAttendancedata:setAttendanceData];
    
    dealerNameSelect = nil;
    sessionSelect = nil;
    dropDownSelectValue = [NSMutableArray arrayWithArray:picketHeading];
    CRMNameArray = [NSMutableArray new];
    CRMIDArray = [NSMutableArray new];
    
    attendanceData = setAttendanceData;
    
    AttendanceDataArray *attendanceDataArray = [MBDataBaseHandler getAttendanceDataArray
                                                ];
    
    NSDictionary *new = [attendanceData toDictionary];
    NSMutableArray *jsonToArray = [NSMutableArray arrayWithObject:new];
    
    if(attendanceDataArray){
        
        [attendanceDataArray.data addObject:attendanceData];
        
        [MBDataBaseHandler saveAttendancedataArray:attendanceDataArray];
        
    }else{
        
        attendanceDataArray = [[AttendanceDataArray alloc] initWithDictionary:@{@"data":jsonToArray} error:nil];
        
        [MBDataBaseHandler saveAttendancedataArray:attendanceDataArray];
        
    }
    
    [self MB_showSuccessMessageWithText:@"Attendance Create Successfully!"];
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
