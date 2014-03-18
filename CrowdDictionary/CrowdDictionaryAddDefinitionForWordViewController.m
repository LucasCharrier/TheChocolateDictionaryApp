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
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_050_link.png"] landscapeImagePhone:[UIImage imageNamed:@"glyphicons_050_link.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    UIBarButtonItem* validateItem = [[UIBarButtonItem alloc] initWithTitle:@"Valider définition" style:UIBarButtonItemStylePlain target:self action:@selector(validationDefinition)];
    [validateItem setAction:@selector(validationDefinition:)];
    [items addObject:validateItem];
    [toolbar setItems:items animated:NO];
    [self.definition setInputAccessoryView:toolbar];
    [self.example setInputAccessoryView:toolbar];
    [self.word setInputAccessoryView:toolbar];
    [self.tags setInputAccessoryView:toolbar];
    
    
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


        UIToolbar* atoolbar = (UIToolbar*)textField.inputAccessoryView;
        UIBarButtonItem* item = [[atoolbar items] lastObject];
        item.title =@"";
        [item setEnabled:YES];

    if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
         [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else{
         [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
    
 
    
    return true;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   if(textView.tag == 2){
        UIToolbar* atoolbar = (UIToolbar*)textView.inputAccessoryView;
        UIBarButtonItem* item = [[atoolbar items] lastObject];
        item.title =@"Valider exemple";
   }else{
       UIToolbar* atoolbar = (UIToolbar*)textView.inputAccessoryView;
       UIBarButtonItem* item = [[atoolbar items] lastObject];
       item.title =@"Valider définition";
   }/*
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



- (void) validationDefinition{
    [self.definition resignFirstResponder];
}

- (void) validationExemple{
    [self.definition resignFirstResponder];
}

@end
