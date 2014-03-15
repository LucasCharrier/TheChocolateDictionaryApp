//
//  CrowdDictionaryTextView.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 12/03/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryTextView.h"

@implementation CrowdDictionaryTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)awakeFromNib{
    CALayer *imageLayer = self.layer;
    [imageLayer setCornerRadius:0];
    [imageLayer setBorderWidth:1];
    [imageLayer setBorderColor:[[UIColor colorWithWhite: 0.80 alpha:1] CGColor]];
 
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
