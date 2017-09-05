//
//  MBValidator.h
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBValidator : NSObject

+(int) code;

+(NSString *) messageForCode: (int)code;

+(int) validateImageWithData: (NSData *)data;
+(int) validateUsername: (NSString *)username;
+(int) validatePassword: (NSString *)password;
+(int) validateConfirmPassword: (NSString *)password;
+(int) validateEmail: (NSString *)email;
+(int) validateMobile: (NSString *)mobile;
+(int) validateGender: (NSString *)gender;
+(int) validateAge: (NSString *)age;
+(int) validateCountry: (NSString *)country;
+(int) validateCity: (NSString *)city;
+(int) validateState: (NSString *)state;
+(int) validateZipCode: (NSString *)zip;
+(int) validateName: (NSString *)name;
+(int) validateFirstName: (NSString *)name;
+(int) validateLastName: (NSString *)name;
+(int) validateAddress: (NSString *)name;


+(BOOL)isAlphaBets :(NSString *)str;
+ (int)validateTermsAndCondition:(BOOL)status;


+ (int)validateProfileImage:(NSString*)key;
+ (int)validateYear:(NSString*)year;
+ (int)validateMake:(NSString*)make;
+ (int)validateModel:(NSString*)Model;
+ (int)validateSchool: (NSString *)school;



+(int)matchPassword: (NSString *)password1 withConfirmed: (NSString *)password2;

+(int)isTextEmpty:(NSString *)str;

+(int) textIsValidEmailFormat:(NSString *)email;

+(NSString *)removeWhiteSpaceInString:(NSString *)str;

+(BOOL)isAlphaNumericAndContainsAtLeastSixDigit :(NSString *)str;

#pragma mark - Phone number validation
+ (BOOL)validatePhoneNumber:(NSString *)mobileNumber;

+ (NSString*)formatNumber:(NSString*)mobileNumber;

+ (NSInteger)getLength:(NSString*)mobileNumber;

+ (BOOL)textField:(UITextField *)textField changeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end
