//
//  CrowdDictionaryDefinitionsForUserViewController.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 27/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryDefinitionsForUserViewController.h"
#import "CrowdDictionaryTableViewCell.h"

@interface CrowdDictionaryDefinitionsForUserViewController ()

@end

@implementation CrowdDictionaryDefinitionsForUserViewController

@synthesize definitionsForUser = _definitionsForUser;
@synthesize userID = _userID;

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("Crowd Dictionary downloader", NULL);
    /* multiphreading, we are creating a new phread in order to not blocked the application while we download the images */
    dispatch_async(downloadQueue, ^{
        NSDictionary* DefinitionsForUser = [[NSUserDefaults standardUserDefaults] objectForKey:DEFINTIONS_FOR_USER];
        
        NSLog(@"%@",DefinitionsForUser);
        dispatch_async(dispatch_get_main_queue(), ^{
            /* once we finished downloading the images we come back to the main thread to put these new photos */
            self.navigationItem.rightBarButtonItem = sender;
            self.definitionsForUser = DefinitionsForUser;
        });
    });
}


- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadMostPopularDefinition];
}

- (void)loadMostPopularDefinition{
    self.definitionsForUser = [CrowdDictionaryWebAPI definitionsForUser:self.userID];
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
    return [self.definitionsForUser count];
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
    static NSString *CellIdentifier = @"Definitions For User";
    CrowdDictionaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.word.text =  [self.definitionsForUser valueForKeyPath:@"Word.name"];
    cell.definition.text = [self.definitionsForUser valueForKeyPath:@"Definition.definition"];
    cell.example.text = [self.definitionsForUser valueForKeyPath:@"Definition.exemple"];
    cell.points.text = [self.definitionsForUser valueForKeyPath:@"Definition.points"];
    cell.username.text = [self.definitionsForUser valueForKeyPath:@"User.username"];
    cell.date.text = [self.definitionsForUser valueForKeyPath:@"Definition.created"];
    cell.tags.text = @" ";
    
    for(NSArray* tag in [self.definitionsForUser valueForKeyPath:@"DefinitionTag.Tag"]){
        cell.tags.text = [[cell.tags.text stringByAppendingString: [tag valueForKeyPath:@"name"]]stringByAppendingString:@" "];
    }
    
    return cell;
}

@end
