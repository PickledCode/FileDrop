//
//  FDFileManager.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDFile.h"
#import "FDDefines.h"

@class FDFileManager, FDFile;

@protocol FDFileManagerDelegate <NSObject>
@required
-(void)fileManager:(FDFileManager*)fm willInsertFile:(FDFile*)file inSection:(NSUInteger)section;
-(void)fileManager:(FDFileManager*)fm didInsertFile:(FDFile*)file inSection:(NSUInteger)section;
@end


@interface FDFileManager : NSObject {
    NSString *connToken;
    NSMutableArray *filesRecv;
    NSMutableArray *filesSend;
    
    id<FDFileManagerDelegate> delegate;
}

-(id)initWithToken:(NSString*)token;
-(NSArray*)filesInSection:(NSUInteger)section;

@property (assign) id<FDFileManagerDelegate> delegate;

@end
