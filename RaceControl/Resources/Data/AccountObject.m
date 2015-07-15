//
//  AccountObject.m
//  CurrentCostApp
//
//  Created by texo on 9/12/14.
//  Copyright (c) 2014 TriHPM. All rights reserved.
//

#import "AccountObject.h"

@implementation AccountObject

+ (AccountObject*)accountInfoFromUserDefault
{
   /* if ([Utilities dataArchiverForKey: kAccount])
        return [DatabaseManager parseDataLogin: [Utilities dataArchiverForKey: kAccount]];*/
    
    if ([Utilities dataForKey:kAccount])
    {
        return [Utilities dataForKey:kAccount];
    }
    
    return nil;
}



@end
