//
//  CrowdDictionaryMostRecentViewController.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 27/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdDictionaryWebAPI.h"
#define MOST_RECENT_DEFINITIONS @"mostRecent"

@interface CrowdDictionaryMostRecentDefinitionsViewController : UITableViewController  <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray* mostRecentDefinitions;
@property (nonatomic) NSString* currentPage;
@end
