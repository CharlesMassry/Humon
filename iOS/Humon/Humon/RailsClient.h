//
//  RailsClient.h
//  Humon
//
//  Created by Charlie Massry on 5/5/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RailsClientErrorCompletionBlock)(NSError *error);

@interface RailsClient : NSObject
+(instancetype)sharedClient;
-(void)createCurrentUserWithCompletionBlock:(RailsClientErrorCompletionBlock)block;
@end
