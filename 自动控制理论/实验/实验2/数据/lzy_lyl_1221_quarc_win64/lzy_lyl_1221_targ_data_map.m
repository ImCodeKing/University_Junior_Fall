    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 7;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (lzy_lyl_1221_P)
        ;%
            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% lzy_lyl_1221_P.CompareToConstant_const
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% lzy_lyl_1221_P.HILWriteAnalog_channels
                    section.data(1).logicalSrcIdx = 1;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 41;
            section.data(41)  = dumData; %prealloc

                    ;% lzy_lyl_1221_P.Gain3_Gain
                    section.data(1).logicalSrcIdx = 2;
                    section.data(1).dtTransOffset = 0;

                    ;% lzy_lyl_1221_P.Gain_Gain
                    section.data(2).logicalSrcIdx = 3;
                    section.data(2).dtTransOffset = 4;

                    ;% lzy_lyl_1221_P.HILInitialize_OOTerminate
                    section.data(3).logicalSrcIdx = 4;
                    section.data(3).dtTransOffset = 8;

                    ;% lzy_lyl_1221_P.HILInitialize_OOExit
                    section.data(4).logicalSrcIdx = 5;
                    section.data(4).dtTransOffset = 9;

                    ;% lzy_lyl_1221_P.HILInitialize_OOStart
                    section.data(5).logicalSrcIdx = 6;
                    section.data(5).dtTransOffset = 10;

                    ;% lzy_lyl_1221_P.HILInitialize_OOEnter
                    section.data(6).logicalSrcIdx = 7;
                    section.data(6).dtTransOffset = 11;

                    ;% lzy_lyl_1221_P.HILInitialize_AOFinal
                    section.data(7).logicalSrcIdx = 8;
                    section.data(7).dtTransOffset = 12;

                    ;% lzy_lyl_1221_P.HILInitialize_POFinal
                    section.data(8).logicalSrcIdx = 9;
                    section.data(8).dtTransOffset = 13;

                    ;% lzy_lyl_1221_P.HILInitialize_OOFinal
                    section.data(9).logicalSrcIdx = 10;
                    section.data(9).dtTransOffset = 14;

                    ;% lzy_lyl_1221_P.HILInitialize_AIHigh
                    section.data(10).logicalSrcIdx = 11;
                    section.data(10).dtTransOffset = 17;

                    ;% lzy_lyl_1221_P.HILInitialize_AILow
                    section.data(11).logicalSrcIdx = 12;
                    section.data(11).dtTransOffset = 18;

                    ;% lzy_lyl_1221_P.HILInitialize_AOHigh
                    section.data(12).logicalSrcIdx = 13;
                    section.data(12).dtTransOffset = 19;

                    ;% lzy_lyl_1221_P.HILInitialize_AOLow
                    section.data(13).logicalSrcIdx = 14;
                    section.data(13).dtTransOffset = 20;

                    ;% lzy_lyl_1221_P.HILInitialize_AOInitial
                    section.data(14).logicalSrcIdx = 15;
                    section.data(14).dtTransOffset = 21;

                    ;% lzy_lyl_1221_P.HILInitialize_AOWatchdog
                    section.data(15).logicalSrcIdx = 16;
                    section.data(15).dtTransOffset = 22;

                    ;% lzy_lyl_1221_P.HILInitialize_POFrequency
                    section.data(16).logicalSrcIdx = 17;
                    section.data(16).dtTransOffset = 23;

                    ;% lzy_lyl_1221_P.HILInitialize_POLeading
                    section.data(17).logicalSrcIdx = 18;
                    section.data(17).dtTransOffset = 24;

                    ;% lzy_lyl_1221_P.HILInitialize_POTrailing
                    section.data(18).logicalSrcIdx = 19;
                    section.data(18).dtTransOffset = 25;

                    ;% lzy_lyl_1221_P.HILInitialize_POInitial
                    section.data(19).logicalSrcIdx = 20;
                    section.data(19).dtTransOffset = 26;

                    ;% lzy_lyl_1221_P.HILInitialize_OOInitial
                    section.data(20).logicalSrcIdx = 21;
                    section.data(20).dtTransOffset = 27;

                    ;% lzy_lyl_1221_P.HILInitialize_OOWatchdog
                    section.data(21).logicalSrcIdx = 22;
                    section.data(21).dtTransOffset = 30;

                    ;% lzy_lyl_1221_P.Gain2_Gain
                    section.data(22).logicalSrcIdx = 23;
                    section.data(22).dtTransOffset = 33;

                    ;% lzy_lyl_1221_P.Constant1_Value
                    section.data(23).logicalSrcIdx = 24;
                    section.data(23).dtTransOffset = 34;

                    ;% lzy_lyl_1221_P.Bias_Bias
                    section.data(24).logicalSrcIdx = 25;
                    section.data(24).dtTransOffset = 35;

                    ;% lzy_lyl_1221_P.Constant_Value
                    section.data(25).logicalSrcIdx = 26;
                    section.data(25).dtTransOffset = 36;

                    ;% lzy_lyl_1221_P.SignalGenerator1_Amplitude
                    section.data(26).logicalSrcIdx = 27;
                    section.data(26).dtTransOffset = 37;

                    ;% lzy_lyl_1221_P.SignalGenerator1_Frequency
                    section.data(27).logicalSrcIdx = 28;
                    section.data(27).dtTransOffset = 38;

                    ;% lzy_lyl_1221_P.Gain2_Gain_p
                    section.data(28).logicalSrcIdx = 29;
                    section.data(28).dtTransOffset = 39;

                    ;% lzy_lyl_1221_P.Gain1_Gain
                    section.data(29).logicalSrcIdx = 30;
                    section.data(29).dtTransOffset = 40;

                    ;% lzy_lyl_1221_P.Gain_Gain_i
                    section.data(30).logicalSrcIdx = 31;
                    section.data(30).dtTransOffset = 41;

                    ;% lzy_lyl_1221_P.TransferFcn_A
                    section.data(31).logicalSrcIdx = 32;
                    section.data(31).dtTransOffset = 42;

                    ;% lzy_lyl_1221_P.TransferFcn_C
                    section.data(32).logicalSrcIdx = 33;
                    section.data(32).dtTransOffset = 43;

                    ;% lzy_lyl_1221_P.TransferFcn_D
                    section.data(33).logicalSrcIdx = 34;
                    section.data(33).dtTransOffset = 44;

                    ;% lzy_lyl_1221_P.TransferFcn1_A
                    section.data(34).logicalSrcIdx = 35;
                    section.data(34).dtTransOffset = 45;

                    ;% lzy_lyl_1221_P.TransferFcn1_C
                    section.data(35).logicalSrcIdx = 36;
                    section.data(35).dtTransOffset = 46;

                    ;% lzy_lyl_1221_P.TransferFcn1_D
                    section.data(36).logicalSrcIdx = 37;
                    section.data(36).dtTransOffset = 47;

                    ;% lzy_lyl_1221_P.Gain_Gain_e
                    section.data(37).logicalSrcIdx = 38;
                    section.data(37).dtTransOffset = 48;

                    ;% lzy_lyl_1221_P.Gain_Gain_h
                    section.data(38).logicalSrcIdx = 39;
                    section.data(38).dtTransOffset = 49;

                    ;% lzy_lyl_1221_P.Saturation_UpperSat
                    section.data(39).logicalSrcIdx = 40;
                    section.data(39).dtTransOffset = 50;

                    ;% lzy_lyl_1221_P.Saturation_LowerSat
                    section.data(40).logicalSrcIdx = 41;
                    section.data(40).dtTransOffset = 51;

                    ;% lzy_lyl_1221_P.Gain1_Gain_d
                    section.data(41).logicalSrcIdx = 42;
                    section.data(41).dtTransOffset = 52;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section

            section.nData     = 8;
            section.data(8)  = dumData; %prealloc

                    ;% lzy_lyl_1221_P.HILInitialize_CKChannels
                    section.data(1).logicalSrcIdx = 43;
                    section.data(1).dtTransOffset = 0;

                    ;% lzy_lyl_1221_P.HILInitialize_DOWatchdog
                    section.data(2).logicalSrcIdx = 44;
                    section.data(2).dtTransOffset = 1;

                    ;% lzy_lyl_1221_P.HILInitialize_EIInitial
                    section.data(3).logicalSrcIdx = 45;
                    section.data(3).dtTransOffset = 2;

                    ;% lzy_lyl_1221_P.HILInitialize_POModes
                    section.data(4).logicalSrcIdx = 46;
                    section.data(4).dtTransOffset = 3;

                    ;% lzy_lyl_1221_P.HILInitialize_POConfiguration
                    section.data(5).logicalSrcIdx = 47;
                    section.data(5).dtTransOffset = 4;

                    ;% lzy_lyl_1221_P.HILInitialize_POAlignment
                    section.data(6).logicalSrcIdx = 48;
                    section.data(6).dtTransOffset = 5;

                    ;% lzy_lyl_1221_P.HILInitialize_POPolarity
                    section.data(7).logicalSrcIdx = 49;
                    section.data(7).dtTransOffset = 6;

                    ;% lzy_lyl_1221_P.HILReadEncoderTimebase_Clock
                    section.data(8).logicalSrcIdx = 50;
                    section.data(8).dtTransOffset = 7;

            nTotData = nTotData + section.nData;
            paramMap.sections(4) = section;
            clear section

            section.nData     = 8;
            section.data(8)  = dumData; %prealloc

                    ;% lzy_lyl_1221_P.HILInitialize_AIChannels
                    section.data(1).logicalSrcIdx = 51;
                    section.data(1).dtTransOffset = 0;

                    ;% lzy_lyl_1221_P.HILInitialize_AOChannels
                    section.data(2).logicalSrcIdx = 52;
                    section.data(2).dtTransOffset = 1;

                    ;% lzy_lyl_1221_P.HILInitialize_DOChannels
                    section.data(3).logicalSrcIdx = 53;
                    section.data(3).dtTransOffset = 2;

                    ;% lzy_lyl_1221_P.HILInitialize_EIChannels
                    section.data(4).logicalSrcIdx = 54;
                    section.data(4).dtTransOffset = 3;

                    ;% lzy_lyl_1221_P.HILInitialize_EIQuadrature
                    section.data(5).logicalSrcIdx = 55;
                    section.data(5).dtTransOffset = 5;

                    ;% lzy_lyl_1221_P.HILInitialize_OOChannels
                    section.data(6).logicalSrcIdx = 56;
                    section.data(6).dtTransOffset = 6;

                    ;% lzy_lyl_1221_P.HILReadEncoderTimebase_Channels
                    section.data(7).logicalSrcIdx = 57;
                    section.data(7).dtTransOffset = 9;

                    ;% lzy_lyl_1221_P.HILReadEncoderTimebase_SamplesI
                    section.data(8).logicalSrcIdx = 58;
                    section.data(8).dtTransOffset = 11;

            nTotData = nTotData + section.nData;
            paramMap.sections(5) = section;
            clear section

            section.nData     = 37;
            section.data(37)  = dumData; %prealloc

                    ;% lzy_lyl_1221_P.HILInitialize_Active
                    section.data(1).logicalSrcIdx = 59;
                    section.data(1).dtTransOffset = 0;

                    ;% lzy_lyl_1221_P.HILInitialize_AOTerminate
                    section.data(2).logicalSrcIdx = 60;
                    section.data(2).dtTransOffset = 1;

                    ;% lzy_lyl_1221_P.HILInitialize_AOExit
                    section.data(3).logicalSrcIdx = 61;
                    section.data(3).dtTransOffset = 2;

                    ;% lzy_lyl_1221_P.HILInitialize_DOTerminate
                    section.data(4).logicalSrcIdx = 62;
                    section.data(4).dtTransOffset = 3;

                    ;% lzy_lyl_1221_P.HILInitialize_DOExit
                    section.data(5).logicalSrcIdx = 63;
                    section.data(5).dtTransOffset = 4;

                    ;% lzy_lyl_1221_P.HILInitialize_POTerminate
                    section.data(6).logicalSrcIdx = 64;
                    section.data(6).dtTransOffset = 5;

                    ;% lzy_lyl_1221_P.HILInitialize_POExit
                    section.data(7).logicalSrcIdx = 65;
                    section.data(7).dtTransOffset = 6;

                    ;% lzy_lyl_1221_P.HILInitialize_CKPStart
                    section.data(8).logicalSrcIdx = 66;
                    section.data(8).dtTransOffset = 7;

                    ;% lzy_lyl_1221_P.HILInitialize_CKPEnter
                    section.data(9).logicalSrcIdx = 67;
                    section.data(9).dtTransOffset = 8;

                    ;% lzy_lyl_1221_P.HILInitialize_CKStart
                    section.data(10).logicalSrcIdx = 68;
                    section.data(10).dtTransOffset = 9;

                    ;% lzy_lyl_1221_P.HILInitialize_CKEnter
                    section.data(11).logicalSrcIdx = 69;
                    section.data(11).dtTransOffset = 10;

                    ;% lzy_lyl_1221_P.HILInitialize_AIPStart
                    section.data(12).logicalSrcIdx = 70;
                    section.data(12).dtTransOffset = 11;

                    ;% lzy_lyl_1221_P.HILInitialize_AIPEnter
                    section.data(13).logicalSrcIdx = 71;
                    section.data(13).dtTransOffset = 12;

                    ;% lzy_lyl_1221_P.HILInitialize_AOPStart
                    section.data(14).logicalSrcIdx = 72;
                    section.data(14).dtTransOffset = 13;

                    ;% lzy_lyl_1221_P.HILInitialize_AOPEnter
                    section.data(15).logicalSrcIdx = 73;
                    section.data(15).dtTransOffset = 14;

                    ;% lzy_lyl_1221_P.HILInitialize_AOStart
                    section.data(16).logicalSrcIdx = 74;
                    section.data(16).dtTransOffset = 15;

                    ;% lzy_lyl_1221_P.HILInitialize_AOEnter
                    section.data(17).logicalSrcIdx = 75;
                    section.data(17).dtTransOffset = 16;

                    ;% lzy_lyl_1221_P.HILInitialize_AOReset
                    section.data(18).logicalSrcIdx = 76;
                    section.data(18).dtTransOffset = 17;

                    ;% lzy_lyl_1221_P.HILInitialize_DOPStart
                    section.data(19).logicalSrcIdx = 77;
                    section.data(19).dtTransOffset = 18;

                    ;% lzy_lyl_1221_P.HILInitialize_DOPEnter
                    section.data(20).logicalSrcIdx = 78;
                    section.data(20).dtTransOffset = 19;

                    ;% lzy_lyl_1221_P.HILInitialize_DOStart
                    section.data(21).logicalSrcIdx = 79;
                    section.data(21).dtTransOffset = 20;

                    ;% lzy_lyl_1221_P.HILInitialize_DOEnter
                    section.data(22).logicalSrcIdx = 80;
                    section.data(22).dtTransOffset = 21;

                    ;% lzy_lyl_1221_P.HILInitialize_DOReset
                    section.data(23).logicalSrcIdx = 81;
                    section.data(23).dtTransOffset = 22;

                    ;% lzy_lyl_1221_P.HILInitialize_EIPStart
                    section.data(24).logicalSrcIdx = 82;
                    section.data(24).dtTransOffset = 23;

                    ;% lzy_lyl_1221_P.HILInitialize_EIPEnter
                    section.data(25).logicalSrcIdx = 83;
                    section.data(25).dtTransOffset = 24;

                    ;% lzy_lyl_1221_P.HILInitialize_EIStart
                    section.data(26).logicalSrcIdx = 84;
                    section.data(26).dtTransOffset = 25;

                    ;% lzy_lyl_1221_P.HILInitialize_EIEnter
                    section.data(27).logicalSrcIdx = 85;
                    section.data(27).dtTransOffset = 26;

                    ;% lzy_lyl_1221_P.HILInitialize_POPStart
                    section.data(28).logicalSrcIdx = 86;
                    section.data(28).dtTransOffset = 27;

                    ;% lzy_lyl_1221_P.HILInitialize_POPEnter
                    section.data(29).logicalSrcIdx = 87;
                    section.data(29).dtTransOffset = 28;

                    ;% lzy_lyl_1221_P.HILInitialize_POStart
                    section.data(30).logicalSrcIdx = 88;
                    section.data(30).dtTransOffset = 29;

                    ;% lzy_lyl_1221_P.HILInitialize_POEnter
                    section.data(31).logicalSrcIdx = 89;
                    section.data(31).dtTransOffset = 30;

                    ;% lzy_lyl_1221_P.HILInitialize_POReset
                    section.data(32).logicalSrcIdx = 90;
                    section.data(32).dtTransOffset = 31;

                    ;% lzy_lyl_1221_P.HILInitialize_OOReset
                    section.data(33).logicalSrcIdx = 91;
                    section.data(33).dtTransOffset = 32;

                    ;% lzy_lyl_1221_P.HILInitialize_DOFinal
                    section.data(34).logicalSrcIdx = 92;
                    section.data(34).dtTransOffset = 33;

                    ;% lzy_lyl_1221_P.HILInitialize_DOInitial
                    section.data(35).logicalSrcIdx = 93;
                    section.data(35).dtTransOffset = 34;

                    ;% lzy_lyl_1221_P.HILReadEncoderTimebase_Active
                    section.data(36).logicalSrcIdx = 94;
                    section.data(36).dtTransOffset = 35;

                    ;% lzy_lyl_1221_P.HILWriteAnalog_Active
                    section.data(37).logicalSrcIdx = 95;
                    section.data(37).dtTransOffset = 36;

            nTotData = nTotData + section.nData;
            paramMap.sections(6) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% lzy_lyl_1221_P.HILReadEncoderTimebase_Overflow
                    section.data(1).logicalSrcIdx = 96;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(7) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 2;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (lzy_lyl_1221_B)
        ;%
            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% lzy_lyl_1221_B.Bias
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% lzy_lyl_1221_B.Gain
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% lzy_lyl_1221_B.MultiportSwitch
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% lzy_lyl_1221_B.Gain_m
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

                    ;% lzy_lyl_1221_B.Gain_g
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 5;

                    ;% lzy_lyl_1221_B.Gain1
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% lzy_lyl_1221_B.Compare
                    section.data(1).logicalSrcIdx = 6;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(2) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 5;
        sectIdxOffset = 2;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (lzy_lyl_1221_DW)
        ;%
            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% lzy_lyl_1221_DW.HILInitialize_FilterFrequency
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% lzy_lyl_1221_DW.HILInitialize_Card
                    section.data(1).logicalSrcIdx = 1;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% lzy_lyl_1221_DW.HILReadEncoderTimebase_Task
                    section.data(1).logicalSrcIdx = 2;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(3) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% lzy_lyl_1221_DW.Scope_PWORK.LoggedData
                    section.data(1).logicalSrcIdx = 3;
                    section.data(1).dtTransOffset = 0;

                    ;% lzy_lyl_1221_DW.Scope1_PWORK.LoggedData
                    section.data(2).logicalSrcIdx = 4;
                    section.data(2).dtTransOffset = 1;

                    ;% lzy_lyl_1221_DW.Scope2_PWORK.LoggedData
                    section.data(3).logicalSrcIdx = 5;
                    section.data(3).dtTransOffset = 2;

                    ;% lzy_lyl_1221_DW.HILWriteAnalog_PWORK
                    section.data(4).logicalSrcIdx = 6;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            dworkMap.sections(4) = section;
            clear section

            section.nData     = 5;
            section.data(5)  = dumData; %prealloc

                    ;% lzy_lyl_1221_DW.HILInitialize_ClockModes
                    section.data(1).logicalSrcIdx = 7;
                    section.data(1).dtTransOffset = 0;

                    ;% lzy_lyl_1221_DW.HILInitialize_DOStates
                    section.data(2).logicalSrcIdx = 8;
                    section.data(2).dtTransOffset = 1;

                    ;% lzy_lyl_1221_DW.HILInitialize_QuadratureModes
                    section.data(3).logicalSrcIdx = 9;
                    section.data(3).dtTransOffset = 2;

                    ;% lzy_lyl_1221_DW.HILInitialize_InitialEICounts
                    section.data(4).logicalSrcIdx = 10;
                    section.data(4).dtTransOffset = 4;

                    ;% lzy_lyl_1221_DW.HILReadEncoderTimebase_Buffer
                    section.data(5).logicalSrcIdx = 11;
                    section.data(5).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            dworkMap.sections(5) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 3957275191;
    targMap.checksum1 = 275050817;
    targMap.checksum2 = 17367548;
    targMap.checksum3 = 3390007489;

