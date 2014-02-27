//
//  CrowdDictionaryRandomDefinition.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 17/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryRandomDefinition.h"

@implementation CrowdDictionaryRandomDefinition 

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("Crowd Dictionary downloader", NULL);
    /* multiphreading, we are creating a new phread in order to not blocked the application while we download the images */
    dispatch_async(downloadQueue, ^{
        NSArray* randomDefinition = [[NSUserDefaults standardUserDefaults] objectForKey:RANDOM_DEFINITION];
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
  
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
      return 0;
}


@end
