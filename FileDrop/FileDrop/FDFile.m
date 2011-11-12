//
//  FDFile.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDFile.h"
#import "FDFileRecv.h"

@implementation FDFile

@synthesize fileID, localPath, isPaused, isAccepted, isAcceptable, bytesTransfered, bytesTotal, icon, progressIndeterminate, progressAnimated, filename;

- (id)init
{
    if ((self = [super init])) {
        self.progressIndeterminate = YES;
        self.progressAnimated = NO;
        self.isPaused = YES;
        self.isAccepted = NO;
        bytesTransfered = 0;
        bytesTotal = 1;
    }
    return self;
}

-(CGFloat)progress {
    return (bytesTransfered / bytesTotal);
}

- (void)setIsAccepted:(BOOL)accepted
{
    if (isAccepted != accepted) {
        [self willChangeValueForKey:@"isAccepted"];
        isAccepted = accepted;
        [self didChangeValueForKey:@"isAccepted"];
        
        self.progressIndeterminate = !isAccepted;
        //self.progressAnimated = !isPaused && isAccepted;
    }
}

- (void)setIsPaused:(BOOL)paused
{
    if (isPaused != paused) {
        [self willChangeValueForKey:@"isPaused"];
        isPaused = paused;
        [self didChangeValueForKey:@"isPaused"];
        
        //self.progressAnimated = !isPaused && isAccepted;
    }
}

- (void)updateIcon {
    NSString *extension = [self.filename pathExtension];
    icon = [[NSWorkspace sharedWorkspace] iconForFileType:extension];
}

@end
