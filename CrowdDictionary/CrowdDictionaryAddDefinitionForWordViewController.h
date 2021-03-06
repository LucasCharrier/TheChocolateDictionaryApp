//
//  CrowdDictionaryAddDefinitionForWordViewController.h
//  CrowdDictionary
//
//  Created by Lucas Charrier on 04/03/2014.
//  Copyright (c) 2014 Lucas Charrier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHInputToolbar.h"


@interface CrowdDictionaryAddDefinitionForWordViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate,BHInputToolbarDelegate>{
    BHInputToolbar *inputToolbar;
    
@private
    BOOL keyboardIsVisible;
}

/*@property (strong, nonatomic) IBOutlet UITextField *word;
@property (strong, nonatomic) IBOutlet UITextView *definition;
@property (strong, nonatomic) IBOutlet UITextField *tags;
@property (strong, nonatomic) IBOutlet UITextView *example;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *okButton;
@property (strong, nonatomic) IBOutlet UILabel *definitionPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *exemplePlaceholder;*/
@property (strong, nonatomic) IBOutlet UIToolbar *topToolbar;
@property (strong, nonatomic)  BHInputToolbar *bottomToolbar;

@end
