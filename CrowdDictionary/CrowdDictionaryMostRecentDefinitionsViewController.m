//
//  CrowdDictionaryMostRecentViewController.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 27/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryMostRecentDefinitionsViewController.h"
#import "CrowdDictionaryTableViewCell.h"

@interface CrowdDictionaryMostRecentDefinitionsViewController ()

@end

@implementation CrowdDictionaryMostRecentDefinitionsViewController

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("Crowd Dictionary downloader", NULL);
    /* multiphreading, we are creating a new phread in order to not blocked the application while we download the images */
    dispatch_async(downloadQueue, ^{
        NSDictionary* mostRecentDefinitions = [[NSUserDefaults standardUserDefaults] objectForKey:MOST_RECENT_DEFINITIONS];
        
        NSLog(@"%@",mostRecentDefinitions);
        dispatch_async(dispatch_get_main_queue(), ^{
            /* once we finished downloading the images we come back to the main thread to put these new photos */
            self.navigationItem.rightBarButtonItem = sender;
            self.mostRecentDefinitions = mostRecentDefinitions;
        });
    });
}


- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadMostRecentDefinition];
}

- (void)loadMostRecentDefinition{
    self.mostRecentDefinitions = [CrowdDictionaryWebAPI mostRecentDefinitions];
    NSLog(@"kikou : %@",self.mostRecentDefinitions );
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.mostRecentDefinitions count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 380;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Most Recent Definitions";
    CrowdDictionaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //NSLog(@"%@",self.mostRecentDefinitions);
    /*
    // Configure the cell...
        cell.word.text =  [self.mostRecentDefinitions valueForKeyPath:@"Word.name"];
        cell.definition.text = [self.mostRecentDefinitions valueForKeyPath:@"Definition.definition"];
        cell.example.text = [self.mostRecentDefinitions valueForKeyPath:@"Definition.exemple"];
        cell.points.text = [self.mostRecentDefinitions valueForKeyPath:@"Definition.points"];
        cell.username.text = [self.mostRecentDefinitions valueForKeyPath:@"User.username"];
        cell.date.text = [self.mostRecentDefinitions valueForKeyPath:@"Definition.created"];
        cell.tags.text = @" ";
        for(NSArray* tag in [self.mostRecentDefinitions valueForKeyPath:@"DefinitionTag.Tag"]){
            cell.tags.text = [[cell.tags.text stringByAppendingString: [tag valueForKeyPath:@"name"]]stringByAppendingString:@" "];
        }
    }
     */
    
    
    return cell;
}



@end
