//
//  FDFile.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDFile : NSObject {
    NSString *localPath;
    NSData *fileHash;
    
    BOOL isPaused;
    NSUInteger bytesTransfered;
    NSUInteger bytesTotal;
}

-(CGFloat)progress;

@property (assign) BOOL isPaused;

@property (assign) NSUInteger bytesTransfered;
@property (readonly) NSUInteger bytesTotal;

@end
