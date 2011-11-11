//
//  FDFunctions.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/11/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#include "FDFunctions.h"


NSString* randomString(void) {
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    return (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, cfuuid);
}

