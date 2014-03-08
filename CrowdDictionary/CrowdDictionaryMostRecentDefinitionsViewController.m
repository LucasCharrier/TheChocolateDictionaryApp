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

@synthesize mostRecentDefinitions = _mostRecentDefinitions;
@synthesize currentPage = _currentPage;

- (NSString *)currentPage{
    if(!_currentPage){
        self.currentPage = @"2";
    }
    return _currentPage;
}

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("Crowd Dictionary downloader", NULL);
    /* multiphreading, we are creating a new phread in order to not blocked the application while we download the images */
    dispatch_async(downloadQueue, ^{
        NSArray* mostRecentDefinitions = [[NSUserDefaults standardUserDefaults] objectForKey:MOST_RECENT_DEFINITIONS];
        
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
    self.mostRecentDefinitions = [CrowdDictionaryWebAPI mostRecentDefinitionsOnPage:@"1"];
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
   
    
    NSDictionary* definition = [self.mostRecentDefinitions objectAtIndex:indexPath.row];
  
    // Configure the cell...
        cell.word.text =  [definition valueForKeyPath:@"Word.name"];
        cell.definition.text = [definition valueForKeyPath:@"Definition.definition"];
        cell.example.text = [definition valueForKeyPath:@"Definition.exemple"];
        cell.points.text = [definition valueForKeyPath:@"Definition.points"];
        cell.username.text = [definition valueForKeyPath:@"User.username"];
        cell.date.text = [definition valueForKeyPath:@"Definition.created"];
        cell.tags.text = @" ";
        for(NSArray* tag in [definition valueForKeyPath:@"DefinitionTag.Tag"]){
            cell.tags.text = [[cell.tags.text stringByAppendingString: [tag valueForKeyPath:@"name"]]stringByAppendingString:@" "];
        }
    
     
    
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    // NSLog(@"offset: %f", offset.y);
    // NSLog(@"content.height: %f", size.height);
    // NSLog(@"bounds.height: %f", bounds.size.height);
    // NSLog(@"inset.top: %f", inset.top);
    // NSLog(@"inset.bottom: %f", inset.bottom);
    // NSLog(@"pos: %f of %f", y, h);
    
    float reload_distance = 10;
    if(y > h + reload_distance) {
        NSLog(@"load more rows");
        NSArray* moreDefinition = [CrowdDictionaryWebAPI mostRecentDefinitionsOnPage:self.currentPage];
        if(moreDefinition){
            self.currentPage = [NSString stringWithFormat:@"%d", [self.currentPage intValue] + 1];
            self.mostRecentDefinitions = [self.mostRecentDefinitions arrayByAddingObjectsFromArray:moreDefinition];
            NSLog(@"%@",self.mostRecentDefinitions);
            [self.tableView reloadData];
        }

    }
}



@end
