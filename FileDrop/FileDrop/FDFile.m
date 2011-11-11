//
//  FDFile.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDFile.h"

@implementation FDFile

@synthesize fileID, localPath, isPaused, isAccepted, bytesTransfered, bytesTotal, icon;

-(CGFloat)progress {
    return (bytesTransfered / bytesTotal);
}

- (void)setLocalPath:(NSString *)path
{
    if (localPath != path) {
        [self willChangeValueForKey:@"localPath"];
        localPath = path;
        [self didChangeValueForKey:@"localPath"];
        NSString *extension = [[path lastPathComponent] pathExtension];
        NSWorkspace *ws = [NSWorkspace sharedWorkspace];
        self.icon = [ws iconForFileType:extension];
    }
}

@end
