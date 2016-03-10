//
//  FISGithubRepositorySpec.m
//  github-repo-list
//
//  Created by Joe Burgess on 5/6/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import <Expecta.h>
#import "FISGithubRepository.h"


SpecBegin(FISGithubRepository)

describe(@"FISGithubRepository", ^{
    describe(@"initWithDictionary", ^{
        __block NSDictionary *repoDictionary;
        __block NSURL *correctURL;
        __block NSString *correctFullName;
        __block NSString *correctRepositoryID;
        beforeAll(^{
            repoDictionary = @{@"html_url":@"https://github.com",
                               @"full_name":@"test/test",
                               @"id":@2};
            correctURL = [NSURL URLWithString:repoDictionary[@"html_url"]];
            correctFullName = repoDictionary[@"full_name"];
            correctRepositoryID = [repoDictionary[@"id"] stringValue];
        });

        it(@"Should return the correct data", ^{
            FISGithubRepository *repo = [[FISGithubRepository alloc] initWithDictionary:repoDictionary];

            expect(repo.htmlURL).to.equal(correctURL);
            expect(repo.repositoryID).to.equal(correctRepositoryID);
            expect(repo.fullName).to.equal(correctFullName);
        });

    });

});

SpecEnd
