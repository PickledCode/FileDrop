//
//  FDFileManager.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDFileManager.h"

@implementation FDFileManager

@synthesize delegate;


-(id)initWithToken:(NSString *)token {
    self = [super init];
    if (self) {
        client = [[FDServerClient alloc] initWithToken:token andFileManager:self];
        if (!client) {
            return nil;
        }
        
        filesRecv = [NSMutableArray new];
        filesSend = [NSMutableArray new];
    }
    return self;
}


#pragma mark -
#pragma mark File manipulation

-(void)pauseFile:(FDFile*)file {
    
}
-(void)resumeFile:(FDFile*)file {
    
}

-(void)acceptFile:(FDFileRecv*)file {
    if ([filesSend containsObject:file] && [[file localPath] length] > 0) {
        file.isAccepted = YES;
    }
}
-(void)declineFile:(FDFileRecv*)file {
    if ([filesRecv containsObject:file]) {
        
    } else if ([filesSend containsObject:file]) {
        
    }
}


#pragma mark -
#pragma mark File Sending
-(void)sendFileWithPath:(NSString*)path {
    BOOL isDir;
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (!fileExists || isDir) {
        NSLog(@"Invalid file path specified (isDir=%d, fileExists=%d)", isDir, fileExists);
        return;
    }
    
    FDFileSend *file = [[FDFileSend alloc] initWithLocalPath:path];
    [filesSend addObject:file];
}


#pragma mark -
#pragma mark Section methods

-(NSUInteger)numberOfSections { return 2; }
-(NSString*)titleForSection:(NSUInteger)section {
    if (section == FDFM_FILERECV_SECTION) {
        return @"Downloads";
    } else if (section == FDFM_FILESEND_SECTION) {
        return @"Uploads";
    }
    return @"";
}
-(NSArray*)filesInSection:(NSUInteger)section {
    if (section == FDFM_FILERECV_SECTION) {
        return filesRecv;
    } else if (section == FDFM_FILESEND_SECTION) {
        return filesSend;
    }
    return nil;
}
-(FDFile*)fileInSection:(NSUInteger)section atIndex:(NSUInteger)ind {
    return [[self filesInSection:section] objectAtIndex:ind];
}

@end
