//
//  MainView.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDMainView.h"

@implementation FDMainView


- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.backgroundColor = [TUIColor colorWithWhite:0.9 alpha:1.0];
        
        _tableView = [[TUITableView alloc] initWithFrame:self.bounds style:TUITableViewStylePlain];
        _tableView.autoresizingMask = TUIViewAutoresizingFlexibleSize;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.maintainContentOffsetAfterReload = YES;
        [self addSubview:_tableView];
    }
    return self;
}

-(void)dealloc {
    [_tableView release];
    [super dealloc];
}


#pragma mark -
#pragma mark Table View delegates

- (CGFloat)tableView:(TUITableView *)tableView heightForRowAtIndexPath:(TUIFastIndexPath *)indexPath {
    return 86.0;
}

//- (void)tableView:(TUITableView *)tableView didSelectRowAtIndexPath:(TUIFastIndexPath *)indexPath; // happens on left/right mouse down, key up/down
//- (void)tableView:(TUITableView *)tableView didDeselectRowAtIndexPath:(TUIFastIndexPath *)indexPath;
//- (void)tableView:(TUITableView *)tableView didClickRowAtIndexPath:(TUIFastIndexPath *)indexPath withEvent:(NSEvent *)event; // happens on left/right mouse up (can look at clickCount)

//- (BOOL)tableView:(TUITableView*)tableView shouldSelectRowAtIndexPath:(TUIFastIndexPath*)indexPath forEvent:(NSEvent*)event; // YES, if not implemented
//- (NSMenu *)tableView:(TUITableView *)tableView menuForRowAtIndexPath:(TUIFastIndexPath *)indexPath withEvent:(NSEvent *)event;

// the following are good places to update or restore state (such as selection) when the table data reloads
//- (void)tableViewWillReloadData:(TUITableView *)tableView;
//- (void)tableViewDidReloadData:(TUITableView *)tableView;


- (NSInteger)numberOfSectionsInTableView:(TUITableView *)tableView { return 1; }
//- (TUIView *)tableView:(TUITableView *)tableView headerViewForSection:(NSInteger)section;

- (NSInteger)tableView:(TUITableView *)table numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (TUITableViewCell *)tableView:(TUITableView *)tableView cellForRowAtIndexPath:(TUIFastIndexPath *)indexPath {
    FDFileCell *cell = reusableTableCellOfClass(tableView, FDFileCell);
    
    return cell;
}


//- (void)tableView:(TUITableView *)tableView willDisplayCell:(TUITableViewCell *)cell forRowAtIndexPath:(TUIFastIndexPath *)indexPath; // called after the cell's frame has been set but before it's added as a subview
// Row Reordering:
//- (BOOL)tableView:(TUITableView *)tableView canMoveRowAtIndexPath:(TUIFastIndexPath *)indexPath;
//- (void)tableView:(TUITableView *)tableView moveRowAtIndexPath:(TUIFastIndexPath *)fromIndexPath toIndexPath:(TUIFastIndexPath *)toIndexPath;
//- (TUIFastIndexPath *)tableView:(TUITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(TUIFastIndexPath *)fromPath toProposedIndexPath:(TUIFastIndexPath *)proposedPath;

#pragma mark -

@end
