//
//  UserSession.h
//  Humon
//
//  Created by Charlie Massry on 5/5/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject
+(NSString *)userID;
+(NSString *)userToken;
+(void)setUserID:(NSNumber *)userID;
+(void)setUserToken:(NSString *)userToken;
+(BOOL)userIsLoggedIn;
@end
