//
//  FDFile.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDFile.h"

@implementation FDFile

@synthesize isPaused, bytesTransfered, bytesTotal;


-(CGFloat)progress {
    return (bytesTransfered / bytesTotal);
}


@end
