//
//  GameLayer.h
//  SlotoRama
//
//  Created by admin on 9/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SCSprite.h"
#import "Engine.h"
#import "ScoreLabel.h"

@interface GameLayer : CCLayer {
    enum zOrder {
        z_background,
        z_frame,
        z_particle,
        z_button,
        z_label,
        z_hold,
        z_coin
    };   
    enum tagOrder {
        tag_Frame,
        tag_Coin
    };
    SCSprite*           m_sprCharacter[CHARACTER_COUNT];
    
    ScoreLabel*         m_lblCoin;
    CCLabelTTF*         m_lblLines;
    CCLabelTTF*         m_lblBets;
    CCLabelTTF*         m_lblMaxLines;
    
    Engine              m_Eng;
    NSMutableArray*     m_arrParticle;
    NSMutableArray*     m_arrLine;
    NSMutableArray*     m_arrHold;
    NSMutableArray*     m_arrCoin;
    
    int     m_nCardXRev, m_nCardYRev, m_nCardXBetRev, m_nCardYBetRev;
    int     m_nSTPointY;
    int     m_nSlotTick;
    int     m_nTouchCol;
    int     m_nFrameCount;
    BOOL    m_bDrawRuleLine;
    BOOL    m_bIsAnim;
    
    BOOL    m_bIsCoinAnim;
}
-(void) initVariables;
-(void) initImages;
-(void) initButtons;
-(void) initLabels;
-(void) startSlot;
-(void) controlSlot;
-(void) drawCharacters;
-(void) drawHolds;
-(void) drawLine: (BOOL)bDrawRuleLine;
-(void) startParticleAnim: (CGPoint)pt charIndex: (int) charIndex;
-(void) endParticleAnim;
-(void) setInfo;
@end
