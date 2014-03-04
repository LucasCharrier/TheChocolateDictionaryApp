//
//  CrowdDictionaryMostPopularDefinitionViewController.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 27/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdDictionaryWebAPI.h"
#define MOST_POPULAR_DEFINITIONS @"mostPopularDefinitions"

@interface CrowdDictionaryMostPopularDefinitionViewController : UITableViewController  <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSDictionary* mostPopularDefinitions;

@end
