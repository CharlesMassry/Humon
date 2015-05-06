//
//  RailsClient.m
//  Humon
//
//  Created by Charlie Massry on 5/5/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#if DEBUG
#define ROOT_URL @"http://localhost:3000/v1/"
#else
#define ROOT_URL @"localhost/"
#endif

#import "RailsClient.h"
#import "UserSession.h"

static NSString *const AppSecret =  @"SECRET_API_KEY";

@interface RailsClient ()
@property (strong, nonatomic) NSURLSession *session;
@end

@implementation RailsClient

+(instancetype)sharedClient {
    static RailsClient *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[RailsClient alloc] init];
    });
    return _sharedClient;
}

-(instancetype)init {
    self = [super init];
    if(self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 30.0;
        sessionConfiguration.timeoutIntervalForResource = 30.0;
        
        NSDictionary *headers = [UserSession userIsLoggedIn] ? @{
                                                      @"Accept" : @"application/json",
                                                @"Content-Type" : @"application/json",
                                             @"tb-device-token" : [[NSUUID UUID] UUIDString],
                                             @"tb-app-secret"   : AppSecret
                                                      } :
                                                              @{
                                                      @"Accept" : @"application/json",
                                                @"Content-Type" : @"application/json",
                                             @"tb-device-token" : [[NSUUID UUID] UUIDString],
                                               @"tb-app-secret" : AppSecret
                                                      };

        [sessionConfiguration setHTTPAdditionalHeaders:headers];
        
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    
    return self;
}

-(void)createCurrentUserWithCompletionBlock:(RailsClientErrorCompletionBlock)block {
    NSString *urlString = [NSString stringWithFormat:@"%@users", ROOT_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionTask *task = [self.session dataTaskWithRequest:request
                                             completionHandler:^void(NSData *data, NSURLResponse *response, NSError *error){
                                                 if (!error) {
                                                     NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                        options:kNilOptions
                                                                                                                          error:nil];
                                                     [UserSession setUserToken:responseDictionary[@"device_token"]];
                                                     [UserSession setUserID:responseDictionary[@"user_id"]];
                                                     
                                                     NSURLSessionConfiguration *newConfiguration = self.session.configuration;
                                                     [newConfiguration setHTTPAdditionalHeaders:@{
                                                                                                   @"Accept" : @"application/json",
                                                                                                   @"Content-Type" : @"application/json",
                                                                                                   @"tb-device-token" : responseDictionary[@"device_token"]
                                                                                                   }];
                                                     [self.session finishTasksAndInvalidate];
                                                     self.session = [NSURLSession sessionWithConfiguration:newConfiguration];
                                                 }
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     block(error);
                                                 });
                                             }];
    
    [task resume];
}

@end
