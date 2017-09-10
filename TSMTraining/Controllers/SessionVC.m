//
//  SessionVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "SessionVC.h"
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SessionVC ()<UITableViewDelegate, UITableViewDataSource, IQActionSheetPickerViewDelegate, UISearchBarDelegate, UISearchControllerDelegate,CLLocationManagerDelegate, UIImagePickerControllerDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate, UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *createSessionBtn;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *trainingTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *trainingLOBLbl;
@property (weak, nonatomic) IBOutlet UILabel *productLineLbl;
@property (weak, nonatomic) IBOutlet UILabel *dealerNameLbl;


@end

@implementation SessionVC{
    
    BOOL shouldShowSearchResults;
    CRMData *userData;
    CRMDataArray *dataArray;
    SessionData *sessionData;
    AttendanceData *attendanceData;
    NSInteger selectedIndexofRow;
    NSArray *picketHeading, *trainingLOBArray, *dealerNameArray;
    NSMutableArray *dropDownSelectValue, *productLineArray, *CRMNameArray, *CRMIDArray, *filterCRMNameArray, *filterCRMIDArray;
    NSString *trainingType,*trainingLOB,*productLine,*dealerName, *sessionLocation;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
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
    
    [self setupInitialScreen];
    
    [MBAppInitializer keyboardManagerEnabled];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

-(void)setupInitialScreen{
    
    [self setTitle:@"Session" isBold:YES];
    [self addGrayLogOutButton];
    [self nibRegistration];
    
    [self checkLocationServicesAndStartUpdates];
    
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
    
    
    
    if(sessionData){
        [self.tableView setHidden:NO];
        [self.createSessionBtn setHidden:YES];
        [self.selectView setHidden:YES];
    }else{
        [self.tableView setHidden:YES];
        [self.createSessionBtn setHidden:YES];
        [self.selectView setHidden:NO];
    }
    
//    [self.navigationItem setHidesBackButton:YES];
    
    dealerNameArray = [self getValueFromDataArray:dataArray withKey:@"dealer_name" withValue:@""];
    
    dropDownSelectValue = [[NSMutableArray alloc] initWithObjects:@"Select Training Type", @"Select Training LOB", @"Select Product Line", @"Select Dealer Name", nil];
    picketHeading = [[NSArray alloc] initWithArray:dropDownSelectValue];
    
    [MBAppInitializer keyboardManagerEnabled];
    
    self.trainingTypeLbl.tag = 0;
    self.trainingLOBLbl.tag = 1;
    self.productLineLbl.tag = 2;
    self.dealerNameLbl.tag = 3;
    
    [self.trainingTypeLbl setUserInteractionEnabled:YES];
    [self.trainingLOBLbl setUserInteractionEnabled:YES];
    [self.productLineLbl setUserInteractionEnabled:YES];
    [self.dealerNameLbl setUserInteractionEnabled:YES];
    
    self.trainingTypeLbl.text = dropDownSelectValue[0];
    self.trainingLOBLbl.text = dropDownSelectValue[1];
    self.productLineLbl.text = dropDownSelectValue[2];
    self.dealerNameLbl.text = dropDownSelectValue[3];
    
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)];
    tapAction.delegate =self;
    tapAction.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *tapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)];
    tapAction1.delegate =self;
    tapAction1.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *tapAction2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)];
    tapAction2.delegate =self;
    tapAction2.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *tapAction3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)];
    tapAction3.delegate =self;
    tapAction3.numberOfTapsRequired = 1;
    //Enable the lable UserIntraction
    
    [self.trainingTypeLbl addGestureRecognizer:tapAction];
    [self.trainingLOBLbl addGestureRecognizer:tapAction1];
    [self.productLineLbl addGestureRecognizer:tapAction2];
    [self.dealerNameLbl addGestureRecognizer:tapAction3];
    
}

-(void)addGrayBackButtonForSession{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"back") style:UIBarButtonItemStylePlain target:self action:@selector(action_MoveToBackSession:)];
    [item setTintColor:[UIColor whiteColor]];
    
    self.tabBarController.navigationItem.leftBarButtonItem = item;
    
    
}

-(IBAction)action_MoveToBackSession:(id)sender{
    
    [self.tableView setHidden:YES];
    [self.createSessionBtn setHidden:YES];
    [self.selectView setHidden:NO];
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    
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
    
    if(sessionData){
        
        SessionCloseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_Seeion_Name_cell forIndexPath:indexPath];
        
        cell.sessionName.text = sessionData.session_name;
        
        [self.createSessionBtn setHidden:YES];
        
        return cell;
        
    }else{
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
    
    return nil;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(sessionData){
        return 1;
    }else{
        if(dealerName && ![dealerName isEqualToString:@""]){
            return shouldShowSearchResults?filterCRMNameArray.count:CRMNameArray.count;
        }else{
            return 0;
        }
    }
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    
    if(sessionData){
        return @"Session Close";
    }else{
        return @" ";
    }
    
    return nil;
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
    
    if(sessionData){
        [self getPicAndLocation];
    }else{
        [self selectCrmNameWithID:indexPath];
    }
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
            self.trainingTypeLbl.text = trainingType;
        }
            
            break;
        case 1:{
            trainingLOB = titles[0];
            productLine = nil;
            [dropDownSelectValue replaceObjectAtIndex:2 withObject:@"Select Product Line"];
            self.trainingLOBLbl.text = trainingLOB;
            self.productLineLbl.text = @"Select Product Line";
            productLineArray = [[self getValueFromDataArray:dataArray withKey:@"crm_product_line" withValue:trainingLOB] copy];
        }
            
            break;
        case 2:
            productLine = titles[0];
            self.productLineLbl.text = productLine;
            break;
        case 3:
            dealerName = titles[0];
            self.dealerNameLbl.text = dealerName;
            
            CRMNameArray = [[self getValueFromDataArray:dataArray withKey:@"crm_name" withValue:dealerName] copy];
            for(int i = 0; i<CRMNameArray.count;i++){
                [CRMIDArray addObject:@""];
            }
            
            break;
        default:
            break;
    }
    
    if(trainingType && trainingLOB && productLine && dealerName){
        
        [self.selectView setHidden:YES];
        [self.createSessionBtn setHidden:NO];
        [self.tableView setHidden:NO];
        
        [self addGrayBackButtonForSession];
        
//        [self.navigationItem setHidesBackButton:NO];
        
        [self.tableView reloadData];
        
    }
    
    //    [self.tableView reloadData];
    
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
        
        
        NSDateFormatter *formatter = [NSDateFormatter MB_defaultDateFormatter];
        
        NSDate *date = [NSDate date];
        
        NSString *stringDate = [formatter stringFromDate:date];
        
        setSessionData.last_session_update = stringDate;
        
        setSessionData.session_name = [NSString stringWithFormat:@"%@_%@_%@", stringDate, trainingLOB, dealerCode[0]];
        
        [MBDataBaseHandler saveSessiondata:setSessionData];
        
        [self MB_showSuccessMessageWithText:@"Session Create Successfully!"];
        
        dealerName = nil;
        trainingType = nil;
        trainingLOB = nil;
        dropDownSelectValue = [NSMutableArray arrayWithArray:picketHeading];
        productLineArray = [NSMutableArray new];
        CRMNameArray = [NSMutableArray new];
        CRMIDArray = [NSMutableArray new];
        
        sessionData = setSessionData;
        
        [self.tableView reloadData];
        
    }
    
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            sessionLocation = nil;
            NSLog(@"User still thinking..");
        } break;
        case kCLAuthorizationStatusDenied: {
            sessionLocation = nil;
            NSLog(@"User hates you");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             sessionLocation = [NSString stringWithFormat:@"%@, %@, %@", placemark.subLocality, placemark.locality, placemark.country ];
             
         }
         else
         {
             sessionLocation = nil;
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             
         }
         
     }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"%@",error.userInfo);
    if([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Enable location permission"
                                                  message:@"To auto detect location, please enable location services for this app"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:@"Dismiss"
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Cancel action");
                                           }];
            
            UIAlertAction *goToSettings = [UIAlertAction
                                           actionWithTitle:@"Settings"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               //Simple way to open settings module
                                               NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                               [[UIApplication sharedApplication] openURL:url];
                                           }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:goToSettings];
            [self presentViewController:alertController animated:YES completion:^{
                //            alertController.view.tintColor = [UIColor blueColor];
            }];        }
    }
}


-(void) checkLocationServicesAndStartUpdates
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    
    //Checking authorization status
    if (![CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        
        //Now if the location is denied.
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Enable location permission"
                                              message:@"To auto detect location, please enable location services for this app"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Dismiss"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        
        UIAlertAction *goToSettings = [UIAlertAction
                                       actionWithTitle:@"Settings"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           //Simple way to open settings module
                                           NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                           [[UIApplication sharedApplication] openURL:url];
                                       }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:goToSettings];
        [self presentViewController:alertController animated:YES completion:^{
            //            alertController.view.tintColor = [UIColor blueColor];
        }];
        
        return;
    }
    else
    {
        //Location Services Enabled, let's start location updates
        [locationManager startUpdatingLocation];
    }
}

-(void)getPicAndLocation{
    
    if(attendanceData){
        
        [self checkLocationServicesAndStartUpdates];
        [self selectPic];
        
    }else{
        [self MB_showErrorMessageWithText:@"Please Upload attendance for this session!"];
    }
    
    
    
    
}

-(void) selectPic{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        return;
    }
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    if (status != ALAuthorizationStatusAuthorized) {
        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            UIImagePickerController *picker= [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [picker setDelegate:self];
            
            [self presentModalViewController:picker animated:YES];
        } failureBlock:^(NSError *error) {
            if (error.code == ALAssetsLibraryAccessUserDeniedError) {
                
                
                NSLog(@"user denied access, code: %zd", error.code);
                
                //Now if the location is denied.
                UIAlertController *alertController = [UIAlertController
                                                      alertControllerWithTitle:@"Enable Camera permission"
                                                      message:@"please enable camera services for this app"
                                                      preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *cancelAction = [UIAlertAction
                                               actionWithTitle:@"Dismiss"
                                               style:UIAlertActionStyleCancel
                                               handler:^(UIAlertAction *action)
                                               {
                                                   NSLog(@"Cancel action");
                                               }];
                
                UIAlertAction *goToSettings = [UIAlertAction
                                               actionWithTitle:@"Settings"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action)
                                               {
                                                   //Simple way to open settings module
                                                   NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                   [[UIApplication sharedApplication] openURL:url];
                                               }];
                
                [alertController addAction:cancelAction];
                [alertController addAction:goToSettings];
                [self presentViewController:alertController animated:YES completion:^{
                    //            alertController.view.tintColor = [UIColor blueColor];
                }];
                
            } else {
                NSLog(@"Other error code: %zd", error.code);
            }
        }];
    }else{
        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [picker setDelegate:self];
        
        [self presentModalViewController:picker animated:YES];
    }
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage]; // or you can use UIImagePickerControllerEditedImage too
    NSData *mediaData = UIImageJPEGRepresentation(image, 0.3);
    
    sessionData.session_location = sessionLocation;
    NSString *stringImage = [mediaData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    sessionData.session_image = stringImage;
    NSDateFormatter *formatter = [NSDateFormatter MB_defaultDateFormatter];
    
    NSDate *date = [NSDate date];
    
    NSString *stringDate = [formatter stringFromDate:date];
    
    sessionData.last_session_update = stringDate;
    
    SessionDataArray *sessionDataArray = [MBDataBaseHandler getSessionDataArray
                                          ];
    
    NSDictionary *new = [sessionData toDictionary];
    NSMutableArray *jsonToArray = [NSMutableArray arrayWithObject:new];
    
    if(sessionDataArray){
        
        [sessionDataArray.data addObject:sessionData];
        
        [MBDataBaseHandler saveSessiondataArray:sessionDataArray];
        
        [MBDataBaseHandler deleteAllRecordsForType:SESSIONDATA];
        [MBDataBaseHandler deleteAllRecordsForType:ATTENDANCEDATA];
        sessionData = nil;
        attendanceData = nil;
    }else{
        
        sessionDataArray = [[SessionDataArray alloc] initWithDictionary:@{@"data":jsonToArray} error:nil];
        
        [MBDataBaseHandler saveSessiondataArray:sessionDataArray];
        [MBDataBaseHandler deleteAllRecordsForType:SESSIONDATA];
        [MBDataBaseHandler deleteAllRecordsForType:ATTENDANCEDATA];
        sessionData = nil;
        attendanceData = nil;
    }
    
    [self.tableView reloadData];
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
