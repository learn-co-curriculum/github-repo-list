//
//  FISGithubAPIClient.m
//  github-repo-list
//
//  Created by Joe Burgess on 5/5/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISGithubAPIClient.h"
#import "FISConstants.h"
#import <AFNetworking.h>

@implementation FISGithubAPIClient
NSString *const GITHUB_API_URL=@"https://api.github.com";

+(void)getRepositoriesWithCompletion:(void (^)(NSArray *))completionBlock
{
    // create a string to turn into a URL
    NSString *urlString = [NSString stringWithFormat:@"%@/repositories?client_id=%@&client_secret=%@",GITHUB_API_URL,GITHUB_CLIENT_ID,GITHUB_CLIENT_SECRET];
    NSURL *thisURL = [NSURL URLWithString:urlString];
    
    // create a session
    NSURLSession *thisSession = [NSURLSession sharedSession];
    
    // create NSURLSessionDataTask using thisSession
    NSURLSessionDataTask *thisTask = [thisSession dataTaskWithURL:thisURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSArray *responseArrayOfDictionaries = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        completionBlock(responseArrayOfDictionaries);
    }];
    
    [thisTask resume];
}

@end
