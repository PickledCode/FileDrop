//
//  FDTokenWindowController.m
//  FileDrop
//
//  Created by Indragie Karunaratne on 11-11-11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDTokenWindowController.h"

@implementation FDTokenWindowController
@synthesize tokenField, delegate, okButtonEnabled;

- (id)init
{
    return [super initWithWindowNibName:NSStringFromClass([self class])];
}

- (IBAction)ok:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(tokenWindowController:clickedOKWithToken:)]) {
        [self.delegate tokenWindowController:self clickedOKWithToken:self.tokenField.stringValue];
    }
}

- (IBAction)cancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(tokenWindowControllerClickedCancel:)]) {
        [self.delegate tokenWindowControllerClickedCancel:self];
    }
}

#pragma mark - NSTextFieldDelegate

- (void)controlTextDidChange:(NSNotification *)obj
{
    self.okButtonEnabled = self.tokenField.stringValue.length != 0;
}
@end
