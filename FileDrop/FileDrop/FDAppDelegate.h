//
//  FDAppDelegate.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/8/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FDFileDrop.h"

@interface FDAppDelegate : NSObject <NSApplicationDelegate> {
    NSMutableArray *sessionWindows;
    NSUInteger sessionAmount;
}

-(IBAction)newSession:(id)sender;

@end
