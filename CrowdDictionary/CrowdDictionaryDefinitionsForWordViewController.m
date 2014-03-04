//
//  CrowdDictionaryDefinitionsForWordViewController.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 02/03/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryDefinitionsForWordViewController.h"
#import "CrowdDictionaryTableViewCell.h"

@interface CrowdDictionaryDefinitionsForWordViewController ()

@end

@implementation CrowdDictionaryDefinitionsForWordViewController


@synthesize definitionsForWord = _definitionsForWord;
@synthesize searchWord = _searchWord;

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("Crowd Dictionary downloader", NULL);
    /* multiphreading, we are creating a new phread in order to not blocked the application while we download the images */
    dispatch_async(downloadQueue, ^{
        NSDictionary* definitionsForWord = [[NSUserDefaults standardUserDefaults] objectForKey:DEFITNITIONS_FOR_WORD];
        
        NSLog(@"%@",definitionsForWord);
        dispatch_async(dispatch_get_main_queue(), ^{
            /* once we finished downloading the images we come back to the main thread to put these new photos */
            self.navigationItem.rightBarButtonItem = sender;
            self.definitionsForWord = definitionsForWord;
        });
    });
}


- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadDefinitionsForWord];
    
}

- (void)loadDefinitionsForWord{
    self.definitionsForWord = [CrowdDictionaryWebAPI definitionsForWord:self.searchWord.text];
    NSLog(@"kikou : %@",self.definitionsForWord );
    
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
    return [self.definitionsForWord count];
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
    static NSString *CellIdentifier = @"Definitions For Word";
    CrowdDictionaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //NSLog(@"%@",self.definitionsForWord);
    
    // Configure the cell...
    cell.word.text =  [self.definitionsForWord valueForKeyPath:@"Word.name"];
    cell.definition.text = [self.definitionsForWord valueForKeyPath:@"Definition.definition"];
    cell.example.text = [self.definitionsForWord valueForKeyPath:@"Definition.exemple"];
    cell.points.text = [self.definitionsForWord valueForKeyPath:@"Definition.points"];
    cell.username.text = [self.definitionsForWord valueForKeyPath:@"User.username"];
    cell.date.text = [self.definitionsForWord valueForKeyPath:@"Definition.created"];
    cell.tags.text = @" ";
    
    for(NSArray* tag in [self.definitionsForWord valueForKeyPath:@"DefinitionTag.Tag"]){
        cell.tags.text = [[cell.tags.text stringByAppendingString: [tag valueForKeyPath:@"name"]]stringByAppendingString:@" "];
    }
    
    return cell;
}

@end
