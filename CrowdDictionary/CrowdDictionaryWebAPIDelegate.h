//
//  CrowdDictionaryWebAPIDelegate.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 17/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CrowdDictionaryWebAPIDelegate <NSObject>
    - (void)receivedGroupsJSON:(NSData *)objectNotation;
    - (void)fetchingGroupsFailedWithError:(NSError *)error;
@end
