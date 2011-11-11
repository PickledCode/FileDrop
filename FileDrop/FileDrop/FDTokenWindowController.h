//
//  FDTokenWindowController.h
//  FileDrop
//
//  Created by Indragie Karunaratne on 11-11-11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol FDTokenWindowControllerDelegate;
@interface FDTokenWindowController : NSWindowController
@property (nonatomic, weak) IBOutlet NSTextField *tokenField;
@property (nonatomic, assign) IBOutlet id<FDTokenWindowControllerDelegate> delegate;
@property (nonatomic, assign) BOOL okButtonEnabled;
- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;
@end

@protocol FDTokenWindowControllerDelegate <NSObject>
@optional
- (void)tokenWindowController:(FDTokenWindowController*)controller clickedOKWithToken:(NSString*)token;
- (void)tokenWindowControllerClickedCancel:(FDTokenWindowController*)controller;
@end