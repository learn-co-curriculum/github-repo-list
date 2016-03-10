//
//  FISReposDataStoreSpec.m
//  github-repo-list
//
//  Created by Joe Burgess on 5/6/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#import "FISReposDataStore.h"
#define EXP_SHORTHAND
#import <Expecta.h>
#import <OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import "FISGithubRepository.h"


SpecBegin(FISReposDataStore)

describe(@"FISReposDataStore", ^{
    
    beforeAll(^{
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.host isEqualToString:@"api.github.com"] && [request.URL.path isEqualToString:@"/repositories"];
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"repositories.json", [NSBundle mainBundle]) statusCode:200 headers:@{@"Content-Type": @"application/json"}];
        }];
    });

    describe(@"sharedDataStore", ^{
        it(@"Should have a sharedDataStore class method", ^{
            expect([FISReposDataStore class]).to.respondTo(@selector(sharedDataStore));
        });
        
        it(@"Should be a singleton", ^{
            expect([FISReposDataStore sharedDataStore]).to.beIdenticalTo([FISReposDataStore sharedDataStore]);
        });
    });

    describe(@"getRepositories Method", ^{
        it(@"Should Get The Correct Repositories", ^{
            waitUntil(^(DoneCallback done) {
                FISReposDataStore *dataStore = [[FISReposDataStore alloc] init];
                
                [dataStore getRepositoriesWithCompletion:^{
                    expect([dataStore.repositories count]).to.equal(2);

                    FISGithubRepository *repo1 = dataStore.repositories[0];
                    expect(repo1.repositoryID).to.equal(@"1");
                    expect(repo1.fullName).to.equal(@"mojombo/grit");
                    expect(repo1.htmlURL).to.equal([NSURL URLWithString:@"https://github.com/mojombo/grit"]);

                    FISGithubRepository *repo2 = dataStore.repositories[1];
                    expect(repo2.repositoryID).to.equal(@"26");
                    expect(repo2.fullName).to.equal(@"wycats/merb-core");
                    expect(repo2.htmlURL).to.equal([NSURL URLWithString:@"https://github.com/wycats/merb-core"]);

                    done();
                }];
            });
        });
    });
    
});

SpecEnd
