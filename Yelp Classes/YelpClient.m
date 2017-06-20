//
//  YelpClient.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

//- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term andLocation:(NSString *)location success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
//    
//    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
//    NSDictionary *parameters = @{@"term": term, @"location" : @"San Francisco"};
//    NSLog(@"%@", parameters);
//    return [self GET:@"search" parameters:parameters success:success failure:failure];
//
//}

- (AFHTTPRequestOperation *)searchWithDictionary:(NSMutableDictionary *)dictionary success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    //[dictionary setObject:@"San Francisco" forKey:@"location"];
  //  [dictionary setObject:[NSNumber numberWithInt:self.offset] forKey:@"offset"];
    
    NSLog(@"%@", dictionary);
    
    
    return [self GET:@"search" parameters:dictionary success:success failure:failure];
}

- (AFHTTPRequestOperation *)searchWithbusinessId:(NSDictionary *)dictionary success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSLog(@"%@", dictionary);
    
    
    return [self GET:@"businesses" parameters:dictionary success:success failure:failure];
}




//- (AFHTTPRequestOperation *)searchWithCoordinates:(NSString *)coordinates success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
//    
//    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
//    NSDictionary *parameters = @{@"ll" : coordinates};
//    
//    return [self GET:@"search" parameters:parameters success:success failure:failure];
//}

//- (AFHTTPRequestOperation *)search:(NSMutableDictionary *)data success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//   // NSDictionary *parameters = @{@"term": term,@"ll": location, @"radius_filter":@"40000"};
//    
//    // [data setObject:[NSNumber numberWithInt:self.offset] forKey:@"offset"];
//    return [self GET:@"search" parameters:data success:success failure:failure];
//}

@end
