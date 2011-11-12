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

@interface FDTransferWindowController : NSWindowController <FDTokenWindowControllerDelegate, FDFileManagerDelegate>

+ (id)transferWindowControllerWithTitle:(NSString*)title;
- (void)reloadContent;

@property (nonatomic, retain) NSArray *tableContent;
@property (nonatomic, weak) IBOutlet NSTableView *IBtableView;

@end

