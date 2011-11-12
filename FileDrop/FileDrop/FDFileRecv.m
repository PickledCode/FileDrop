//
//  FDFileRecv.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDFileRecv.h"

@implementation FDFileRecv

-(id)initWithMeta:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        _meta = [dict copy];
        fileID = [_meta objectForKey:@"id"];
        filename = [_meta objectForKey:@"name"];
        bytesTotal = [[_meta objectForKey:@"bytesTotal"] unsignedIntegerValue];
        [self updateIcon];
    }
    return self;
}


- (void)setIsAccepted:(BOOL)accepted {
    [super setIsAccepted:accepted];
    self.isAcceptable = !isAccepted;
}

-(void)acceptToLocalPath:(NSString*)lp {
    localPath = [lp copy];
    filename = [lp lastPathComponent];
    [self updateIcon];
    self.isAccepted = YES;
}

@end
