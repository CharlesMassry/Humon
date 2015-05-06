//
//  Event.h
//  Humon
//
//  Created by Charlie Massry on 5/6/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Event : NSObject <MKAnnotation>

@property(copy, nonatomic) NSString *name;
@property(copy, nonatomic) NSString *address;
@property(strong, nonatomic) NSDate *startDate;
@property(strong, nonatomic) NSDate *endDate;

@property(copy, nonatomic)NSString *userID;
@property(copy, nonatomic)NSString *eventID;

@property(assign, nonatomic)CLLocationCoordinate2D coordinate;

+(NSArray *)eventsWithJSON:(NSArray *)JSON;
-(instancetype)initWithJSON:(NSDictionary *)JSON;
-(NSDictionary *)JSONDictionary;
@end
