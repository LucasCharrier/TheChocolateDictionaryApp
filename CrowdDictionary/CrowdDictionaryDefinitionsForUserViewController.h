//
//  CrowdDictionaryDefinitionsForUserViewController.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 27/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdDictionaryWebAPI.h"
#define DEFINTIONS_FOR_USER @"DefinitionsForUser"

@interface CrowdDictionaryDefinitionsForUserViewController : UITableViewController  <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSDictionary* definitionsForUser;
@property (nonatomic) NSString* userID;

@end
