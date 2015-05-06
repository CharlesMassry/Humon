//
//  Event.m
//  Humon
//
//  Created by Charlie Massry on 5/6/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Event.h"
#import "NSDateFormatter+DefaultDateFormatter.h"
#import "UserSession.h"

@implementation Event
-(instancetype)initWithJSON:(NSDictionary *)JSON {
    self = [super init];

    if(self) {
        _name = JSON[@"name"];
        _address = JSON[@"address"];
        _startDate = [[NSDateFormatter RFC3339DateFormatter] dateFromString:JSON[@"started_at"]];
        _endDate = [[NSDateFormatter RFC3339DateFormatter] dateFromString:JSON[@"ended_at"]];
        
        double lat = [JSON[@"lat"] doubleValue];
        double lon = [JSON[@"lon"] doubleValue];
        _coordinate = CLLocationCoordinate2DMake(lat, lon);
        _userID = [NSString stringWithFormat:@"%@", JSON[@"owner"][@"id"]];
        _eventID = [NSString stringWithFormat:@"%@", JSON[@"id"]];
        
    }
    
    return self;
}

+(NSArray *)eventsWithJSON:(NSArray *)JSON {
    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    for (NSDictionary *eventJSON in JSON) {
        Event *event = [[Event alloc] initWithJSON:eventJSON];
        [events addObject:event];
    }
    
    return [events copy];
}

-(NSDictionary *)JSONDictionary {
    NSMutableDictionary *JSONDictionary = [[NSMutableDictionary alloc] init];
    [JSONDictionary setObject:self.address
                       forKey:@"address"];
    [JSONDictionary setObject:self.name
                       forKey:@"name"];

    [JSONDictionary setObject:@(self.coordinate.latitude)
                       forKey:@"lat"];
    [JSONDictionary setObject:@(self.coordinate.longitude)
                       forKey:@"lon"];
    
    NSString *start = [[NSDateFormatter RFC3339DateFormatter] stringFromDate:self.startDate];
    NSString *end = [[NSDateFormatter RFC3339DateFormatter] stringFromDate:self.endDate];
    
    [JSONDictionary setObject:start
                       forKey:@"started_at"];
    [JSONDictionary setObject:end
                       forKey:@"ended_at"];
    
    NSDictionary *user = @{@"device_token" : [UserSession userID]};
    [JSONDictionary setObject:user
                       forKey:@"user"];
    
    return JSONDictionary;
}

@end
