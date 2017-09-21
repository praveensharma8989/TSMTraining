//
//  sessionSecondVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 12/09/17.
//
//

#import "sessionSecondVC.h"

@interface sessionSecondVC ()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate, IQActionSheetPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *createSessionBtn;
@property (weak, nonatomic) IBOutlet UILabel *trainingLOBLbl;
@property (weak, nonatomic) IBOutlet UILabel *productLineLbl;

@end

@implementation sessionSecondVC{
    
    CRMData *userData;
    CRMDataArray *dataArray;
    SessionData *sessionData;
    AttendanceData *attendanceData;
    NSInteger selectedIndexofRow;
    NSArray *picketHeading, *trainingLOBArray, *arrayCRMName, *arrayCVPax, *arrayILCV, *arrayMHCV, *arraySCVCargo;
    NSMutableArray *dropDownSelectValue, *productLineArray;
    NSString *trainingLOB,*productLine;
    
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
    [self addGrayLogOutButton];
    [self addGrayBackButton];
//    [self nibRegistration];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    sessionData = [MBDataBaseHandler getSessionData];
    attendanceData = [MBDataBaseHandler getAttendanceData];
    
    trainingLOBArray = [self getValueFromDataArray:dataArray withKey:@"crm_LOB" withValue:@""];
    productLineArray = [NSMutableArray new];
    
    arrayCRMName = [self getValueFromDataArray:dataArray withKey:@"crm_name" withValue:@""];
    
    dropDownSelectValue = [[NSMutableArray alloc] initWithObjects: @"Select Training LOB", @"Select Product Line", nil];
    picketHeading = [[NSArray alloc] initWithArray:dropDownSelectValue];
    
    arrayCVPax = @[@"Buses", @"SCV Passenger"];
    arrayILCV = @[@"ILCV", @"ICV", @"LCV"];
    arrayMHCV = @[@"MHCV Construck", @"MHCV Cargo"];
    arraySCVCargo = @[@"SCV Cargo", @"Pick ups"];
    
    [MBAppInitializer keyboardManagerEnabled];
    
    self.trainingLOBLbl.tag = 0;
    self.productLineLbl.tag = 1;
    
    [self.trainingLOBLbl setUserInteractionEnabled:YES];
    [self.productLineLbl setUserInteractionEnabled:YES];
    
    self.trainingLOBLbl.text = dropDownSelectValue[0];
    self.productLineLbl.text = dropDownSelectValue[1];
    
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)];
    tapAction.delegate =self;
    tapAction.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *tapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)];
    tapAction1.delegate =self;
    tapAction1.numberOfTapsRequired = 1;
    
    [self.trainingLOBLbl addGestureRecognizer:tapAction];
    [self.productLineLbl addGestureRecognizer:tapAction1];
}

-(NSArray *)getValueFromDataArray :(CRMDataArray *)data withKey:(NSString *)key withValue:(NSString *)value{
    
    NSPredicate *predicate;
    
    if([key isEqualToString:@"crm_LOB"]){
        
        predicate = [NSPredicate predicateWithFormat:@"(SELF.crm_LOB != %@)", @""];
        
    }else if([key isEqualToString:@"crm_product_line"]){
        
        predicate = [NSPredicate predicateWithFormat:@"(SELF.crm_LOB == %@)AND(SELF.crm_product_line != %@)", value,@""];
        
    }else if([key isEqualToString:@"crm_name"]){
        NSArray *idsToLookFor = [_sessionDataCreate.trainees_crm_ids componentsSeparatedByString:@","];
        predicate = [NSPredicate predicateWithFormat:@"crm_id IN %@", idsToLookFor];
    }else{
        predicate = [NSPredicate predicateWithFormat:@"(SELF.dealer_name != %@)", @""];
    }
    
    
    NSArray *array =[data.data filteredArrayUsingPredicate:predicate];
    
    NSString *valueForKey = [NSString stringWithFormat:@"@distinctUnionOfObjects.%@",key];
    
    NSArray *uniqueGenres = [array valueForKeyPath:valueForKey];
    
    NSArray *arraysort = [uniqueGenres sortedArrayUsingSelector:@selector(compare:)];
    
    return arraysort;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrayCRMName.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SessionCloseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_Seeion_Name_cell forIndexPath:indexPath];
    
    cell.sessionName.text = arrayCRMName[indexPath.row];
    return cell;
    
}

-(IBAction)lblClick :(UITapGestureRecognizer *)tapsender{
    
    UILabel *currentLabel = (UILabel *)tapsender.view;
    NSLog(@"tap %ld",(long)currentLabel.tag);
    
    [self selectValueFromPicker:currentLabel.tag];
    
}

-(void)selectValueFromPicker :(NSInteger)row{
    
    if(!row){
        row = 0;
    }
    
    selectedIndexofRow = row;
    
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:picketHeading[row] delegate:self];
    picker.actionToolbar.titleButton.titleFont = [UIFont systemFontOfSize:12];
    picker.actionToolbar.titleButton.titleColor = [UIColor blackColor];
    
    if(selectedIndexofRow == 0){
        
        [picker setTitlesForComponents:@[trainingLOBArray]];
        
    }else if(selectedIndexofRow == 1){
        
        [picker setTitlesForComponents:@[productLineArray]];
        
    }
    
    [picker setTag:row];
    
    if(row == 1 && productLineArray.count == 0){
        
    }else{
        [picker show];
    }
    
    
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray<NSString *> *)titles{
    
    [dropDownSelectValue replaceObjectAtIndex:pickerView.tag withObject:titles[0]];
    
    switch (pickerView.tag) {
        case 0:{
            trainingLOB = titles[0];
            productLine = nil;
            [dropDownSelectValue replaceObjectAtIndex:1 withObject:@"Select Product Line"];
            self.trainingLOBLbl.text = trainingLOB;
            self.productLineLbl.text = @"Select Product Line";
            
            if([trainingLOB isEqualToString:@"CV Pax"]){
                productLineArray = [arrayCVPax copy];
            }else if([trainingLOB isEqualToString:@"ILCV"]){
                productLineArray = [arrayILCV copy];
            }else if([trainingLOB isEqualToString:@"MHCV"]){
                productLineArray = [arrayMHCV copy];
            }else if([trainingLOB isEqualToString:@"SCV Cargo"]){
                productLineArray = [arraySCVCargo copy];
            }
            
//            productLineArray = [[self getValueFromDataArray:dataArray withKey:@"crm_product_line" withValue:trainingLOB] copy];
        }
            break;
        case 1:
            productLine = titles[0];
            self.productLineLbl.text = productLine;

            break;
        default:
            break;
    }
    
}

- (IBAction)createSessionClick:(id)sender {
    
    if(!sessionData){
        if([trainingLOB isEqualToString:@""] || !trainingLOB){
            [self MB_showErrorMessageWithText:@"Please Select Training LOB"];
        }else if([productLine isEqualToString:@""] || !productLine){
            [self MB_showErrorMessageWithText:@"Please Select Product Line"];
        }else{
            
            NSDateFormatter *formatter = [NSDateFormatter MB_defaultDateFormatter];
            NSDate *date = [NSDate date];
            NSString *stringDate = [formatter stringFromDate:date];
        
            NSDateFormatter *formatter1 = [NSDateFormatter MB_defaultFormatter:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString *stringDate1 = [formatter1 stringFromDate:date];
            
            NSString *sessionName = [NSString stringWithFormat:@"%@_%@_%@", stringDate, trainingLOB, _sessionDataCreate.dealer_code];
            SessionDataArray *sesssionDataArray = [MBDataBaseHandler getSessionDataArray];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.session_name == %@)", sessionName];
            
            NSArray *sessionArray = [sesssionDataArray.data filteredArrayUsingPredicate:predicate];
            
            if(sessionArray.count > 0){
                [self MB_showErrorMessageWithText:@"This session already exist!"];
            }else{
                SessionData *setSessionData = [SessionData new];
                setSessionData.trainer_crm_id = GET_USER_DEFAULTS(CRMID);
                setSessionData.dealer_code = _sessionDataCreate.dealer_code;
                setSessionData.dealer_name = _sessionDataCreate.dealer_name;
                setSessionData.training_type = _sessionDataCreate.training_type;
                setSessionData.product_line = productLine;
                setSessionData.LOB_training = trainingLOB;
                setSessionData.trainees_crm_ids = _sessionDataCreate.trainees_crm_ids;
                setSessionData.session_status = @"open";
                setSessionData.last_session_update = stringDate1;
                setSessionData.session_name = sessionName;
                
                [MBDataBaseHandler saveSessiondata:setSessionData];
                
                trainingLOB = nil;
                dropDownSelectValue = [NSMutableArray arrayWithArray:picketHeading];
                productLineArray = [NSMutableArray new];
                sessionData = setSessionData;
                [self MB_showSuccessMessageWithText:@"Session Create Successfully!"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }

    }else{
        [self MB_showErrorMessageWithText:@"Please close previous session!"];
    }
    
    
}

//-(void)addGrayBackButtonCustom{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"back") style:UIBarButtonItemStylePlain target:self action:@selector(action_MoveToBackCustom::)];
//    [item setTintColor:[UIColor whiteColor]];
//    
//    if(self.tabBarController){
//        self.tabBarController.navigationItem.leftBarButtonItem = item;
//    }else{
//        self.navigationItem.leftBarButtonItem = item;
//    }
//    
//}
//-(IBAction)action_MoveToBackCustom:(id)sender{
//    ENDEDITING;
//    POP;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
