//
//  SessionVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "SessionVC.h"

@interface SessionVC ()<UITableViewDelegate, UITableViewDataSource, IQActionSheetPickerViewDelegate, UISearchBarDelegate, UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *createSessionBtn;


@end

@implementation SessionVC{

    CRMData *userData;
    CRMDataArray *dataArray;
    SessionData *sessionData;
    NSInteger selectedIndexofRow;
    NSArray *picketHeading, *trainingLOBArray, *dealerNameArray;
    NSMutableArray *dropDownSelectValue, *productLineArray, *CRMNameArray, *CRMIDArray;
    NSString *trainingType,*trainingLOB,*productLine,*dealerName;
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
    [self setNavigation];
    [self addGrayLogOutButton];
    [self nibRegistration];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    sessionData = [MBDataBaseHandler getSessionData];
    
    trainingLOBArray = [self getValueFromDataArray:dataArray withKey:@"crm_LOB" withValue:@""];
    productLineArray = [NSMutableArray new];
    CRMNameArray = [NSMutableArray new];
    CRMIDArray = [NSMutableArray new];
    
    dealerNameArray = [self getValueFromDataArray:dataArray withKey:@"dealer_name" withValue:@""];
    
    dropDownSelectValue = [[NSMutableArray alloc] initWithObjects:@"Select Training Type", @"Select Training LOB", @"Select Product Line", @"Select Dealer Name", nil];
    picketHeading = [[NSArray alloc] initWithArray:dropDownSelectValue];
    
}

-(NSArray *)getValueFromDataArray :(CRMDataArray *)data withKey:(NSString *)key withValue:(NSString *)value{
    
    NSPredicate *predicate;
    
    if([key isEqualToString:@"crm_LOB"]){
        
         predicate = [NSPredicate predicateWithFormat:@"(SELF.crm_LOB != %@)", @""];
        
    }else if([key isEqualToString:@"crm_product_line"]){
        
        predicate = [NSPredicate predicateWithFormat:@"(SELF.crm_LOB == %@)AND(SELF.crm_product_line != %@)", value,@""];
        
    }else if([key isEqualToString:@"crm_name"]){
        predicate = [NSPredicate predicateWithFormat:@"(SELF.dealer_name == %@)", value];
    }else if([key isEqualToString:@"crm_id"]){
        predicate = [NSPredicate predicateWithFormat:@"(SELF.crm_name == %@)", value];
    }else if([key isEqualToString:@"dealer_code"]){
        predicate = [NSPredicate predicateWithFormat:@"(SELF.dealer_name == %@)", value];
    }else{
        predicate = [NSPredicate predicateWithFormat:@"(SELF.dealer_name != %@)", @""];
    }
    
    
    NSArray *array =[data.data filteredArrayUsingPredicate:predicate];
    
    NSString *valueForKey = [NSString stringWithFormat:@"@distinctUnionOfObjects.%@",key];
    
    NSArray *uniqueGenres = [array valueForKeyPath:valueForKey];
    
    
    return uniqueGenres;
}

-(void) nibRegistration{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([selectTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_SELECT_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserSelectTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_USER_SELECT];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            SessionCloseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_Seeion_Name_cell forIndexPath:indexPath];
            
            cell.sessionName.text = sessionData.session_name;
            
            return cell;
        
        }
            break;
            
        case 1:{
        
            selectTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_SELECT_CELL forIndexPath:indexPath];
            
            cell.selectValue.text = dropDownSelectValue[indexPath.row];
            return cell;
        
        }
            
            break;
            
        case 2:{
        
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(sessionData){
        [self.createSessionBtn setHidden:YES];
        return 1;
    }else{
        [self.createSessionBtn setHidden:NO];
        return 3;
    }
    
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        if(sessionData){
            return 1;
        }else{
            return 0;
        }
        
    }else if (section == 1){
        
        return 4;
        
    }else{
        
        if(dealerName && ![dealerName isEqualToString:@""]){
            return CRMNameArray.count;
        }else{
            return 0;
        }
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:{
        
            if(sessionData){
                return @"Session Close";
            }else{
                return nil;
            }
            
        }
            break;
            
        case 1:
            return @"Create Session";
            
            break;
        
        case 2:
            return @" ";
            break;
        default:
            break;
    }
    
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if(section == 2 && dealerName && ![dealerName isEqualToString:@""]){
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
        searchBar.delegate = self;
        
//        self.tableView.tableHeaderView = searchBar;
        
        UISearchDisplayController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        searchController.searchResultsDataSource = self;
        searchController.searchResultsDelegate = self;
        searchController.delegate = self;
        
//        self.tableView.dataSource      =   self;
//        self.tableView.delegate        =   self;
        [view addSubview:searchBar];
        return view;
        
    }else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 2 && dealerName && ![dealerName isEqualToString:@""]){
        return 44;
    }
    return self.tableView.sectionHeaderHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            break;
            
        case 1:{
         
            [self selectValueFromPicker:indexPath.row];
        }
            break;
            
        case 2:
            [self selectCrmNameWithID:indexPath];
            break;
        default:
            break;
    }
    
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

-(void)selectValueFromPicker :(NSInteger)row{
    
    selectedIndexofRow = row;
    
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:picketHeading[row] delegate:self];
    picker.actionToolbar.titleButton.titleFont = [UIFont systemFontOfSize:12];
    picker.actionToolbar.titleButton.titleColor = [UIColor blackColor];
    
    if(selectedIndexofRow == 0){
        [picker setTitlesForComponents:@[@[@"Refresher", @"Produuct Training"]]];
    }else if(selectedIndexofRow == 1){
        
        [picker setTitlesForComponents:@[trainingLOBArray]];
        
    }else if(selectedIndexofRow == 2){
        
        [picker setTitlesForComponents:@[productLineArray]];
        
    }else{
        
        [picker setTitlesForComponents:@[dealerNameArray]];
        
    }
    
    
    
    [picker setTag:row];
    
    if(row == 2 && productLineArray.count == 0){
        
    }else{
        [picker show];
    }
    
    
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray<NSString *> *)titles{
    
    [dropDownSelectValue replaceObjectAtIndex:pickerView.tag withObject:titles[0]];
    
    switch (pickerView.tag) {
        case 0:{
            trainingType = titles[0];
        }
        
            break;
        case 1:{
            trainingLOB = titles[0];
            productLine = nil;
            [dropDownSelectValue replaceObjectAtIndex:2 withObject:@"Select Product Line"];
            productLineArray = [[self getValueFromDataArray:dataArray withKey:@"crm_product_line" withValue:trainingLOB] copy];
        }
            
            break;
        case 2:
            productLine = titles[0];
            break;
        case 3:
            dealerName = titles[0];
            
            CRMNameArray = [[self getValueFromDataArray:dataArray withKey:@"crm_name" withValue:dealerName] copy];
            for(int i = 0; i<CRMNameArray.count;i++){
                [CRMIDArray addObject:@""];
            }
            
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
    
}
- (IBAction)createSessionClick:(id)sender {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length > 0"];
    NSArray *anotherArray = [CRMIDArray filteredArrayUsingPredicate:predicate];
    
    if([trainingType isEqualToString:@""] || !trainingType){
        [self MB_showErrorMessageWithText:@"Please Select Training Type"];
    }else if([trainingLOB isEqualToString:@""] || !trainingLOB){
        [self MB_showErrorMessageWithText:@"Please Select Training Type"];
    }else if([productLine isEqualToString:@""] || !productLine){
        [self MB_showErrorMessageWithText:@"Please Select Product Line"];
    }else if([dealerName isEqualToString:@""] || !dealerName){
        [self MB_showErrorMessageWithText:@"Please Select Dealer Name"];
    }else if(anotherArray.count==0 || !anotherArray){
        [self MB_showErrorMessageWithText:@"Please Select CRM Names"];
    }else{
        
        SessionData *setSessionData = [SessionData new];
        setSessionData.trainer_crm_id = GET_USER_DEFAULTS(CRMID);
        NSArray *dealerCode = [self getValueFromDataArray:dataArray withKey:@"dealer_code" withValue:dealerName];
        setSessionData.dealer_code = dealerCode[0];
        setSessionData.dealer_name = dealerName;
        setSessionData.training_type = trainingType;
        setSessionData.product_line = productLine;
        setSessionData.LOB_training = trainingLOB;
        setSessionData.trainees_crm_ids = [anotherArray copy];
        setSessionData.session_status = TRUE;
        setSessionData.last_session_update = [NSString stringWithFormat:@"%@", [NSDate date]];
        setSessionData.session_name = @"newdata";
        
        [MBDataBaseHandler saveSessiondata:setSessionData];
        
        [self MB_showSuccessMessageWithText:@"Session Create Successfully!"];
        
        dealerName = nil;
        trainingType = nil;
        trainingLOB = nil;
        dropDownSelectValue = [picketHeading copy];
        productLineArray = nil;
        CRMNameArray = nil;
        CRMIDArray = nil;
        
        sessionData = setSessionData;
        
        [self.tableView reloadData];
        
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
