//
//  FDFunctions.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/11/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#ifndef FileDrop_FDFunctions_h
#define FileDrop_FDFunctions_h

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

#include <stdint.h>
#include <stdio.h>
#include <CommonCrypto/CommonDigest.h>


// In bytes:
#define FD_HASH_FileHashDefaultChunkSizeForReadingData 4096
//#define RKRandom(x) (arc4random() % ((NSUInteger)(x) + 1))


NSString* randomString(void);
NSString* FileHash(NSString *path);
CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData);

#endif
