//
//  SessionCloseVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "SessionCloseVC.h"
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>


@interface SessionCloseVC ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *locationName;

@end

@implementation SessionCloseVC{
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    SessionData *sessionData;
    AttendanceData *attendanceData;
    NSString *sessionLocation;
    
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
    
    [self setTitle:@"Session Close" isBold:YES];
    
    [self addGrayBackButton];
    [self addGrayLogOutButton];
    
    [self checkLocationServicesAndStartUpdates];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    sessionData = [MBDataBaseHandler getSessionData];
    attendanceData = [MBDataBaseHandler getAttendanceData];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(sessionData){
        
        SessionCloseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_Seeion_Name_cell forIndexPath:indexPath];
        cell.sessionName.text = sessionData.session_name;
        return cell;
        
    }else{
        SessionCloseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_Seeion_Name_cell forIndexPath:indexPath];
        cell.sessionName.text = @"No Session Data!";
        return cell;
    }
    return nil;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(sessionData){
        return 1;
    }else{
        return 1;
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(sessionData){
        [self getPicAndLocation];
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
             _locationName.text = sessionLocation;
             
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
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized)
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [picker setDelegate:self];
        
        [self presentModalViewController:picker animated:YES];
        
    }
    else if(authStatus == AVAuthorizationStatusDenied)
    {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
         {
             if(granted)
             {
                 UIImagePickerController *picker= [[UIImagePickerController alloc] init];
                 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                 
                 [picker setDelegate:self];
                 
                 [self presentModalViewController:picker animated:YES];
             }
             else
             {
                 
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
             }
         }];
    }else if(authStatus == AVAuthorizationStatusNotDetermined)
    {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
         {
             if(granted)
             {
                 UIImagePickerController *picker= [[UIImagePickerController alloc] init];
                 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                 
                 [picker setDelegate:self];
                 
                 [self presentModalViewController:picker animated:YES];
             }
             else
             {
                 
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
             }
         }];
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
    
    
    if(![sessionData.session_image isEqualToString:@""] && ![sessionData.session_location isEqualToString:@""]){
        
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
        
        [self MB_showSuccessMessageWithText:@"Session Close Successfully!"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        
        [self MB_showErrorMessageWithText:@"Error."];
        
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
