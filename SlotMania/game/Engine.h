//
//  Engine.h
//  SlotoRama
//
//  Created by admin on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef SlotMania_Engine_h
#define SlotMania_Engine_h

#include "stdlib.h"
#include <vector>
#include "Constants.h"

struct GAMERESULT_ {
    int nRuleLineIndex;
    int nEqualCount;
    int nCharacterIndex;
};

typedef std::vector<GAMERESULT_> TGameResult;

class Engine {
    void InitCardStartPosY(int nColIndex);
    
public:
    Engine();
    void getInfo();
    void InitVariable();
    void LoadSlot();
    void InitSlot();
    void ProcessSlot(int);    
    void SetCardBetweenY(float fBetweenY);
    void ResetSlot(int);
    void CompareCards();
    void MoveSlot(int);
    void SetState(int, int);
    bool isStopAllSlots();
    
    int         m_nArrSlot[ROW_][COL_];
    int         m_nArrTempSlot[CHARACTER_COUNT][COL_];
    float       m_fBetweenY;
    float       m_fMovingY[COL_];
    bool        m_bSloting[COL_];
    int         m_nRuleLineCount;
    int         m_nRowIndex[COL_];
    int         m_nMaxLineCount;
    
    int         m_nBet;
    int         m_nGameCoin;
    bool        m_bStartSlot;
    bool        m_bHit;
    bool        m_bLoad;
    
    float       m_fPrevStep[COL_];
    float       m_fMovingYStep[COL_];
    int         m_nSlotTick[COL_];
    NSString*   m_strState[COL_];
   
    TGameResult m_vecGameResult;
};

extern int nArrRules[RULE_LINE_COUNT][COL_][2];
#endif
