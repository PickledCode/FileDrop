//
//  FDTransferWindowController.m
//  FileDrop
//
//  Created by Indragie Karunaratne on 11-11-11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDTransferWindowController.h"

@implementation FDTransferWindowController {
    FDFileManager *fileManager;
    FDTokenWindowController *tokenWindowController;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
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
}

- (void)tokenWindowControllerClickedCancel:(FDTokenWindowController*)controller
{
    [NSApp endSheet:tokenWindowController.window];
    [tokenWindowController.window orderOut:nil];
}

#pragma mark - FDFileManagerDelegate

-(void)fileManagerErrorTokenInvalid:(FDFileManager*)fm
{
    fileManager = nil;
}

@end
