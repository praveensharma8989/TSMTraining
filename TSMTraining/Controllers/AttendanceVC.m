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

@end

@implementation AttendanceVC{
    
    CRMDataArray *dataArray;
    CRMData *userData;
    SessionData *sessionData;
    NSString *dealerNameSelect, *sessionSelect;
    NSMutableArray *CRMNameArray, *CRMIDArray, *filterDataArray, *dropDownSelectValue;
    NSArray *dealerNameArray, *picketHeading;
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
    
    [self setTitle:@"Score" isBold:YES];
    
    [MBAppInitializer keyboardManagerEnabled];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

-(void)setupInitialScreen{
    
    [self setTitle:@"Score" isBold:YES];
    [self addGrayLogOutButton];
    [self nibRegistration];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    sessionData = [MBDataBaseHandler getSessionData];
    
    CRMNameArray = [NSMutableArray new];
    CRMIDArray = [NSMutableArray new];
    filterDataArray = [NSMutableArray new];
    
    
    dealerNameArray = [self getValueFromDataArray:dataArray withKey:@"dealer_name" withValue:@""];
    
    dropDownSelectValue = [[NSMutableArray alloc] initWithObjects:@"Select Training Type", @"Select Training LOB", @"Select Product Line", @"Select Dealer Name", nil];
    picketHeading = [[NSArray alloc] initWithArray:dropDownSelectValue];
    
}

-(void) nibRegistration{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([selectTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_SELECT_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserSelectTableViewCell class]) bundle:nil] forCellReuseIdentifier:K_USER_SELECT];
}

-(NSArray *)getValueFromDataArray :(CRMDataArray *)data withKey:(NSString *)key withValue:(NSString *)value{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.dealer_name != %@)", @""];
    NSArray *array =[data.data filteredArrayUsingPredicate:predicate];
    
    NSString *valueForKey = [NSString stringWithFormat:@"@distinctUnionOfObjects.%@",key];
    
    NSArray *uniqueGenres = [array valueForKeyPath:valueForKey];
    
    
    return uniqueGenres;
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
            cell.selectValue = dropDownSelectValue[indexPath.row];
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
        if(sessionData){
            [picker setTitlesForComponents:@[@[sessionData.session_name]]];
        }
    }
    
    
    [picker setTag:row];
    
    if(row == 1 && sessionData){
        
    }else{
        [picker show];
    }
    
    
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray<NSString *> *)titles{
    
    [dropDownSelectValue replaceObjectAtIndex:pickerView.tag withObject:titles[0]];
    
    switch (pickerView.tag) {
        case 0:{
            dealerNameSelect = titles[0];
        }
            
            break;
        case 1:{
            sessionSelect = titles[0];
            
        }
            
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
