//
//  UserSession.m
//  Humon
//
//  Created by Charlie Massry on 5/5/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "UserSession.h"
#import <SSKeychain/SSKeychain.h>

static NSString *const Service = @"Humon";
static NSString *const UserID = @"currentUserID";
static NSString *const UserToken = @"currentUserToken";

@implementation UserSession

+(NSString *)userID {
    NSString *userID = [SSKeychain passwordForService:Service
                                              account:UserID];
    return userID;
}

+(NSString *)userToken {
    NSString *userToken = [SSKeychain passwordForService:Service
                                                 account:UserToken];
    return userToken;
}

+(void)setUserID:(NSNumber *)userID {
    if (!userID) {
        [SSKeychain deletePasswordForService:Service
                                     account:UserID];
        return;
    }
    
    NSString *IDString = [NSString stringWithFormat:@"%@", userID];
    [SSKeychain setPassword:IDString
                 forService:Service
                    account:UserID];
}

+(void)setUserToken:(NSString *)userToken {
    if (!userToken) {
        [SSKeychain deletePasswordForService:Service
                                     account:UserToken];
        return;
    }
    
    [SSKeychain setPassword:userToken
                 forService:Service
                    account:UserToken
                      error:nil];
}

+(BOOL)userIsLoggedIn {
    BOOL hasUserID = [self userID] ? YES : NO;
    BOOL hasUserToken = [self userToken] ? YES : NO;
    
    return hasUserID && hasUserToken;
}

@end
