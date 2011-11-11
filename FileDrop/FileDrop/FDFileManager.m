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
        
    }
    return self;
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

@end
