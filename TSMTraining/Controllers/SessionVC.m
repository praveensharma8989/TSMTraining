//
//  SessionVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "SessionVC.h"
#import "sessionSecondVC.h"

@interface SessionVC ()<UITableViewDelegate, UITableViewDataSource, IQActionSheetPickerViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *createSessionBtn;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *trainingTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *dealerNameLbl;


@end

@implementation SessionVC{
    
    BOOL shouldShowSearchResults;
    CRMData *userData;
    CRMDataArray *dataArray;
    SessionData *sessionData;
    SessionData *createSessionData;
    
    AttendanceData *attendanceData;
    NSInteger selectedIndexofRow;
    NSArray *picketHeading, *trainingLOBArray, *dealerNameArray;
    NSMutableArray *dropDownSelectValue, *productLineArray, *CRMNameArray, *CRMIDArray, *filterCRMNameArray, *filterCRMIDArray;
    NSString *trainingType,*dealerName;
    
    UISearchController *searchControllerBar;
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
    
    
    [MBAppInitializer keyboardManagerEnabled];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

-(void)setupInitialScreen{
    
    [self setTitle:@"Session" isBold:YES];
    [self addGrayBackButton];
    [self addGrayLogOutButton];
    [self nibRegistration];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    sessionData = [MBDataBaseHandler getSessionData];
    attendanceData = [MBDataBaseHandler getAttendanceData];
    
    trainingLOBArray = [self getValueFromDataArray:dataArray withKey:@"crm_LOB" withValue:@""];
    productLineArray = [NSMutableArray new];
    CRMNameArray = [NSMutableArray new];
    CRMIDArray = [NSMutableArray new];
    filterCRMNameArray = [NSMutableArray new];
    filterCRMIDArray = [NSMutableArray new];
    shouldShowSearchResults = false;
    
    
    
    if(CRMNameArray){
        [self.tableView setHidden:NO];
    }else{
        [self.tableView setHidden:YES];
    }
    
    dealerNameArray = [self getValueFromDataArray:dataArray withKey:@"dealer_name" withValue:@""];
    
    dropDownSelectValue = [[NSMutableArray alloc] initWithObjects:@"Select Training Type", @"Select Dealer Name", nil];
    picketHeading = [[NSArray alloc] initWithArray:dropDownSelectValue];
    
    
    [MBAppInitializer keyboardManagerEnabled];
    
    self.trainingTypeLbl.tag = 0;
    self.dealerNameLbl.tag = 1;
    
    [self.trainingTypeLbl setUserInteractionEnabled:YES];
    [self.dealerNameLbl setUserInteractionEnabled:YES];
    
    self.trainingTypeLbl.text = dropDownSelectValue[0];
    self.dealerNameLbl.text = dropDownSelectValue[1];
    
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)];
    tapAction.delegate =self;
    tapAction.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *tapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)];
    tapAction1.delegate =self;
    tapAction1.numberOfTapsRequired = 1;
  
    //Enable the lable UserIntraction
    
    [self.trainingTypeLbl addGestureRecognizer:tapAction];
    [self.dealerNameLbl addGestureRecognizer:tapAction1];
    
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
    
    NSArray *arraycrmName;
    NSArray *arraycrnId;
    if(shouldShowSearchResults){
        arraycrmName = filterCRMNameArray;
        arraycrnId = filterCRMIDArray;
    }else{
        arraycrmName = CRMNameArray;
        arraycrnId = CRMIDArray;
    }
    UserSelectTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_USER_SELECT forIndexPath:indexPath];
    if(arraycrmName.count >0){
        cell.nameLbl.text = arraycrmName[indexPath.row];
        if([arraycrnId[indexPath.row] isEqualToString:@""]){
            [cell.selectTick setImage:[UIImage imageNamed:@"blankTick"]];
        }else{
            [cell.selectTick setImage:[UIImage imageNamed:@"selectTick"]];
        }
    }
    [self.createSessionBtn setHidden:NO];
    
    return cell;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        if(dealerName && ![dealerName isEqualToString:@""]){
            return shouldShowSearchResults?filterCRMNameArray.count:CRMNameArray.count;
        }else{
            return 0;
        }
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @" ";
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(dealerName && ![dealerName isEqualToString:@""]){
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        
        [view setTintColor:[UIColor lightGrayColor]];
        [view setBackgroundColor:[UIColor lightGrayColor]];
        
        searchControllerBar = [[UISearchController alloc] initWithSearchResultsController:nil];
        
        searchControllerBar.searchResultsUpdater = self;
        searchControllerBar.dimsBackgroundDuringPresentation = NO;
        searchControllerBar.searchBar.delegate = self;
        
        searchControllerBar.hidesNavigationBarDuringPresentation = false;
        
        searchControllerBar.searchBar.searchBarStyle = UISearchBarStyleProminent;
        
        [searchControllerBar setNeedsStatusBarAppearanceUpdate];
        
        
        [view addSubview:searchControllerBar.searchBar];
        
        [searchControllerBar.searchBar sizeToFit];
        
        return view;
        
    }else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(dealerName && ![dealerName isEqualToString:@""]){
        return 44;
    }else{
        return 30;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self selectCrmNameWithID:indexPath];
    
}

-(void)selectCrmNameWithID:(NSIndexPath *)crmNamePosition{
    
    NSArray *arraycrmName;
    NSArray *arraycrmId;
    
    if(shouldShowSearchResults){
        
        arraycrmName = filterCRMNameArray;
        arraycrmId = filterCRMIDArray;
        
    }else{
        
        arraycrmName = CRMNameArray;
        arraycrmId = CRMIDArray;
        
    }
    
    
    if(![arraycrmId[crmNamePosition.row] isEqualToString:@""]){
        
        if(shouldShowSearchResults){
            
            NSInteger index = [CRMNameArray indexOfObject:filterCRMNameArray[crmNamePosition.row]];
            [CRMIDArray replaceObjectAtIndex:index withObject:@""];
            [filterCRMIDArray replaceObjectAtIndex:crmNamePosition.row withObject:@""];
            
        }else{
            [CRMIDArray replaceObjectAtIndex:crmNamePosition.row withObject:@""];
        }
        
    }else{
        
        NSArray *crmids = [self getValueFromDataArray:dataArray withKey:@"crm_id" withValue:CRMNameArray[crmNamePosition.row]];
        NSString *crmid = crmids[0];
        
        if(shouldShowSearchResults){
            
            NSInteger index = [CRMNameArray indexOfObject:filterCRMNameArray[crmNamePosition.row]];
            [CRMIDArray replaceObjectAtIndex:index withObject:crmid];
            [filterCRMIDArray replaceObjectAtIndex:crmNamePosition.row withObject:crmid];
            
        }else{
            [CRMIDArray replaceObjectAtIndex:crmNamePosition.row withObject:crmid];
        }
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[crmNamePosition] withRowAnimation:NO];
    
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
        [picker setTitlesForComponents:@[@[@"Refresher", @"Produuct Training"]]];
    }else if(selectedIndexofRow == 1){
        
        [picker setTitlesForComponents:@[dealerNameArray]];
        
    }
    
    [picker setTag:row];
    
    [picker show];
    
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray<NSString *> *)titles{
    
    [dropDownSelectValue replaceObjectAtIndex:pickerView.tag withObject:titles[0]];
    
    switch (pickerView.tag) {
        case 0:{
            trainingType = titles[0];
            self.trainingTypeLbl.text = trainingType;
        }
            
            break;
        case 1:{
            dealerName = titles[0];
            self.dealerNameLbl.text = dealerName;
            
            CRMNameArray = [[self getValueFromDataArray:dataArray withKey:@"crm_name" withValue:dealerName] copy];
            for(int i = 0; i<CRMNameArray.count;i++){
                [CRMIDArray addObject:@""];
            }
        }
            
            break;
        
        default:
            break;
    }
    
    if(dealerName){
    
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        
    }
    
}
- (IBAction)createSessionClick:(id)sender {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length > 0"];
    NSArray *anotherArray = [CRMIDArray filteredArrayUsingPredicate:predicate];
    
    if([trainingType isEqualToString:@""] || !trainingType){
        [self MB_showErrorMessageWithText:@"Please Select Training Type"];
    }else if([dealerName isEqualToString:@""] || !dealerName){
        [self MB_showErrorMessageWithText:@"Please Select Dealer Name"];
    }else if(anotherArray.count==0 || !anotherArray){
        [self MB_showErrorMessageWithText:@"Please Select CRM Names"];
    }else{
        
        createSessionData = [SessionData new];
        createSessionData.trainer_crm_id = GET_USER_DEFAULTS(CRMID);
        NSArray *dealerCode = [self getValueFromDataArray:dataArray withKey:@"dealer_code" withValue:dealerName];
        createSessionData.dealer_code = dealerCode[0];
        createSessionData.dealer_name = dealerName;
        createSessionData.training_type = trainingType;
        
        createSessionData.trainees_crm_ids = [anotherArray componentsJoinedByString:@","];
        createSessionData.session_status = false;
        
        
        NSDateFormatter *formatter = [NSDateFormatter MB_defaultDateFormatter];
        
        NSDate *date = [NSDate date];
        
        NSString *stringDate = [formatter stringFromDate:date];
        
        createSessionData.last_session_update = stringDate;
        
        sessionSecondVC *vwNav = [self.storyboard instantiateViewControllerWithIdentifier:K_SESSION_SECOND_VC];
        
        vwNav.sessionDataCreate = createSessionData;
        vwNav.arrayCrmID = anotherArray;
        
        [self.navigationController pushViewController:vwNav animated:YES];
        
    }
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if(searchText.length==0){
        
        shouldShowSearchResults = NO;
        filterCRMNameArray = CRMNameArray;
        
    }else{
        
        shouldShowSearchResults = YES;
        [self filterDataFromNameArray:searchText];
        
    }
    
}


-(void)filterDataFromNameArray:(NSString *)string{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", string];
    NSArray *array = [CRMNameArray filteredArrayUsingPredicate:predicate];
    
    filterCRMNameArray = [NSMutableArray new];
    filterCRMNameArray = [array copy];
    filterCRMIDArray = [NSMutableArray new];
    
    for(int i = 0; i < filterCRMNameArray.count; i++){
        
        NSInteger index = [CRMNameArray indexOfObject:filterCRMNameArray[i]];
        [filterCRMIDArray addObject:CRMIDArray[index]];
        
    }
    
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    shouldShowSearchResults = YES;
    [searchBar resignFirstResponder];
}


#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    //
    //    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    NSString *searchText = searchController.searchBar.text;
    
    if(searchText.length==0){
        
        shouldShowSearchResults = NO;
        filterCRMNameArray = [NSMutableArray new];
        filterCRMIDArray = [NSMutableArray new];
        
    }else{
        
        shouldShowSearchResults = YES;
        [self filterDataFromNameArray:searchText];
        
    }
    [self.tableView reloadData];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(IBAction)lblClick :(UITapGestureRecognizer *)tapsender{
    
    UILabel *currentLabel = (UILabel *)tapsender.view;
    NSLog(@"tap %ld",(long)currentLabel.tag);
    
    [self selectValueFromPicker:currentLabel.tag];
    
}

@end
