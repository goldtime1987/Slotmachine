//
//  SoundManager.m
//  crashGame
//
//  Created by KCU on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"
#include <sys/time.h>

#import "SoundDefs.h"


@implementation SoundManager

static SoundManager *_sharedSound = nil;
static NSString* strBGM[] =
{
    @"Spin.mp3",
    @"Wack.mp3",
    @"Street.mp3",
    @"Action.mp3",
    @"Life.mp3",
    @"Mad.mp3",
    @"Ride.mp3",
};

static NSString* strEffects[] =
{
    @"SFXBible_13477.wav",//generic button presses
    @"SFXBible_12403.wav",//collecting stars
    @"SFXBible_05134.wav",//Sound when die
    @"SFXBible_13528.wav",//Normal Jumping
    @"SFXBible_11648",//Sound while having any power up
    @"Cartoon Chipmunk.caf",//evil rabbit voice---------------------------------
    @"Cartoon Boing.mp3",//Rabbit Powerup Jumping-------------------------------
    @"SFXBible_00455.wav",//bird power up while flapping------------------------
    @"Electro Beep Accent 03.caf",//Getting powered up--------------------------
    @"SFXBible_12199.wav",//collecting powerups in level 
    @"Bell Transition.mp3",//Sound when collecting bigger stars
    @"SFXBible_01660.wav",//Sound of powercape use-------------------------------
    
    @"Cartoon Space Boing.caf",//Sound have powerwand bouncing off evil rabbit
    @"SFXBible_11324",//sound if you can`t do something
    @"Time Passing.mp3",//Sound just before powerup will be lost-----------------
    @"Electro Beep Accent 03.caf",//sound when any power up's are used
    
};


+ (SoundManager*) sharedSoundManager 
{
	if (!_sharedSound) 
	{
		_sharedSound = [[SoundManager alloc] init];
	}
	
	return _sharedSound;
}

+ (void) releaseSoundManager 
{
	if (_sharedSound) 
	{
		[_sharedSound release];
		_sharedSound = nil;
	}
}

- (id) init
{
	if ( (self=[super init]) )
	{
		soundEngine = [SimpleAudioEngine sharedEngine];
		audioManager = [CDAudioManager sharedManager];
		mbEffectMute = NO;
		mbBackgroundMute = NO;
        [self loadData];
	}
	
	return self;
}

- (void) loadData
{
}

- (void) playRandomBackground
{
}

#pragma mark -
#pragma mark Load and unload sound files.
- (void) loadData: (NSString*) fileName
{
    [soundEngine preloadEffect: fileName];
}

-(void) unloadData: (NSString*) fileName 
{
	[soundEngine unloadEffect: fileName];    
}

- (void) loadBGM: (int) nID 
{
    if(nID < 0 || nID > kBGMCount) return;
        
    [soundEngine preloadEffect: strBGM[nID]];
}
- (void) unloadBGM: (int) nID
{
    if(nID < 0 || nID > kBGMCount) return;
    
    [soundEngine unloadEffect: strBGM[nID]];
}

#pragma mark -
#pragma mark Play background and effect.

- (void) playEffect: (NSString*) strFile bForce: (BOOL) bForce
{
	if (strFile == nil)
		return;
	if (mbEffectMute)
		return;
	
	[soundEngine playEffect: strFile];
}

- (void) playEffectWithID: (int) nEffectID bForce: (BOOL) bForce
{
	if (mbEffectMute)
		return;
	
	[soundEngine playEffect: strEffects[nEffectID]];
}

- (void) playBackgroundMusic:(NSString*) strFile
{
	if (strFile == nil)
		return;
	if (mbBackgroundMute)
		return;
    
	[soundEngine playBackgroundMusic: strFile loop:TRUE];
}

-(void) stopBackgroundMusic
{
	[soundEngine stopBackgroundMusic];
}

- (void) setBackgroundMusicMute: (BOOL) bMute
{
	mbBackgroundMute = bMute;
    
    if(bMute)
        [soundEngine stopBackgroundMusic];
}

- (void) setEffectMute: (BOOL) bMute
{
	mbEffectMute = bMute;
}

- (BOOL) getBackgroundMusicMuted
{
	return mbBackgroundMute;
}

- (BOOL) getEffectMuted
{
	return mbEffectMute;
}

- (float) backgroundVolume
{
	return soundEngine.backgroundMusicVolume;
}

- (void) setBackgroundVolume: (float) fVolume
{
	soundEngine.backgroundMusicVolume = fVolume;
}

- (void) setEffectVolume: (float) fVolume
{
	soundEngine.effectsVolume = fVolume;
}

- (float) effectVolume
{
	return soundEngine.effectsVolume;
}

- (void) playBGM:(int) nID
{
    if (nID < 0 || nID >= kBGMCount)
		return;
	if (mbBackgroundMute)
		return;
    
	[soundEngine playBackgroundMusic: strBGM[nID] loop:TRUE];
}

- (void) stopMusicID: (int) nID
{
    if (nID < 0 || nID >= kBGMCount)
		return;
    
    [soundEngine stopEffect: nID];
}
- (void) dealloc
{
	[super dealloc];
}
@end
