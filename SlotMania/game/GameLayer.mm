//
//  GameLayer.m
//  SlotoRama
//
//  Created by admin on 9/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "ResourceManager.h"
#import "SoundManager.h"
#import "GrowButton.h"
#import "DeviceSettings.h"
#import "TitleLayer.h"
#import "PayTableLayer.h"
#import "AppSettings.h"
#import "Particle.h"
#import "HoldLayer.h"
#import "CoinLayer.h"
#include "Constants.h"

@implementation GameLayer

-(id) init {
    if((self = [super init])){
        [self initVariables];
        [self initImages];
        [self initButtons];
        [self initLabels];
        [self drawLine: YES];
        [self schedule:@selector(onTime) interval:1.0f / 60.0f];
    }
    return self;
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) initVariables {
    self.isTouchEnabled = YES;
    m_nSlotTick         = -1;
    if (!IS_IPAD()) {
        m_nCardXRev     = iDevPixelX(18.0f);
        m_nCardYRev     = -iDevPixelY(1);
        m_nCardXBetRev  = -iDevPixelX(9.9f);
        m_nCardYBetRev  = -iDevPixelY(10);
    }
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if (winSize.width == 568) {
        m_nCardYBetRev  = -iDevPixelY(24);
        m_nCardXRev     = iDevPixelX(19);
    }
    
    m_arrParticle       = [[NSMutableArray alloc] init];
    m_arrLine           = [[NSMutableArray alloc] init];
    m_arrHold           = [[NSMutableArray alloc] init];
    m_arrCoin           = [[NSMutableArray alloc] init];
    m_Eng.SetCardBetweenY(CARD_BETWEEN_Y);
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) initImages {
    int nCurStage = [AppSettings getCurrentStage];
    NSString* strSub;
    NSString* strFileName = [NSString stringWithFormat: @"game_bg%d.png", nCurStage];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite* s = [CCSprite spriteWithFile: IS_IPHONE5()?HD_568(strFileName):SD_OR_PD(strFileName)];
    [s setPosition: ccp(winSize.width / 2, winSize.height / 2)];
    [self addChild: s];
        
   
    for(int i = 0; i < CHARACTER_COUNT; i++) {
        strSub = [NSString stringWithFormat: @"%@_%d", strIconName[i], nCurStage];
        strFileName = [[ResourceManager sharedResourceManager] makeFileName:strSub ext:@"png"];
        m_sprCharacter[i] = [[SCSprite spriteWithFile:strFileName] retain];
    }
    
    for (int i = 0; i < RULE_LINE_COUNT; i++) {        
        strSub = [NSString stringWithFormat: @"%dline", i+1];
        strFileName = [[ResourceManager sharedResourceManager] makeFileName:strSub ext:@"png"];
        SCSprite* sprLine = [SCSprite spriteWithSpriteFrameName:strFileName];
        [self addChild:sprLine];
        sprLine.position = ccp(SCREEN_WIDTH / 2, lineY[i]);
        sprLine.visible = NO;
        [m_arrLine addObject:sprLine];
    }    
    
    for (int i = 0; i < COL_; i++) {
        HoldLayer* sprHold = [HoldLayer node];
        [self addChild:sprHold z:z_hold];
        sprHold.position = ccp(CARD_START_X + m_nCardXRev + i * (CARD_BETWEEN_X + m_nCardXBetRev), iDevPixelY(68.6f));
        [m_arrHold addObject:sprHold]; 
    }
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) initButtons {
    GrowButton* btnPlayTable = [GrowButton buttonWithSpriteFrame:@"pay_table_nor"  
                                                 selectframeName:@"pay_table_on" 
                                                             tag:0
                                                          target:self 
                                                        selector:@selector(onPlayTable)];
    [self addChild:btnPlayTable z:z_button];
    btnPlayTable.position = ccp(iDevPixelX(34), iDevPixelY(32));
    
    GrowButton* btnLines = [GrowButton buttonWithSpriteFrame:@"line_nor" selectframeName:@"line_on" tag:0 target:self selector:@selector(onLines)];
    [self addChild:btnLines z:z_button];
    btnLines.position = ccp(iDevPixelX(114), iDevPixelY(17));
    
    GrowButton* btnBet = [GrowButton buttonWithSpriteFrame:@"bet_nor" 
                                           selectframeName:@"bet_on"
                                                       tag:0 
                                                    target:self  
                                                  selector:@selector(onBet)];
    [self addChild:btnBet z:z_button];
    btnBet.position = ccp(iDevPixelX(316), iDevPixelY(17));
    
    GrowButton* btnMaxLine = [GrowButton buttonWithSpriteFrame:@"max_lines_nor" 
                                               selectframeName:@"max_lines_on"
                                                           tag:0 
                                                        target:self  
                                                      selector:@selector(onMaxLines)];
    [self addChild:btnMaxLine z:z_button];
    btnMaxLine.position = ccp(iDevPixelX(214), iDevPixelY(17));
    
    GrowButton* btnSpin = [GrowButton buttonWithSpriteFrame:@"spin_nor" 
                                            selectframeName:@"spin_on" 
                                                        tag:0 
                                                     target:self  
                                                   selector:@selector(onSpin)];
    [self addChild:btnSpin z:z_button];
    btnSpin.position = ccp(iDevPixelX(448), iDevPixelY(32));
    
    GrowButton* btnBack = [GrowButton buttonWithSpriteFrame:@"buy_nor" 
                                            selectframeName:@"buy_on" 
                                                        tag:0 
                                                     target:self 
                                                   selector:@selector(onBack)];
    
    [self addChild:btnBack z:z_button];
    btnBack.position = ccp(SCREEN_WIDTH / 2, SCREEN_HEIGHT - iDevPixelY(10));
    
    GrowButton* btnBuy = [GrowButton buttonWithSpriteFrame:@"coin_nor1" 
                                           selectframeName:@"coin_on1" 
                                                       tag:0 
                                                    target:self 
                                                  selector:@selector(onCoinBuy)];
    [self addChild:btnBuy z:z_button];
    btnBuy.position = ccp(iDevPixelX(40), SCREEN_HEIGHT - iDevPixelY(25));
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) initLabels {
    m_lblCoin = [ScoreLabel createWithVal:m_Eng.m_nGameCoin];
    [self addChild:m_lblCoin z:z_label];
    m_lblCoin.position = ccp(iDevPixelX(170), iDevPixelY(285));
        
    m_lblLines = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", m_Eng.m_nRuleLineCount] fontName:@"Thonburi" fontSize:iDevSize(16.0f)];
    [self addChild:m_lblLines z:z_label];
    m_lblLines.position = ccp(iDevPixelX(115), iDevPixelY(40));
    
    m_lblMaxLines = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", m_Eng.m_nMaxLineCount] fontName:@"Thonburi" fontSize:iDevSize(16.0f)];
    [self addChild:m_lblMaxLines z:z_label];
    m_lblMaxLines.position = ccp(iDevPixelX(220), iDevPixelY(40));
    
    m_lblBets = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", m_Eng.m_nBet] fontName:@"Thonburi" fontSize:iDevSize(16.0f)];
    [self addChild:m_lblBets z:z_label];
    m_lblBets.position = ccp(iDevPixelX(315), iDevPixelY(40));
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) onTime {
    [self controlSlot];
}

#pragma mark -
#pragma mark slot move start.
/////////////////////////////////////////////////////////////////////////////////////
-(void) startSlot {
    if (m_Eng.m_bStartSlot)
        return;
    if (m_Eng.m_nGameCoin < m_Eng.m_nBet * m_Eng.m_nRuleLineCount) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"Coin is insufficient.\n If you continue purchase coins." 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (m_bIsAnim) {
        [self endParticleAnim];
        m_bIsAnim = false;
    }
    m_nSlotTick = 0;
    m_Eng.m_vecGameResult.clear();
    [self drawLine:NO];
    for(int i = 0; i < COL_; i++)
        m_Eng.m_bSloting[i] = true;
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) controlSlot {
    m_Eng.ProcessSlot(m_nSlotTick);    
    
    if(m_Eng.isStopAllSlots()){
        if(m_Eng.m_bStartSlot)
            [self schedule:@selector(compareCards) interval:0.5f];
    }else
        m_Eng.m_bStartSlot = true;
    
    if(m_nSlotTick > -1){
        m_nSlotTick ++;
        if(m_nSlotTick > 2 * TICK){
            int nCols = m_nSlotTick / TICK - 1;
            if(m_nSlotTick % 10 == 0)
                if(nCols < 6)
                    m_Eng.m_strState[nCols - 1] = @"last";
                else if(m_Eng.m_bSloting[COL_ - 1] == false)
                    m_nSlotTick = -1;
        }
    }
}

-(void) coinAnim {
    if([m_arrCoin count] < 15) {
        CoinLayer* coin = [CoinLayer node];
        [self addChild:coin z:z_coin tag:tag_Coin];
        [coin setPosition:ccp(SCREEN_WIDTH/2, iDevPixelY(50))];
        [m_arrCoin addObject: coin];
    }
    else if ([(CoinLayer*)[m_arrCoin objectAtIndex:14] position].y > SCREEN_HEIGHT - iDevPixelY(40)) {
        [m_arrCoin removeAllObjects];
        [self unschedule:@selector(coinAnim)];
    }
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) compareCards {
    int nCardX = CARD_START_X + m_nCardXRev;
    int nCardY = CARD_START_Y + m_nCardYRev;
    int nCardBetweenX = CARD_BETWEEN_X + m_nCardXBetRev;
    int nCardBetweenY = CARD_BETWEEN_Y + m_nCardYBetRev;
    [self unschedule:@selector(compareCards)];
    int nPrevCoin = m_Eng.m_nGameCoin;
    m_Eng.CompareCards();
    if(m_Eng.m_bHit) {
        [self schedule:@selector(coinAnim) interval:1.0f / 15.0f];
    }
    [m_lblCoin setVal:m_Eng.m_nGameCoin prevVal:nPrevCoin];
    
    if(m_Eng.isStopAllSlots()) {
        if( (m_Eng.m_vecGameResult.size() > 0) && !m_bIsAnim ){
            m_bIsAnim= true;
            TGameResult::iterator it = m_Eng.m_vecGameResult.begin(), itEnd = m_Eng.m_vecGameResult.end();
            for (; it != itEnd; it++) {
                int nRuleIndex = (*it).nRuleLineIndex;
                int nEqualCount = (*it).nEqualCount;
                int nCharIndex = (*it).nCharacterIndex;
                ((CCSprite*)[m_arrLine objectAtIndex:nRuleIndex]).visible = YES;
                
                for(int j = 0; j < nEqualCount; j++){
                    CGPoint ptCardPos = ccp(nCardX + nArrRules[nRuleIndex][j][1] * nCardBetweenX, 
                                            nCardY - (nArrRules[nRuleIndex][j][0] - 1) * nCardBetweenY);
                    
                    CGPoint ptt;
                    ptt = ccp(ptCardPos.x, ptCardPos.y);
                    
                    NSString* strFileName = [[ResourceManager sharedResourceManager] makeFileName:@"character_frame" ext:@"png"];
                    SCSprite* sprFrame = [SCSprite spriteWithSpriteFrameName:strFileName];
                    [self addChild:sprFrame z:z_frame tag:tag_Frame];
                    sprFrame.position = ptt;
                    m_nFrameCount++;
                    [self startParticleAnim: ptt charIndex:nCharIndex];
                }
            }
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) draw {
    [self drawCharacters];
    [self drawHolds];
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) drawCharacters {
    int nCardX = CARD_START_X + m_nCardXRev;
    int nCardY = CARD_START_Y + m_nCardYRev;
    int nCardBetweenX = CARD_BETWEEN_X + m_nCardXBetRev;
    int nCardBetweenY = CARD_BETWEEN_Y + m_nCardYBetRev;
    for(int i = 0; i < ROW_; i++){
        for(int j = 0; j < COL_; j++){
            int nCardType = m_Eng.m_nArrSlot[i][j];
            CCSprite* spr = m_sprCharacter[nCardType];
            CGPoint ptPos = ccp(nCardX + j * nCardBetweenX, nCardY - (i - 1) * nCardBetweenY - m_Eng.m_fMovingY[j]);
            spr.position = ptPos;
            [spr visit];
        }
    }    
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) drawHolds {
    for (int i = 0; i < COL_; i++) {
        if (!m_Eng.m_bSloting[i]) {
            [(HoldLayer*)([m_arrHold objectAtIndex:i]) disappear];
        }
        else{
            [(HoldLayer*)([m_arrHold objectAtIndex:i]) appear];
        }
            
    }
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) drawLine: (BOOL)bDrawRuleLine {
    if ([AppSettings getPayTableFlag]) {
        [AppSettings setPayTableFlag:NO];
        return;
    }
    for(int i = 0; i < RULE_LINE_COUNT; i++){
        if (i <  m_Eng.m_nRuleLineCount)
            ((CCSprite*)[m_arrLine objectAtIndex:i]).visible = bDrawRuleLine;
        else 
            ((CCSprite*)[m_arrLine objectAtIndex:i]).visible = NO;
    }
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) startParticleAnim: (CGPoint)pt charIndex:(int)charIndex {
    Particle* particle = (Particle*)[Particle startAnim:charIndex];
    [self addChild:particle z:z_particle];
    particle.position = ccp(pt.x, pt.y); 
    [m_arrParticle addObject:particle];
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) endParticleAnim {
    for (int i = 0; i < [m_arrParticle count]; i++) {
        [[m_arrParticle objectAtIndex:i] remove];
    }
    [m_arrParticle removeAllObjects];
    for (int i = 0; i < m_nFrameCount; i++) {
        [self removeChildByTag:tag_Frame cleanup:YES];
    }
}

-(void) setInfo {
    [AppSettings setCoin:m_Eng.m_nGameCoin];
    [AppSettings setLineCount:m_Eng.m_nRuleLineCount];
    [AppSettings setMaxLineCount:m_Eng.m_nMaxLineCount];
    [AppSettings setBetCount:m_Eng.m_nBet];
}

/////////////////////////////////////////////////////////////////////////////////////
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * pTouch = [touches anyObject];
	CGPoint location = [pTouch locationInView: [pTouch view]];    
    m_nSTPointY = location.y;
    for(int i = 0; i < COL_; i++){        
        CGRect rCols = CGRectMake(CARD_START_X - CARD_BETWEEN_X / 2.0f + i * CARD_BETWEEN_X, 
                                  CARD_START_Y + CARD_BETWEEN_Y / 2.0f - CARD_BETWEEN_Y * (ROW_ - 1), 
                                  CARD_BETWEEN_X, 
                                  CARD_BETWEEN_Y * (ROW_ - 1));
        if(CGRectContainsPoint(rCols, location)){
            m_nTouchCol = i;
            m_Eng.m_strState[i] = @"last";
            //m_Eng.m_bSloting[i] = false;
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * pTouch = [touches anyObject];
	CGPoint location = [pTouch locationInView: [pTouch view]];    
    
    for(int i = 0; i < COL_; i++){        
        CGRect rCols = CGRectMake(CARD_START_X - CARD_BETWEEN_X / 2.0f + i * CARD_BETWEEN_X, 
                                  CARD_START_Y + CARD_BETWEEN_Y / 2.0f - CARD_BETWEEN_Y * (ROW_ - 1), 
                                  CARD_BETWEEN_X, 
                                  CARD_BETWEEN_Y * (ROW_ - 1));
        if(CGRectContainsPoint(rCols, location)){
            if (i==m_nTouchCol && location.y > m_nSTPointY) {
                [self startSlot];
            }
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) onPlayTable {
    [[SoundManager sharedSoundManager] playEffect:@"click.wav" bForce:YES];
    if (m_Eng.m_bStartSlot)
        return;
    NSString* strSlot = @"";
    NSString* strTempSlot = @"";
    NSString* strRowIndex = @"";
    NSString* strGameResult = @"";
    for (int i = 0; i < CHARACTER_COUNT; i++) {
        for (int j = 0; j < COL_; j++) { 
            if (i==0) {
                strRowIndex = [strRowIndex stringByAppendingFormat:@"%c", m_Eng.m_nRowIndex[j] + 1];
            }
            if (i < ROW_)
                strSlot = [strSlot stringByAppendingFormat:@"%c", m_Eng.m_nArrSlot[i][j] + 1];
            strTempSlot = [strTempSlot stringByAppendingFormat:@"%c", m_Eng.m_nArrTempSlot[i][j] + 1];
        }
    }
    int nCount = 0;
    TGameResult::iterator it = m_Eng.m_vecGameResult.begin(), itEnd = m_Eng.m_vecGameResult.end();
    for (; it != itEnd; it++) {
        strGameResult = [strGameResult stringByAppendingFormat:@"%c", (*it).nRuleLineIndex + 1];
        strGameResult = [strGameResult stringByAppendingFormat:@"%c", (*it).nEqualCount + 1];
        strGameResult = [strGameResult stringByAppendingFormat:@"%c", (*it).nCharacterIndex + 1];
        nCount++;
    }
    [AppSettings setGameResult:strGameResult];
    [AppSettings setGameResultCount:nCount];
    
    [self setInfo];
    [AppSettings setPayTableFlag:YES];
    [AppSettings setSlot:strSlot];
    [AppSettings setTempSlot:strTempSlot];
    [AppSettings setRowIndex:strRowIndex];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInB transitionWithDuration:0.7 scene:[PayTableLayer node]]];
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) onBet {
    [[SoundManager sharedSoundManager] playEffect:@"click.wav" bForce:YES];
    if (m_Eng.m_bStartSlot)
        return;
    m_Eng.m_nBet++;
    if (m_Eng.m_nBet > 10)
        m_Eng.m_nBet = 1;
    [m_lblBets setString:[NSString stringWithFormat:@"%d", m_Eng.m_nBet]];    
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) onLines {
    [[SoundManager sharedSoundManager] playEffect:@"click.wav" bForce:YES];
    if (m_Eng.m_bStartSlot)
        return;
    m_Eng.m_nRuleLineCount ++;
    if(m_Eng.m_nRuleLineCount > m_Eng.m_nMaxLineCount)
        m_Eng.m_nRuleLineCount = 1;
    [m_lblLines setString:[NSString stringWithFormat:@"%d", m_Eng.m_nRuleLineCount]];
    [self drawLine:YES];
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) onMaxLines {
    [[SoundManager sharedSoundManager] playEffect:@"click.wav" bForce:YES];
    if (m_Eng.m_bStartSlot)
        return;
    m_Eng.m_nMaxLineCount++;
    if(m_Eng.m_nMaxLineCount > RULE_LINE_COUNT)
        m_Eng.m_nMaxLineCount = 1;
    m_Eng.m_nRuleLineCount = m_Eng.m_nMaxLineCount;
    [m_lblLines setString:[NSString stringWithFormat:@"%d", m_Eng.m_nRuleLineCount]];
    [m_lblMaxLines setString:[NSString stringWithFormat:@"%d", m_Eng.m_nMaxLineCount]];
    [self drawLine:YES];
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) onSpin {
    [[SoundManager sharedSoundManager] playEffect:@"click.wav" bForce:YES];
    [self startSlot];
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) onBack {
    [[SoundManager sharedSoundManager] playEffect:@"click.wav" bForce:YES];
    [self setInfo];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[TitleLayer node]]];
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) onCoinBuy {
}

/////////////////////////////////////////////////////////////////////////////////////
-(void) dealloc {
    for(int i = 0; i < CHARACTER_COUNT; i++)
        [m_sprCharacter[i] release];
    
    [self removeAllChildrenWithCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
