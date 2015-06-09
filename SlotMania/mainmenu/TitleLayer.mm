//
//  TitleLayer.m
//  hotair
//
//  Created by admin on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TitleLayer.h"
#import "ResourceManager.h"
#import "GameLayer.h"
#import "DeviceSettings.h"
#import "AppSettings.h"
#import "Button.h"
#import "SoundManager.h"
#import "SCSprite.h"

@implementation TitleLayer

-(id) init {
    if((self = [super init])){
        m_appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [self initData];
        [self initImages];
        [self initLabels];
        [self initMenu];
    }
    return self;
}

-(void) initData {
    if (![AppSettings getStartFlag]) {
        [AppSettings setCoin:1000];
        [AppSettings setStartFlag];
        [AppSettings setLineCount:1];
        [AppSettings setMaxLineCount:1];
        [AppSettings setBetCount:1];
    }
}

-(void) initImages {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite* s = [CCSprite spriteWithFile: IS_IPHONE5()?HD_568(@"menu_bg.png"):SD_OR_PD(@"menu_bg.png")];
    [s setPosition: ccp(winSize.width / 2, winSize.height / 2)];
    [self addChild: s];
    
    NSString* strFileName = [[ResourceManager sharedResourceManager] makeFileName:@"coin_box" ext:@"png"];
    SCSprite* sprCoinBox = [SCSprite spriteWithSpriteFrameName:strFileName];
    [sprCoinBox setPosition:ccp(iDevPixelX(82), iDevPixelY(300))];
    [self addChild:sprCoinBox];
    
    strFileName = [[ResourceManager sharedResourceManager] makeFileName:@"coin_add" ext:@"png"];
    SCSprite *sprCoinAdd = [SCSprite spriteWithSpriteFrameName:strFileName];
    [sprCoinAdd setPosition:ccp(iDevPixelX(20), iDevPixelY(300))];
    [self addChild:sprCoinAdd];
    
    strFileName = [[ResourceManager sharedResourceManager] makeFileName:@"number_box" ext:@"png"];
    SCSprite *sprNumBox = [SCSprite spriteWithSpriteFrameName:strFileName];
    [sprNumBox setPosition:ccp(iDevPixelX(255), iDevPixelY(300))];
    [self addChild:sprNumBox];
}

-(void) initLabels {
    int nCoin = [AppSettings getCoin];
    m_lblScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", nCoin] fontName:@"Thonburi" fontSize:iDevSize(16.0f)];
    [self addChild:m_lblScore z:1];
    m_lblScore.position = ccp(iDevPixelX(85), iDevPixelY(300));
}

-(void) initMenu {
    [self initStages];
    [self initControls];
    
}

-(void) initStages {
    float fx, fy;
    NSString* str[6] = {@"zombies" ,@"pirates" ,@"jewels" ,@"fruit" ,@"cash" ,@"dragons"};
    for (int i = 0; i < 6; i++) {
        fx = iDevPixelX(90) + iDevPixelX(150) * (i % 3);
        fy = iDevPixelY(220) - iDevPixelY(120) * (i / 3);
        
        m_menuItem[i] = [GrowButton buttonWithSpriteFrame:str[i] 
                                          selectframeName:str[i] 
                                                      tag:i 
                                                   target:self 
                                                 selector:@selector(onLoadgame:)];
        [m_menuItem[i] setPosition:ccp(fx, fy)];
        [self addChild:m_menuItem[i]];
    }    
}

-(void) initControls {
    CCMenuItem* sendGifts = [Button itemFromFrameName:@"send_gifts_nor"
                                    selectedFrameName:@"send_gifts_on" 
                                              tartget:self 
                                             selector:@selector(menuSendGifts:)];
    [sendGifts setPosition:ccp(iDevPixelX(80), iDevPixelY(26))];
    
    
    CCMenuItem* collectGifts = [Button itemFromFrameName:@"collect_gifts_nor" 
                                    selectedFrameName:@"collect_gifts_on" 
                                              tartget:self 
                                             selector:@selector(menuCollectGifts:)];
    [collectGifts setPosition:ccp(iDevPixelX(240), iDevPixelY(26))];
    
    CCMenuItem* collectNow = [Button itemFromFrameName:@"collect_now_nor" 
                                       selectedFrameName:@"collect_now_on" 
                                                 tartget:self 
                                                selector:@selector(menuCollectNow:)];
    [collectNow setPosition:ccp(iDevPixelX(400), iDevPixelY(26))];
    
    
    CCMenuItem* addCoin = [Button itemFromFrameName:@"coin_nor" 
                                     selectedFrameName:@"coin_on" 
                                               tartget:self 
                                              selector:@selector(menuAddCoin:)];
    if (IS_IPAD()) {
        [addCoin setPosition:ccp(iDevPixelX(132), iDevPixelY(300))];
    }
    else
        [addCoin setPosition:ccp(iDevPixelX(126), iDevPixelY(300))];
    
    
    CCMenuItem* mail = [Button itemFromFrameName:@"mail_nor" 
                                  selectedFrameName:@"mail_on" 
                                            tartget:self 
                                           selector:@selector(menuMail:)];
    [mail setPosition:ccp(iDevPixelX(385), iDevPixelY(300))];
    
   
    CCMenuItem* setting = [Button itemFromFrameName:@"setting_nor" 
                               selectedFrameName:@"setting_on" 
                                         tartget:self 
                                           selector:@selector(menuSetting:)];
    [setting setPosition:ccp(iDevPixelX(445), iDevPixelY(300))];
    ScaleMenu *menu = [ScaleMenu menuWithItems: sendGifts, collectGifts, collectNow, addCoin, mail, setting, nil];
    menu.position = CGPointZero;    
    [self addChild: menu];
}

-(void) onLoadgame:(id) sender {
    int tag = ((GrowButton*)sender).tag;
    [[SoundManager sharedSoundManager] playEffect:@"click.wav" bForce:YES];
    [AppSettings setCurrentStage: tag + 1];
    if (tag < 6)
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[GameLayer node]]];
}

-(void) menuSendGifts:(id) sender {

}

-(void) menuCollectGifts:(id) sender {

}

-(void) menuCollectNow:(id) sender {

}

-(void) menuAddCoin:(id) sender {
    
}

-(void) menuMail:(id) sender {
    
}

-(void) menuSetting:(id) sender {
    
}

-(void) dealloc{
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
