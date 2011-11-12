//
//  FDFileManager.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDFile.h"
#import "FDFileRecv.h"
#import "FDFileSend.h"
#import "FDDefines.h"
#import "FDServerClient.h"

@class FDFileManager, FDFile;

@protocol FDFileManagerDelegate <NSObject>
@required // One less check for if something responds to a selector. Empty implementations are easy enough

// File add/remove
-(void)fileManager:(FDFileManager*)fm willInsertFile:(FDFile*)file inSection:(NSUInteger)section;
-(void)fileManager:(FDFileManager*)fm didInsertFile:(FDFile*)file inSection:(NSUInteger)section;
-(void)fileManager:(FDFileManager*)fm willRemoveFile:(FDFile*)file inSection:(NSUInteger)section;
-(void)fileManager:(FDFileManager*)fm didRemoveFile:(FDFile*)file inSection:(NSUInteger)section;

// Errors
-(void)fileManagerErrorTokenInvalid:(FDFileManager*)fm;
@end


@interface FDFileManager : NSObject {
    FDServerClient *client;
    
    NSMutableArray *filesRecv;
    NSMutableArray *filesSend;
    
    __unsafe_unretained id<FDFileManagerDelegate> delegate;
}

-(id)initWithToken:(NSString*)token delegate:(id<FDFileManagerDelegate>)aDelegate;

-(void)addFileFromMeta:(NSDictionary*)meta;
-(void)sendFileWithPath:(NSString*)path;

-(void)acceptFile:(FDFileRecv*)file withPath:(NSString*)path;
-(void)declineFile:(FDFileRecv*)file;

-(void)pauseFile:(FDFile*)file;
-(void)resumeFile:(FDFile*)file;
-(void)cancelFile:(FDFile*)file;


-(NSUInteger)numberOfSections;
-(NSString*)titleForSection:(NSUInteger)section;
-(NSArray*)filesInSection:(NSUInteger)section;
-(NSArray*)activeFilesInSection:(NSUInteger)section;
-(FDFile*)fileInSection:(NSUInteger)section atIndex:(NSUInteger)ind;


@property (unsafe_unretained) id<FDFileManagerDelegate> delegate;

@end
