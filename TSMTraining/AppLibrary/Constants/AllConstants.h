//
//  AllConstants.h
//  TSMTraining
//
//  Created by Mobikasa on 01/09/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#define APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define BaseUrl @"https://wheebox.com/MobileAPIService/"

#define HelloServlet @"HelloServlet"

#define Session @"Session"

#define Attendance @"Attendance"

#define Score @"Score"


#define CRMID @"CRMID"
#define CRMPASSWORD @"CRMPASSWORD"



#define TapTap [self.view endEditing:YES]

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


// Remove white space.
#define REMOVE_WHITE_SPACE(text) [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

#define Int_To_String(intValue) [NSString stringWithFormat:@"%ld",(long)intValue]


#ifndef AllConstants_h
#define AllConstants_h


#endif /* AllConstants_h */
