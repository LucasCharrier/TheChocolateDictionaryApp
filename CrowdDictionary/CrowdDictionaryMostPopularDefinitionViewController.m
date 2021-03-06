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
@synthesize mostPopularDefinitions = _mostPopularDefinitions;


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
        NSArray* mostPopularDefinitions = [[NSUserDefaults standardUserDefaults] objectForKey:MOST_POPULAR_DEFINITIONS];

        dispatch_async(dispatch_get_main_queue(), ^{
            /* once we finished downloading the images we come back to the main thread to put these new photos */
            self.navigationItem.rightBarButtonItem = sender;
            self.mostPopularDefinitions = mostPopularDefinitions;
        });
    });
}



- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadMostRecentDefinition];
}

- (void)loadMostRecentDefinition{
    self.mostPopularDefinitions = [CrowdDictionaryWebAPI mostPopularDefinitionsOnPage:@"1"];
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
    
    NSDictionary* definition = [self.mostPopularDefinitions objectAtIndex:indexPath.row];
    
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
            self.mostPopularDefinitions = [self.mostPopularDefinitions arrayByAddingObjectsFromArray:moreDefinition];
            [self.tableView reloadData];
        }
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_030_pencil.png"] landscapeImagePhone:[UIImage imageNamed:@"glyphicons_030_pencil.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_027_search.png"] landscapeImagePhone:[UIImage imageNamed:@"glyphicons_027_search.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    /*UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
     searchBar.backgroundImage = [[UIImage alloc] init];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar] ;
     self.searchWord = searchBar;
     searchBar.delegate = self;*/
    
    
    NSArray *actionButtonItems = @[editItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    self.navigationItem.leftBarButtonItem = searchItem;
    [searchItem setAction:@selector(goToSearchViewController)];
    [editItem setAction:@selector(goToEditViewController)];
}

- (void)goToSearchViewController{
    [self performSegueWithIdentifier:@"search" sender:self];
}

- (void)goToEditViewController{
    [self performSegueWithIdentifier:@"edit" sender:self];
}





@end
