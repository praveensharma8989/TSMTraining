//
//  AllConstants.h
//  TSMTraining
//
//  Created by Mobikasa on 01/09/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#define APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define BaseUrl @"https://wheebox.com/MobileAPIService/"

#define RegData @"RegData"

#define ConfirmID @"ConfirmID"

#define ResetPassword @"ResetPassword"

#define Session @"Session"

#define Attendance @"Attendance"

#define Score @"Score"


#define CRMID @"CRMID"
#define TEMCRMID @"TEMCRMID"
#define CRMPASSWORD @"CRMPASSWORD"



#define TapTap [self.view endEditing:YES]

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width

#define CELLHEIGHT self.contentView.frame.size.height
#define CELLWIDTH self.contentView.frame.size.width

#define SHOWERRORALERT(msg) [[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show]

//NSUserDefaults MACROS
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define SAVE_USER_DEFAULTS(VALUE,KEY) [[NSUserDefaults standardUserDefaults] setObject:VALUE forKey:KEY]; [[NSUserDefaults standardUserDefaults] synchronize]
#define GET_USER_DEFAULTS(KEY) [[NSUserDefaults standardUserDefaults] objectForKey:KEY]
#define REMOVE_USER_DEFAULTSFOR(KEY) [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY]

#define IMAGE(v) [UIImage imageNamed:v]

#define ENDEDITING [self.view.window endEditing:YES]

#define PUSH(v) [self.navigationController pushViewController:v animated:YES]
#define POP  [self.navigationController popViewControllerAnimated:YES]
#define POPTOROOT  [self.navigationController popToRootViewControllerAnimated:YES]
#define PUSHCONTROLLER(v) [self.navigationController pushViewController:GETCONTROLLER(v) animated:YES]

#define DISMISSCONTROLLER [self dismissViewControllerAnimated:YES completion:nil]


// Image and font constant
#define flowerImage @"flower50X73"
#define fontRegular @"HelveticaNeue"
#define fontBold @"HelveticaNeue-Bold"
#define fontMedium @"HelveticaNeue-Medium"
#define fontLight @"HelveticaNeue-Light"

// Remove white space.
#define REMOVE_WHITE_SPACE(text) [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

#define Int_To_String(intValue) [NSString stringWithFormat:@"%ld",(long)intValue]


#define K_SELECT_CELL @"selectTableViewCell"
#define K_USER_SELECT @"UserSelectTableViewCell"
#define K_Seeion_Name_cell @"SessionCloseTableViewCell"
#define K_SCORE_CUSTOM_CELL @"ScoreCustomTableViewCell"
#define K_SCORE_STATIC_CELL @"ScoreStatickTableViewCell"


#define K_SESSION_SECOND_VC @"sessionSecondVC"
#define K_SCORE_SECOND_VC @"ScoreSecondVC"
#define K_THIRD_SECOND_VC @"ScoreThirdVC"
#define K_UPDATE_SECOND_VC @"ScoreUpdateTV"

 #define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SHARED_INSTANCE(...) ({\
static dispatch_once_t pred;\
static id sharedObject;\
dispatch_once(&pred, ^{\
sharedObject = (__VA_ARGS__);\
});\
sharedObject;\
})

#ifndef AllConstants_h
#define AllConstants_h


#endif /* AllConstants_h */
