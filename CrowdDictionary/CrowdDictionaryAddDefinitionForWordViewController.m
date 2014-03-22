//
//  CrowdDictionaryAddDefinitionForWordViewController.m
//  CrowdDictionary
//
//  Created by Lucas Charrier on 04/03/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import "CrowdDictionaryAddDefinitionForWordViewController.h"
#define kOFFSET_FOR_KEYBOARD 130.0
#define kOFFSET_FOR_KEYBOARD_EXEMPLE 50.0
#define kStatusBarHeight 20
#define kDefaultToolbarHeight 46
#define kKeyboardHeightPortrait 216
#define kKeyboardHeightLandscape 140

@interface CrowdDictionaryAddDefinitionForWordViewController ()

@end

@implementation CrowdDictionaryAddDefinitionForWordViewController

//@synthesize definition = _definition;



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
    
    keyboardIsVisible = NO;
    
    /* Calculate screen size */
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    /* Create toolbar */
    self.bottomToolbar = [[BHInputToolbar alloc] initWithFrame:CGRectMake(0, screenFrame.size.height-kDefaultToolbarHeight+20, screenFrame.size.width, kDefaultToolbarHeight)];
    [self.view addSubview:self.bottomToolbar];
    self.bottomToolbar.inputDelegate = self;
    self.bottomToolbar.textView.placeholder = @"";
    
    [[self.bottomToolbar.textView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.bottomToolbar.textView layer] setBorderWidth:1.0];
    [[self.bottomToolbar.textView layer] setCornerRadius:5];
   
    [self.navigationItem.rightBarButtonItem setTitle:@"+ Publier"];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.60]];


    
    /* ITEMS */
  /*  [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tags.png"] landscapeImagePhone:[UIImage imageNamed:@"tags.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    UIBarButtonItem* validateItem = [[UIBarButtonItem alloc] initWithTitle:@"tags" style:UIBarButtonItemStylePlain target:self action:@selector(resignFirstResponder)];
    [items addObject:validateItem];*/
   /* UIToolbar *toolbar1 = [[UIToolbar alloc] init];
    toolbar1.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);
    [self.view addSubview:toolbar1];
    UIToolbar *toolbar2 = [[UIToolbar alloc] init];
    toolbar2.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 44);
    [self.view addSubview:toolbar2];
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
    [[textView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[textView layer] setBorderWidth:1.0];
    //textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:textView];

    [textView setInputAccessoryView:toolbar2];
    [items addObject:barItem];
   [toolbar1 setItems:items animated:NO];
    [toolbar2 setItems:items animated:NO];*/
    
    NSMutableArray *itemsForTopToolbar = [[NSMutableArray alloc] init];
    [itemsForTopToolbar  addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [itemsForTopToolbar addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_150_edit.png"] landscapeImagePhone:[UIImage imageNamed:@"glyphicons_150_edit.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [itemsForTopToolbar  addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
   [itemsForTopToolbar addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_071_book.png"] landscapeImagePhone:[UIImage imageNamed:@"glyphicons_071_book.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [itemsForTopToolbar  addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [itemsForTopToolbar addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_051_eye_open.png"] landscapeImagePhone:[UIImage imageNamed:@"glyphicons_051_eye_open.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [itemsForTopToolbar  addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [itemsForTopToolbar addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_066_tags.png"] landscapeImagePhone:[UIImage imageNamed:@"glyphicons_066_tags.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [itemsForTopToolbar  addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    /*[itemsForTopToolbar addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"definition.png"] landscapeImagePhone:[UIImage imageNamed:@"definition.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [itemsForTopToolbar addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tags.png"] landscapeImagePhone:[UIImage imageNamed:@"tags.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [itemsForTopToolbar addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tags.png"] landscapeImagePhone:[UIImage imageNamed:@"tags.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [itemsForTopToolbar addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tags.png"] landscapeImagePhone:[UIImage imageNamed:@"tags.png"] style:UIBarButtonItemStylePlain target:self action:nil]];*/
    
  

    [self.topToolbar setItems:itemsForTopToolbar];
    /*[self.definition setInputAccessoryView:toolbar];
    [self.example setInputAccessoryView:toolbar];
    [self.word setInputAccessoryView:toolbar];
    [self.tags setInputAccessoryView:toolbar];*/

    /*
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
    [self.view addSubview:toolbar];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_050_link.png"] landscapeImagePhone:[UIImage imageNamed:@"glyphicons_050_link.png"] style:UIBarButtonItemStylePlain target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    UIBarButtonItem* validateItem = [[UIBarButtonItem alloc] initWithTitle:@"Valider définition" style:UIBarButtonItemStylePlain target:self action:@selector(resignFirstResponder)];
    [items addObject:validateItem];
    [toolbar setItems:items animated:NO];
    [self.definition setInputAccessoryView:toolbar];
    [self.example setInputAccessoryView:toolbar];
    [self.word setInputAccessoryView:toolbar];
    [self.tags setInputAccessoryView:toolbar];
    */
    
	// Do any additional setup after loading the view.
}


/*
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
        [item setEnabled:FALSE];
    
    
    if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
         [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else{
         [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
    
 
    
    return true;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    UIToolbar* atoolbar = (UIToolbar*)textView.inputAccessoryView;
    UIBarButtonItem* item = [[atoolbar items] lastObject];
    [item setEnabled:TRUE];
    [item setTarget:textView];

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
    /*if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
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
    if ([textView isEqual:self.example])
    {
        //move the main view, so that the keyboard does not hide it.
        
        [self setViewMovedUp:YES ForTag:textView.tag];
        NSLog(@"self.tags : %f",self.view.frame.origin.y);
    }
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField.text.length == 0){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite:1 alpha:0.6]];
    }
    return true;
}
*/
/*- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}*/
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    /*if(![string  isEqual: @""]){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite:1 alpha:1]];
    }else if(range.location == 0){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite:1 alpha:0.6]];
    }
    NSLog(@"%lu, string : %@",(unsigned long)range.location, string);
    return TRUE;
    if(![self.word.text isEqual:@""] && ![self.definition.text isEqual:@""] && ![self.example.text isEqual:@""]){
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:1]];
    }else{
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite: 1 alpha:0.6]];
    }
    
    return TRUE;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView isEqual:self.example])
    {
        //move the main view, so that the keyboard does not hide it.
        
        [self setViewMovedUp:YES ForTag:textView.tag];
        NSLog(@"self.tags : %f",self.view.frame.origin.y);
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   
    if ([textField isEqual:self.tags])
    {
        //move the main view, so that the keyboard does not hide it.
        
            [self setViewMovedUp:YES ForTag:textField.tag];

    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.tags])
    {
        //move the main view, so that the keyboard does not hide it.
        
        [self setViewMovedUp:NO ForTag:textField.tag];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp ForTag:(NSInteger)tag
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
 
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        if(tag == 3){
            
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
            rect.origin.y -= kOFFSET_FOR_KEYBOARD;
            rect.size.height += kOFFSET_FOR_KEYBOARD;
        }else if(tag == 2){
            rect.origin.y -= kOFFSET_FOR_KEYBOARD_EXEMPLE;
            rect.size.height += kOFFSET_FOR_KEYBOARD_EXEMPLE;
        }
    }
    else
    {
        if(tag == 3){
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            // 2. increase the size of the view so that the area behind the keyboard is covered up.
            rect.origin.y += kOFFSET_FOR_KEYBOARD;
            rect.size.height -= kOFFSET_FOR_KEYBOARD;
        }else if(tag == 2){
            rect.origin.y += kOFFSET_FOR_KEYBOARD_EXEMPLE;
            rect.size.height -= kOFFSET_FOR_KEYBOARD_EXEMPLE;
        }
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}
*/

/*- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}*/
/*
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}*/

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	/* Listen for keyboard */
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	/* No longer listen for keyboard */
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect r = self.bottomToolbar.frame;
	if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        r.origin.y = screenFrame.size.height - self.bottomToolbar.frame.size.height - kStatusBarHeight;
        if (keyboardIsVisible) {
            r.origin.y -= kKeyboardHeightPortrait;
        }
        [self.bottomToolbar.textView setMaximumNumberOfLines:13];
	}
	else
    {
        r.origin.y = screenFrame.size.width - self.bottomToolbar.frame.size.height - kStatusBarHeight;
        if (keyboardIsVisible) {
            r.origin.y -= kKeyboardHeightLandscape;
        }
        [self.bottomToolbar.textView setMaximumNumberOfLines:7];
        [self.bottomToolbar.textView sizeToFit];
    }
    self.bottomToolbar.frame = r;
}

#pragma mark -
#pragma mark Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    /* Move the toolbar to above the keyboard */
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	CGRect frame = self.bottomToolbar.frame;
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        frame.origin.y = self.view.frame.size.height - frame.size.height - kKeyboardHeightPortrait;
    }
    else {
        frame.origin.y = self.view.frame.size.width - frame.size.height - kKeyboardHeightLandscape - kStatusBarHeight;
    }
	self.bottomToolbar.frame = frame;
	[UIView commitAnimations];
    keyboardIsVisible = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    /* Move the toolbar back to bottom of the screen */
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	CGRect frame = self.bottomToolbar.frame;
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        frame.origin.y = self.view.frame.size.height - frame.size.height;
    }
    else {
        frame.origin.y = self.view.frame.size.width - frame.size.height;
    }
	self.bottomToolbar.frame = frame;
	[UIView commitAnimations];
    keyboardIsVisible = NO;
}

-(void)inputButtonPressed:(NSString *)inputText
{
    /* Called when toolbar button is pressed */
    NSLog(@"Pressed button with text: '%@'", inputText);
}


@end
