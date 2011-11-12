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
        fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:localPath];
        fileID = randomString();
        filename = [p lastPathComponent];
        bytesTotal = [[[NSFileManager defaultManager] attributesOfItemAtPath:localPath error:nil] fileSize];
        fileHash = FileHash(localPath);
        self.isPaused = NO;
        [self updateIcon];
    }
    return self;
}

-(NSDictionary*)genMeta {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:filename forKey:@"name"];
    [dict setObject:[NSNumber numberWithUnsignedInteger:bytesTotal] forKey:@"bytesTotal"];
    [dict setObject:fileHash forKey:@"fileHash"];
    return dict;
}

-(BOOL)canPause { return YES; }

@end
