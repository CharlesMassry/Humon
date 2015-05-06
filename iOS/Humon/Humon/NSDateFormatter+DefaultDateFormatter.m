//
//  NSDateFormatter+DefaultDateFormatter.m
//  Humon
//
//  Created by Charlie Massry on 5/6/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "NSDateFormatter+DefaultDateFormatter.h"

@implementation NSDateFormatter (DefaultDateFormatter)
+(instancetype)RFC3339DateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    return dateFormatter;
}
@end
