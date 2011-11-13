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


NSString* FileHash(NSString *path) {
    return (__bridge_transfer NSString*)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FD_HASH_FileChunkSize);
}
NSString* FileHashPartial(NSString *path, NSUInteger readLength) {
    return (__bridge_transfer NSString*)FilePartialMD5HashCreateWithPath((__bridge CFStringRef)path, readLength, FD_HASH_FileChunkSize);
}

// Thanks http://www.joel.lopes-da-silva.com/2010/09/07/compute-md5-or-sha-hash-of-large-file-efficiently-on-ios-and-mac-os-x/
CFStringRef FilePartialMD5HashCreateWithPath(CFStringRef filePath, NSUInteger readUntil, NSUInteger chunkSize) {
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, 
                                                     (CFStringRef)filePath, 
                                                     kCFURLPOSIXPathStyle, 
                                                     (Boolean)false);
    if (!fileURL) goto done;
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, 
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    BOOL didSucceed = (BOOL)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    BOOL hasMoreData = YES;
    NSUInteger readLength = 0;
    while (hasMoreData && readLength < readUntil) {
        NSUInteger readDiff = readUntil - readLength;
        NSUInteger readChunk = MIN(readDiff, chunkSize);
        
        uint8_t buffer[readChunk];
        CFIndex readBytesCount = CFReadStreamRead(readStream, 
                                                  (UInt8 *)buffer, 
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject, 
                      (const void *)buffer, 
                      (CC_LONG)readBytesCount);
    }
    // Check if the read operation succeeded
    didSucceed = !hasMoreData || readLength == readUntil;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault, 
                                       (const char *)hash, 
                                       kCFStringEncodingUTF8);
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}
// Original:
CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath, NSUInteger chunkSize) {
    
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, 
                                                     (CFStringRef)filePath, 
                                                     kCFURLPOSIXPathStyle, 
                                                     (Boolean)false);
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, 
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSize];
        CFIndex readBytesCount = CFReadStreamRead(readStream, 
                                                  (UInt8 *)buffer, 
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject, 
                      (const void *)buffer, 
                      (CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault, 
                                       (const char *)hash, 
                                       kCFStringEncodingUTF8);
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}
