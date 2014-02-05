//
//  CrowdDictionaryDetailViewController.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 04/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrowdDictionaryDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
