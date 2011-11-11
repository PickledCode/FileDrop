//
//  FDFileSend.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDFileSend.h"

@implementation FDFileSend

-(id)initWithLocalPath:(NSString*)p {
    self = [super init];
    if (self) {
        localPath = [p copy];
        fileID = randomString();
        filename = [p lastPathComponent];
        
        NSString *extension = [self.filename pathExtension];
        NSWorkspace *ws = [NSWorkspace sharedWorkspace];
        icon = [ws iconForFileType:extension];
    }
    return self;
}

@end
