/**
 @author RVI
 
 @section Licence
 Copyright 2012 Rémy Virin. All rights reserved.
 
 @section Description
 NSDictionary category for parsing
 */

#import "NSDictionary+SKParsing.h"

@implementation NSDictionary (SKParsing)

/**
 * This method is used to get the object of name inKey ONLY if it is a string
 * This method does a type checking and returns nil if the type is not a NSString
 * @param inKey is the key of the object in the dictionary
 * @return nil if the key was not found or was not a NSString, the NSString associated to inKey key otherwise
 */

- (NSString *)getStringValue:(NSString *)inKey
{
    NSString * result = nil;
    id value = nil;
    
    if (inKey != nil) {
        value = [self objectForKey:inKey];
        if (value && [value isKindOfClass:[NSString class]]) {
            result = (NSString *)value;
        }
    }
    return result;
}

/**
 * This method is used to get the object in NSDate of inKey ONLY if it is a string
 * This method does a type checking and returns nil if the type is not a NSString
 * @param inKey is the key of the object in the dictionary
 * @return nil if the key was not found or was not a NSString, the NSString associated to inKey key otherwise
 */

- (NSDate *)getDateValue:(NSString *)inKey
{
    NSDate * result = nil;
    id value = nil;
    
    if (inKey != nil) {
        value = [self objectForKey:inKey];
        if (value && [value isKindOfClass:[NSString class]]) {
            
            result = nil; //[NSDate dateFromStringUTC:value];
        }
    }
    return  result;
}


/**
 * This method is used to get the object of name inKey ONLY if it is a string.
 * This method does a type checking and returns nil if the type is not a NSNumber.
 * @param inKey is the key of the object in the dictionary
 * @return nil if the key was not found or was not a NSNumber, the NSDecimalNumber associated to inKey key otherwise
 */

- (NSDecimalNumber *)getDecimalNumberValue:(NSString *)inKey
{
    NSDecimalNumber * result = nil;
    id value;
    
    if (inKey != nil) {
        value = [self objectForKey:inKey];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            result = [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
        }
    }
    return result;
}


/**
 * This method is used to get the BOOL value of name inKey ONLY if it is a number.
 * This method does a type checking and returns inDefaultValue if the type is not a NSNumber.
 * @param inKey is the key of the object in the dictionary
 * @param inDefaultValue is the value that is returned if the inKey object is not found or with a wrong type
 * @return inDefaultValue if the key was not found or was not a NSNumber, the BOOL value associated to inKey key otherwise
 */

- (BOOL)getBoolValue:(NSString *)inKey withDefaultValue:(BOOL)inDefaultValue
{
    NSNumber * value = nil;
    BOOL result = inDefaultValue;
    
    if (inKey != nil) {
        value = [self objectForKey:inKey];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            result = [value boolValue];
        }
    }
    return result;
}


@end
