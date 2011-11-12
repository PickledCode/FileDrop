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


-(id)initWithToken:(NSString*)token delegate:(id<FDFileManagerDelegate>)aDelegate {
    self = [super init];
    if (self) {
        delegate = aDelegate;
        
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

-(void)acceptFile:(FDFileRecv*)file withPath:(NSString *)path {
    if (file.isAccepted && [[file localPath] isEqualToString:path]) {
        return;
    } else if (file.isAccepted) {
        NSLog(@"Uh, confused. File is already accepted but path isn't the same");
        return;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        // Resume file 
        [KBPacket writeFileBytes:file toSocket:client.socket];
    }
    [file acceptToLocalPath:path];
    [KBPacket writeAcceptFile:file toSocket:client.socket];
}
-(void)declineFile:(FDFileRecv*)file {
    if ([filesRecv containsObject:file]) {
        [delegate fileManager:self willRemoveFile:file inSection:FDFM_FILERECV_SECTION];
        [filesRecv removeObject:file];
        [delegate fileManager:self didRemoveFile:file inSection:FDFM_FILERECV_SECTION];
    }
    [KBPacket writeDeclineFile:file toSocket:client.socket];
}
-(void)cancelFile:(FDFile *)file {
    if ([filesSend containsObject:file]) {
        [delegate fileManager:self willRemoveFile:file inSection:FDFM_FILESEND_SECTION];
        [filesSend removeObject:file];
        [delegate fileManager:self didRemoveFile:file inSection:FDFM_FILESEND_SECTION];
    } else if ([filesRecv containsObject:file]) {
        [delegate fileManager:self willRemoveFile:file inSection:FDFM_FILERECV_SECTION];
        [filesRecv removeObject:file];
        [delegate fileManager:self didRemoveFile:file inSection:FDFM_FILERECV_SECTION];
    }
    [KBPacket writeCancelFile:file toSocket:client.socket];
}


-(FDFile*)getFileRecvFromID:(NSString*)fID {
    for (FDFile *file in filesRecv) {
        if ([[file fileID] isEqualToString:fID]) {
            return file;
        }
    }
    return nil;
}
-(FDFile*)getFileSendFromID:(NSString*)fID {
    for (FDFile *file in filesSend) {
        if ([[file fileID] isEqualToString:fID]) {
            return file;
        }
    }
    return nil;
}
-(FDFile*)getFileFromID:(NSString*)fID {
    FDFile *fSend = [self getFileSendFromID:fID];
    return fSend ? fSend : [self getFileRecvFromID:fID];
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
    [delegate fileManager:self willInsertFile:file inSection:FDFM_FILESEND_SECTION];
    [filesSend addObject:file];
    [delegate fileManager:self didInsertFile:file inSection:FDFM_FILESEND_SECTION];
    [KBPacket writeInitFile:file toSocket:client.socket];
}

#pragma mark File Recv (Private)
-(void)addFileFromMeta:(NSDictionary*)meta {
    FDFileRecv *file = [[FDFileRecv alloc] initWithMeta:meta];
    [delegate fileManager:self willInsertFile:file inSection:FDFM_FILERECV_SECTION];
    [filesRecv addObject:file];
    [delegate fileManager:self didInsertFile:file inSection:FDFM_FILERECV_SECTION];
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
-(NSArray*)activeFilesInSection:(NSUInteger)section {
    NSMutableArray *active = [NSMutableArray new];
    NSArray *objs = [self filesInSection:section];
    for (FDFile *file in objs) {
        if (file.isAccepted && !file.isPaused) {
            [active addObject:file];
        }
    }
    return active;
}
-(FDFile*)fileInSection:(NSUInteger)section atIndex:(NSUInteger)ind {
    return [[self filesInSection:section] objectAtIndex:ind];
}

@end
