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

@synthesize fileID, localPath, isPaused, isAccepted, isFinished, isAcceptable, bytesTransfered, bytesTotal, icon, progressIndeterminate, progressAnimated, filename, fileManagerRef, fileHandler;

- (id)init
{
    if ((self = [super init])) {
        self.progressIndeterminate = YES;
        self.progressAnimated = NO;
        self.isFinished = NO;
        self.isPaused = YES;
        self.isAccepted = NO;
        bytesTransfered = 0;
        bytesTotal = 1;
    }
    return self;
}

-(void)dealloc {
    [fileHandler closeFile];
}


-(CGFloat)progress {
    return (bytesTransfered / bytesTotal);
}
-(BOOL)canPause { return NO; }

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

- (void)setBytesTransfered:(NSUInteger)bytes
{
    if (bytesTransfered != bytes) {
        [self willChangeValueForKey:@"bytesTransfered"];
        bytesTransfered = bytes;
        [self didChangeValueForKey:@"bytesTransfered"];
        
        if (bytesTransfered >= bytesTotal) {
            self.isFinished = YES;
        }
    }
}

- (void)updateIcon {
    [self willChangeValueForKey:@"icon"];
    NSString *extension = [self.filename pathExtension];
    icon = [[NSWorkspace sharedWorkspace] iconForFileType:extension];
    [self didChangeValueForKey:@"icon"];
}

@end
