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
    }
    return self;
}

-(void)acceptToLocalPath:(NSString*)lp {
    localPath = [lp copy];
    isAccepted = YES;
}

@end
