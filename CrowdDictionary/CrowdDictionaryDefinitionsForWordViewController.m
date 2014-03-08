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
    self.searchWord.delegate = self;
    NSLog(@"awakeFromNib");
    
}

- (void)loadDefinitionsForWord{
    self.definitionsForWord = [CrowdDictionaryWebAPI definitionsForWord:self.searchWord.text];
    NSLog(@"kikou : %@",self.definitionsForWord );
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [self.definitionsForWord count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if(section == 1)
        return [[self.definitionsForWord valueForKey:@"tags"] count];
    else
        return [[self.definitionsForWord valueForKey:@"words"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 380;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Definitions For Word";
    CrowdDictionaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray* definition = nil;
    
    if(indexPath.row < [[self.definitionsForWord valueForKey:@"tags"] count] ){
        definition = [[self.definitionsForWord valueForKey:@"tags"] objectAtIndex:indexPath.row];
    }else{
        definition = [[self.definitionsForWord valueForKey:@"words"] objectAtIndex:indexPath.row];
    }
    //NSLog(@"%@",self.definitionsForWord);
    
    // Configure the cell...
    NSLog(@"the defintiion %@",definition);
   // cell.word.text =  [definition valueForKeyPath:@"Word.name"];
    cell.definition.text = [definition valueForKeyPath:@"Definition.definition"];
    cell.example.text = [definition valueForKeyPath:@"Definition.exemple"];
    cell.points.text = [definition valueForKeyPath:@"Definition.points"];
    cell.username.text = [definition valueForKeyPath:@"User.username"];
    cell.date.text = [definition valueForKeyPath:@"Definition.created"];
    cell.tags.text = @" ";
    
    for(NSArray* tag in [self.definitionsForWord valueForKeyPath:@"DefinitionTag.Tag"]){
        cell.tags.text = [[cell.tags.text stringByAppendingString: [tag valueForKeyPath:@"name"]]stringByAppendingString:@" "];
    }
    
    return cell;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
    [searchBar resignFirstResponder];
    self.definitionsForWord = [CrowdDictionaryWebAPI definitionsForWord:searchBar.text];
     NSLog(@"searchBarSearchButtonClicked%@",self.definitionsForWord);
    [self.tableView reloadData];
}




@end
