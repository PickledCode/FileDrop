//
//  NSError+FDAdditions.m
//  FileDrop
//
//  Created by Indragie Karunaratne on 11-11-11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "NSError+FDAdditions.h"

static NSString* const kGenericErrorDomain = @"FDGenericErrorDomain";
static NSInteger const kGenericErrorCode = 9999;

@implementation NSError (FDAdditions)
+ (NSError*)genericErrorWithDescription:(NSString*)description recoveryText:(NSString*)recovery
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:description, NSLocalizedDescriptionKey, recovery, NSLocalizedRecoverySuggestionErrorKey, nil];
    return [NSError errorWithDomain:kGenericErrorDomain code:kGenericErrorCode userInfo:userInfo];
    
}
@end
