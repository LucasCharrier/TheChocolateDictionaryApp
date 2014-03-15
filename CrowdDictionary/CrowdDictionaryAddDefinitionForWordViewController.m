//
//  CrowdDictionaryAddDefinitionForWordViewController.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 04/03/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryAddDefinitionForWordViewController.h"

@interface CrowdDictionaryAddDefinitionForWordViewController ()

@end

@implementation CrowdDictionaryAddDefinitionForWordViewController

@synthesize definition = _definition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.definition.delegate = self;
    self.definition.tag = 0;
    
    self.word.delegate = self;
    self.word.tag = 1;
    
    self.example.delegate = self;
    self.example.tag = 2;
    
    self.tags.delegate = self;
    self.tags.tag = 3;
    
    [self.navigationItem.rightBarButtonItem setTitle:@"+ Publier"];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.60]];
    
    [self.definitionPlaceholder setTextColor:[UIColor colorWithWhite: 0.80 alpha:1]];
    [self.definitionPlaceholder setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    [self.exemplePlaceholder setTextColor:[UIColor colorWithWhite: 0.80 alpha:1]];
    [self.exemplePlaceholder setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    
    [self.okButton setAction:@selector(tapOkButton)];
    
    [self.toolbar setHidden:TRUE];
    
	// Do any additional setup after loading the view.
}



- (void)tapOkButton
{
   
    if(![self.definition.text isEqualToString:@""]  && ![self.word.text isEqualToString:@""] && ![self.example.text isEqualToString:@""]){
            [self performSegueWithIdentifier:@"send" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Compléter les champs"
                                                        message:@"Afin de publier une définition, il faut que les champs mot, définition et exemple soit remplis"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
/*
    if(textField.tag == 1){
         [self.navigationItem.rightBarButtonItem setTitle:@"+ Mot"];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:@"+ Tags"];
    }
    return true;*/
    if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
         [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else{
         [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
    
    return true;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   /* if(textView.tag == 0){
        [self.navigationItem.rightBarButtonItem setTitle:@"+ Définition"];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:@"+ Exemple"];
    }
    if(textView.text.length == 0){
         [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }*/
    if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else{
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
    
    return true;
}

- (void)textViewDidChange:(UITextView *)textView{
    if(textView.text.length == 1){
        if(textView.tag == 0){
            [self.definitionPlaceholder setHidden:TRUE];
        }else{
            [self.exemplePlaceholder setHidden:TRUE];
        }
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else if( textView.text.length == 0){
        if(textView.tag == 0){
            [self.definitionPlaceholder setHidden:FALSE];
        }else{
            [self.exemplePlaceholder setHidden:FALSE];
        }
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
    
    if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else{
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
    
}



- (void)textViewDidEndEditing:(UITextView *)textView{
    if( textView.text.length == 0){
        if(textView.tag == 0){
            [self.definitionPlaceholder setHidden:FALSE];
        }else{
            [self.exemplePlaceholder setHidden:FALSE];
        }
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite:1 alpha:0.6]];
    }
    if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else{
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField.text.length == 0){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite:1 alpha:0.6]];
    }
    return true;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    /*if(![string  isEqual: @""]){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite:1 alpha:1]];
    }else if(range.location == 0){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite:1 alpha:0.6]];
    }
    NSLog(@"%lu, string : %@",(unsigned long)range.location, string);
    return TRUE;*/
    if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else{
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
    
    return TRUE;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGPoint beginCentre = [[[notification userInfo] valueForKey:UIKeyboardCenterBeginUserInfoKey] CGPointValue];
    CGPoint endCentre = [[[notification userInfo] valueForKey:UIKeyboardCenterEndUserInfoKey] CGPointValue];
    CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (nil ==  self.toolbar) {
        
        if(nil ==  self.toolbar) {
            self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];
             self.toolbar.barStyle = UIBarStyleBlackTranslucent;
             self.toolbar.tintColor = [UIColor darkGrayColor];
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
            UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
                                                                                     NSLocalizedString(@"Previous",@"Previous form field"),
                                                                                     NSLocalizedString(@"Next",@"Next form field"),
                                                                                     nil]];
            control.segmentedControlStyle = UISegmentedControlStyleBar;
            control.tintColor = [UIColor darkGrayColor];
            control.momentary = YES;
            [control addTarget:self action:@selector(nextPrevious:) forControlEvents:UIControlEventValueChanged];
            
            UIBarButtonItem *controlItem = [[UIBarButtonItem alloc] initWithCustomView:control];
            
            
            
            
            NSArray *items = [[NSArray alloc] initWithObjects:controlItem, flex, barButtonItem, nil];

       
            
             self.toolbar.frame = CGRectMake(beginCentre.x - (keyboardBounds.size.width/2),
                                               beginCentre.y - (keyboardBounds.size.height/2) -  self.toolbar.frame.size.height,
                                                self.toolbar.frame.size.width,
                                                self.toolbar.frame.size.height);
            
            [self.view addSubview: self.toolbar];
        }
    }
    
    [UIView beginAnimations:@"RS_showKeyboardAnimation" context:nil];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    
    self.toolbar.alpha = 1.0;
    self.toolbar.frame = CGRectMake(endCentre.x - (keyboardBounds.size.width/2),
                                       endCentre.y - (keyboardBounds.size.height/2) -  self.toolbar.frame.size.height - self.view.frame.origin.y,
                                        self.toolbar.frame.size.width,
                                       self.toolbar.frame.size.height);
    
    [UIView commitAnimations];    
    
    keyboardToolbarShouldHide = YES;
}


@end
