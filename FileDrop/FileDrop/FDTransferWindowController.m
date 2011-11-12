//
//  FDTransferWindowController.m
//  FileDrop
//
//  Created by Indragie Karunaratne on 11-11-11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDTransferWindowController.h"
#import "NSError+FDAdditions.h"

static NSString* const kMainCellIdentifier = @"MainCell";
static NSString* const kGroupCellIdentifier = @"GroupCell";
static CGFloat const kMainCellHeight = 60.0;
static CGFloat const kGroupCellHeight = 17.0;

@implementation FDTransferWindowController {
    FDFileManager *fileManager;
    FDTokenWindowController *tokenWindowController;
}
@synthesize tableContent;

+ (id)transferWindowControllerWithTitle:(NSString*)title
{
    FDTransferWindowController *controller = [[FDTransferWindowController alloc] initWithWindowNibName:NSStringFromClass([self class])];
    controller.window.title = title;
    return controller;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self reloadContent];
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

- (void)fileManager:(FDFileManager *)fm didRemoveFile:(FDFile *)file inSection:(NSUInteger)section {
    [self reloadContent];
}
- (void)fileManager:(FDFileManager *)fm didInsertFile:(FDFile *)file inSection:(NSUInteger)section {
    [self reloadContent];
}

#pragma mark - NSTableViewDataSource

- (void)reloadContent
{
    NSInteger sections = [fileManager numberOfSections];
    NSMutableArray *content = [NSMutableArray arrayWithCapacity:sections];
    for (NSInteger i = 0; i < sections; i++) {
        [content addObject:[fileManager titleForSection:i]];
        [content addObjectsFromArray:[fileManager filesInSection:i]];
    }
    self.tableContent = content;
}

- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row {
    id entity = [self.tableContent objectAtIndex:row];
    return [entity isKindOfClass:[NSString class]];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    id entity = [self.tableContent objectAtIndex:row];
    if ([entity isKindOfClass:[NSString class]]) {
        NSTextField *textField = [tableView makeViewWithIdentifier:kGroupCellIdentifier owner:self];
        [textField setStringValue:entity];
        return textField;
    } else {
        return [tableView makeViewWithIdentifier:kMainCellIdentifier owner:self];
    }
}    

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return ([[self.tableContent objectAtIndex:row] isKindOfClass:[NSString class]]) ? kGroupCellHeight : kMainCellHeight;
}
@end
