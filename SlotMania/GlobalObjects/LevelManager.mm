//
//  LevelManager.m
//  Nature&Zombies
//
//  Created by WeiJinLong on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelManager.h"
#import "SynthesizeSingleton.h"
#import "AppDelegate.h"

@implementation LevelManager

SYNTHESIZE_SINGLETON_FOR_CLASS(LevelManager);

@synthesize m_nCurLevel;
@synthesize m_nTarget;
@synthesize m_arrDish;

-(void) createObjects 
{
	[self createLevelInfo: m_nCurLevel];
}

-(void) deleteObjects 
{
    [m_arrDish release];
}

-(void) resetObjects 
{
    [self deleteObjects];
    [self createObjects];
}

-(id) init
{
	if ((self = [super init]))
	{
        [self initGameInfo];
		[self createObjects]; 
	}
	return self;
}


-(void) dealloc 
{
    [self deleteObjects];
	[super dealloc];
}

-(void) initGameInfo
{
    
}


-(void) setLevel: (int) level
{
	m_nCurLevel = level;
    
    [self resetObjects];
}

-(void) createLevelInfo: (int) level
{
}


@end
