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
        isAccepted = NO;
        _meta = [dict copy];
        
        fileID = [_meta objectForKey:@"id"];
    }
    return self;
}

-(NSString*)localPath {
    // Return original file name if not accepted (saved)
    return isAccepted == NO ? [_meta objectForKey:@"name"] : localPath;
}

-(void)acceptToLocalPath:(NSString*)lp {
    localPath = [lp copy];
    isAccepted = YES;
}

@end
