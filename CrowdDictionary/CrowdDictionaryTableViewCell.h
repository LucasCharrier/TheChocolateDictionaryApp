//
//  CrowdDictionaryTableViewCell.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 27/02/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrowdDictionaryTableViewCell : UITableViewCell 
@property (weak, nonatomic) IBOutlet UILabel *word;
@property (weak, nonatomic) IBOutlet UITextView *definition;
@property (weak, nonatomic) IBOutlet UIImageView *like;
@property (weak, nonatomic) IBOutlet UIImageView *unlike;
@property (weak, nonatomic) IBOutlet UILabel *share;

@end
