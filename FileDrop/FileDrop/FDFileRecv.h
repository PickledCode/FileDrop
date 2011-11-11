//
//  FDFileRecv.h
//  FileDrop
//
//  Created by Ryan Sullivan on 11/9/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDFile.h"

@interface FDFileRecv : FDFile {
    NSDictionary *_meta;
}

-(id)initWithMeta:(NSDictionary*)dict;

@end
