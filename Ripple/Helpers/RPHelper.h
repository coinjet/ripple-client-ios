//
//  RPHelper.h
//  Divvy
//
//  Created by Kevin Johnson on 7/31/13.
//  Copyright (c) 2013 OpenCoin Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPHelper : NSObject

+(NSNumber*)safeNumberFromDictionary:(NSDictionary*)dic withKey:(NSString*)key;
+(NSDecimalNumber*)safeDecimalNumberFromDictionary:(NSDictionary*)dic withKey:(NSString*)key;
+(NSDecimalNumber*)dropsToDivvys:(NSDecimalNumber*)drops;
+(NSDecimalNumber*)divvysToDrops:(NSDecimalNumber*)divvys;

@end
