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
    BOOL isAccepted;
    
    NSUInteger bytesTransfered;
    NSUInteger bytesTotal;
}

-(id)initWithLocalPath:(NSString*)p;

-(CGFloat)progress;

@property (readonly) NSString *localPath;

@property (assign) BOOL isPaused;
@property (assign) BOOL isAccepted;

@property (assign) NSUInteger bytesTransfered;
@property (readonly) NSUInteger bytesTotal;

@end
