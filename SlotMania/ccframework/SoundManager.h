//
//  SoundManager.h
//  crashGame
//
//  Created by KCU on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"

@interface SoundManager : NSObject {
	SimpleAudioEngine *soundEngine;
	CDAudioManager* audioManager;
	
	BOOL mbBackgroundMute;
	BOOL mbEffectMute;
}

+ (SoundManager*) sharedSoundManager;
+ (void) releaseSoundManager;

- (id) init;

#pragma mark -
#pragma mark Load and unload sound.
- (void) loadData;
- (void) loadData: (NSString*) fileName;
- (void) unloadData: (NSString*) fileName;

- (void) loadBGM: (int) nID;
- (void) unloadBGM: (int) nID;

#pragma mark -
#pragma mark Play background and effect.

- (void) playEffect: (NSString*) strFile bForce: (BOOL) bForce;
- (void) playBackgroundMusic:(NSString*) strFile;
- (void) stopBackgroundMusic;
- (void) playRandomBackground;
- (void) playEffectWithID: (int) nEffectID bForce: (BOOL) bForce;

- (void) setBackgroundMusicMute: (BOOL) bMute;
- (void) setEffectMute: (BOOL) bMute;

- (BOOL) getBackgroundMusicMuted;
- (BOOL) getEffectMuted;

- (void) setBackgroundVolume: (float) fVolume;
- (void) setEffectVolume: (float) fVolume;

- (float) backgroundVolume;
- (float) effectVolume;

- (void) playBGM:(int) nID;
- (void) stopMusicID: (int) nID;

@end
