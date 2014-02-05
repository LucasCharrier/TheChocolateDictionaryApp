//
//  CrowdDictionaryMasterViewController.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 04/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CrowdDictionaryDetailViewController;

@interface CrowdDictionaryMasterViewController : UITableViewController

@property (strong, nonatomic) CrowdDictionaryDetailViewController *detailViewController;

@end
