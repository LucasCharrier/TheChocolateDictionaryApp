/*
 *  UIInputToolbar.m
 *
 *  Created by Brandon Hamilton on 2011/05/03.
 *  Copyright 2011 Brandon Hamilton.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

#import "BHInputToolbar.h"

@implementation BHInputToolbar

-(void)inputButtonPressed
{
    if ([self.inputDelegate respondsToSelector:@selector(inputButtonPressed:)])
    {
        [self.inputDelegate inputButtonPressed:self.textView.text];
    }

    /* Remove the keyboard and clear the text */
    [self.textView resignFirstResponder];
    [self.textView clearText];
}

-(void)setupToolbar:(NSString *)buttonLabel
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
    self.tintColor = [UIColor lightGrayColor];
    self.backgroundColor = [UIColor lightGrayColor];

    /* Create custom send button*/


    UIButton *button               = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font         = [UIFont boldSystemFontOfSize:15.0f];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.titleEdgeInsets         = UIEdgeInsetsMake(0, 2, 0, 2);
    button.contentStretch          = CGRectMake(0.5, 0.5, 0, 0);
    button.contentMode             = UIViewContentModeScaleToFill;
 

   
    [button setImage:[UIImage imageNamed:@"glyphicons_206_ok_2.png"]
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(inputButtonPressed) forControlEvents:UIControlEventTouchDown];
    [button sizeToFit];
    
    UIButton *optionButton               = [UIButton buttonWithType:UIButtonTypeCustom];
    optionButton.titleLabel.font         = [UIFont boldSystemFontOfSize:15.0f];
    optionButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    optionButton.titleEdgeInsets         = UIEdgeInsetsMake(0, 2, 0, 2);

    optionButton.contentMode             = UIViewContentModeScaleToFill;
    
    [optionButton setImage:[UIImage imageNamed:@"glyphicons_062_paperclip.png"]
            forState:UIControlStateNormal];
    [optionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [optionButton addTarget:self action:@selector(inputButtonPressed) forControlEvents:UIControlEventTouchDown];
    [optionButton sizeToFit];

    
    self.inputButton = [[UIBarButtonItem alloc] initWithCustomView:button];
     self.inputButton.customView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    /* Disable button initially */
    self.inputButton.enabled = NO;
    
    self.optionButton = [[UIBarButtonItem alloc] initWithCustomView:optionButton];
    self.optionButton.customView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    /* Disable button initially */
    self.optionButton.enabled = NO;

    /* Create UIExpandingTextView input */
    self.textView = [[BHExpandingTextView alloc] initWithFrame:CGRectMake(54, 4, self.bounds.size.width - 104, 20)];
    self.textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(4.0f, 0.0f, 10.0f, 0.0f);
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.textView.delegate = self;
    [self.textView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.textView];

    /* Right align the toolbar button */
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    /*UIBarButtonItem* optionItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"glyphicons_062_paperclip.png"] style:UIBarButtonItemStyleBordered target:self action:nil];*/

    NSArray *items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]
                                                initWithCustomView:optionButton],flexItem,self.inputButton, nil];
    [self setItems:items animated:NO];
    
}

-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setupToolbar:@"Send"];
    }
    return self;
}

-(id)init
{
    if ((self = [super init])) {
        [self setupToolbar:@"Send"];
    }
    return self;
}



#pragma mark -
#pragma mark UIExpandingTextView delegate

-(void)expandingTextView:(BHExpandingTextView *)expandingTextView willChangeHeight:(float)height
{
    /* Adjust the height of the toolbar when the input component expands */
    float diff = (self.textView.frame.size.height - height);
    CGRect r = self.frame;
    r.origin.y += diff;
    r.size.height -= diff;
    self.frame = r;
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        [self.inputDelegate expandingTextView:expandingTextView willChangeHeight:height];
    }
}

-(void)expandingTextViewDidChange:(BHExpandingTextView *)expandingTextView
{
    /* Enable/Disable the button */
    if ([expandingTextView.text length] > 0)
        self.inputButton.enabled = YES;
    else
        self.inputButton.enabled = NO;
    if ([self.inputDelegate respondsToSelector:@selector(expandingTextViewDidChange:)])
        [self.inputDelegate expandingTextViewDidChange:expandingTextView];
}

- (BOOL)expandingTextViewShouldReturn:(BHExpandingTextView *)expandingTextView
{
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        return [self.inputDelegate expandingTextViewShouldReturn:expandingTextView];
    }
    
    return YES;
}

- (BOOL)expandingTextViewShouldBeginEditing:(BHExpandingTextView *)expandingTextView
{
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        return [self.inputDelegate expandingTextViewShouldBeginEditing:expandingTextView];
    }
    return YES;
}

- (BOOL)expandingTextViewShouldEndEditing:(BHExpandingTextView *)expandingTextView
{
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        return [self.inputDelegate expandingTextViewShouldEndEditing:expandingTextView];
    }
    return YES;
}

- (void)expandingTextViewDidBeginEditing:(BHExpandingTextView *)expandingTextView
{
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        [self.inputDelegate expandingTextViewDidBeginEditing:expandingTextView];
    }
}

- (void)expandingTextViewDidEndEditing:(BHExpandingTextView *)expandingTextView
{
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        [self.inputDelegate expandingTextViewDidEndEditing:expandingTextView];
    }
}

- (BOOL)expandingTextView:(BHExpandingTextView *)expandingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        return [self.inputDelegate expandingTextView:expandingTextView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

- (void)expandingTextView:(BHExpandingTextView *)expandingTextView didChangeHeight:(float)height
{
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        [self.inputDelegate expandingTextView:expandingTextView didChangeHeight:height];
    }
}


- (void)drawRect:(CGRect)rect
{
    
    /* Draw custon toolbar background */
    
    CGRect input = self.inputButton.customView.frame;
    input.origin.y = self.frame.size.height - input.size.height - 15;
    self.inputButton.customView.frame = input;
    
    CGRect option = self.optionButton.customView.frame;
    option.origin.y = self.frame.size.height - option.size.height - 12;
    self.optionButton.customView.frame = option;
}



- (void)expandingTextViewDidChangeSelection:(BHExpandingTextView *)expandingTextView
{
    if ([self.inputDelegate respondsToSelector:_cmd]) {
        [self.inputDelegate expandingTextViewDidChangeSelection:expandingTextView];
    }
}

@end
