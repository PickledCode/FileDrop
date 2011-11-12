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
        bytesTotal = [[[NSFileManager defaultManager] attributesOfItemAtPath:localPath error:nil] fileSize];
        self.isPaused = NO;
        [self updateIcon];
    }
    return self;
}

-(NSDictionary*)genMeta {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:filename forKey:@"name"];
    [dict setObject:[NSNumber numberWithUnsignedInteger:bytesTotal] forKey:@"bytesTotal"];
    return dict;
}

@end
