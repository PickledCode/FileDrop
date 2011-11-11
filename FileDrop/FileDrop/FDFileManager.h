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
-(void)fileManager:(FDFileManager*)fm willInsertFile:(FDFile*)file inSection:(NSUInteger)section;
-(void)fileManager:(FDFileManager*)fm didInsertFile:(FDFile*)file inSection:(NSUInteger)section;
-(void)fileManager:(FDFileManager*)fm willRemoveFile:(FDFile*)file inSection:(NSUInteger)section;
-(void)fileManager:(FDFileManager*)fm didRemoveFile:(FDFile*)file inSection:(NSUInteger)section;
@end


@interface FDFileManager : NSObject {
    FDServerClient *client;
    
    NSMutableArray *filesRecv;
    NSMutableArray *filesSend;
    
    __weak id<FDFileManagerDelegate> delegate;
}

-(id)initWithToken:(NSString*)token;


-(void)pauseFile:(FDFile*)file;
-(void)resumeFile:(FDFile*)file;

-(void)acceptFile:(FDFileRecv*)file;
-(void)declineFile:(FDFileRecv*)file;


-(NSUInteger)numberOfSections;
-(NSString*)titleForSection:(NSUInteger)section;
-(NSArray*)filesInSection:(NSUInteger)section;
-(FDFile*)fileInSection:(NSUInteger)section atIndex:(NSUInteger)ind;


@property (weak) id<FDFileManagerDelegate> delegate;

@end
