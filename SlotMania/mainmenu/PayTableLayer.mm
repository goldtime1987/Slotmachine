//
//  PayTableLayer.m
//  hotair
//
//  Created by admin on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PayTableLayer.h"
#import "ResourceManager.h"
#import "SoundManager.h"
#import "GameLayer.h"
#import "GrowButton.h"
#import "DeviceSettings.h"
#import "AppSettings.h"

@implementation PayTableLayer

-(id) init {
    if((self = [super init])){
        [self initTable];
    }
    return self;
}

-(void) initTable {
    int curStage = [AppSettings getCurrentStage];
    NSString* strFileName = [NSString stringWithFormat: @"pay_table%d.png", curStage];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite* s = [CCSprite spriteWithFile: IS_IPHONE5()?HD_568(strFileName):SD_OR_PD(strFileName)];
    [s setPosition: ccp(winSize.width / 2, winSize.height / 2)];
    [self addChild: s];
    
   /* CCSprite *sprBg = [[ResourceManager sharedResourceManager] getSpriteWithName:strFileName];
    [sprBg setPosition:ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    sprBg.scale *= 2.0f;
    [self addChild:sprBg];
    */
    
    GrowButton* btnBack = [GrowButton buttonWithSpriteFrame:@"pay_back" 
                                            selectframeName:@"pay_back" 
                                                        tag:0 
                                                     target:self 
                                                   selector:@selector(onBtnBack:)];
    
    [btnBack setPosition:ccp(iDevPixelX(440), iDevPixelY(265))];
    [self addChild:btnBack];
}

-(void) onBtnBack:(id) sender {
    [[SoundManager sharedSoundManager] playEffect:@"click.wav" bForce:YES];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[GameLayer node]]];
}

-(void) dealloc{
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
