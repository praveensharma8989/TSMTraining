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


@end

@implementation SessionVC{

    CRMData *userData;
    CRMDataArray *dataArray;
    SessionData *sessionData;
    NSInteger selectedIndexofRow;
    NSArray *picketHeading;
    NSMutableArray *dropDownSelectValue;
    NSString *trainingType,*trainingLOB,*productLine,*dealerName,*crmName;
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
    dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    
    sessionData = [MBDataBaseHandler getSessionData];
    
    
    dropDownSelectValue = [[NSMutableArray alloc] initWithObjects:@"Select Training Type", @"Select Training LOB", @"Select Product Line", @"Select Dealer Name", nil];
    picketHeading = [[NSArray alloc] initWithArray:dropDownSelectValue];
    
}

-(void) nibRegistration{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([selectTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_SELECT_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserSelectTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_USER_SELECT];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            SessionCloseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_Seeion_Name_cell forIndexPath:indexPath];
            
            cell.sessionName.text = @"yes";
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
            
            cell.nameLbl.text = @"yes";
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
        return 1;
    }else{
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
        
//        if(trainingLOB && trainingType && productLine && dealerName){
            return 5;
//        }else{
//            return 0;
//        }
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
            return @"asdf";
            break;
        default:
            break;
    }
    
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if(section == 2){
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        searchBar.delegate = self;
        
        self.tableView.tableHeaderView = searchBar;
        
        UISearchDisplayController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        searchController.searchResultsDataSource = self;
        searchController.searchResultsDelegate = self;
        searchController.delegate = self;
        
        self.tableView.dataSource      =   self;
        self.tableView.delegate        =   self;
        [view addSubview:searchBar];
        return view;
        
    }else{
        return nil;
    }
    
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
            
            break;
        default:
            break;
    }
    
}

-(void)selectValueFromPicker :(NSInteger)row{
    
    selectedIndexofRow = row;
    
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:picketHeading[row] delegate:self];
    picker.actionToolbar.titleButton.titleFont = [UIFont systemFontOfSize:12];
    picker.actionToolbar.titleButton.titleColor = [UIColor blackColor];
    
    [picker setTitlesForComponents:@[@[@"First", @"Second", @"Third", @"Four", @"Five"]]];
    
    [picker setTag:row];
    
    [picker show];
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray<NSString *> *)titles{
    
    [dropDownSelectValue replaceObjectAtIndex:pickerView.tag withObject:titles[0]];
    
    switch (pickerView.tag) {
        case 0:
            trainingType = titles[0];
            break;
        case 1:
            trainingLOB = titles[0];
            break;
        case 2:
            productLine = titles[0];
            break;
        case 3:
            dealerName = titles[0];
            break;
        default:
            break;
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

@end
