//
//  FDTransferWindowController.h
//  FileDrop
//
//  Created by Indragie Karunaratne on 11-11-11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FDTokenWindowController.h"
#import "FDFileManager.h"

@interface FDTransferWindowController : NSWindowController <FDTokenWindowControllerDelegate, FDFileManagerDelegate, NSTableViewDataSource>

+ (id)transferWindowControllerWithTitle:(NSString*)title;
- (void)reloadContent;

-(NSArray*)acceptedFilesFromDragArray:(NSArray*)files;

- (IBAction)pauseResumeButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;

@property (nonatomic, retain) NSArray *tableContent;
@property (nonatomic, weak) IBOutlet NSTableView *IBtableView;

@end

