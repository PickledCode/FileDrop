//
//  FDAppDelegate.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/8/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDAppDelegate.h"
#import "FDTransferWindowController.h"

@implementation FDAppDelegate {
    FDTransferWindowController *transfer;
}

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    FDFileManager *fm = [[FDFileManager alloc] initWithToken:@"test" delegate:nil];
    NSLog(@"FM: %@", fm);
    [fm sendFileWithPath:@"/Users/ryansullivan/Desktop/FileDrop.zip"];
    
    transfer = [FDTransferWindowController transferWindowControllerWithTitle:@"Some window title"];
    [transfer showWindow:nil];
}

@end
