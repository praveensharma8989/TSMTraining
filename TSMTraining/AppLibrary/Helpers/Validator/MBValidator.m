//
//  MBValidator.m
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "MBValidator.h"
#import "CreditCardValidator.h"

@implementation MBValidator

static const int CODE = 10000;

+(int) code{
    return CODE;
}

+(NSString *) messageForCode: (int)code{
    
    NSString *result;
    
    switch (code) {
        case 0:
            result = @"Success.";
            break;
        case 80:
            result = @"Agree terms and condition. Please check.";
            break;
        case 90:
            result = @"%@ is blank. Please check.";
            break;
            
        case 100:
            result = @"Username is blank. Please check.";
            break;
        case 101:
            result = @"Username can not contain spaces. Please check.";
            break;
        case 102:
            result = @"Invalid characters in username. Please check.";
            break;
            
        case 200:
            result = @"Please provide your password.";//@"Password is blank. Please check.";
            break;
        case 201:
            result = @"The password should contain at least 6 characters. Please try again.";//@"Password must be min. 6 characters. Please check.";
            break;
        case 203:
            result = @"Please confirm your password.";  //@"Confirm password is blank. Please check.";
            break;
        case 204:
            result = @"Confirm password should contain at least 6 characters. Please try again";//@"Confirm password must be min. 6 characters. Please check.";
            break;
        case 205:
            result = @"Password should be 6-16 alphanumeric characters.";
            break;

            
        case 300:
            result = @"BBM pin is blank. Please check.";
            break;
        case 301:
            result = @"BBM pin can not contain spaces. Please check.";
            break;
        case 302:
            result = @"Invalid BBM pin. Please check.";
            break;
            
        case 400:
//            result =  @"Please provide a valid e-mail id."; //@"Email is blank. Please check.";
            result = @"The email id is blank. Please check";
            break;
        case 401:
            result = @"Email can not contain spaces. Please check.";
            break;
        case 402:
//            result = @"Invalid email address. Please check.";
            result = @"The email id is invalid. Please check";
            break;
            
        case 500:
            result = @"Mobile no. is blank. Please check.";
            break;
        case 501:
            result = @"Mobile no. must be at least 10 digits. Please check.";
            break;
        case 502:
            result = @"Mobile no. can not contain spaces. Please check.";
            break;
        case 503:
            result = @"Invalid mobile no. Please check.";
            break;
            
        case 600:
            result = @"Gender is blank. Please check.";
            break;
        case 700:
            result = @"Age is blank. Please check.";
            break;
        case 800:
            result = @"Country is blank. Please check.";
            break;
        case 801:
            result = @"City is blank. Please check.";
            break;
        case 802:
            result = @"State is blank. Please check.";
            break;
        case 803:
            result = @"Zip Code is blank. Please check.";
            break;
        case 900:
//            result = @"Name is blank. Please check.";
            result = @"Please enter your first name";
            break;
        case 901:
            result = @"Invalid characters in name. Please check.";
            break;
        case 903:result = @"Specify your gender.";
            break;
        case 904:
//            result = @"Last Name is blank. Please check.";
            result = @"Please enter your last name";
            break;
        case 905:
            result = @"Address is blank. Please check.";
            break;
            
        case 920:result = @"BBM Pin or email, one is required.";
            break;
        case CODE:
            result = @"You need to fill either email or phone. Please check.";
            break;
            
        case 1000:
            result = @"Password mismatch. Please check.";
            break;
            
        case 1020:
            result = @"Please select profile image.";
            break;
            
        case 1100:
            result = @"Please select vehicle year.";
            break;
        case 1101:
            result = @"Please select vehicle make.";
            break;
        case 1102:
            result = @"Please select vehicle model";
            break;
        case 1103:
            result = @"Please select School.";
            break;
 
            
        case 1200:
            result = @"Please upload profile image.";
            break;
            
        case 1300:
            result = @"Please enter credit card number.";
            break;
        case 1301:
            result = @"Invalid credit card. Please check.";
            break;
        case 1302:
            result = @"Please enter CVV number.";
            break;
        case 1303:
            result = @"Please enter correct CVV number.";
            break;
        case 1304:
            result = @"Please enter Expiry date.";
            break;
        case 1305:
            result = @"Please enter correct Expiry date.";
            break;
        case 1310:
            result = @"Your new and old password should not match each other.";
            break;
        default:
            result = @"Something seems wrong. Please check.";
            break;
    }
    
    return result;
}

+(int) validateUsername: (NSString *)username{
    
    if (!username || username.length==0) {
        return 100;
    }
//    if ([username rangeOfString:@" "].location != NSNotFound) {
//        return 101;
//    }
    
//    if ([username rangeOfString:@"@"].location == NSNotFound) {
//        return 102;
//    }
//    
//    //    NSCharacterSet* notDigits = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
//    //    if ([username rangeOfCharacterFromSet:notDigits].location != NSNotFound){
//    //        return 102;
//    //    }
//    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789_.-"] invertedSet];
//    if ([username rangeOfCharacterFromSet:set].location != NSNotFound) {
//        return 102;
//    }
    return 0;
}

+(int) validatePassword: (NSString *)password{
    
    if (!password || password.length==0) {
        return 200;
    }
    
    if (password.length<6) {
        return 201;
    }
    
    return 0;
}


+(int) validateConfirmPassword: (NSString *)password{
    if (!password || password.length==0) {
        return 203;
    }
    
    if (password.length<6) {
        return 204;
    }
    
    return 0;
}

+(int) validateBBM: (NSString *)bbmpin{
    if (!bbmpin || bbmpin.length==0) {
        return 300;
    }
    
    if (bbmpin.length != 8) {
        return 302;
    }
    
    if ([bbmpin rangeOfString:@" "].location != NSNotFound) {
        return 301;
    }
    
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefABCDEF0123456789"] invertedSet];
    if ([bbmpin rangeOfCharacterFromSet:set].location != NSNotFound) {
        return 302;
    }
    return 0;
}

+ (BOOL) isAlphaNumeric:(NSString*)bbmPin
{
    NSCharacterSet *letterCharacterSet = [NSCharacterSet letterCharacterSet];
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
    NSString *test1 = [bbmPin stringByTrimmingCharactersInSet:letterCharacterSet];
    NSString *test2 = [test1 stringByTrimmingCharactersInSet:numberSet];
    
    return test1.length > 0 && [test2 isEqualToString:@""];
}

+(int) validateMobile: (NSString *)mobile{
    
    if (!mobile || mobile.length==0) {
        return 500;
    }
    
    if (mobile.length<10 || mobile.length>13) {
        return 501;
    }
    
    if ([mobile rangeOfString:@" "].location != NSNotFound) {
        return 502;
    }
    
    return 0;
}

+(int) validateName: (NSString *)name{
    
    if (!name || name.length==0) {
        return 900;
    }
    
    return 0;
}
+(int) validateImageWithData: (NSData *)data{
    if (!data || data.length==0) {
        return 1020;
    }
    
    return 0;
}

+(int) validateFirstName: (NSString *)name{
    if (!name || name.length==0) {
        return 900;
    }
    
    return 0;
}
+(int) validateLastName: (NSString *)name{
    
    if (!name || name.length==0) {
        return 904;
    }
    
    return 0;
}

+(int) validateAddress: (NSString *)name{
    if (!name || name.length==0) {
        return 905;
    }
    
    return 0;
}


+ (int)validateTermsAndCondition:(BOOL)status{
    if (!status) {
        return 80;
    }
    
    return 0;
}


+(int) validateEmail: (NSString *)email{
    
    if (!email || email.length==0) {
        return 400;
    }
    
    if ([email rangeOfString:@" "].location != NSNotFound) {
        return 401;
    }
    
    if ([email rangeOfString:@"@"].location == NSNotFound) {
        return 402;
    }
    
    NSArray *array = [email componentsSeparatedByString:@"@"];
    if ([array[1] rangeOfString:@"."].location == NSNotFound) {
        return 402;
    }
    NSArray *ar = [array[1] componentsSeparatedByString:@"."];
    if ([ar[0] length]==0 || [ar[1] length]==0) {
        return 402;
    }
    
//    if (![[ar lastObject] isEqualToString:@"edu"]) {
//        return 402;
//    }
//    
    
    int code = [self validateUsername: array[0]];
    if (code) {
        return 402;
    }
    

    
    return 0;
}

+(int) validateGender: (NSString *)gender{
    
    if (!gender || gender.length==0) {
        return 600;
    }
    return 0;
}

+(int) validateAge: (NSString *)age{
    
    if (!age || age.length==0) {
        return 700;
    }
    
    return 0;
}

+(int) validateCountry: (NSString *)country{
    
    if (!country || country.length==0) {
        return 800;
    }
    
    return 0;
}

+(int) validateCity: (NSString *)city{
    if (!city || city.length==0) {
        return 801;
    }
    
    return 0;

}
+(int) validateState: (NSString *)state{
    if (!state || state.length==0) {
        return 802;
    }
    
    return 0;

}

+(int) validateZipCode: (NSString *)zip{
    if (!zip || zip.length==0) {
        return 803;
    }
    
    return 0;
}

+(int)matchPassword: (NSString *)password1 withConfirmed: (NSString *)password2{
    
    if (!password1 || !password2 || ![password1 isEqualToString:password2]) {
        return 1000;
    }
    
    return 0;
}


+ (int)validateProfileImage:(NSString*)key{
    if (!key || key.length==0) {
        return 1200;
    }
    return 0;
}

+ (int)validateYear:(NSString*)year{
    
    if ([year integerValue] && [year integerValue]>0) {
        return 0;
    }
    
    return 1100;
}

+ (int)validateMake:(NSString*)make{
    
    if ([make length]>0 && ![make isEqualToString:@"Make"]) {
        return 0;
    }
    
    return 1101;
}

+ (int)validateModel:(NSString*)model{
    
    if ([model length]>0 && ![model isEqualToString:@"Model"]) {
        return 0;
    }
    
    return 1102;
}

+ (int)validateSchool: (NSString *)school{
    if ([school length]>0) {
        return 0;
    }
    
    return 1103;
}


//Credit card validation
+(int) validateCreditCardNumber: (NSString *)cardNo{
    
    if (cardNo.length ==0) {
        return 1300;
    }
    
    BOOL status = [CreditCardValidator isValidNumber:[cardNo stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    if (status) {
        return 0;
    }
    
    return 1301;
}

+(int) validateCvvNumber: (NSString *)cardNo{
    
    if (cardNo.length == 0) {
        return 1302;
    }
    
   
    if (cardNo.length==3) {
        return 0;
    }
    
    return 1303;
}

+ (int) validateExpDate: (NSString *)cardNo{
    if (cardNo.length ==0) {
        return 1304;
    }
    
    
    if (cardNo.length>0) {
        return 0;
    }
    
    return 1305;
}


#pragma mark - To check text field is empty

+ (int)isTextEmpty:(NSString *)str
{
    
    if (str==nil || [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
        return 90;
    
    return 0;
}

#pragma mark - Valid Email Address

+ (int)textIsValidEmailFormat:(NSString *)email
{
    
    BOOL stricterFilter = YES;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if (![emailTest evaluateWithObject:email]) {
        return 402;
    }
    return 0;
}

#pragma mark - String by removing White space charcter

+ (NSString *)removeWhiteSpaceInString:(NSString *)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


#pragma mark - Check Password is alphanumeric

+(BOOL)isAlphaNumericAndContainsAtLeastSixDigit :(NSString *)str{
    
    if (str.length >5 && str.length<17 && ([str rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound) && ( [str rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]].location != NSNotFound ||  [str rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound)) {
        
        return YES;
    }
    
    return NO;
}
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
+(BOOL)isAlphaBets :(NSString *)str
{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    
    if (([str rangeOfCharacterFromSet:cs].location == NSNotFound)) {
        
        return YES;
    }
    return NO;
}


#pragma mark - Validate phone number
+ (BOOL)validatePhoneNumber:(NSString *)mobileNumber
{
    if(mobileNumber.length > 0)
    {
        mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
        mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
        mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
        mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:mobileNumber];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if(mobileNumber.length == 10)
        {
            if (!valid) // Not numeric
            {
                return NO;
            }
            else
            {
                return YES;
            }
        }else
            return NO;
    }else
        return NO;
    
}

#pragma mark - Mobile Validation

+ (NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    NSInteger length = [mobileNumber length] ;
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    return mobileNumber;
}


+ (NSInteger)getLength:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSInteger length = [mobileNumber length];
    
    return length;
}


+ (BOOL)textField:(UITextField *)textField changeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if ([string isEqualToString:@"*"] || [string isEqualToString:@"+"] || [string isEqualToString:@"#"] || [string isEqualToString:@"."] || [string isEqualToString:@","] || [string isEqualToString:@";"]) {
        return NO;
    }
    
    NSInteger length = [MBValidator getLength:textField.text];
    
    //NSLog(@"Length  =  %d ",length);
    
    if(length == 10)
    {
        if(range.length == 0)
            return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSCharacterSet *charactersToRemove = [[ NSCharacterSet alphanumericCharacterSet ] invertedSet ];
    
    newString = [[newString componentsSeparatedByCharactersInSet:charactersToRemove]componentsJoinedByString:@""];
    
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                        options:0
                                                          range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0)
        return NO;
    
    if(length == 3)
    {
        NSString *num = [MBValidator formatNumber:textField.text];
        
        textField.text = [NSString stringWithFormat:@"(%@)",num];
        
        if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
    }
    else if(length == 6)
    {
        NSString *num = [MBValidator formatNumber:textField.text];
        //NSLog(@"%@",[num  substringToIndex:3]);
        //NSLog(@"%@",[num substringFromIndex:3]);
        textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
    }
    return YES;
    
    
}




@end
