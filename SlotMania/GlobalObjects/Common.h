//
//  Common.h
//  Nature&Zombies
//
//  Created by admin on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface Common : NSObject {
    
}

+ (float) adjustScale;

+ (CCAnimate*) getAnimate: (NSString*) strAnimName count: (int) count delay: (float) fDelay;
+ (CCAnimate*) getAnimate: (NSString*) strAnimName first: (int) first last: (int) last delay: (float) fDelay;
+ (CCAnimate*) getAnimate: (NSString*) strAnimName first: (int) first last: (int) last start: (int) start delay: (float) fDelay;

+ (CCAnimate*) getAnimate: (NSString*) strAnimName
					first: (int) first
					 last: (int) last
					start: (int) start
					delay: (float) fDelay
			  highguality: (BOOL) highguality;

+ (void) purgeCachedData;

@end
