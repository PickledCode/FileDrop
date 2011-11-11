//
//  FDTransferWindowController.m
//  FileDrop
//
//  Created by Indragie Karunaratne on 11-11-11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDTransferWindowController.h"
#import "NSError+FDAdditions.h"

@implementation FDTransferWindowController {
    FDFileManager *fileManager;
    FDTokenWindowController *tokenWindowController;
}

+ (id)transferWindowControllerWithTitle:(NSString*)title
{
    FDTransferWindowController *controller = [[FDTransferWindowController alloc] initWithWindowNibName:NSStringFromClass([self class])];
    controller.window.title = title;
    return controller;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)showWindow:(id)sender
{
    [super showWindow:sender];
    tokenWindowController = [[FDTokenWindowController alloc] init];
    tokenWindowController.delegate = self;
    [NSApp beginSheet:tokenWindowController.window modalForWindow:self.window modalDelegate:nil didEndSelector:nil contextInfo:NULL];
}

#pragma mark - FDTokenWindowController

- (void)tokenWindowController:(FDTokenWindowController*)controller clickedOKWithToken:(NSString*)token
{
    [NSApp endSheet:tokenWindowController.window];
    [tokenWindowController.window orderOut:nil];
    fileManager = [[FDFileManager alloc] initWithToken:token delegate:self];
    [self fileManagerErrorTokenInvalid:nil];
}

- (void)tokenWindowControllerClickedCancel:(FDTokenWindowController*)controller
{
    [NSApp endSheet:tokenWindowController.window];
    [tokenWindowController.window orderOut:nil];
    [self.window orderOut:nil];
}

#pragma mark - FDFileManagerDelegate

- (void)fileManagerErrorTokenInvalid:(FDFileManager*)fm
{
    [NSApp endSheet:tokenWindowController.window];
    [tokenWindowController.window orderOut:nil];
    NSError *error = [NSError genericErrorWithDescription:NSLocalizedString(@"FDInvalidTokenErrorDescription", nil) recoveryText:NSLocalizedString(@"FDInvalidTokenErrorRecovery", nil)];
    NSAlert *alert = [NSAlert alertWithError:error];
    [alert beginSheetModalForWindow:self.window modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:NULL];
    fileManager = nil;
}

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    [alert.window orderOut:nil];
    [self.window orderOut:nil];
}

@end
