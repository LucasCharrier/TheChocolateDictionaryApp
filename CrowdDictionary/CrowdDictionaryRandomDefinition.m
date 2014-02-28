//
//  CrowdDictionaryRandomDefinition.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 17/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryRandomDefinition.h"
#import "CrowdDictionaryTableViewCell.h"

@implementation CrowdDictionaryRandomDefinition 

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("Crowd Dictionary downloader", NULL);
    /* multiphreading, we are creating a new phread in order to not blocked the application while we download the images */
    dispatch_async(downloadQueue, ^{
        NSDictionary* randomDefinition = [[NSUserDefaults standardUserDefaults] objectForKey:RANDOM_DEFINITION];
        
        NSLog(@"%@",randomDefinition);
        dispatch_async(dispatch_get_main_queue(), ^{
            /* once we finished downloading the images we come back to the main thread to put these new photos */
            self.navigationItem.rightBarButtonItem = sender;
            self.randomDefinition = randomDefinition;
        });
    });
}


- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadRandomDefinition];
}

- (void)loadRandomDefinition{
    self.randomDefinition = [CrowdDictionaryWebAPI randomSearch];
    NSLog(@"%@",self.randomDefinition);
    NSLog(@"%@",[self.randomDefinition valueForKey:@"Word"]);
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Random";
    CrowdDictionaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.word.text =  [self.randomDefinition valueForKeyPath:@"Word.name"];
    cell.definition.text = [self.randomDefinition valueForKeyPath:@"Definition.definition"];
    cell.example.text = [self.randomDefinition valueForKeyPath:@"Definition.exemple"];
    cell.points.text = [self.randomDefinition valueForKeyPath:@"Definition.points"];
    cell.username.text = [self.randomDefinition valueForKeyPath:@"User.username"];
    cell.date.text = [self.randomDefinition valueForKeyPath:@"Definition.created"];
    //cell.tags.text = [self.randomDefinition valueForKeyPath:@"DefinitionTag.Tag.name"];
    
    return cell;
}


@end
