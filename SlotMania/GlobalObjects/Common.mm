//
//  Common.m
//  Nature&Zombies
//
//  Created by admin on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Common.h"
#import "ResourceManager.h"
#import "AppDelegate.h"

@interface  Common()
+(void) addFrameWithName: (CCAnimation*) animation name:(NSString*) fileName highguality: (BOOL) highguality;
@end



@implementation Common

+ (float) adjustScale {
	
	float fScale = 1.0f;
#ifdef _DEBUG_TEST
	AppDelegate* app = [AppDelegate getDelegate];
	if( [app isIPhone3] ) {
		fScale = 1.0f;
	} else {
		fScale = 2.13f;
	}
#endif
	
	return fScale;
}

//------------------------------- Get the Animate by the animation string. -------------------//
+ (CCAnimate*) getAnimate: (NSString*) strAnimName count: (int) count delay: (float) fDelay
{
	return [self getAnimate: strAnimName first: 1 last: count start: 1 delay: fDelay];
}

+ (CCAnimate*) getAnimate: (NSString*) strAnimName first: (int) first last: (int) last delay: (float) fDelay
{
	return [self getAnimate: strAnimName first: first last: last start: first delay: fDelay];
}

+ (CCAnimate*) getAnimate: (NSString*) strAnimName first: (int) first last: (int) last start: (int) start delay: (float) fDelay
{
	return [self getAnimate: strAnimName first: first last: last start: first delay: fDelay highguality: YES];
}

+ (CCAnimate*) getAnimate: (NSString*) strAnimName
					first: (int) first
					 last: (int) last
					start: (int) start
					delay: (float) fDelay
			  highguality: (BOOL) highguality
{
//    ResourceManager* resManager = [ResourceManager sharedResourceManager];
    
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity: 0];
    
    NSString *fileName;
    CCAnimation *animation;
    
    animation = [CCAnimation animationWithFrames:frames delay: fDelay];
	
    for (int i = start; i <= last; i++)
    {
        fileName = [NSString stringWithFormat:@"%@%02i", strAnimName, i];
		[self addFrameWithName: animation name:fileName highguality: highguality];
    }
    
    for (int i = first; i < start; i++)
    {
        fileName = [NSString stringWithFormat:@"%@%02i", strAnimName, i];
		[self addFrameWithName: animation name:fileName highguality: highguality];
    }
	
    return [CCAnimate actionWithAnimation:animation];
}

+(void) addFrameWithName: (CCAnimation*) animation name:(NSString*) fileName highguality: (BOOL) highguality
{
    ResourceManager* resManager = [ResourceManager sharedResourceManager];
	
	if (highguality) {
		[animation addFrame: [resManager getSpriteFrameWithName:fileName]];
//		[animation addFrameWithFilename: [resManager makeFileName: fileName ext: @"png"]];
	}
	else {
	//	[animation addFrame: [resManager getSpriteFrameWithName_Zombie:fileName]];
//		[animation addFrameWithFilename: [resManager makeFileName: fileName ext: @"png"]];
	}
}

-(void) dealloc
{
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];	
    
    [super dealloc];
}

+ (void) purgeCachedData
{
//	[[CCDirector sharedDirector] purgeCachedData];
	
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];	
}

@end
