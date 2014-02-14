//
//  CrowdDictionaryWebAPI.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 13/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryWebAPI.h"


#define kStrikeIronUserID   @"yourstrikeironuserid@youremail.com"
#define kStrikeIronPassword @"yourstrikeironpassword"

@implementation CrowdDictionaryWebAPI


/*
 we need to make sure that if we already have an outstanding API call, we cancel it.
 The connection is stored in the variable "currentConnection."
 */
- (void) cancelConnection{
    if(currentConnection)
    {
        [currentConnection cancel];
        currentConnection = nil;
        self.apiReturnJSonData = nil;
    }
}

- (IBAction) moreRecentDefinition{
    
    NSString *restCallString = [NSString stringWithFormat:@"http://ws.strikeiron.com/StrikeIron/EMV6Hygiene/VerifyEmail?LicenseInfo.RegisteredUser.UserID=%@;LicenseInfo.RegisteredUser.Password=%@;VerifyEmail.Email;VerifyEmail.Timeout=30", kStrikeIronUserID, kStrikeIronPassword ];
    NSURL *restURL = [NSURL URLWithString:restCallString];
    NSURLRequest *restRequest = [NSURLRequest requestWithURL:restURL];
    [self cancelConnection];
    currentConnection = [[NSURLConnection alloc] initWithRequest:restRequest delegate:self];
    // If the connection was successful, create the XML that will be returned.
    self.apiReturnJSonData = [NSMutableData data];
}

/* 
 didReceiveResponse is called when there is return data. It may be called multiple times for a connection and you should reset the data if it is
 */

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    [self.apiReturnJSonData setLength:0];
}


/*
 didReceiveData is called when some or all of the data from the API call is returned. We will append the data to the apiReturnXMLData instance variable.
 */

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    [self.apiReturnJSonData appendData:data];
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
