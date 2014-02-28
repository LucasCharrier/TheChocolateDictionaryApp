//
//  CrowdDictionaryWebAPI.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 13/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryWebAPI.h"

@implementation CrowdDictionaryWebAPI

+ (NSDictionary *)executeCrowdDictionaryFetch:(NSString *)query
{
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    // NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    return results;
}

+ (NSArray *)mostPopularDefinitions
{
    NSString *request = [NSString stringWithFormat:@"http://www.thechocolatedictionary.com/definitions/mostPopularDefinitions.json"];
    NSDictionary *tmp = [self executeCrowdDictionaryFetch:request];
    NSLog(@"ici le contenu %@",[tmp valueForKeyPath:@"definitions.Definition"]);
    return [tmp valueForKeyPath:@"definitions.Definition"];
}

+ (NSDictionary *)randomSearch
{
    NSString *request = [NSString stringWithFormat:@"http://www.thechocolatedictionary.com/definitions/randomSearch.json"];
    NSDictionary *tmp = [self executeCrowdDictionaryFetch:request];
    NSLog(@"ici le contenu %@",[tmp valueForKeyPath:@"definition"]);
    return [tmp valueForKeyPath:@"definition"];
    
}


+ (NSArray *)definitionsForUser:(NSString *)userID
{
    NSArray *definitions = nil;
    //NSString *userID = [userID objectForKey:CROWD_DICTIONARY_USER_ID];
    if (userID) {
        NSString *request = [NSString stringWithFormat:@"http://www.thechocolatedictionary.com/user/users/show/%@", userID];
        definitions = [[self executeCrowdDictionaryFetch:request] valueForKeyPath:@"definitions.definition"];
        for (NSMutableDictionary *definition in definitions) {
            [definition setObject:userID forKey:CROWD_DICTIONARY_USER_ID];
        }
    }
    return definitions;
}

+ (NSArray *)definitionsForWord:(NSString *)wordID
{
    NSArray *definitions = nil;
    //NSString *wordID = [word objectForKey:CROWD_DICTIONARY_WORD_ID];
    if (wordID) {
        NSString *request = [NSString stringWithFormat:@"http://www.thechocolatedictionary.com/words/show/%@", wordID];
        definitions = [[self executeCrowdDictionaryFetch:request] valueForKeyPath:@"definitions.definition"];
        for (NSMutableDictionary *definition in definitions) {
            [definition setObject:wordID forKey:CROWD_DICTIONARY_WORD_ID];
        }
    }
    return definitions;
}

+ (NSArray *)lastDefinitions
{
    NSArray *definitions = nil;
    NSString *request = [NSString stringWithFormat:@"http://www.thechocolatedictionary.com/definitions/lastDefinitions"];
    definitions = [[self executeCrowdDictionaryFetch:request] valueForKeyPath:@"definitions.definition"];
    for (NSMutableDictionary *definition in definitions) {
        
    }
    return definitions;
}


/*
 we need to make sure that if we already have an outstanding API call, we cancel it.
 The connection is stored in the variable "currentConnection."
 */
- (void) cancelConnection{
    if(currentConnection)
    {
        [currentConnection cancel];
        currentConnection = nil;
        self.apiReturnJsonData = nil;
    }
}


/* 
 didReceiveResponse is called when there is return data. It may be called multiple times for a connection and you should reset the data if it is
 */

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    [self.apiReturnJsonData setLength:0];
}


/*
 didReceiveData is called when some or all of the data from the API call is returned. We will append the data to the apiReturnXMLData instance variable.
 */

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    [self.apiReturnJsonData appendData:data];
}

/*
 didFailWithError is called when there is a terminal error. There will be no other method calls on this connection if it is received. In this case, we are just going to log the error.
*/

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
    NSLog(@"URL Connection Failed!");
    currentConnection = nil;
}
/*
 connectionDidFinishLoading method is called when the call is complete and all data has been received. We will parse the return data from this method. For now, just create the empty method.
 */

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    currentConnection = nil;
}
@end
