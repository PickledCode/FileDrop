//
//  FDFile.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDFile.h"

@implementation FDFile

@synthesize localPath, isPaused, isAccepted, bytesTransfered, bytesTotal;

-(id)initWithLocalPath:(NSString*)p {
    self = [super init];
    if (self) {
        localPath = [p copy];
    }
    return self;
}

-(CGFloat)progress {
    return (bytesTransfered / bytesTotal);
}


@end
