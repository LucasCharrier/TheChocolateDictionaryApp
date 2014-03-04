//
//  CrowdDictionaryMostPopularDefinitionViewController.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 27/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryMostPopularDefinitionViewController.h"
#import "CrowdDictionaryTableViewCell.h"

@interface CrowdDictionaryMostPopularDefinitionViewController ()

@end

@implementation CrowdDictionaryMostPopularDefinitionViewController
@synthesize mostPopularDefinitions;

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("Crowd Dictionary downloader", NULL);
    /* multiphreading, we are creating a new phread in order to not blocked the application while we download the images */
    dispatch_async(downloadQueue, ^{
        NSDictionary* mostPopularDefinitions = [[NSUserDefaults standardUserDefaults] objectForKey:MOST_POPULAR_DEFINITIONS];
        
        NSLog(@"%@",mostPopularDefinitions);
        dispatch_async(dispatch_get_main_queue(), ^{
            /* once we finished downloading the images we come back to the main thread to put these new photos */
            self.navigationItem.rightBarButtonItem = sender;
            self.mostPopularDefinitions = mostPopularDefinitions;
        });
    });
}


- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadMostPopularDefinition];
}

- (void)loadMostPopularDefinition{
    self.mostPopularDefinitions = [CrowdDictionaryWebAPI mostPopularDefinitions];
    NSLog(@"kikou : %@",self.mostPopularDefinitions );
    
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
    return [self.mostPopularDefinitions count];
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
    static NSString *CellIdentifier = @"Most Popular Definitions";
    CrowdDictionaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //NSLog(@"%@",self.mostPopularDefinitions);
    
     // Configure the cell...
     cell.word.text =  [self.mostPopularDefinitions valueForKeyPath:@"Word.name"];
     cell.definition.text = [self.mostPopularDefinitions valueForKeyPath:@"Definition.definition"];
     cell.example.text = [self.mostPopularDefinitions valueForKeyPath:@"Definition.exemple"];
     cell.points.text = [self.mostPopularDefinitions valueForKeyPath:@"Definition.points"];
     cell.username.text = [self.mostPopularDefinitions valueForKeyPath:@"User.username"];
     cell.date.text = [self.mostPopularDefinitions valueForKeyPath:@"Definition.created"];
     cell.tags.text = @" ";
    
     for(NSArray* tag in [self.mostPopularDefinitions valueForKeyPath:@"DefinitionTag.Tag"]){
         cell.tags.text = [[cell.tags.text stringByAppendingString: [tag valueForKeyPath:@"name"]]stringByAppendingString:@" "];
     }
    

    
    
    return cell;
}



@end
