//
//  CrowdDictionaryDefinitionsForWordViewController.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 02/03/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdDictionaryWebAPI.h"
#define DEFITNITIONS_FOR_WORD @"DefinitionsForWord"

@interface CrowdDictionaryDefinitionsForWordViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
@property (nonatomic,strong) NSDictionary* definitionsForWord;

@property (strong, nonatomic) IBOutlet UISearchBar *searchWord;



@end
