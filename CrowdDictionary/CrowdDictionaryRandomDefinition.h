//
//  CrowdDictionaryRandomDefinition.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 17/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrowdDictionaryWebAPI.h"
#define RANDOM_DEFINITION @"random"

@interface CrowdDictionaryRandomDefinition : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSDictionary* randomDefinition;
@end
