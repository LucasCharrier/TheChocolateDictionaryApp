//
//  CrowdDictionaryWebAPI.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 13/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CROWD_DICTIONARY_WORD @"word"
#define CROWD_DICTIONARY_WORD_ID @"word_id"
#define CROWD_DICTIONARY_DESCRIPTION @"description"
#define CROWD_DICTIONARY_USER @"user"
#define CROWD_DICTIONARY_USER_ID @"user_id"
#define CROWD_DICTIONARY_TAGS @"tags"

@protocol CrowdDictionaryWebAPIDelegate;

@interface CrowdDictionaryWebAPI : NSObject <NSURLConnectionDelegate>
{
    NSURLConnection *currentConnection;
}
@property (retain, nonatomic) NSMutableData *apiReturnJsonData;
@property (strong, nonatomic) NSString *word;
@property (strong, nonatomic) NSString *word_id;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *user_username;
@property (strong, nonatomic) NSString *tags;
+ (NSArray *)mostPopularDefinitionsOnPage:(NSString*)pageNumber;
+ (NSArray *)mostRecentDefinitionsOnPage:(NSString*)pageNumber;
+ (NSDictionary *)definitionsForUser:(NSString *)userID;
+ (NSDictionary *)definitionsForWord:(NSString *)wordID;
+ (NSDictionary *)randomSearch;

@property (weak, nonatomic) id<CrowdDictionaryWebAPIDelegate> delegate;

@end
