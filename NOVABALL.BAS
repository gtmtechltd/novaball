DEFINT A-Z
'$DYNAMIC
'$INCLUDE: 'DIRECTQB.BI'
'###########################################################################
'NOVABALL v1.9.6
'       Written and Produced by Geoff Meakin (c) TGSBSoft 2000
'
'EXTERNAL DATA FILES
'       NOVADATA.001    Structural data for use in loaddata()
'       NOVADATA.002    BMP / GIF file for TGSBLogo
'       NOVADATA.003    BMP / GIF file for MenuScreen (-options)

DECLARE SUB movetrack (PlayerMask)
DECLARE SUB displayupdate (null)
DECLARE SUB updatetrack1 (luminance)
DECLARE SUB updatetrack2 (luminance)
DECLARE SUB init ()
DECLARE SUB loaddata (null)
DECLARE SUB drawtrack1 (title)
DECLARE SUB drawtrack2 (title)
DECLARE SUB mousemove (null)
DECLARE SUB mouse (mpointer)
DECLARE SUB mousecheck (mcheck)
DECLARE SUB editmenu (null)
DECLARE SUB drawedit (null)
DECLARE SUB font (fs, fx, fy, ftext$)
DECLARE SUB gettrackname (null)
DECLARE SUB newname (null)
DECLARE SUB savegame (file$)
DECLARE SUB loadgame (file$)
DECLARE SUB intro (null)
DECLARE SUB initsound (null)
DECLARE SUB initmusic (modfile$)
DECLARE SUB endmain (null)
DECLARE SUB getball (null)
DECLARE SUB setcol (colflag)
'set part of palette to specific colours
DECLARE SUB menu (null)
DECLARE SUB calculateperspective (ballz&, trackz&, ballx, bally, balln, trackn, final&)
DECLARE SUB keypress (PlayerMask)
DECLARE SUB moveball (PlayerMask)
DECLARE SUB checkball (PlayerMask)
DECLARE SUB cleartrack (null)
DECLARE SUB specialpower (null)
DECLARE SUB message1 (m$, mc1, md1, ml1)
DECLARE SUB message2 (m$, mc2, md2, ml2)
DECLARE SUB resettrack1 (title)
DECLARE SUB resettrack2 (title)
DECLARE SUB resetall1 (null)
DECLARE SUB resetall2 (null)
DECLARE SUB bonus1 (bonusmask)
DECLARE FUNCTION menu2 (null)
DECLARE FUNCTION jumpdata (a$, n)
DECLARE FUNCTION newfile$ (msk$)
DECLARE FUNCTION choosefile$ (msk$, opt1$, msg$)
DECLARE FUNCTION camerav (ballv&, trackv&, ballz&, trackz&)
DECLARE FUNCTION rotatex (Angle, wd, rd, sx, th)
DECLARE FUNCTION rotatey (Angle, ht, rd, sy, th)
DECLARE FUNCTION try (depth)
DECLARE FUNCTION grid (ballz&, lane, trackno)
DECLARE FUNCTION jumpdata (a$, n)
DECLARE FUNCTION danger (squaretype)
DECLARE FUNCTION compute (ballv&, ballz&, jumping, ballx, maxv&, trackn, nojumps, intel, lum)
DECLARE FUNCTION suddenstop& (ballv&, ballz&)
DECLARE FUNCTION dimmer$ (dimst$, dimno!)
DECLARE FUNCTION getx (gx$)
DECLARE FUNCTION gety (gy$)
DECLARE FUNCTION range (ra, rb, rc)
CONST Baddx = 14
CONST Baddy = 8
CONST high = 1
CONST low = 0
CONST yes = 1
CONST no = 0
CONST alphabet$ = "abcdefghijklmnopqrstuvwxyz"
'ball attributes
COMMON SHARED ballsx, ballsy, ballsz, ballv, ballr
COMMON SHARED ballx1, bally1, ballv1&, ballz1&
COMMON SHARED ballx2, bally2, ballv2&, ballz2&
COMMON SHARED scr1ball1x, scr1ball1y, scr1ball1z, scr1ball1v, scr1ball1r
COMMON SHARED scr2ball1x, scr2ball1y, scr2ball1z, scr2ball1v, scr2ball1r
COMMON SHARED scr1ball2x, scr1ball2y, scr1ball2z, scr1ball2v, scr1ball2r
COMMON SHARED scr2ball2x, scr2ball2y, scr2ball2z, scr2ball2v, scr2ball2r
COMMON SHARED oscr1ball1x, oscr1ball1y, oscr2ball1x, oscr2ball1y
COMMON SHARED oscr1ball2x, oscr1ball2y, oscr2ball2x, oscr2ball2y
COMMON SHARED jumping1, jumping2
COMMON SHARED maxv1&, maxv2&

'player attributes
COMMON SHARED nojumps1, nojumps2, updatejump1, updatejump2
COMMON SHARED jump(), g1l1, g1l2, g2l1, g2l2, trackn1, trackn2
COMMON SHARED trackn1b, trackn2b, trackn$
COMMON SHARED gridlane1, gridlane2, ballwait1, ballwait2
COMMON SHARED p1square1, p1square2, p2square1, p2square2
COMMON SHARED reversi1, reversi2
COMMON SHARED rev1, rev2
COMMON SHARED status1, status2
COMMON SHARED score1&, score2&
COMMON SHARED showscore1&, showscore2&
COMMON SHARED p1, p2
COMMON SHARED lum1, lum2
COMMON SHARED notime1, notime2
COMMON SHARED countdown1, countdown2
COMMON SHARED newlevel1, newlevel2
COMMON SHARED showtime1, showtime2
COMMON SHARED death1, death2
COMMON SHARED opp1, opp2
COMMON SHARED final1&, final2&
COMMON SHARED intelligence1, intelligence2
COMMON SHARED intel1, intel2
COMMON SHARED jumplimit, bonusstage1
COMMON SHARED bonusseq1$, bonustime1
COMMON SHARED bonuscounter1
COMMON SHARED bonusrep1$
COMMON SHARED bonusmarker1

'track attributes
COMMON SHARED trackz1&, trackz2&, trackpalette$
COMMON SHARED trackv1&, trackv2&
COMMON SHARED tname1$, tname2$
COMMON SHARED tracktype, trackfog
COMMON SHARED camera1, camera2
COMMON SHARED dng1, dng2

'graphics arrays
COMMON SHARED scr1ballbuff1(), scr1ballbuff2(), scr2ballbuff1(), scr2ballbuff2()
COMMON SHARED roll(), ball(), ballsize
COMMON SHARED fchar(), msecurs(), msebuff()
COMMON SHARED Button$, trackfog$, grey1$, grey2$, square$, dot$

'mouse attributes
COMMON SHARED msewheel, mcount, msecnt
COMMON SHARED mzone, mselb, mserb
COMMON SHARED msex, msey, omsex, omsey, mcnt, mouseon

'editor attributes
COMMON SHARED editcol1, editcol2
COMMON SHARED menuopt, hotkey
COMMON SHARED editstatus
COMMON SHARED editmode

'miscellaneous
COMMON SHARED Col$(), performance
COMMON SHARED soundon
COMMON SHARED counter&
COMMON SHARED collision
COMMON SHARED boundary(), priority()
COMMON SHARED msg1$, msg2$, msgcount1, msgcount2, msgdelay1, msgdelay2, msgc1, msgc2
COMMON SHARED s!(), c!()
COMMON SHARED track1(), track2(), pnts()
COMMON SHARED automatch
COMMON SHARED gametype

'keyboard attributes
COMMON SHARED leftkey1, rightkey1, upkey1, downkey1, firekey1
COMMON SHARED leftkey2, rightkey2, upkey2, downkey2, firekey2
COMMON SHARED keyleft1, keyright1, keyup1, keydown1, keyfire1
COMMON SHARED keyleft2, keyright2, keyup2, keydown2, keyfire2
COMMON SHARED keyquit, keynew, keyhalt, keyu, keyd, keyl, keyr
COMMON SHARED currentkey1, lastkey1, currentkey2, lastkey2
ballsize = DQBsize(0, 0, 28, 26)
tracksize = DQBsize(0, 0, 63, 63) \ 2
bigsize = DQBsize(0, 0, 172, 172) \ 2

DIM track1(tracksize)
DIM track2(tracksize)
DIM priority(16)
DIM boundary(300, 2)
DIM Col$(15)                            'colours used in game (string hex)
DIM msecurs(100), msebuff(100)          'to store mouse sprite, and background
DIM fchar(250)                          'to store a font character
DIM ball(ballsize)                      'to store the ball grey sphere
DIM roll(ballsize * 10)                 'to store the dots on the ball
DIM jump(4, 60)
DIM scr1ballbuff1(ballsize)
DIM scr1ballbuff2(ballsize)
DIM scr2ballbuff1(ballsize)
DIM scr2ballbuff2(ballsize)             'to store the background!
DIM SHARED Pal          AS STRING * 768 'to store a palette!
DIM SHARED scrfx(bigsize)
DIM s!(360), c!(360)
DIM pnts(500, 3)
DIM SHARED intel(7)

'initialise with 4 virtual screens, and 1 actual screen      

'       screen 0:       visible
'       screen 1:
'       screen 2:       map + font + try
'       screen 3:       background
'       screen 4:       workground

        r = DQBinit(4, 0)
       
'exit if there was a memory problem

        IF r <> 0 THEN
                PRINT : PRINT
                PRINT "Error: ";
                SELECT CASE r
                CASE 1: PRINT "this program requires a 386 or better CPU to run!"
                CASE 2: PRINT "no expanded memory managers were found on your system!"
                CASE 3: PRINT "this program requires more free EMS memory to run!"
                END SELECT
                PRINT "Fatal error."
                DQBclose
                END
        END IF

'initialise the mouse

        mouseon = 1
        IF NOT DQBmouseDetected THEN mouseon = 0
       
'mouseon = 0' if nomouse (i.e. using keys to control)

        IF mouseon = 1 THEN DQBresetMouse: DQBmouseHide: DQBsetMouseRange 0, 0, 320, 200
        msex = 0: msey = 0
        omsex = -1: omsey = -1
        DQBinstallKeyboard

'initialise the keyboard

        SCREEN 13
        CLS

'initialise the screen

'initialise variables in the game
        init
      
'initialise game-structural data, as contained in NOVADATA.001
        loaddata (0)
       
'calculate, display and grab to memory the balldots      
        getball (0)
      
'titlescreen
        'intro (0)
     
menuflag:
'menu
omsex = -1: omsey = -1
        menu (0)

IF menuopt = 1 THEN Mask = 2: GOTO credits
IF menuopt = 5 THEN GOTO editing

endmain (0)

gameon:
     
        editmode = 0
        omsex = -1: omsey = -1
        DQBclearLayer 0
        drawtrack1 (1)
        drawtrack2 (1)
        resetall1 (0)
        resetall2 (0)
        setcol 1
        setcol 3
        setcol 4
        DQBcopyLayer 0, 1

        DO

                IF ballwait1 > 0 AND death1 > -1 THEN ballwait1 = ballwait1 - 1: IF ballwait1 = 0 THEN jumping1 = 300: ballv1& = 500
                IF ballwait2 > 0 AND death2 > -1 THEN ballwait2 = ballwait2 - 1: IF ballwait2 = 0 THEN jumping2 = 300: ballv2& = 500
                updatetrack1 (lum1)
                updatetrack2 (lum2)

                keypress (Mask)
                moveball (Mask)
                movetrack (Mask)

                checkball (Mask)

                specialpower (0)

                displayupdate (Mask)
                mousemove (0)
                IF keyhalt THEN DQBwait 10

LOOP UNTIL keyquit

GOTO credits

editing:
     
        editmode = 1
        gametype = 0
        resetall1 (0)
        resetall2 (0)
        trackz1& = -10000: trackz2& = -150000
        Mask = 1
        p2 = 4
       
        f$ = choosefile$("*.MAP", "  <Empty Track>", "  Select a file to LOAD from:  ")
        IF f$ = "" OR LEFT$(f$, 1) = "<" THEN
                cleartrack (0)
        ELSE
                loadgame (f$)
        END IF

        omsex = -1: omsey = -1
'clear the screen then set it up for editing                
                                                             
        DQBclearLayer 0
                                                             
        drawtrack1 (0)
        drawtrack2 (1)
                                                             
        drawedit (0)

        setcol 1
        setcol 3
        setcol 4
        editstatus = 0
       
        resettrack2 (1)
        notime2 = 300
        nojumps2 = 7
        status2 = p2 + 3

        DO
               
                IF ballwait2 > 0 AND death2 > -1 THEN ballwait2 = ballwait2 - 1: IF ballwait2 = 0 THEN jumping2 = 300: ballv2& = 500
                updatetrack1 (63)
                updatetrack2 (lum1)
                'DQBwait 1
                counter& = (counter& + 1) MOD 1048576

                mouse (0)
                mouse (1)

                keypress (Mask)
                moveball (Mask)
                movetrack (Mask)
                checkball (Mask)
                specialpower (0)
                displayupdate (Mask)

                'DQBsetPal trackpalette$
                mousemove (0)
                mousecheck (0)
                editmenu (0)

        LOOP UNTIL DQBkey(KEYESC) OR editstatus = 1
        IF editstatus = 0 THEN GOTO menuflag

fileflag:
        f$ = choosefile$("*.MAP", "  <Create New Filename>  ", "  SAVE Track Below     or ESCAPE to Quit  ")
        IF f$ = "" THEN GOTO menuflag
        IF LEFT$(f$, 1) = "<" THEN
                f$ = newfile$(".MAP")
                IF f$ = "" THEN GOTO fileflag
        END IF
        savegame (f$)
        GOTO menuflag

        endmain (0)

perspectiv:
        DATA 99,94,84,63,50,41,36,32,28,24,21,18,16,15,14,13,13,12,12,11,11,9,7,6,6,5,5,4,4,4,4,3,3,3,3,3,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,100

gamedata:
DATA "Incoming mail: 05 Tshmiri, 7753. "
DATA "Hello Jarith, its been a long time. Your escape route has been arranged- "
DATA "you will need to navigate 26 sub-levels of the novatubes to gain access "
DATA "to the tunnel substructure. My accomplices will be waiting for you there. "
DATA "Be on your guard- as soon as you leave the grey launch bay, the tunnel "
DATA "defences will be activated, but I know you already know what the colors "
DATA "mean. You have only limited time, but hey it'll be "
DATA "like the good old days. See you flipside if you make it."
DATA "                                    "
DATA "Welcome to NOVABALL. This is version 1.9.6 (c) TGSBSoft 2000"
DATA "     Code, SFX, GFX by Geoff Meakin. This is FREEWARE"
DATA "                                        "
DATA "???"

endmain (0)

credits:

DO
LOOP UNTIL NOT DQBkey(KEYESC)

DQBsetTextureSize 64

DQBclearLayer 0
FOR y = 1 TO 48
Z = 97 - y
LINE (0, y + 15)-(63, y + 15), y
LINE (64, y + 15)-(127, y + 15), y + 48
NEXT
LINE (0, 0)-(127, 5), 0, BF
DQBget 0, 0, 0, 63, 63, VARSEG(track1(0)), VARPTR(track1(0))
DQBget 0, 64, 0, 127, 63, VARSEG(track2(0)), VARPTR(track2(0))

counter& = 0: editmode = 0
omsex = -1: omsey = -1
resetall1 (0)
resetall2 (0)
setcol 1
setcol 3
setcol 4
DQBclearLayer 0

chc = menu2(0)
SELECT CASE chc
        CASE 1: Mask = 2: opp1 = 0: opp2 = 0: gametype = 0: GOTO gameon
        CASE 2: Mask = 0: opp1 = 0: opp2 = 0: gametype = 0: GOTO gameon
        CASE 3: Mask = 2: opp1 = 0: opp2 = 0: gametype = 1: GOTO gameon
        CASE 4: Mask = 0: opp1 = 0: opp2 = 0: gametype = 1: GOTO gameon
        CASE 5: Mask = 0: opp1 = 0: opp2 = 1: gametype = 2: GOTO gameon
        CASE -1: GOTO menuflag
END SELECT

endmain (0)

REM $STATIC
SUB bonus1 (bonusmask)

IF (bonusmask AND 2) <> 2 OR gametype > 0 THEN EXIT SUB

l = INT(trackn1 / 3) + 2
bonusseq1$ = ""
bonusrep1$ = ""
bonustime1 = 50 + 20 * l
FOR x = 1 TO l
        bonusseq1$ = bonusseq1$ + CHR$(65 + INT(RND(1) * 14.99))
NEXT x
ballz1& = -118000
ballx1 = 0: bally1 = 0
bonusstage1 = 1
msg1$ = "! BONUS ROUND !"
bonuscounter1 = 102
bonusmarker1 = 0

END SUB

SUB calculateperspective (ballz&, trackz&, ballx, bally, balln, trackn, final&)

bz& = ballz&
distance& = (ballz& - trackz&) / 100
IF distance& < 0 OR distance& > 800 THEN ballv = 0: EXIT SUB
IF ABS(balln - trackn) > 1 THEN ballv = 0: EXIT SUB
IF balln > trackn THEN
        bz& = ballz& + final& + 150000
        distance& = (bz& - trackz&) / 100
        IF distance& < 0 OR distance& > 800 THEN ballv = 0: EXIT SUB
END IF
IF balln < trackn THEN
        bz& = ballz& - final& - 150000
        distance& = (bz& - trackz&) / 100
        IF distance& < 0 OR distance& > 800 THEN ballv = 0: EXIT SUB
END IF
ballv = -1
dist = (bz& - trackz&) / 100
ballsx = (ballx) * (try(dist) / 50)
ballsy = try(dist) * 35 / 50 + 35 - bally * (try(dist) + 4) / 54
ballsz = (100 + 12 * try(dist)) / 7
ballr = INT((bz& MOD 4000) / 400)
IF ballr < 0 THEN ballr = ballr + 10

END SUB

FUNCTION camerav (ballv&, trackv&, ballz&, trackz&)

dist& = (ballz& - trackz& - 700)
fff = SQR(ABS(dist&))
IF dist& <= 0 THEN
        ret& = trackv& - 50
        IF ret& < ballv& - fff THEN ret& = ballv& - fff
ELSE
        ret& = trackv& + 35
        IF ret& > ballv& + fff THEN ret& = ballv& + fff
END IF

camerav = ret&

END FUNCTION

SUB checkball (PlayerMask)

IF (PlayerMask AND 1) = 0 AND (status1 MOD 4 < 3) AND death1 > -1 AND bonusstage1 = 0 THEN

        IF jumping1 = 0 THEN

                IF p1square1 <> 2 AND maxv1& > 1500 THEN maxv1& = maxv1& - 1
               
                IF (dng1 AND 4) = 4 THEN reversi1 = 1
                IF (dng1 AND 8) = 8 THEN reversi1 = 0
                IF p1square1 <> 4 THEN rev1 = 2
                SELECT CASE p1square1

                        
                        CASE 0:
                                'black - hole
                                IF ballwait1 = 0 THEN
                                       
                                        ballwait1 = 120
                                        ballv1& = 0
                                        maxv1& = 1500
                                        status1 = p1 + 0
                                END IF
                        
                        CASE 1:
                                'red - slow down
                                ballv1& = ballv1& - INT(ballv1& / 20)
                                                        

                        CASE 2:
                                'green - speed up
                                jumping1 = 100
                                IF ballv1& < 1500 THEN ballv1& = 1500
                                ballv1& = ballv1& + 100
                                IF maxv1& < 2500 AND lum1 > 29 THEN maxv1& = 2500
                                score1& = score1& + 1
                        CASE 3:
                                'blue - bounce
                                ballv1& = ballv1& + 200
                                jumping1 = 300
                                IF keyfire1 AND nojumps1 > 0 THEN
                                        ballv1& = ballv1& + 100
                                        updatejump1 = yes
                                        nojumps1 = nojumps1 - (gametype + 1) MOD 2
                                        jumping1 = 400
                                END IF
                                score1& = score1& + 5
                        CASE 4:
                                'purple - block and reverse
                                jumping1 = 200
                                IF ballv1& > -500 THEN ballv1& = -500
                                ballv1& = ballv1& - 10
                                rev1 = -1
                                status1 = p1 + 0
                                maxv1& = 1500
                                score1& = score1& - 5
                        CASE 5:
                                'white - novaball
                                jumping1 = 400
                                maxv1& = 6300
                                IF ballv1& < 2500 THEN ballv1& = 2500
                                status1 = p1 + 1
                                message1 "NOVABALL", 200, 5, 255
                                score1& = score1& + 50
                        CASE 6:
                                'orange - BONUS score+jumps
                                score1& = score1& + 100
                                jumping1 = 400
                                IF ball(v1&) < 1500 THEN ball(v1&) = 1500
                                nojumps1 = nojumps1 + 5
                                IF nojumps1 > jumplimit THEN nojumps1 = jumplimit
                                updatejump1 = yes
                                message1 "BONUS +5 JUMPS", 150, 10, 202
                        CASE 7:
                                'yellow - takeover
                                IF (p1 AND 4) = 0 THEN
                                        takeover1 = 300
                                        p1 = p1 + 4
                                        status1 = status1 + 4
                                END IF
                                jumping1 = 400
                                IF ball(v1&) < 1500 THEN ball(v1&) = 1500
                                message1 "TAKEOVER", 300, 300, 200
                                score1& = score1& + 5
                                death1 = 500
                        CASE 8:
                                'blind //
                                lum2 = -200
                                jumping1 = 300
                                IF keyfire1 AND nojumps1 > 0 THEN
                                        ballv1& = ballv1& + 100
                                        updatejump1 = yes
                                        nojumps1 = nojumps1 - (gametype + 1) MOD 2
                                        jumping1 = 400
                                END IF
                                message1 "BLIND OPPONENT", 150, 10, 196
                                score1& = score1& + 5
                        CASE 9:
                                'unknown - warpback
                                IF (boundary(ballx1 + 150, 2) = 0 AND (counter& MOD 100) < 50) OR (boundary(ballx1 + 150, 2) = 1 AND (counter& MOD 100) > 49) THEN
                                        jumping1 = 400
                                        maxv1& = 2500
                                        ballv1& = -3500
                                        status1 = p1 + 2
                                        message1 "SETBACK!", 100, 100, 201
                                        score1& = score1& - 50
                                ELSE
                                        ballv1& = ballv1& + 200
                                        jumping1 = 300
                                        IF keyfire1 AND nojumps1 > 0 THEN
                                                ballv1& = ballv1& + 100
                                                updatejump1 = yes
                                                nojumps1 = nojumps1 - (gametype + 1) MOD 2
                                                jumping1 = 400
                                        END IF
                                        score1& = score1& + 5
                                END IF
                        CASE 10:
                                'grey1 - end/beginning
                                'IF ballv1& < 100 THEN ballv1& = 100
                                IF ballz1& < 0 THEN
                                        IF keyup1 = 0 THEN ballv1& = ballv1& + 10
                                        IF keydown1 THEN ballv1& = ballv1& + 10
                                ELSE
                                        IF keyup1 THEN ballv1& = ballv1& - 10
                                        IF keydown1 THEN ballv1& = ballv1& + 10
                                        ballv1& = suddenstop&(ballv1&, ballz1&)
                                        IF ABS(ballv1&) < 50 AND status1 <> p1 + 3 THEN
                                                status1 = p1 + 3
                                                countdown1 = 180
                                        END IF
                                END IF
                                IF counter& MOD 6 = 0 THEN
                                        IF notime1 < 999 THEN notime1 = notime1 + 1
                                END IF
                                trackz1& = ballz1& - 700
                        CASE 11:
                                'grey2 - end/beginning
                                'IF ballv1& < 100 THEN ballv1& = 100
                                IF ballz1& < 0 THEN
                                        IF keyup1 = 0 THEN ballv1& = ballv1& + 10
                                        IF keydown1 THEN ballv1& = ballv1& + 10
                                ELSE
                                        IF keyup1 THEN ballv1& = ballv1& - 10
                                        IF keydown1 THEN ballv1& = ballv1& + 10
                                        ballv1& = suddenstop&(ballv1&, ballz1&)
                                        IF ABS(ballv1&) < 50 AND status1 <> p1 + 3 THEN
                                                status1 = p1 + 3
                                                countdown1 = 180
                                        END IF
                                END IF
                                IF counter& MOD 6 = 0 THEN
                                        IF notime1 < 999 THEN notime1 = notime1 + 1
                                END IF
                                trackz1& = ballz1& - 700
                        CASE 12:
                                'track1 - normal / no effect
                               
                        CASE 13:
                                'track2 - normal / no effect

                        CASE 14:
                                'cyan1 - reverse controls
                                               
                        CASE 15:
                                'cyan2 - reverse controls
                                
                END SELECT
        END IF

        IF ballv1& > maxv1& THEN ballv1& = maxv1&
        IF maxv1& < 1500 AND lum1 > 29 THEN maxv1& = 1500

END IF
IF (PlayerMask AND 2) = 0 AND (status2 MOD 4 < 3) AND death2 > -1 THEN

        IF jumping2 = 0 THEN

                IF p2square1 <> 2 AND maxv2& > 1500 THEN maxv2& = maxv2& - 1
              
                IF (dng2 AND 4) = 4 THEN reversi2 = 1
                IF (dng2 AND 8) = 8 THEN reversi2 = 0
                IF p2square1 <> 4 THEN rev2 = 2
                SELECT CASE p2square1

                       
                        CASE 0:
                                'black - hole
                                IF ballwait2 = 0 THEN
                                      
                                        ballwait2 = 120
                                        ballv2& = 0
                                        maxv2& = 1500
                                        status2 = p2 + 0
                                END IF
                       
                        CASE 1:
                                'red - slow down
                                ballv2& = ballv2& - INT(ballv2& / 20)
                                                       

                        CASE 2:
                                'green - speed up
                                jumping2 = 100
                                IF ballv2& < 1500 THEN ballv2& = 1500
                                ballv2& = ballv2& + 100
                                IF maxv2& < 2500 AND lum2 > 29 THEN maxv2& = 2500
                                score2& = score2& + 1
                        CASE 3:
                                'blue - bounce
                                ballv2& = ballv2& + 200
                                jumping2 = 300
                                IF keyfire2 AND nojumps2 > 0 THEN
                                        ballv2& = ballv2& + 100
                                        updatejump2 = yes
                                        nojumps2 = nojumps2 - (gametype + 1) MOD 2
                                        jumping2 = 400
                                END IF
                                score2& = score2& + 5
                        CASE 4:
                                'purple - block and reverse
                                jumping2 = 200
                                IF ballv2& > -500 THEN ballv2& = -500
                                ballv2& = ballv2& - 10
                                rev2 = -1
                                status2 = p2 + 0
                                maxv2& = 1500
                                score2& = score2& - 5
                        CASE 5:
                                'white - warp        
                                jumping2 = 400
                                maxv2& = 6300
                                IF ballv2& < 2500 THEN ballv2& = 2500
                                status2 = p2 + 1
                                message2 "NOVABALL", 300, 300, 255
                                score2& = score2& + 50
                        CASE 6:
                                'orange - score
                                nojumps2 = nojumps2 + 5
                                IF nojumps2 > jumplimit THEN nojumps2 = jumplimit
                                score2& = score2& + 1000
                                jumping2 = 400
                                IF ball(v2&) < 1500 THEN ball(v2&) = 1500
                                message2 "BONUS +5 JUMPS", 300, 300, 202
                                score2& = score2& + 100
                                updatejump2 = 1
                        CASE 7:
                                'yellow - jumps
                                IF (p2 AND 4) = 0 THEN
                                        takeover2 = 300
                                        p2 = p2 + 4
                                        status2 = status2 + 4
                                END IF
                                jumping2 = 400
                                IF ball(v2&) < 1500 THEN ball(v2&) = 1500
                                message2 "TAKEOVER", 300, 300, 200
                                score2& = score2& + 5
                                death2 = 500
                        CASE 8:
                                'blind! // CPU takeover
                                'advanced function
                                lum1 = -200
                                jumping2 = 300
                                IF keyfire2 AND nojumps2 > 0 THEN
                                        ballv2& = ballv2& + 100
                                        updatejump2 = yes
                                        nojumps2 = nojumps2 - (gametype + 1) MOD 2
                                        jumping2 = 400
                                END IF
                                message2 "OPPONENT BLIND", 300, 300, 196
                                score2& = score2& + 5
                        CASE 9:
                                'unknown - warpback
                                IF (boundary(ballx2 + 150, 2) = 0 AND (counter& MOD 100) < 50) OR (boundary(ballx2 + 150, 2) = 1 AND (counter& MOD 100) > 49) THEN
                                        jumping2 = 400
                                        maxv2& = 2500
                                        ballv2& = -3500
                                        status2 = p2 + 2
                                        message2 "SETBACK", 300, 300, 201
                                        score2& = score2& - 50
                                ELSE
                                        ballv2& = ballv2& + 200
                                        jumping2 = 300
                                        IF keyfire2 AND nojumps2 > 0 THEN
                                                ballv2& = ballv2& + 100
                                                updatejump2 = yes
                                                nojumps2 = nojumps2 - (gametype + 1) MOD 2
                                                jumping2 = 400
                                        END IF
                                        score2& = score2& + 5
                                END IF
                        CASE 10:
                                'grey1 - end/beginning
                                'IF ballv2& < 100 THEN ballv2& = 100
                                IF ballz2& < 0 THEN
                                        IF keyup2 = 0 THEN ballv2& = ballv2& + 10
                                        IF keydown2 THEN ballv2& = ballv2& + 10
                                ELSE
                                        IF keyup2 THEN ballv2& = ballv2& - 10
                                        IF keydown2 THEN ballv2& = ballv2& + 10
                                        ballv2& = suddenstop&(ballv2&, ballz2&)
                                        IF ABS(ballv2&) < 30 AND status2 <> p2 + 3 THEN
                                                status2 = p2 + 3
                                                countdown2 = 180
                                        END IF
                                END IF
                                IF counter& MOD 6 = 0 THEN
                                        IF notime2 < 999 THEN notime2 = notime2 + 1
                                END IF
                                trackz2& = ballz2& - 700
                        CASE 11:
                                'grey2 - end/beginning
                                'IF ballv2& < 100 THEN ballv2& = 100
                                IF ballz2& < 0 THEN
                                        IF keyup2 = 0 THEN ballv2& = ballv2& + 10
                                        IF keydown2 THEN ballv2& = ballv2& + 10
                                ELSE
                                        IF keyup2 THEN ballv2& = ballv2& - 10
                                        IF keydown2 THEN ballv2& = ballv2& + 10
                                        ballv2& = suddenstop&(ballv2&, ballz2&)
                                        IF ABS(ballv2&) < 30 AND status2 <> p2 + 3 THEN
                                                status2 = p2 + 3
                                                countdown2 = 180
                                        END IF
                                END IF
                                IF counter& MOD 6 = 0 THEN
                                        IF notime2 < 999 THEN notime2 = notime2 + 1
                                END IF
                                trackz2& = ballz2& - 700
                        CASE 12:
                                'track1 - normal / no effect
                              
                        CASE 13:
                                'track2 - normal / no effect

                        CASE 14:
                                'cyan1 - reverse controls
                               
                        CASE 15:
                                'cyan2 - reverse controls
                               
                END SELECT
        END IF

        IF ballv2& > maxv2& THEN ballv2& = maxv2&
        IF maxv2& < 1500 AND lum2 > 29 THEN maxv2& = 1500

END IF
IF (PlayerMask AND 3) = 0 AND status1 MOD 4 < 3 AND status2 MOD 4 < 3 AND death1 > -1 AND death2 > -1 AND bonusstage1 = 0 THEN

        'now check for collisions

        distance& = ABS(ballz1& - ballz2&)
        dist = ABS(ballx1 - ballx2)
        IF distance& < 1100 AND dist < 28 AND trackn1 = trackn2 AND ABS(bally1 - bally2) < 18 AND ballwait1 = 0 AND ballwait2 = 0 THEN
                IF dist < 16 THEN
                        SWAP ballv1&, ballv2&
                        SWAP maxv1&, maxv2&
                        IF distance& + ABS(ballv1& - ballv2&) < 1100 THEN
                                x = INT((1100 - distance& - ABS(ballv1& - ballv2&)) / 2)
                                IF ballv1& > ballv2& THEN
                                        ballv1& = ballv1& + x + 10
                                        ballv2& = ballv2& - x - 10
                                ELSE
                                        ballv2& = ballv2& + x + 10
                                        ballv1& = ballv1& - x - 10
                                END IF
                        END IF
                END IF
                        IF ballx1 < ballx2 AND collision = 0 THEN collision = -3 ELSE collision = 3
        END IF

END IF
IF (status1 MOD 4) = 3 OR death1 < 0 THEN trackz1& = ballz1& - 700: trackv1& = 0: ballv1& = 0
IF (status2 MOD 4) = 3 OR death2 < 0 THEN trackz2& = ballz2& - 700: trackv2& = 0: ballv2& = 0
IF lum1 < 30 AND opp1 = 1 AND maxv1& > 500 THEN maxv1& = maxv1& - 50
IF lum2 < 30 AND opp2 = 1 AND maxv2& > 500 THEN maxv2& = maxv2& - 50
IF bonusstage1 > 0 THEN trackz1& = -150700: trackv1& = 0

END SUB

FUNCTION choosefile$ (msk$, opt1$, msg$)

DQBclearLayer 0
nofiles = 0
Offset = 1
chc = 1
q = 0
setcol 1
MID$(trackpalette$, 4, 3) = CHR$(0) + CHR$(0) + CHR$(40)
MID$(trackpalette$, 7, 3) = CHR$(40) + CHR$(0) + CHR$(0)
DQBsetPal trackpalette$

IF LEN(opt1$) > 0 THEN q = 1: chc = 0

file$ = DQBdir$(msk$, ATTRIB.A)

IF file$ <> "" THEN
        DO
               nofiles = nofiles + 1
               file$ = DQBdir$("", ATTRIB.A)
        LOOP UNTIL file$ = ""
END IF

IF Offset > nofiles THEN Offset = nofiles
IF nofiles = 0 THEN r = 0: GOTO flag2
IF LEN(opt1$) > 0 THEN Offset = 0

flag1:
c$ = ""
DQBclearLayer 0
DQBboxf 0, 0, 0, 319, 7, 1
DQBprint 0, msg$, 0, 0, 255
a$ = ""
p = Offset + 15
IF p > nofiles + q THEN p = nofiles + q
a$ = a$ + "  Viewing:" + STR$(Offset + q) + "-" + RIGHT$(STR$(p), LEN(STR$(p)) - 1) + " of" + STR$(nofiles + q) + "  "
DQBprint 0, a$, 0, 8, 250
COLOR 15
Z = 4

IF Offset = 0 THEN
        IF chc = 0 THEN
                DQBboxf 0, 0, Z * 8 - 8, 319, Z * 8 - 1, 2
                c$ = opt1$
                DQBprint 0, c$, 0, Z * 8 - 8, 255
                Z = Z + 1
        ELSE
                DQBprint 0, opt1$, 0, Z * 8 - 8, 250
                Z = Z + 1
        END IF
END IF
IF nofiles > 0 THEN

        file$ = DQBdir$(msk$, ATTRIB.A)
        IF Offset > 1 THEN
                FOR x = 1 TO Offset - 1
                        file$ = DQBdir$("", ATTRIB.A)
                NEXT x
        END IF

        IF chc = Offset + q THEN
                DQBboxf 0, 0, Z * 8 - 8, 319, Z * 8 - 1, 2
                c$ = "  " + file$
                DQBprint 0, c$, 0, Z * 8 - 8, 255
                Z = Z + 1
        ELSE
                DQBprint 0, "  " + file$, 0, Z * 8 - 8, 250
                Z = Z + 1
        END IF
       
        x = 1
        WHILE (x < 15 AND nofiles - Offset - x >= 0)
                file$ = DQBdir$("", ATTRIB.A)
                IF chc = Offset + x + q THEN
                        DQBboxf 0, 0, Z * 8 - 8, 319, Z * 8 - 1, 2
                        c$ = "  " + file$
                        DQBprint 0, c$, 0, Z * 8 - 8, 255
                        Z = Z + 1
                ELSE
                        DQBprint 0, "  " + file$, 0, Z * 8 - 8, 250
                        Z = Z + 1
                END IF
                x = x + 1
        WEND
END IF
Z = 24
DQBboxf 0, 0, Z * 8 - 8, 319, Z * 8 - 1, 1
DQBprint 0, "  Please Select a file.  ", 0, Z * 8 - 8, 255
Z = 0
DO
        Z = Z + 1
        DQBwait 1
        u = DQBkey(KEYUP)
        D = DQBkey(KEYDOWN)
LOOP UNTIL (u = 0 AND D = 0) OR Z > 10

DO
u = DQBkey(KEYUP)
D = DQBkey(KEYDOWN)
E = DQBkey(KEYESC)
r = DQBkey(KEYENTER)
LOOP UNTIL u OR D OR E OR r
IF u THEN chc = chc - 1
IF D THEN chc = chc + 1
IF chc < 0 THEN chc = 0
IF opt1$ = "" AND chc < 1 THEN chc = 1
IF chc > nofiles THEN chc = nofiles
IF chc < Offset + 5 THEN Offset = chc - 5
IF chc > Offset + 10 THEN Offset = chc - 10
IF Offset < 0 THEN Offset = 0
IF opt1$ = "" AND Offset < 1 THEN Offset = 1
IF E = 0 AND r = 0 THEN GOTO flag1

flag2:
a$ = ""
IF r THEN a$ = c$
WHILE LEFT$(a$, 1) = " "
        a$ = RIGHT$(a$, LEN(a$) - 1)
WEND
choosefile$ = a$

END FUNCTION

SUB cleartrack (null)

x = -1: y = 0
DO
x = x + 1: IF x = 320 THEN x = 0: y = y + 1
Z = 13 - (x + y) MOD 2
IF x > 280 AND y MOD 4 > 1 THEN Z = 11 - (x + y) MOD 2
DQBpset 2, x, y, Z
LOOP UNTIL x = 319 AND y = 4 * 27 - 1

tname1$ = "New Track"
IF LEN(tname1$) < 20 THEN tname1$ = tname1$ + STRING$(20 - LEN(tname1$), " ")

FOR x = 1 TO 27
FOR y = 1 TO LEN(tname1$)
m$ = MID$(tname1$, y, 1)
Z = INSTR("abcdefghijklmnopqrstuvwxyz1234567890,.:/?!ABCDEFGHIJKLMNOPQRSTUVWXYZ", m$)
sx = (x * 20 - 21 + y)
DQBpset 2, sx MOD 160, 181 + INT(sx / 160), Z
NEXT
NEXT

END SUB

FUNCTION compute (ballv&, ballz&, jumping, ballx, maxv&, trackn, nojumps, intel, lum)

SHARED keyup0, keydown0, keyleft0, keyright0

'based on all these attributes return status of keyleft, keyright
'                                               keyfire,keyup,keydown

'nearest grade boundary
ngb = boundary(ballx + 150, 0)
IF ngb = 999 THEN
        i = INT(RND(1) * 1.999)
        IF i = 0 THEN
                ngb = boundary(ballx + 149, 0)
        ELSE
                ngb = boundary(ballx + 151, 0)
        END IF
END IF

'centre of square
csq = boundary(ballx + 150, 1)

'current lane
cl = boundary(ballx + 150, 2) + 1

bz& = ballz&: bv& = ballv&
minz& = 0: maxz& = 0
FOR n = 1 TO 16
        bv& = bv& + 10
        bz& = bz& + bv&
        IF n = 1 THEN minz& = bz&
NEXT n
maxz& = bz&
curs1 = INT((ballz& - 9800) / 10000) + 2
maxs1 = INT((maxz& - 9800) / 10000) + 2

keyleft0 = 0
keyright0 = 0

IF curs1 <> maxs1 THEN

'perform the test- between 1 and 16 frames is there a better square than
'the current lane?
        changelane = 0
        FOR ns1 = curs1 + SGN(maxs1 - curs1) TO maxs1 STEP SGN(maxs1 - curs1)
                
                IF ns1 > -1 THEN
                        sx = ns1 MOD 320
                        sy = 2 * INT(ns1 / 320) + trackn * 4 - 4
                        cg1 = DQBpoint(2, sx, sy)
                        cg2 = DQBpoint(2, sx, sy + 1)
'downgrading!!                   
                        IF ns1 MOD intel = 0 AND intel < 40 AND counter& MOD 240 < 60 THEN SWAP cg1, cg2

                ELSE
                        cg1 = 11: cg2 = 11
                END IF
               
                IF cl = 1 THEN
                        IF priority(cg2) < priority(cg1) THEN changelane = 1
                ELSE
                        IF priority(cg1) < priority(cg2) THEN changelane = 1
                END IF
        NEXT ns1
        IF changelane = 0 THEN
                IF ballx > csq THEN keyleft0 = 1: keyright0 = 0
                IF ballx < csq THEN keyleft0 = 0: keyright0 = 1
        ELSE
                IF ballx > ngb THEN keyleft0 = 1: keyright0 = 0
                IF ballx < ngb THEN keyleft0 = 0: keyright0 = 1
                IF ballx = ngb THEN
                        q1 = priority(grid(minz&, cl - 1, trackn))
                        q2 = priority(grid(minz&, 2 - cl, trackn))
                        IF q1 > q2 THEN
                                q3 = ABS(ngb) MOD 44
                                q3 = q3 MOD 10
                                IF q3 = 0 THEN keyright0 = 1: keyleft0 = 0 ELSE keyleft0 = 1: keyright0 = 0
                        END IF
                END IF
        END IF
ELSE
'no need to perform the test! Head towards the centre of the square
'ie if we havent changed square in 16 moves, we are not likely to have in 1
'I know its possible - but hey a bit of error will look more human
        IF ballx > csq THEN keyleft0 = 1: keyright0 = 0
        IF ballx < csq THEN keyleft0 = 0: keyright0 = 1
END IF

keyfire0 = 0

q1 = priority(grid(minz& + ballv& + 20, cl - 1, trackn))
q2 = priority(grid(minz& + ballv& + 20, 2 - cl, trackn))

IF q1 > 9 AND q2 > 9 THEN
        IF (q1 > 10 AND q2 > 10) OR nojumps > 5 OR ballv& < 600 THEN keyfire0 = 1
END IF

IF ((q1 > 4 AND q1 < 7) OR (q2 > 4 AND q2 < 7)) AND (jumping = 0 OR (jumping > 0 AND jump(INT(jumping / 100), 0) - (jumping MOD 100) = 1)) THEN
'IF NEXT SQUARE IS A BOUNCE SQUARE
'**AND** I AM i) not Jumping    oR ii) last framejump

        framestoland = 1 + jump(3, 0)

        minz& = ballz& + 10010 + ballv&
        maxz& = ballz&
       
        FOR n = 1 TO framestoland
                maxz& = maxz& + ballv& + 200 + n * 10' this is the landing point
        NEXT n

        IF maxz& > minz& THEN
                mins1 = INT((minz& - 9800) / 10000) + 2
                maxs1 = INT((maxz& - 9800) / 10000) + 2
                superjump = 0
                FOR ns1 = mins1 TO maxs1
                        IF ns1 > -1 THEN
                                sx = ns1 MOD 320
                                sy = 2 * INT(ns1 / 320) + trackn * 4 - 4
                                cg1 = DQBpoint(2, sx, sy)
                                cg2 = DQBpoint(2, sx, sy + 1)
'downgrading!!!                              
                                IF ns1 MOD intel = 0 AND intel < 40 AND counter& MOD 240 < 60 THEN SWAP cg1, cg2
                        ELSE
                                cg1 = 11: cg2 = 11
                        END IF
                        IF priority(cg1) < 11 OR priority(cg2) < 11 THEN superjump = 1
                        
                NEXT ns1
                IF superjump = 0 THEN keyfire0 = 1

        END IF
END IF

'updown
keyup0 = 1
keydown0 = 0
IF jumping <> 0 THEN
        framestoland = jump(INT(jumping / 100), 0) - (jumping MOD 100)
        minz& = ballz&
        maxz& = ballz&
        minv& = ballv&
        maxv& = ballv&
       
        FOR n = 1 TO framestoland
                minv& = minv& - 20
                IF minv& < 0 THEN minv& = 0
                maxv& = maxv& + 10
                minz& = minz& + minv&
                maxz& = maxz& + maxv&
        NEXT n

        'we know mins1 < maxs1
       
        mins1 = INT((minz& - 9800) / 10000) + 2
        maxs1 = INT((maxz& - 9800) / 10000) + 2

        bestsq = -1
        FOR ns1 = mins1 TO maxs1
                IF ns1 > -1 THEN
                        sx = ns1 MOD 320
                        sy = 2 * INT(ns1 / 320) + trackn * 4 - 4
                        cg1 = DQBpoint(2, sx, sy)
                        cg2 = DQBpoint(2, sx, sy + 1)
'downgrading             
                        IF ns1 MOD intel = 0 AND intel < 40 AND counter& MOD 240 < 60 THEN SWAP cg1, cg2
                ELSE
                        cg1 = 11: cg2 = 11
                END IF
                IF cg1 = 5 OR cg2 = 5 THEN bestsq = 4
                IF ((cg1 > 5 AND cg1 < 9) OR (cg2 > 5 AND cg2 < 9)) AND bestsq < 3 THEN bestsq = 3
                IF (cg1 = 3 OR cg2 = 3) AND bestsq < 2 THEN bestsq = 2
                IF (priority(cg1) < 10 OR priority(cg2) < 10) AND bestsq < 2 THEN bestsq = 1
                IF (cg1 = 1 OR cg2 = 1) AND bestsq < 1 THEN bestsq = 0
                
        NEXT ns1
        currentsq = -1
       
        IF cg1 = 5 OR cg2 = 5 THEN currentsq = 4
        IF ((cg1 > 5 AND cg1 < 9) OR (cg2 > 5 AND cg2 < 9)) AND currentsq < 3 THEN currentsq = 3
        IF (cg1 = 3 OR cg2 = 3) AND currentsq < 2 THEN currentsq = 2
        IF (priority(cg1) < 10 OR priority(cg2) < 10) AND currentsq < 2 THEN currentsq = 1
        IF (cg1 = 1 OR cg2 = 1) AND currentsq < 1 THEN currentsq = 0
       
        IF bestsq > currentsq THEN
                keydown0 = 1: keyup0 = 0
        ELSE
                keydown0 = 0: keyup0 = 1
        END IF

        IF framestoland = 1 THEN
                'keyfire0 = 1
                cl = boundary(ballx + 150 + (keyright0 - keyleft0) * rev2, 2) + 1
                minz& = ballz& + ballv& + (keyup0 - 2 * keydown0) * 10
                q1 = danger(grid(minz&, cl - 1, trackn))
                cb = INT(jumping / 100)
                nb = 0
                IF cb = 2 OR cb = 3 THEN nb = 1
                IF cb = 4 THEN nb = 2
                IF (q1 AND 2) = 2 THEN nb = 3

                minz& = ballz&: maxz& = ballz&
                minv& = ballv&: maxv& = ballv&
                FOR n = 1 TO jump(nb, 0) + 1
                        minv& = minv& - 20
                        maxv& = maxv& + 10
                        minz& = minz& + minv&
                        maxz& = maxz& + maxv&
                NEXT n
                mins1 = INT((minz& - 9800) / 10000) + 2
                maxs1 = INT((maxz& - 9800) / 10000) + 2
                IF mins1 > maxs1 THEN SWAP mins1, maxs1
    
                echobounce = 1
                FOR ns1 = mins1 TO maxs1
                        IF ns1 > -1 THEN
                                sx = ns1 MOD 320
                                sy = 2 * INT(ns1 / 320) + trackn * 4 - 4
                                cg1 = DQBpoint(2, sx, sy)
                                cg2 = DQBpoint(2, sx, sy + 1)
                        ELSE
                                cg1 = 11: cg2 = 11
                        END IF
                        IF priority(cg1) < 11 OR priority(cg2) < 11 THEN echobounce = 0
                NEXT ns1
                IF nb = 0 THEN echobounce = 0
                IF echobounce = 1 THEN keyfire0 = 1
                'after we bounce were gonna die, so make sure we bounce higher
                'to increase our chances of carrying on
        END IF
END IF

'refuse to go backwards :-)
IF ballv& < 20 THEN keydown0 = 0: keyup0 = 1
IF ballv& > 800 AND (lum < 60 OR (editmode = 1 AND lum1 < 60)) THEN keydown0 = 1: keyup0 = 0
compute = keyfire0

END FUNCTION

FUNCTION danger (squaretype)

'provide a bit mask depending on the square.

' %12345678
' bit 8         AND 1           check if you canNOT bounce off square
' bit 7         AND 2           check if square is a bounce square
' bit 6         AND 4           check if reversing square
' bit 5         AND 8           check if reorientating square
' bit 4         AND 16
' bit 3         AND 32
' bit 2         AND 64
' bit 1         AND 128
D = 0
SELECT CASE squaretype
        CASE 0: D = 1   'black   00000001
        CASE 1:         'red     00000000
        CASE 2: D = 1   'green   00000001
        CASE 3: D = 3   'blue    00000011
        CASE 4: D = 1   'purple  00000001
        CASE 5: D = 3   'white   00000011
        CASE 6: D = 3   'orange  00000011
        CASE 7: D = 3   'yellow  00000011
        CASE 8: D = 1   'unknown 00000001
        CASE 9: D = 1   'unknown 00000001
        CASE 10: D = 1  'grey1   00000001
        CASE 11: D = 1  'grey2   00000001
        CASE 12: D = 8  'track1  00001000
        CASE 13: D = 8  'track2  00001000
        CASE 14: D = 4  'cyan1   00000100
        CASE 15: D = 4  'cyan2   00000100
END SELECT

danger = D

END FUNCTION

FUNCTION dimmer$ (dimstr$, dimno!)

x$ = dimstr$
FOR x = 1 TO LEN(dimstr$)
MID$(x$, x, 1) = CHR$(INT(ASC(MID$(x$, x, 1)) / dimno!))
NEXT x

dimmer$ = x$

END FUNCTION

SUB displayupdate (PlayerMask)

'calculate perspective information based on 3d track information
      
        calculateperspective ballz1&, trackz1&, ballx1, bally1, trackn1, trackn1, final1&
         scr1ball1x = ballsx: scr1ball1y = ballsy
         scr1ball1z = ballsz: scr1ball1v = ballv
         scr1ball1r = ballr
       
        calculateperspective ballz2&, trackz2&, ballx2, bally2, trackn2, trackn2, final2&
         scr2ball2x = ballsx: scr2ball2y = ballsy
         scr2ball2z = ballsz: scr2ball2v = ballv
         scr2ball2r = ballr
'calculate perspective information for "secondary" balls

        calculateperspective ballz2&, trackz1&, ballx2, bally2, trackn2, trackn1, final2&
         scr1ball2x = ballsx: scr1ball2y = ballsy
         scr1ball2z = ballsz: scr1ball2v = ballv
         scr1ball2r = ballr
      
        calculateperspective ballz1&, trackz2&, ballx1, bally1, trackn1, trackn2, final1&
         scr2ball1x = ballsx: scr2ball1y = ballsy
         scr2ball1z = ballsz: scr2ball1v = ballv
         scr2ball1r = ballr
  
        IF bonusstage1 > 0 THEN scr2ball1v = 0: scr1ball2v = 0

        IF ballwait1 > 0 THEN scr1ball1v = no: scr2ball1v = no
        IF ballwait2 > 0 THEN scr1ball2v = no: scr2ball2v = no
        IF (PlayerMask AND 1) = 1 THEN scr1ball1v = no: scr2ball1v = no: scr1ball2v = no
        IF (PlayerMask AND 2) = 2 THEN scr2ball1v = no: scr2ball2v = no: scr1ball2v = no

IF showtime1 < notime1 THEN showtime1 = showtime1 + 3
IF showtime1 > notime1 THEN showtime1 = notime1
IF showtime2 < notime2 THEN showtime2 = showtime2 + 3
IF showtime2 > notime2 THEN showtime2 = notime2

IF bonusstage1 = 0 THEN
        t1$ = STR$(showtime1)
        t1$ = RIGHT$(t1$, LEN(t1$) - 1)
        WHILE LEN(t1$) < 3: t1$ = "0" + t1$: WEND
        t1$ = LEFT$(t1$, 2) + "." + RIGHT$(t1$, 1)
        IF showtime1 < 50 AND (showtime MOD 4 < 2) THEN t1$ = ""
ELSE
        t1$ = STR$(bonustime1)
        t1$ = RIGHT$(t1$, LEN(t1$) - 1)
        WHILE LEN(t1$) < 3: t1$ = "0" + t1$: WEND
        t1$ = LEFT$(t1$, 2) + "." + RIGHT$(t1$, 1)
        IF bonustime1 < 30 AND (bonustime1 MOD 4 < 2) THEN t1$ = ""
END IF

t2$ = STR$(showtime2)
t2$ = RIGHT$(t2$, LEN(t2$) - 1)
WHILE LEN(t2$) < 3: t2$ = "0" + t2$: WEND
t2$ = LEFT$(t2$, 2) + "." + RIGHT$(t2$, 1)
IF showtime2 < 50 AND (showtime MOD 4 < 2) THEN t2$ = ""

j1$ = STR$(nojumps1)
j1$ = RIGHT$(j1$, LEN(j1$) - 1)
j2$ = STR$(nojumps2)
j2$ = RIGHT$(j2$, LEN(j2$) - 1)
IF LEN(j1$) < 2 THEN j1$ = "0" + j1$
IF LEN(j2$) < 2 THEN j2$ = "0" + j2$

scorechange1 = 0
scorechange2 = 0

IF score1& < 0 THEN score1& = 0
IF score2& < 0 THEN score2& = 0

IF score1& > showscore1& THEN
        showscore1& = showscore1& + 2
        scorechange1 = 1
END IF
IF showscore1& > score1& THEN showscore1& = score1&: scorechange1 = 1
IF score2& > showscore2& THEN
        showscore2& = showscore2& + 2
        scorechange2 = 1
END IF
IF showscore2& > score2& THEN showscore2& = score2&: scorechange2 = 1

s1$ = LEFT$(STR$(showscore1&), 6)
s1$ = RIGHT$(s1$, LEN(s1$) - 1)
WHILE LEN(s1$) < 5
s1$ = "0" + s1$
WEND
s2$ = LEFT$(STR$(showscore2&), 6)
s2$ = RIGHT$(s2$, LEN(s2$) - 1)
WHILE LEN(s2$) < 5
s2$ = "0" + s2$
WEND

        DQBwait 1
          DQBsetPal trackpalette$
IF (PlayerMask AND 1) = 0 THEN
        DQBsetSolidPut

          counter& = (counter& + 1) MOD 1048576
          DQBput 0, oscr1ball1x + 146, oscr1ball1y, VARSEG(scr1ballbuff1(0)), VARPTR(scr1ballbuff1(0))
          DQBput 0, oscr1ball2x + 146, oscr1ball2y, VARSEG(scr1ballbuff2(0)), VARPTR(scr1ballbuff2(0))
       
'message1 stuff in here
IF (death1 = -100) AND (opp1 = 1 OR keyfire1 OR bonusstage1 > 0) AND editmode = 0 THEN
        IF bonusstage1 = 0 THEN resetall1 (1) ELSE bonusstage1 = 0: resettrack1 (1)
END IF
IF msgcount1 MOD msgdelay1 = 0 THEN
        omsex = -1: omsey = -1
        m = INT(msgcount1 / msgdelay1) MOD 2
        IF m = 0 THEN
                DQBboxf 0, 0, 20, 319, 27, 0
        ELSE
                DQBboxf 0, 0, 20, 319, 27, 0
                DQBprint 0, msg1$, &H8000, 20, msgc1
        END IF
END IF
      
'time, jumps, score stuff here
IF newlevel1 = yes THEN final1& = ballz1&: resettrack1 (1): IF trackn1 MOD 3 = 1 AND editmode = 0 THEN bonus1 (PlayerMask)

DQBboxf 0, 136, 0, 163, 7, 0
DQBprint 0, t1$, 136, 0, 255
IF updatejump1 = 1 THEN
        DQBboxf 0, 212, 0, 228, 7, 0
        DQBprint 0, j1$, 212, 0, 255
END IF
IF scorechange1 = 1 THEN
        DQBboxf 0, 276, 0, 316, 7, 0
        DQBprint 0, s1$, 276, 0, 255
END IF
          DQBget 0, scr1ball1x + 146, scr1ball1y, scr1ball1x + 174, scr1ball1y + 26, VARSEG(scr1ballbuff1(0)), VARPTR(scr1ballbuff1(0))
          DQBget 0, scr1ball2x + 146, scr1ball2y, scr1ball2x + 174, scr1ball2y + 26, VARSEG(scr1ballbuff2(0)), VARPTR(scr1ballbuff2(0))
        DQBsetTransPut
          IF ballz1& > ballz2& THEN
                IF scr1ball1v THEN DQBrPut 0, scr1ball1x + 146, scr1ball1y, VARSEG(roll(0)), VARPTR(roll(0)) + ballsize * scr1ball1r, 0, scr1ball1z
                IF scr1ball2v THEN DQBrPut 0, scr1ball2x + 146, scr1ball2y, VARSEG(roll(0)), VARPTR(roll(0)) + ballsize * scr1ball2r, 0, scr1ball2z
          ELSE
                IF scr1ball2v THEN DQBrPut 0, scr1ball2x + 146, scr1ball2y, VARSEG(roll(0)), VARPTR(roll(0)) + ballsize * scr1ball2r, 0, scr1ball2z
                IF scr1ball1v THEN DQBrPut 0, scr1ball1x + 146, scr1ball1y, VARSEG(roll(0)), VARPTR(roll(0)) + ballsize * scr1ball1r, 0, scr1ball1z
          END IF
END IF
IF (PlayerMask AND 2) = 0 THEN

          DQBsetSolidPut
          DQBput 0, oscr2ball1x + 146, oscr2ball1y + 100, VARSEG(scr2ballbuff1(0)), VARPTR(scr2ballbuff1(0))
          DQBput 0, oscr2ball2x + 146, oscr2ball2y + 100, VARSEG(scr2ballbuff2(0)), VARPTR(scr2ballbuff2(0))
       
'message2 stuff in here
IF (death2 = -100) AND (opp2 = 1 OR keyfire2) AND editmode = 0 THEN
        resetall2 (1)
END IF
IF newlevel2 = yes THEN final2& = ballz2&: resettrack2 (1)
IF msgcount2 MOD msgdelay2 = 0 THEN
        omsex = -1: omsey = -1
        m = INT(msgcount2 / msgdelay2) MOD 2
        IF m = 0 THEN
                DQBboxf 0, 0, 120 + editmode * 10, 319, 127 + editmode * 10, 0
        ELSE
                DQBboxf 0, 0, 120 + editmode * 10, 319, 127 + editmode * 10, 0
                DQBprint 0, msg2$, &H8000, 120 + editmode * 10, msgc2
        END IF
END IF

'time, jumps, score stuff here
DQBboxf 0, 136, 100 + editmode * 10, 163, 107 + editmode * 10, 0
DQBprint 0, t2$, 136, 100 + editmode * 10, 255
IF updatejump2 = 1 THEN
        DQBboxf 0, 212, 100 + editmode * 10, 228, 107 + editmode * 10, 0
        DQBprint 0, j2$, 212, 100 + editmode * 10, 255
END IF
IF scorechange2 = 1 THEN
        DQBboxf 0, 276, 100 + editmode * 10, 316, 107 + editmode * 10, 0
        DQBprint 0, s2$, 276, 100 + editmode * 10, 255
END IF

          DQBget 0, scr2ball1x + 146, scr2ball1y + 100, scr2ball1x + 174, scr2ball1y + 126, VARSEG(scr2ballbuff1(0)), VARPTR(scr2ballbuff1(0))
          DQBget 0, scr2ball2x + 146, scr2ball2y + 100, scr2ball2x + 174, scr2ball2y + 126, VARSEG(scr2ballbuff2(0)), VARPTR(scr2ballbuff2(0))
     
        DQBsetTransPut
          IF ballz1& > ballz2& THEN
                IF scr2ball1v THEN DQBrPut 0, scr2ball1x + 146, scr2ball1y + 100, VARSEG(roll(0)), VARPTR(roll(0)) + ballsize * scr2ball1r, 0, scr2ball1z
                IF scr2ball2v THEN DQBrPut 0, scr2ball2x + 146, scr2ball2y + 100, VARSEG(roll(0)), VARPTR(roll(0)) + ballsize * scr2ball2r, 0, scr2ball2z
          ELSE
                IF scr2ball2v THEN DQBrPut 0, scr2ball2x + 146, scr2ball2y + 100, VARSEG(roll(0)), VARPTR(roll(0)) + ballsize * scr2ball2r, 0, scr2ball2z
                IF scr2ball1v THEN DQBrPut 0, scr2ball1x + 146, scr2ball1y + 100, VARSEG(roll(0)), VARPTR(roll(0)) + ballsize * scr2ball1r, 0, scr2ball1z
          END IF
END IF
        oscr1ball1x = scr1ball1x: oscr1ball1y = scr1ball1y
        oscr2ball1x = scr2ball1x: oscr2ball1y = scr2ball1y
        oscr1ball2x = scr1ball2x: oscr1ball2y = scr1ball2y
        oscr2ball2x = scr2ball2x: oscr2ball2y = scr2ball2y

IF msgcount1 > -1 THEN msgcount1 = msgcount1 - 1
IF msgcount2 > -1 THEN msgcount2 = msgcount2 - 1
updatejump1 = updatejump1 - SGN(updatejump1)
updatejump2 = updatejump2 - SGN(updatejump2)

END SUB

SUB drawedit (null)


LINE (0, 101)-(20, 107), 198, B
LINE (25, 101)-(45, 107), 194, BF
LINE (50, 101)-(70, 107), 195, BF
LINE (75, 101)-(95, 107), 196, BF
LINE (100, 101)-(120, 107), 197, BF
LINE (125, 101)-(145, 107), 198, BF
LINE (150, 101)-(170, 107), 199, BF
LINE (175, 101)-(195, 107), 200, BF
LINE (200, 101)-(220, 107), 201, BF
LINE (225, 101)-(245, 107), 202, BF
LINE (250, 101)-(260, 107), 203, BF
LINE (260, 101)-(270, 107), 204, BF
LINE (275, 101)-(285, 107), 205, BF
LINE (285, 101)-(295, 107), 206, BF
LINE (300, 101)-(310, 107), 207, BF
LINE (310, 101)-(320, 107), 208, BF

LINE (0, 16)-(16, 32), editcol1 + 193, BF
LINE (20, 16)-(36, 32), editcol2 + 193, BF
IF editcol1 = 0 THEN LINE (0, 16)-(16, 32), 198, B
IF editcol2 = 0 THEN LINE (20, 16)-(36, 32), 198, B
DQBget 2, 40, 160, 79, 166, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBput 0, 0, 0, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBget 2, 40, 167, 79, 173, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBput 0, 45, 0, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBget 2, 40, 174, 79, 180, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBput 0, 90, 0, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBget 2, 80, 160, 119, 166, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBput 0, 135, 0, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBget 2, 80, 167, 119, 173, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBput 0, 180, 0, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBget 2, 80, 174, 119, 180, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBput 0, 225, 0, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBget 2, 120, 160, 159, 166, VARSEG(fchar(0)), VARPTR(fchar(0))
DQBput 0, 270, 0, VARSEG(fchar(0)), VARPTR(fchar(0))

sx = (trackn1 * 20 - 21)
tname$ = ""
FOR y = 1 TO 20
Z = DQBpoint(2, (sx + y) MOD 320, 181 + INT((sx + y) / 320))
tname$ = tname$ + MID$(" abcdefghijklmnopqrstuvwxyz1234567890,.:/?!ABCDEFGHIJKLMNOPQRSTUVWXYZ", Z + 1, 1)
NEXT y

gettrackname (0)
LINE (44, 15)-(320, 37), 0, BF
font 0, 45, 30, "A: " + tname1$

setcol 4

DQBsetPal trackpalette$
END SUB

SUB drawtrack1 (title)

LINE (0, 0)-(320, 100), 0, BF

FOR y = 52 TO 99

c = y - 51

x1 = 160 - 160 * (y - 50) / 50
x2 = 160 - 96 * (y - 50) / 50
x3 = 160 - 32 * (y - 50) / 50
x4 = 160 + 32 * (y - 50) / 50
x5 = 160 + 96 * (y - 50) / 50
x6 = 160 + 160 * (y - 50) / 50

LINE (x1, y)-(x2, y), c
LINE (x5, y)-(x6, y), c
LINE (x2, y)-(x3, y), c + 48
LINE (x4, y)-(x5, y), c + 48
LINE (x3, y)-(x4, y), c

NEXT

IF title = 1 THEN
        a$ = "PLYR1"
        IF (p1 AND 4) = 4 THEN a$ = " CPU "
        DQBprint 0, a$, 0, 0, 255
        DQBprint 0, "LEV", 56, 0, 200
        DQBprint 0, "TIME", 104, 0, 194
        DQBprint 0, "JUMPS", 168, 0, 195
        DQBprint 0, "SCORE", 232, 0, 196
END IF

END SUB

SUB drawtrack2 (title)

LINE (0, 101)-(320, 200), 0, BF

FOR y = 52 TO 100

c = y - 51

x1 = 160 - 160 * (y - 50) / 50
x2 = 160 - 96 * (y - 50) / 50
x3 = 160 - 32 * (y - 50) / 50
x4 = 160 + 32 * (y - 50) / 50
x5 = 160 + 96 * (y - 50) / 50
x6 = 160 + 160 * (y - 50) / 50

LINE (x1, y + 100)-(x2, y + 100), c + 96
LINE (x5, y + 100)-(x6, y + 100), c + 96
LINE (x2, y + 100)-(x3, y + 100), c + 144
LINE (x4, y + 100)-(x5, y + 100), c + 144
LINE (x3, y + 100)-(x4, y + 100), c + 96

'IF tracktype = 1 THEN
'        PSET (x1, y + 100), 0
'        PSET (x2, y + 100), 0
'        PSET (x3, y + 100), 0
'        PSET (x4, y + 100), 0
'        PSET (x5, y + 100), 0
'        PSET (x6, y + 100), 0
'END IF

NEXT y

IF title = 1 THEN
        a$ = "PLYR2"
        IF (p2 AND 4) = 4 THEN a$ = " CPU "
        DQBprint 0, a$, 0, 100 + editmode * 10, 255
        DQBprint 0, "LEV", 56, 100 + editmode * 10, 200
        DQBprint 0, "TIME", 104, 100 + editmode * 10, 194
        DQBprint 0, "JUMPS", 168, 100 + editmode * 10, 195
        DQBprint 0, "SCORE", 232, 100 + editmode * 10, 196
END IF

END SUB

SUB editmenu (null)

IF mcount > 0 THEN mcount = mcount - 1
IF NOT (mselb) THEN mcount = 0
IF trackv1& <> 0 THEN trackz1& = trackz1& + INT(trackv1& * 10)
IF trackz1& < -10000 THEN trackz1& = -10000: trackv1& = 0
IF trackz1& > 6000000 THEN trackz1& = 6000000: trackv1& = 0
IF (mselb = 0 OR (mzone <> 15 AND mzone <> 16)) AND trackv1& <> 0 AND hotkey <> 1 AND hotkey <> 2 THEN
        IF ABS(trackv1&) > 20 THEN trackv1& = trackv1& - SGN(trackv1&)
        IF INT(trackz1& / 10000) <> INT((trackz1& + INT(trackv1& * 10)) / 10000) THEN
                IF trackv1& < 0 THEN
                        IF trackz1& > 0 THEN trackz1& = trackz1& - (trackz1& MOD 10000) ELSE trackz1& = -10000

                END IF
                IF trackv1& > 0 THEN
                        IF trackz1& > 0 THEN trackz1& = trackz1& + 10000 - (trackz1& MOD 10000) ELSE trackz1& = 0
                END IF
                trackv1& = 0
        END IF
END IF

IF msewheel > 0 THEN
trackv1& = trackv1& + 1
IF trackv1& < 100 THEN trackv1& = 100
END IF

IF msewheel < 0 THEN
trackv1& = trackv1& - 1
IF trackv1& > -100 THEN trackv1& = -100
END IF

IF (mselb = 0 AND mserb = 0) OR mzone = 0 THEN
        IF hotkey = 1 THEN
                trackv1& = trackv1& + 1
                IF trackv1& < 100 THEN trackv1& = 100
        END IF
        IF hotkey = 2 THEN
                trackv1& = trackv1& - 1
                IF trackv1& > -100 THEN trackv1& = -100
        END IF
EXIT SUB
END IF

IF mzone = 14 THEN
        editstatus = 1 ' exit
END IF

IF mzone = 15 THEN
trackv1& = trackv1& + 1
IF trackv1& < 100 THEN trackv1& = 100
IF mserb AND msewheel = 0 AND trackv1& < 300 THEN trackv1& = 300
END IF
IF mzone = 16 THEN
trackv1& = trackv1& - 1
IF trackv1& > -100 THEN trackv1& = -100
IF mserb AND msewheel = 0 AND trackv1& > -300 THEN trackv1& = -300
END IF
IF mzone = 17 AND (mcount = 0 OR mserb) THEN
        mcount = 20
        trackn1 = trackn1 + 1
        IF trackn1 > 27 THEN trackn1 = 1
        gettrackname (0)
        mouse (0)
        LINE (44, 15)-(320, 37), 0, BF
        font 0, 45, 30, MID$(UCASE$(alphabet$ + "?"), trackn1, 1) + ": " + tname1$
        omsex = msex: omsey = msey
        mouse (1)
END IF
IF mzone = 18 AND (mcount = 0 OR mserb) THEN
        mcount = 20
        trackn1 = trackn1 - 1
        IF trackn1 < 1 THEN trackn1 = 27
        gettrackname (0)
        mouse (0)
        LINE (44, 15)-(320, 37), 0, BF
        font 0, 45, 30, MID$(UCASE$(alphabet$ + "?"), trackn1, 1) + ": " + tname1$
        omsex = msex: omsey = msey
        mouse (1)
END IF
IF mzone = 19 THEN
        resetall2 (1)
        p2 = 4
        trackn2 = trackn1
        resettrack2 (1)
        notime2 = 300
        nojumps2 = 7
        status2 = p2 + 3
END IF
IF mzone = 20 THEN
        status2 = p2
'test
END IF
IF mzone = 37 THEN
        newname (0)
END IF

IF mzone > 20 AND mzone < 37 THEN
        mz = mzone - 20
        s1 = INT((trackz1& + 10000& * INT((mz + 1) / 2)) / 10000)
        sx = s1 MOD 320
        sy = 2 * INT(s1 / 320) + trackn1 * 4 - 4
        ec1 = editcol1
        ec2 = editcol2
        p = DQBpoint(2, sx, sy + 1 - mz MOD 2)
        IF editcol1 = 10 THEN
                ec1 = 10 + (sx + mz) MOD 2
                ec2 = 10 + (sx + mz) MOD 2
        END IF
        IF editcol1 = 12 THEN
                ec1 = 12 + (sx + mz) MOD 2
                ec2 = 13 - (sx + mz) MOD 2
        END IF
        IF editcol1 = 14 THEN
                ec1 = 14 + (sx + mz) MOD 2
                ec2 = 15 - (sx + mz) MOD 2
        END IF
        IF s1 < 601 THEN
                IF p = 10 OR p = 11 THEN
                        DQBpset 2, sx, sy + mz MOD 2, 13 - (sx + mz) MOD 2
                        x = s1
                        DO
                                x = x - 1
                                xx = x MOD 320
                                xy = 2 * INT(x / 320) + trackn1 * 4 - 4
                                p = DQBpoint(2, xx, xy)
                                IF p = 10 OR p = 11 THEN
                                        DQBpset 2, xx, xy, 13 - (xx + xy) MOD 2
                                        DQBpset 2, xx, xy + 1, 12 + (xx + xy) MOD 2
                                END IF
                        LOOP UNTIL (p <> 10 AND p <> 11) OR x = 0
                END IF
                IF ec1 = 10 OR ec1 = 11 THEN
                        FOR x = s1 TO 600
                                xx = x MOD 320
                                xy = 2 * INT(x / 320) + trackn1 * 4 - 4
                                DQBpset 2, xx, xy, 11 - (xx + xy) MOD 2
                                DQBpset 2, xx, xy + 1, 10 + (xx + xy) MOD 2
                        NEXT x
                END IF
                IF mselb THEN DQBpset 2, sx, sy + 1 - mz MOD 2, ec1
                IF mserb THEN DQBpset 2, sx, sy + 1 - mz MOD 2, ec2
        END IF
END IF

IF mzone > 0 AND mzone < 14 THEN
        IF mselb THEN
                editcol1 = mzone - 1
                IF editcol1 = 12 THEN editcol1 = 14: editcol2 = 15
                IF editcol1 = 11 THEN editcol1 = 12: editcol2 = 13
                IF editcol1 = 10 THEN editcol1 = 10: editcol2 = 11
                IF editcol1 < 10 AND editcol2 > 9 THEN editcol2 = 0
        END IF
        IF mserb THEN
                editcol2 = mzone - 1
                IF editcol2 = 12 THEN editcol1 = 14: editcol2 = 15
                IF editcol2 = 11 THEN editcol1 = 12: editcol2 = 13
                IF editcol2 = 10 THEN editcol1 = 10: editcol2 = 11
                IF editcol2 < 10 AND editcol1 > 9 THEN editcol1 = 0
        END IF
        LINE (0, 16)-(16, 32), editcol1 + 193, BF
        LINE (20, 16)-(36, 32), editcol2 + 193, BF
        IF editcol1 = 0 THEN LINE (0, 16)-(16, 32), 198, B
        IF editcol2 = 0 THEN LINE (20, 16)-(36, 32), 198, B
END IF

END SUB

SUB endmain (null)

DQBfadeTo 0, 0, 0
DQBinitText
DQBclose
CLS
COLOR 15
PRINT "NOVABALL v1.9.6 (c)TGSBSoft 2000"
PRINT "TGSBSoft is The Good Ship Bjerkeley"
PRINT "For more info, see NOVABALL.HTML"
PRINT
PRINT "This is FREEWARE (see restrictions)"
PRINT
PRINT ""
PRINT
PRINT "Have a nice day 83T"
END

END SUB

SUB font (fs, fx, fy, ftext$)


IF fs = 0 THEN DQBsetSolidPut
FOR c = 1 TO LEN(ftext$)
        m$ = MID$(ftext$, c, 1)
        rw = 1: cl = INSTR("abcdefghijklmnopqrstuvwxyz1234567890,.", m$)
                IF cl = 0 THEN rw = 2: cl = INSTR(":/?!ABCDEFGHIJKLMNOPQRSTUVW", m$)
                IF cl = 0 THEN rw = 3: cl = INSTR("XYZ", m$)
        IF cl > 0 THEN
                rw = rw * 22 - 22
                y = -1
                Z = 0
                DO
                        y = y + 1
                        p = DQBpoint(2, y, rw + 115)
                        IF p = 247 THEN Z = Z + 1
                LOOP UNTIL Z = cl
                bx = y
                ay = rw + 1
                by = rw + 21
                DO
                        y = y - 1
                        p = DQBpoint(2, y, rw + 115)
                LOOP UNTIL y = 0 OR p = 247
             
                IF p = 247 THEN y = y + 1
                ax = y
           
                IF m$ = "x" THEN fx = fx - 2

                DQBget 2, ax, ay + 115, bx, by + 115, VARSEG(fchar(0)), VARPTR(fchar(0))
                DQBput 0, fx, fy - 14, VARSEG(fchar(0)), VARPTR(fchar(0))
               
                fx = fx + bx - ax + 2
                IF m$ = "/" THEN fx = fx - 5
        ELSE
                fx = fx + 8
        END IF
        IF fx > 640 THEN c = LEN(ftext$)
NEXT c
DQBsetTransPut

END SUB

SUB getball (null)

setcol 1
setcol 5
DQBsetPal trackpalette$

pi! = 3.1415
pie! = pi! / 180
scx! = 2.6
scy! = 2.4
h = 10
ox = 159
oy = 100
D = 34
g = 2
frame = 0

FOR Angle = 0 TO 18 STEP 2
        DQBclearLayer 1
        DQBput 1, 146, 87, VARSEG(ball(0)), VARPTR(ball(0))

        FOR x = 0 TO 18 STEP g
                FOR y = 0 TO 35 STEP g
                        Z = x * 36 + y
                        p3! = 20 * SIN((x * 10) * pie!) * COS((y * 10) * pie!)
                        p2! = 20 * SIN((x * 10) * pie!) * SIN((y * 10) * pie!)
                        p1! = 20 * COS((x * 10) * pie!)
                        q1! = p1!
                        q2! = p3! * SIN(Angle * pie!) + p2! * COS(Angle * pie!)
                        q3! = p3! * COS(Angle * pie!) - p2! * SIN(Angle * pie!)
                        sy! = q3! * scy! * h / (q2! + h + D)
                        sx! = q1! * scx! * h / (q2! + h + D)
                        IF NOT (q2! > -6) THEN
                        
                                c = DQBpoint(1, ox + sx!, oy - sy!) - 242
                                IF c < 0 THEN c = 0
                                c = c / 2 + 233
                                IF c < 0 THEN c = 0
                                DQBpset 1, ox + sx!, oy - sy!, c
                                sz = INT(SQR(sx! * sx! + sy! * sy!))
                                IF sz < 12 THEN
                                        IF ABS(sy!) < 8 THEN
                                                DQBpset 1, ox + sx!, oy - sy! - SGN(sy!), c
                                        END IF
                                        IF ABS(sx!) < 8 THEN
                                                DQBpset 1, ox + sx! + SGN(sx!), oy - sy!, c
                                                IF ABS(sy!) < 3 THEN
                                                        DQBpset 1, ox + sx! + SGN(sx!), oy - sy! - SGN(sy!), c
                                                END IF
                                        END IF
                                END IF
                        END IF
                NEXT
        NEXT
        DQBget 1, 160 - 14, 100 - 13, 160 + 14, 100 + 13, VARSEG(roll(0)), VARPTR(roll(0)) + (ballsize * frame)
        frame = frame + 1
NEXT

DQBclearLayer 1

END SUB

SUB gettrackname (null)

sx = (trackn1 * 20 - 21)
tname1$ = ""
FOR y = 1 TO 20
Z = DQBpoint(2, (sx + y) MOD 160, 181 + INT((sx + y) / 160))
tname1$ = tname1$ + MID$(" abcdefghijklmnopqrstuvwxyz1234567890,.:/?!ABCDEFGHIJKLMNOPQRSTUVWXYZ", Z + 1, 1)
NEXT y

sx = (trackn2 * 20 - 21)
tname2$ = ""
FOR y = 1 TO 20
Z = DQBpoint(2, (sx + y) MOD 160, 181 + INT((sx + y) / 160))
tname2$ = tname2$ + MID$(" abcdefghijklmnopqrstuvwxyz1234567890,.:/?!ABCDEFGHIJKLMNOPQRSTUVWXYZ", Z + 1, 1)
NEXT y

END SUB

FUNCTION getx (gx$)

a$ = UCASE$(gx$)
gx = INSTR("ABCDEFGHIJKLMNOPQRSTUVWXYZ", a$) MOD 5
IF gx = 0 THEN gx = 5
getx = gx

END FUNCTION

FUNCTION gety (gy$)

a$ = UCASE$(gy$)
gety = INT((INSTR("ABCDEFGHIJKLMNOPQRSTUVWXYZ", a$) - 1) / 5) + 1

END FUNCTION

FUNCTION grid (ballz&, lane, trackno)

s1 = INT((ballz& - 9800) / 10000) + 2
IF s1 > -1 AND s1 < 601 THEN
        sx = s1 MOD 320
        sy = 2 * INT(s1 / 320) + trackno * 4 - 4
        grid = DQBpoint(2, sx, sy + lane)
ELSE
        grid = 11
END IF

END FUNCTION

SUB init

'non-changeable constants

Col$(0) = CHR$(0) + CHR$(0) + CHR$(0)           'black
Col$(1) = CHR$(63) + CHR$(0) + CHR$(0)          'red
Col$(2) = CHR$(0) + CHR$(63) + CHR$(0)          'green
Col$(3) = CHR$(0) + CHR$(0) + CHR$(63)          'blue
Col$(4) = CHR$(63) + CHR$(0) + CHR$(63)         'purple
Col$(5) = CHR$(63) + CHR$(63) + CHR$(63)        'white
Col$(6) = CHR$(63) + CHR$(30) + CHR$(0)         'orange
Col$(7) = CHR$(63) + CHR$(63) + CHR$(0)         'yellow
Col$(8) = CHR$(20) + CHR$(60) + CHR$(40)           'aqua green
Col$(9) = CHR$(40) + CHR$(40) + CHR$(63)        'lt blue
Col$(10) = CHR$(50) + CHR$(50) + CHR$(50)       'grey1  (light)
Col$(11) = CHR$(40) + CHR$(40) + CHR$(40)       'grey2  (dark)
Col$(12) = CHR$(50) + CHR$(40) + CHR$(20)       'brown1 (light)
Col$(13) = CHR$(40) + CHR$(30) + CHR$(10)       'brown2 (dark)
Col$(14) = CHR$(10) + CHR$(63) + CHR$(63)       'cyan1  (light)
Col$(15) = CHR$(0) + CHR$(50) + CHR$(50)        'cyan2  (dark)
                                               
FOR y = 1 TO 5
FOR x = 0 TO 15
Col$(x) = Col$(x) + Col$(x)
NEXT x
NEXT y
trackpalette$ = STRING$(768, CHR$(0))
grey1$ = ""
grey2$ = ""
square$ = ""
FOR x = 0 TO 15
grey1$ = grey1$ + CHR$(x * 3 + 3) + CHR$(x * 3 + 3) + CHR$(x * 3 + 3)
NEXT x
FOR x = 0 TO 15
grey2$ = grey2$ + CHR$(33 + x * 2) + CHR$(33 + x * 2) + CHR$(33 + x * 2)
NEXT x
FOR x = 1 TO 15
square$ = square$ + LEFT$(Col$(x), 3)
NEXT x
dot$ = ""
FOR x = 1 TO 7
w = x * 9
y = x * 9 / 2
Z = x * 9 / 4
dot$ = dot$ + CHR$(w) + CHR$(Z) + CHR$(y)
NEXT x
msecnt = 0
msex = 160
msey = 100
mselb = 0
mserb = 0
b$ = "1 9 12 7 14 5 215 3 214 4 313 4 31 21 3 71 2 81  91"
a$ = ""
FOR x = 1 TO LEN(b$)
        m$ = MID$(b$, x, 1)
        IF m$ = " " THEN a$ = a$ + " "
        IF m$ = "1" THEN a$ = a$ + "1"
        IF VAL(m$) > 1 THEN a$ = a$ + STRING$(VAL(m$) - 1, RIGHT$(a$, 1))
NEXT x

FOR x = 1 TO 10
        FOR y = 1 TO 10
                Z = y * 10 - 10 + x
                m$ = MID$(a$, Z, 1)
                m = VAL(m$) * 255
                PSET (x, y), m
        NEXT
NEXT
GET (1, 1)-(10, 10), msecurs(0)
LINE (1, 1)-(10, 10), 0, BF
editcol1 = 3
editcol2 = 0
jump(1, 0) = jumpdata("-2 3x-1 6x0 3x1 2", 1) ' rebounds, and green
jump(2, 0) = jumpdata("-5 -3 -2 4x-1 7x0 4x1 2 3 5", 2) ' first jump +1
jump(3, 0) = jumpdata("-5 2x-4 3x-3 4x-2 5x-1 7x0 5x1 4x2 3x3 2x4 5", 3) ' second jump/blue + 1
jump(4, 0) = jumpdata("-5 3x-4 5x-3 7x-2 7x-1 11x0 7x1 7x2 5x3 3x4 5", 4) ' blue + fire + 2 (+1)
counter& = 0
FOR x = -150 TO 150
        y = x + 150
        IF x < -87 THEN boundary(y, 0) = -88
        IF x >= -87 AND x < -58 THEN boundary(y, 0) = -86
        IF x = -58 THEN boundary(y, 0) = 999
        IF x > -58 AND x < -29 THEN boundary(y, 0) = -30
        IF x >= -29 AND x < 2 THEN boundary(y, 0) = -28
        IF x = 2 THEN boundary(y, 0) = 999
        IF x > 2 AND x < 31 THEN boundary(y, 0) = 30
        IF x >= 31 AND x < 60 THEN boundary(y, 0) = 32
        IF x = 60 THEN boundary(y, 0) = 999
        IF x > 60 AND x < 89 THEN boundary(y, 0) = 88
        IF x >= 89 THEN boundary(y, 0) = 90
      
        IF x < -87 THEN boundary(y, 1) = -116: boundary(y, 2) = 0
        IF x >= -87 AND x < -29 THEN boundary(y, 1) = -58: boundary(y, 2) = 1
        IF x >= -29 AND x < 31 THEN boundary(y, 1) = 2: boundary(y, 2) = 0
        IF x >= 31 AND x < 89 THEN boundary(y, 1) = 60: boundary(y, 2) = 1
        IF x >= 89 THEN boundary(y, 1) = 118: boundary(y, 2) = 0

NEXT x

priority(10) = 1
priority(11) = 1
priority(5) = 2
priority(7) = 3
priority(6) = 4
priority(8) = 5
priority(3) = 6
priority(2) = 7
priority(12) = 8
priority(13) = 8
priority(14) = 9
priority(15) = 9
priority(1) = 10
priority(0) = 11
priority(4) = 12
priority(9) = 13
editmode = 0

FOR x = 0 TO 360
s!(x) = SIN(x * 3.14159 / 180)
c!(x) = COS(x * 3.14159 / 180)
NEXT x

'constants which at some stage should be loaded / editable
leftkey1 = 44
rightkey1 = 45
upkey1 = 33
downkey1 = 46
firekey1 = 34

leftkey2 = 79
rightkey2 = 80
upkey2 = 77
downkey2 = 81
firekey2 = 78

'other variables it would be useful to alter
soundon = 0
performance = high
trackfog$ = CHR$(63) + CHR$(63) + CHR$(63)
trackfog = high
tracktype = 0
camera1 = 0
camera2 = 1
opp1 = 0' human
opp2 = 0' computer or 1
a = DQBloadFont("hitech2.fnt")
intel(0) = 1
intel(1) = 1
intel(2) = 2
intel(3) = 4
intel(4) = 6
intel(5) = 16
intel(6) = 32
intel(7) = 40   ' for perfection only. (takeover)

intelligence1 = 6
intelligence2 = 7
intel1 = intel(intelligence1)
intel2 = intel(intelligence2)
automatch = yes

jumplimit = 20
bonusstage1 = 0
bonusseq1$ = ""
bonustime1 = 0
currentkey1 = 0
lastkey1 = 0
bonusmarker1 = 0
gametype = 0
trackn$ = "ABC"

END SUB

SUB intro (null)

IF DQBloadLayer(3, "NOVADATA.002", Pal) THEN PRINT "Error loading ECLOGO.PCX, program aborted": DQBclose: END
DQBfadeTo 0, 0, 0
COLOR 255
DQBget 3, 230, 35, 285, 100, VARSEG(scrfx(0)), VARPTR(scrfx(0))
DQBcopyLayer 3, 0
DQBboxf 3, 230, 35, 285, 100, 0

DQBclearLayer 4

DQBput 4, 133, 68, VARSEG(scrfx(0)), VARPTR(scrfx(0))
DQBget 4, 133 - Baddx, 68 - Baddy, 188 + Baddx, 133 + Baddy, VARSEG(scrfx(0)), VARPTR(scrfx(0))

wd = INT((55 + Baddx) / 2)
ht = INT((65 + Baddy) / 2)
rd = SQR(wd ^ 2 + ht ^ 2) - 10
th = INT(ATN(wd / ht) / 3.141 * 180)
sx = 223
sy = 94

ut! = 0
vt! = 0
tht! = th
g! = 9.81
tf! = .2

Z = 0

DQBfadeIn Pal
DO

at! = g! * SIN(tht! * 3.141 / 180)
at! = at! - ABS(ut!) ^ .5 * SGN(ut!) / 2
'calculate at

tht2! = tht! + ut! * tf! + .5 * at! * tf! * tf!
vt! = ut! + at! * tf!
'calculate thetat t+deltat

x = INT(tht2! - th)

dx = rotatex(x, wd, rd, sx, th)
dy = rotatey(x, ht, rd, sy, th)
r = INT(x / 360 * 256)

DQBcopyLayer 3, 0
DQBrPut 0, dx, dy, VARSEG(scrfx(0)), VARPTR(scrfx(0)), r, 100

tht! = tht2!
ut! = vt!
DQBwait 1
Z = DQBkey(KEYESC)
LOOP UNTIL Z OR (ABS(ut!) < .1 AND ABS(at!) < .1)

t! = 0
DO
t! = t! + tf!
x = dx:
y = dy + .005 * 9.81 * t! ^ 4
DQBcopyLayer 3, 0
DQBrPut 0, x, y, VARSEG(scrfx(0)), VARPTR(scrfx(0)), r, 100
DQBwait 1
Z = DQBkey(KEYESC)
LOOP UNTIL Z OR (y > 200)

Z = 0
DQBfadeTo 63, 63, 63

END SUB

FUNCTION jumpdata (a$, n)

x = 0: DO
y = INSTR(a$, " ")
IF y > 0 THEN
        b$ = LEFT$(a$, y - 1)
        a$ = RIGHT$(a$, LEN(a$) - y)
        Z = 0
        Z = INSTR(b$, "x")
        IF Z > 0 THEN
                c$ = LEFT$(b$, Z - 1)
                b$ = RIGHT$(b$, LEN(b$) - Z)
                FOR w = 1 TO VAL(c$)
                        x = x + 1
                        jump(n, x) = VAL(b$)
                NEXT w
        ELSE
                x = x + 1
                jump(n, x) = VAL(b$)
        END IF
ELSE
        x = x + 1
        jump(n, x) = VAL(a$)
        y = -1
END IF
LOOP UNTIL y = -1

jumpdata = x

END FUNCTION

SUB keypress (PlayerMask)

SHARED keyup0, keydown0, keyleft0, keyright0

IF (PlayerMask AND 1) = 0 AND ballwait1 = 0 THEN
        IF (status1 AND 4) = 0 THEN
                keyleft1 = DQBkey(leftkey1)
                keyright1 = DQBkey(rightkey1)
                keyup1 = DQBkey(upkey1)
                keydown1 = DQBkey(downkey1)
                keyfire1 = DQBkey(firekey1)
                IF reversi1 = yes AND status1 MOD 4 < 3 THEN SWAP keyleft1, keyright1
        ELSE
                IF (status1 MOD 4 < 3) THEN
                        IF automatch = yes AND editmode = 0 THEN
                                IF trackn1 > trackn2 OR (trackn1 = trackn2 AND ballz1& > ballz2&) THEN intel1 = intel(1) ELSE intel1 = intel(6)
                        END IF
                        keyfire1 = compute(ballv1&, ballz1&, jumping1, ballx1, maxv1&, trackn1, nojumps1, intel1, lum1)
                        keyleft1 = keyleft0
                        keyright1 = keyright0
                        keyup1 = keyup0
                        keydown1 = keydown0
                ELSE
                        keyfire1 = 1
                END IF
        END IF
ELSE
        keyleft1 = 0: keyright1 = 0: keyup1 = 0: keydown1 = 0: keyfire1 = 0
END IF

IF (PlayerMask AND 2) = 0 AND ballwait2 = 0 THEN
        IF (status2 AND 4) = 0 THEN
                keyleft2 = DQBkey(leftkey2)
                keyright2 = DQBkey(rightkey2)
                keyup2 = DQBkey(upkey2)
                keydown2 = DQBkey(downkey2)
                keyfire2 = DQBkey(firekey2)
                IF reversi2 = yes AND status2 MOD 4 < 3 THEN SWAP keyleft2, keyright2
        ELSE
                IF (status2 MOD 4 < 3) THEN
                        IF automatch = yes AND editmode = 0 THEN
                                IF trackn2 > trackn1 OR (trackn2 = trackn1 AND ballz2& > ballz1&) THEN intel2 = intel(1) ELSE intel2 = intel(6)
                        END IF

                        keyfire2 = compute(ballv2&, ballz2&, jumping2, ballx2, maxv2&, trackn2, nojumps2, intel2, lum2)
                        keyleft2 = keyleft0
                        keyright2 = keyright0
                        keyup2 = keyup0
                        keydown2 = keydown0
                ELSE
                        keyfire2 = 1
                END IF
        END IF
ELSE
        keyleft2 = 0: keyright2 = 0: keyup2 = 0: keydown2 = 0: keyfire2 = 0
END IF

keyquit = DQBkey(KEYESC)
keynew = DQBkey(KEYENTER)
keyhalt = DQBkey(KEYSPACE)
keyu = DQBkey(KEYUP)
keyd = DQBkey(KEYDOWN)
keyl = DQBkey(KEYLEFT)
keyr = DQBkey(KEYRIGHT)

lastkey1 = currentkey1
IF bonusstage1 > 0 THEN
        currentkey1 = 0
        IF keyleft1 THEN currentkey1 = 1
        IF keyright1 THEN currentkey1 = 2
        IF keyup1 THEN currentkey1 = 3
        IF keydown1 THEN currentkey1 = 4
        IF keyfire1 THEN currentkey1 = 5
END IF
END SUB

SUB loaddata (null)

OPEN "NOVADATA.001" FOR INPUT AS #1

DO
DO
INPUT #1, a$
LOOP UNTIL LEFT$(a$, 1) = "["

IF LEFT$(a$, 8) = "[3ddata]" THEN GOSUB trackdata
IF LEFT$(a$, 10) = "[fontdata]" THEN GOSUB fontdata
IF LEFT$(a$, 11) = "[sounddata]" THEN GOSUB sounddata
IF LEFT$(a$, 12) = "[buttondata]" THEN GOSUB buttondata
IF LEFT$(a$, 10) = "[balldata]" THEN GOSUB balldata
IF LEFT$(a$, 13) = "[perspective]" THEN GOSUB perspective


LOOP UNTIL LEFT$(a$, 5) = "[end]"

CLOSE 1
loadgame ("NOVADATA.001")

GOTO loaddataend


trackdata:

b$ = ""
FOR x = 1 TO 12
        INPUT #1, a$
        b$ = b$ + a$
NEXT x
FOR x = 1 TO LEN(b$)
        m$ = MID$(b$, x, 1)
        Z = INSTR("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", m$) - 1
        DQBpset 2, (x - 1) MOD 320, 112 + INT((x - 1) / 320), Z
NEXT x
RETURN

fontdata:
b$ = "hgfedcba0"

FOR y = 240 TO 305
        INPUT #1, a$
        FOR x = 1 TO 8
                DO
                        Z = INSTR(a$, MID$(b$, x, 1))
                        IF Z > 0 THEN a$ = LEFT$(a$, Z - 1) + MID$(b$, x + 1, 1) + MID$(b$, x + 1, 1) + RIGHT$(a$, LEN(a$) - Z)
                LOOP UNTIL Z = 0
        NEXT x
        FOR x = 0 TO 312
                Z = INSTR("0123456789ABCDEFG", MID$(a$, x + 1, 1)) - 1
                IF Z = 0 THEN Z = -240
                DQBpset 2, x, y - 240 + 115, Z + 240
        NEXT x
NEXT y
RETURN

sounddata:
FOR x = 1 TO 5
INPUT #1, a$
y = INSTR(a$, ":")
IF y = 0 THEN y = 1
m$ = LCASE$(LEFT$(a$, y - 1))
IF m$ = "soundcard" THEN
        'mseconfig.soundcard = VAL(MID$(a$, 11, LEN(a$) - 10))
END IF
IF m$ = "baseio" THEN
        add$ = (MID$(a$, 8, 3))
        add = 256 * (INSTR("0123456789abcdef", LEFT$(add$, 1)) - 1)
        add = add + 16 * (INSTR("0123456789abcdef", MID$(add$, 2, 1)) - 1)
        add = add + INSTR("0123456789abcdef", RIGHT$(add$, 1)) - 1
        'mseconfig.baseio = add
END IF
IF m$ = "irq" THEN
        'mseconfig.IRQ = VAL(MID$(a$, 5, LEN(a$) - 4))
END IF
IF m$ = "dma" THEN
        'mseconfig.DMA = VAL(MID$(a$, 5, LEN(a$) - 4))
END IF
IF m$ = "soundquality" THEN
        'mseconfig.soundquality = VAL(MID$(a$, 14, LEN(a$) - 13))
END IF
NEXT x
RETURN

buttondata:
sx = -1: sy = -1
DO
INPUT #1, a$
FOR x = 1 TO LEN(a$)
sx = sx + 1: IF sx MOD 40 = 0 THEN sy = sy + 1: sx = sx - 40: IF INT(sy / 7) = 3 THEN sy = 0: sx = sx + 40
m$ = MID$(a$, x, 1)
Z = INSTR("0123456789abcdefghijklmnopqrstuvwxyz", m$) - 1
IF Z > 0 THEN DQBpset 2, 80 + sx, 160 + sy, Z + 209
NEXT x
LOOP UNTIL Z = -1
INPUT #1, a$
a$ = RIGHT$(a$, LEN(a$) - 1)
a$ = LEFT$(a$, LEN(a$) - 1)
Button$ = ""
FOR x = 1 TO LEN(a$)
m$ = MID$(a$, x, 1)
IF m$ = CHR$(99) THEN m$ = ","
m = ASC(m$) - 32
Button$ = Button$ + CHR$(m)
NEXT x
RETURN

balldata:
FOR y = 0 TO 26
INPUT #1, a$
a$ = LEFT$(a$, LEN(a$) - 1)
a$ = RIGHT$(a$, LEN(a$) - 1)
FOR x = 0 TO 28
b$ = MID$(a$, x + 1, 1)
c = INSTR("0123456789ABCDEFGHI", b$) - 1
c = c / 18 * 15
IF b$ = "1" OR b$ = "2" THEN c = 1
IF c > 0 THEN c = 255 - c
DQBpset 2, 161 + x, 160 + y, c
NEXT
NEXT
DQBget 2, 161, 160, 189, 186, VARSEG(ball(0)), VARPTR(ball(0))
RETURN

perspective:
'INPUT #1, a$
'FOR x = 1 TO LEN(a$)
'sx = (x MOD 320)
'sy = 185 + INT(x / 320)
'm$ = MID$(a$, x, 1)
'IF m$ = CHR$(36) THEN m$ = ","
'DQBpset 2, sx, sy, ASC(m$)
'NEXT x

y = -1
Z = 3
RESTORE perspectiv
DO
        READ n
        FOR x = 1 TO n
                y = y + 1
                sx = ((800 - y) MOD 320)
                sy = 185 + INT((800 - y) / 320)
                DQBpset 2, sx, sy, Z
        NEXT x
        Z = Z + 1
        IF Z > 67 THEN Z = 67
LOOP UNTIL y > 800
RETURN

loaddataend:

END SUB

SUB loadgame (file$)

OPEN file$ FOR INPUT AS #1

D$ = STRING$(3, CHR$(0))
D$ = D$ + CHR$(35) + CHR$(0) + CHR$(0)
D$ = D$ + CHR$(63) + CHR$(20) + CHR$(5)
FOR x = 1 TO 253
D$ = D$ + CHR$(63) + CHR$(63) + CHR$(63)
NEXT x

SCREEN 13
DQBinitVGA
DQBsetPal D$
LOCATE 1, 16
COLOR 255
PRINT "Loading.."

chck = 0
DO
DO
INPUT #1, a$
LOOP UNTIL LEFT$(a$, 1) = "["

IF LEFT$(a$, 11) = "[trackdata]" THEN GOSUB loadtrack
IF LEFT$(a$, 10) = "[checksum]" THEN GOSUB checktrack
IF LEFT$(a$, 12) = "[tracknames]" THEN GOSUB loadnames

LOOP UNTIL LEFT$(a$, 5) = "[end]"

CLOSE 1
GOTO loadgameend

loadtrack:
v = 0
x = -1
y = 0
DO
INPUT #1, a$
FOR w = 1 TO LEN(a$)
x = x + 1: IF x = 320 THEN x = 0: y = y + 1
m$ = MID$(a$, w, 1)
Z = INSTR("0123456789abcdefghijkl", m$) - 1
IF Z > -1 THEN v = (v + Z) MOD 5000
IF Z > -1 THEN DQBpset 2, x, y, Z
NEXT w
LOOP UNTIL Z = -1

RETURN

loadnames:
INPUT #1, a$
IF LEFT$(a$, 1) = "Ý" THEN a$ = RIGHT$(a$, LEN(a$) - 1)
IF RIGHT$(a$, 1) = "Ý" THEN a$ = LEFT$(a$, LEN(a$) - 1)
FOR x = 1 TO LEN(a$)
sx = (x - 1)
m$ = MID$(a$, x, 1)
Z = INSTR(" " + alphabet$ + "1234567890#.:/?!" + UCASE$(alphabet$), m$) - 1
DQBpset 2, sx MOD 320, 181 + INT(sx / 320), Z
NEXT x
RETURN

checktrack:
INPUT #1, a$
a$ = MID$(a$, 2, 4)
chck = VAL(a$)
RETURN

loadgameend:

END SUB

SUB menu (null)

IF mouseon = 1 THEN DQBsetMouseRange 0, 0, 320, 200

DQBsetPal STRING$(768, CHR$(63))
IF DQBloadLayer(3, "NOVADATA.003", Pal) THEN PRINT "Error loading ECLOGO.PCX, program aborted": DQBclose: END
DQBcopyLayer 3, 0
DQBfadeIn Pal

FOR x = 1 TO 30
DQBfadeStepTo 0, 0, 0
DQBwait 1
NEXT x

DQBgetPal Pal
p$ = STRING$(768, CHR$(0))
MID$(p$, 1, 720) = LEFT$(Pal, 720)

MID$(p$, 721, 48) = grey2$

DQBsetPal p$

font 1, 139, 107, "Game"
font 1, 136, 132, "Editor"

DO
'DQBcopyLayer 1, 0
DQBwait 1
mouse (0)
mouse (1)
mousemove (0)
mousecheck (1)

Z = DQBkey(KEYESC)
LOOP UNTIL Z OR (mselb AND mzone > 0)
IF Z THEN endmain (0)

menuopt = mzone
mouse (0)

END SUB

FUNCTION menu2 (null)

DQBsetMouseRange 0, 100, 320, 200
ax = 160: ay = 50
br = 100: cr = 100
RESTORE gamedata
omsex = -1
omsey = -1
mzone = 0
fret = 0
opp1 = 1: opp2 = 1
gametype = 0
resetall1 (0)
resetall2 (0)

SHARED track1, track2, track3
track1 = INSTR(UCASE$(alphabet$) + "?", LEFT$(trackn$, 1))
track2 = INSTR(UCASE$(alphabet$) + "?", MID$(trackn$, 2, 1))
track3 = INSTR(UCASE$(alphabet$) + "?", RIGHT$(trackn$, 1))

GOSUB starset1
GOSUB starset2

m$ = STRING$(41, " ")
lenm = 328

m1 = 8
m2 = 0
DQBclearLayer 1
DQBsetClipBox 0, 100, 319, 199

DQBprint 1, "HiScores          Squares", 8, 112, 194
DQBprint 1, "50000", 8, 128, 200
DQBprint 1, "25000", 8, 136, 195
DQBprint 1, "10000", 8, 144, 201
DQBprint 1, "5000", 8, 152, 202
DQBprint 1, "1000", 8, 160, 196

DQBprint 1, "GEF", 72, 128, 200
DQBprint 1, "GEF", 72, 136, 195
DQBprint 1, "GEF", 72, 144, 201
DQBprint 1, "GEF", 72, 152, 202
DQBprint 1, "GEF", 72, 160, 196

DQBprint 1, "Slow", 160, 128, 255
DQBprint 1, "Fast", 160, 136, 255
DQBprint 1, "Jump", 160, 144, 255
DQBprint 1, "Block", 160, 152, 255
DQBprint 1, "Nova", 160, 160, 255
DQBprint 1, "Bonus", 160, 168, 255
DQBprint 1, "Takeover", 240, 128, 255
DQBprint 1, "Blind", 240, 136, 255
DQBprint 1, "????", 240, 144, 255
DQBprint 1, "Interface", 240, 152, 255
DQBprint 1, "Normal", 240, 160, 255
DQBprint 1, "????", 240, 168, 255

DQBboxf 1, 145, 128, 155, 135, 194
DQBboxf 1, 145, 136, 155, 143, 195
DQBboxf 1, 145, 144, 155, 151, 196
DQBboxf 1, 145, 152, 155, 159, 197
DQBboxf 1, 145, 160, 155, 167, 198
DQBboxf 1, 145, 168, 155, 175, 199

DQBboxf 1, 225, 128, 235, 135, 200
DQBboxf 1, 225, 136, 235, 143, 201
DQBboxf 1, 225, 144, 235, 151, 202
DQBboxf 1, 225, 152, 235, 159, 203
DQBtri 1, 235, 152, 226, 159, 235, 163, 204
DQBboxf 1, 225, 160, 235, 167, 205
DQBtri 1, 235, 160, 226, 167, 235, 171, 206
DQBboxf 1, 225, 168, 235, 175, 207
DQBtri 1, 235, 168, 226, 175, 235, 175, 208

DQBprint 1, "1PLAY  2PLAY 1PLAY  2PLAY   HUMAN", 0, 184, 255
DQBprint 1, " --ARCADE--    -PRACTICE-", 4, 192, 196
DQBprint 1, "ROBOT", 216, 192, 255
DQBprint 1, "v", 232, 187, 194
a$ = UCASE$(alphabet$) + "?"
DQBprint 1, MID$(a$, track1, 1), 280, 184, 255
DQBprint 1, MID$(a$, track2, 1), 296, 184, 255
DQBprint 1, MID$(a$, track3, 1), 312, 184, 255

DQBsetClipBox 0, 0, 319, 199

DO
        IF ballwait1 > 0 THEN ballwait1 = ballwait1 - 1: IF ballwait1 = 0 THEN jumping1 = 300: ballv1& = 500
        updatetrack1 (63)
        keypress (Mask)
        moveball (Mask)
        movetrack (Mask)

        checkball (Mask)

        specialpower (0)
        IF newlevel1 = 1 THEN newlevel1 = 0: resettrack1 (0)
        IF newlevel2 = 1 THEN newlevel2 = 0: resettrack2 (0)

        counter& = counter& + 1 MOD 3600
        bth = (180 * COS(counter& * 3.141 / 1800) - 60) MOD 360
        cth = (180 * COS(counter& * 3.141 / 1800) + 60) MOD 360
        br = 50 + ABS(200 * SIN(counter& * 3.141 / 540))
        cr = 50 + ABS(200 * SIN(counter& * 3.141 / 540))
        bx = ax + br * SIN(bth * 3.141 / 180)
        by = ay - br * COS(bth * 3.141 / 180)
        cx = ax + cr * SIN(cth * 3.141 / 180)
        cy = ay - cr * COS(cth * 3.141 / 180)

        ballrad = 45 * br / 50
        p1x& = ax + ballrad * SIN(bth * 3.141 / 180)
        p1y& = ay - ballrad * COS(bth * 3.141 / 180)
        p2x& = ax + ballrad * SIN(cth * 3.141 / 180)
        p2y& = ay - ballrad * COS(cth * 3.141 / 180)
        m = ballx1 + 146
        n = 292 - m
        gx = INT((m * p1x& + n * p2x&) / (m + n))
        gy = INT((m * p1y& + n * p2y&) / (m + n))
        bearing# = DQBangle((bx + cx) / 2, (by + cy) / 2, ax, ay)
       
        sz = INT(br * 14 / 100)
      
        l = bally1 * (SQR((gx - ax) ^ 2 + (gy - ay) ^ 2)) / 46
       
        dx = gx + (sz + l) * SIN(bearing# * 3.141 / 128)
        dy = gy - (sz + l) * COS(bearing# * 3.141 / 128)
      
        ballr = (INT(((ballz1& + 150000) MOD 4000) / 400))

        ratio = sz / 14 * 100
        IF ratio < 5 THEN ratio = 5

        m2 = (m2 + 1) MOD 4
        IF m2 = 0 THEN
                m1 = m1 - 2
                IF m1 < 0 THEN
                        a$ = LEFT$(m$, 1)
                        m$ = RIGHT$(m$, LEN(m$) - 1)
                        IF INSTR("ijl1I!,.;:'-", a$) > 0 THEN m1 = m1 + 4: lenm = lenm - 4:  ELSE m1 = m1 + 8: lenm = lenm - 8
                        IF lenm < 320 THEN
                                READ n$
                                IF n$ = "???" THEN RESTORE gamedata: READ n$: m$ = STRING$(41, " "): lenm = 328
                                FOR x = 1 TO LEN(n$)
                                        b$ = MID$(n$, x, 1)
                                        IF INSTR("ijl1I!,.;:'-", b$) > 0 THEN lenm = lenm + 4 ELSE lenm = lenm + 8
                                NEXT x
                                m$ = m$ + n$
                        END IF
                END IF
        END IF
        DQBclearLayer 3
        DQBrPut 3, 160 - 14, 100 - 13, VARSEG(roll(0)), (VARPTR(roll(0)) + ballsize * ballr), INT(bearing#), 100
        DQBget 3, 160 - 86, 100 - 86, 160 + 85, 100 + 85, VARSEG(scrfx(0)), VARPTR(scrfx(0))
        DQBsetClipBox 0, 0, 319, 99
        DQBboxf 1, 0, 0, 319, 99, 0
        FOR x = 0 TO 4
                sx1 = (bx * x + cx * (5 - x)) / 5
                sx2 = (bx * (x + 1) + cx * (5 - (x + 1))) / 5
                sy1 = (by * x + cy * (5 - x)) / 5
                sy2 = (by * (x + 1) + cy * (5 - (x + 1))) / 5
                IF x MOD 2 = 0 THEN
                        DQBttri 1, ax, ay, sx1, sy1, sx2, sy2, 32, 13, 0, 63, 63, 63, VARSEG(track1(0)), VARPTR(track1(0))
                ELSE
                        DQBttri 1, ax, ay, sx1, sy1, sx2, sy2, 32, 13, 0, 63, 63, 63, VARSEG(track2(0)), VARPTR(track2(0))
                END IF
        NEXT x
        DQBsetTransPut
        wv = 2 * 14 * SIN((90 - counter& / 10) * 3.141 / 180)
        IF wv > 14 THEN wv = 28 - wv
        IF wv < -14 THEN wv = -28 - wv
        IF performance = high THEN
                IF ballwait1 = 0 THEN DQBrPut 1, dx - 86, dy - 86, VARSEG(scrfx(0)), VARPTR(scrfx(0)), 0, ratio
        ELSE
                IF ballwait1 = 0 THEN DQBellipse 1, dx, dy, sz, sz, 0
        END IF
        DQBprint 1, "NOVABALL v1.9.6", &H8000, 46, 198

        DQBsetClipBox 0, 100, 319, 199
       
        IF m2 = 0 THEN
                DQBsetTextBackCol 196
                DQBsetTextStyle SOLID
                DQBprint 1, m$, m1, 100, 255
                DQBsetTextStyle NONE
        END IF
        IF performance = high THEN GOSUB starmove

        DQBsetClipBox 0, 0, 319, 199
        DQBwait 1
        DQBcopyLayer 1, 0
        mouse (1)
        mousemove (0)
        mousecheck (2)
        DQBsetPal trackpalette$

LOCATE 6, 1

IF mselb THEN
        IF mzone = 6 THEN
                IF (counter& MOD 20 = 0) OR mserb THEN track1 = track1 + 1
        END IF
        IF mzone = 7 THEN
                IF (counter& MOD 20 = 0) OR mserb THEN track2 = track2 + 1
        END IF
        IF mzone = 8 THEN
                IF (counter& MOD 20 = 0) OR mserb THEN track3 = track3 + 1
        END IF
        IF mzone = 1 THEN fret = 1
        IF mzone = 2 THEN fret = 2
        IF mzone = 3 THEN fret = 3
        IF mzone = 4 THEN fret = 4
        IF mzone = 5 THEN fret = 5
END IF
IF mserb AND (counter& MOD 20 = 0) THEN
        IF mzone = 6 THEN track1 = track1 - 1
        IF mzone = 7 THEN track2 = track2 - 1
        IF mzone = 8 THEN track3 = track3 - 1
END IF
IF track1 < 1 THEN track1 = track1 + 26
IF track1 > 26 THEN track1 = track1 - 26
IF track2 < 1 THEN track2 = track2 + 26
IF track2 > 26 THEN track2 = track2 - 26
IF track3 < 1 THEN track3 = track3 + 26
IF track3 > 26 THEN track3 = track3 - 26
IF (mselb OR mserb) AND mzone > 5 THEN
                DQBsetTextBackCol 0
                DQBsetTextStyle SOLID
                a$ = UCASE$(alphabet$) + "?"
                DQBprint 1, MID$(a$, track1, 1), 280, 184, 255
                DQBprint 1, MID$(a$, track2, 1), 296, 184, 255
                DQBprint 1, MID$(a$, track3, 1), 312, 184, 255
                DQBsetTextStyle NONE
END IF

IF keyquit THEN fret = -1

LOOP UNTIL fret <> 0

GOTO menu2end

starmove:
MID$(trackpalette$, 301, 3) = CHR$(INT(RND(1) * 63)) + CHR$(INT(RND(1) * 63)) + CHR$(INT(RND(1) * 63))
MID$(trackpalette$, 304, 3) = CHR$(INT(RND(1) * 63)) + CHR$(INT(RND(1) * 63)) + CHR$(INT(RND(1) * 63))
MID$(trackpalette$, 307, 3) = CHR$(INT(RND(1) * 63)) + CHR$(INT(RND(1) * 63)) + CHR$(INT(RND(1) * 63))
MID$(trackpalette$, 310, 3) = CHR$(INT(RND(1) * 63)) + CHR$(INT(RND(1) * 63)) + CHR$(INT(RND(1) * 63))

FOR x = 1 TO 50
px = pnts(x, 0) / 10
py = pnts(x, 1) / 10
IF DQBpoint(1, px, py) < 194 THEN DQBpset 1, px, py, 0
pnts(x, 0) = pnts(x, 0) + pnts(x, 2)
pnts(x, 1) = pnts(x, 1) + pnts(x, 3)
pnts(x, 3) = pnts(x, 3) + 1
IF pnts(x, 1) > 2000 THEN pnts(x, 1) = 2001: pnts(x, 2) = 0: pnts(x, 3) = 0
px = pnts(x, 0) / 10
py = pnts(x, 1) / 10
IF DQBpoint(1, px, py) < 194 AND pnts(INT((x - 1) / 25) * 25 + 1, 2) <> 0 THEN DQBpset 1, px, py, 100 + INT(RND(1) * 4)
NEXT x

IF pnts(1, 2) = 0 THEN GOSUB starset1
IF pnts(26, 2) = 0 THEN GOSUB starset2
RETURN

starset1:
ox = INT(RND(1) * 2000) + 600
oy = INT(RND(1) * 500) + 1200
FOR x = 1 TO 25
pnts(x, 0) = ox
pnts(x, 1) = ox
pnts(x, 2) = INT(RND(1) * 40) - 20
pnts(x, 3) = INT(RND(1) * 20) - 20
NEXT x
RETURN

starset2:
ox = INT(RND(1) * 2000) + 600
oy = INT(RND(1) * 500) + 1200
FOR x = 1 TO 25
pnts(x + 25, 0) = ox
pnts(x + 25, 1) = oy
pnts(x + 25, 2) = INT(RND(1) * 40) - 20
pnts(x + 25, 3) = INT(RND(1) * 20) - 15
NEXT x
RETURN

menu2end:
menu2 = fret
trackn$ = MID$(UCASE$(alphabet$) + "?", track1, 1) + MID$(UCASE$(alphabet$) + "?", track2, 1) + MID$(UCASE$(alphabet$) + "?", track3, 1)

END FUNCTION

SUB message1 (m$, mc1, md1, ml1)

msg1$ = m$
msgcount1 = mc1
msgdelay1 = md1
msgc1 = ml1

END SUB

SUB message2 (m$, mc2, md2, ml2)

msg2$ = m$
msgcount2 = mc2
msgdelay2 = md2
msgc2 = ml2

END SUB

SUB mouse (mpointer)

IF mpointer = 0 THEN
IF omsex > -1 AND omsey > -1 THEN PUT (omsex, omsey), msebuff(0), PSET
ELSE
GET (msex, msey)-(msex + 9, msey + 9), msebuff(0)
PUT (msex, msey), msecurs(0), OR
END IF


END SUB

SUB mousecheck (mcheck)

mzone = 0
IF mcheck = 0 THEN
        IF msey > 100 AND msey < 108 THEN
                IF msex MOD 25 < 20 THEN mzone = INT(msex / 25) + 1
        END IF
        IF msey >= 0 AND msey <= 6 THEN
                IF msex MOD 45 < 40 THEN mzone = 14 + INT(msex / 45)
        END IF
        IF mzone = 0 AND msey < 100 THEN
                x1 = 160 - 160 * (msey - 50) / 50
                x2 = 160 - 96 * (msey - 50) / 50
                x3 = 160 - 32 * (msey - 50) / 50
                x4 = 160 + 32 * (msey - 50) / 50
                x5 = 160 + 96 * (msey - 50) / 50
                x6 = 160 + 160 * (msey - 50) / 50
                IF (msex >= x1 AND msex < x2) OR (msex >= x3 AND msex < x4) OR (msex >= x5 AND msex <= x6) THEN mzone = 21
                IF (msex >= x2 AND msex < x3) OR (msex >= x4 AND msex < x5) THEN mzone = 22
                IF msey < 52 THEN mzone = 0
                IF msey = 52 THEN mzone = mzone + 14
                IF msey = 53 THEN mzone = mzone + 12
                IF msey = 54 THEN mzone = mzone + 10
                IF msey = 55 OR msey = 56 THEN mzone = mzone + 8
                IF (msey > 56 AND msey < 60) THEN mzone = mzone + 6
                IF (msey > 59 AND msey < 64) THEN mzone = mzone + 4
                IF (msey > 63 AND msey < 72) THEN mzone = mzone + 2
                IF (msex < x1 OR msex > x6) THEN mzone = 0
                IF (msey > 16 AND msey < 31 AND msex > 38) THEN mzone = 37
        END IF
END IF
IF mcheck = 1 THEN
        IF msex > 100 AND msex < 244 THEN
                IF msey >= 94 AND msey <= 112 THEN mzone = 1
                IF msey >= 118 AND msey <= 136 THEN mzone = 5
        END IF
END IF
IF mcheck = 2 THEN
        IF msey >= 184 THEN
                IF msex >= 0 AND msex <= 35 THEN mzone = 1
                IF msex >= 52 AND msex <= 90 THEN mzone = 2
                IF msex >= 100 AND msex <= 134 THEN mzone = 3
                IF msex >= 152 AND msex <= 190 THEN mzone = 4
                IF msex >= 216 AND msex <= 254 THEN mzone = 5
                IF msex >= 280 AND msex <= 286 THEN mzone = 6
                IF msex >= 296 AND msex <= 302 THEN mzone = 7
                IF msex >= 308 THEN mzone = 8
        END IF
END IF
END SUB

SUB mousemove (null)

omsex = msex
omsey = msey

IF mouseon = 1 THEN
     
        maddx = 0
        maddy = 0
        msex = DQBmouseX
        msey = DQBmouseY
        mselb = DQBmouseLB
        mserb = DQBmouseRB
ELSE
        ml = DQBkey(75)
        mr = DQBkey(77)
        mu = DQBkey(72)
        md = DQBkey(80)
        IF ml = TRUE THEN maddx = -2
        IF mr = TRUE THEN maddx = 2
        IF mu = TRUE THEN maddy = -2
        IF md = TRUE THEN maddy = 2
        mselb = (DQBkey(57))
        mserb = (DQBkey(28))
END IF
hotkey = 0
IF DQBkey(33) THEN hotkey = 1
IF DQBkey(48) THEN hotkey = 2
msewheel = 0
IF DQBkey(73) THEN msewheel = 1
IF DQBkey(81) THEN msewheel = -1
msex = msex + maddx
msey = msey + maddy
IF msex < 0 THEN msex = 0
IF msey < 0 THEN msey = 0
IF msex > 309 THEN msex = 309
IF msey > 189 THEN msey = 189

END SUB

SUB moveball (PlayerMask)

'do all x-z axis calculations first!!

IF collision <> 0 THEN
        ballx1 = ballx1 + collision * (2 + 2 * INT(RND(1) * 3.999))
        ballx2 = ballx2 - collision * (2 + 2 * INT(RND(1) * 3.999))
        collision = collision - SGN(collision)
END IF

IF rev1 = 2 THEN ballx1 = ballx1 + (ballx1 MOD 2)
IF rev2 = 2 THEN ballx2 = ballx2 + (ballx2 MOD 2)
IF jumping1 = 0 AND bonusstage1 = 0 THEN bally1 = 0
IF jumping2 = 0 THEN bally2 = 0

IF (PlayerMask AND 1) = 0 AND (status1 MOD 4 < 3) AND death1 > -1 AND bonusstage1 = 0 THEN

        IF collision = 0 THEN
                IF keyleft1 THEN ballx1 = ballx1 - rev1
                IF keyright1 THEN ballx1 = ballx1 + rev1
        END IF
       
        IF keyup1 THEN ballv1& = ballv1& + 10
        IF keydown1 AND NOT (keyup1) THEN ballv1& = ballv1& - 20

        IF ballx1 < -146 THEN ballx1 = -146
        IF ballx1 > 148 THEN ballx1 = 148
        ballz1& = ballz1& + ballv1&

        g1l1 = grid(ballz1&, 0, trackn1)
        g1l2 = grid(ballz1&, 1, trackn1)
        gridlane1 = boundary(ballx1 + 150, 2) + 1
        p1square1 = g1l1: p1square2 = g1l2
        IF gridlane1 = 2 THEN p1square1 = g1l2: p1square2 = g1l1
        dng1 = danger(p1square1)
       
        IF keyfire1 AND nojumps1 > 0 AND jumping1 = 0 THEN
               
                'suppose you are pressing fire, you have some jumps left, and are not  
                'jumping
       
                IF (dng1 AND 2) = 2 THEN
                       
                        'suppose the square you are on, is a superbounce square
                       
                        jumping1 = 400                  'maximum jump
                        updatejump1 = yes               'remember to update JUMPS xx
                        nojumps1 = nojumps1 - (gametype + 1) MOD 2      'decrease #jumps left
                ELSE
                       
                        'suppose a non-superbounce square

                        IF (dng1 AND 1) = 0 THEN
                               
                                'jump ONLY if it is NOT a danger, or "self-propelled" square

                                jumping1 = 200            'ordinary bounce
                                updatejump1 = yes         'remember to update counter
                                nojumps1 = nojumps1 - (gametype + 1) MOD 2 'decrease #jumps left
                        ELSE
                                'you do not jump because of the fire button
                                'however you may jump for other reasons [elsewhere]
                                '1. because you have just "landed" from a jump
                                '2. because the square is a danger/self-propelled
                                '   this is dealt with in the trackcheck section
                        END IF
                END IF
        END IF

        IF jumping1 <> 0 THEN
               
                'suppose you are in the middle/have started jumping

                jumping1 = jumping1 + 1         'increase jump-counter

                bally1 = bally1 - jump(INT(jumping1 / 100), jumping1 MOD 100)
               
                'change the vertical position of the ball depending on which jump
                'you are engaged in

                IF jumping1 MOD 100 >= jump(INT(jumping1 / 100), 0) THEN
                      
                        IF (dng1 AND 8) = 8 AND ballv1& < 100 AND rev1 = -1 THEN ballv1& = 100: rev1 = 2

                        'suppose the jump is finished- what then?
                       
                        IF keyfire1 AND nojumps1 > 0 AND ((dng1 AND 1) = 0) THEN
                               
                                'if you are pressing fire, have jumps left                    
                                'and you are ABLE to bounce, then a higher
                                'jump is in order!

                                nojumps1 = nojumps1 - (gametype + 1) MOD 2       'use a jump
                                updatejump1 = yes               'update counter
                                jumping1 = 300                  'set JUMP=3
                                        IF (dng1 AND 2) = 2 THEN jumping1 = 400
                                                                'if you are on a bounce
                                                                'square, you can jump
                                                                'extra high!
                        ELSE
                               
                                'you have landed on a square without forcing a jump
                               
                                IF (dng1 AND 1) = 0 THEN

                                        'if landed on a normal square then depending on
                                        'previous bounce, perform a bounce-echo

                                        SELECT CASE INT(jumping1 / 100)
                                                CASE 0: jumping1 = 0
                                                CASE 1: jumping1 = 0
                                                CASE 2: jumping1 = 100
                                                CASE 3: jumping1 = 100
                                                CASE 4: jumping1 = 200
                                        END SELECT
                                ELSE
                                                             
                                        jumping1 = 0
                                        'the rest will be dealt with in the trackcheck
                              
                                END IF
                        END IF
                END IF
        END IF
END IF
IF (PlayerMask AND 2) = 0 AND (status2 MOD 4 < 3) AND death2 > -1 THEN

        IF collision = 0 THEN
                IF keyleft2 THEN ballx2 = ballx2 - rev2
                IF keyright2 THEN ballx2 = ballx2 + rev2
        END IF
      
        IF keyup2 THEN ballv2& = ballv2& + 10
        IF keydown2 AND NOT (keyup2) THEN ballv2& = ballv2& - 20

        IF ballx2 < -146 THEN ballx2 = -146
        IF ballx2 > 148 THEN ballx2 = 148
        ballz2& = ballz2& + ballv2&

        g2l1 = grid(ballz2&, 0, trackn2)
        g2l2 = grid(ballz2&, 1, trackn2)
        gridlane2 = boundary(ballx2 + 150, 2) + 1
        p2square1 = g2l1: p2square2 = g2l2
        IF gridlane2 = 2 THEN p2square1 = g2l2: p2square2 = g2l1
        dng2 = danger(p2square1)

        IF keyfire2 AND nojumps2 > 0 AND jumping2 = 0 THEN
              
                'suppose you are pressing fire, you have some jumps left, and are not
                'jumping
      
                IF (dng2 AND 2) = 2 THEN
                      
                        'suppose the square you are on, is a superbounce square
                      
                        jumping2 = 400                  'maximum jump
                        updatejump2 = yes               'remember to update JUMPS xx
                        nojumps2 = nojumps2 - (gametype + 1) MOD 2       'decrease #jumps left
                ELSE
                      
                        'suppose a non-superbounce square

                        IF (dng2 AND 1) = 0 THEN
                              
                                'jump ONLY if it is NOT a danger, or "self-propelled" square

                                jumping2 = 200            'ordinary bounce
                                updatejump2 = yes         'remember to update counter
                                nojumps2 = nojumps2 - (gametype + 1) MOD 2 'decrease #jumps left
                        ELSE
                                'you do not jump because of the fire button
                                'however you may jump for other reasons [elsewhere]
                                '1. because you have just "landed" from a jump
                                '2. because the square is a danger/self-propelled
                                '   this is dealt with in the trackcheck section
                        END IF
                END IF
        END IF

        IF jumping2 <> 0 THEN
              
                'suppose you are in the middle/have started jumping

                jumping2 = jumping2 + 1         'increase jump-counter

                bally2 = bally2 - jump(INT(jumping2 / 100), jumping2 MOD 100)
              
                'change the vertical position of the ball depending on which jump
                'you are engaged in

                IF jumping2 MOD 100 >= jump(INT(jumping2 / 100), 0) THEN
                     
                        IF (dng2 AND 8) = 8 AND ballv2& < 100 AND rev2 = -1 THEN ballv2& = 100: rev2 = 2

                        'suppose the jump is finished- what then?
                      
                        IF keyfire2 AND nojumps2 > 0 AND ((dng2 AND 1) = 0) THEN
                              
                                'if you are pressing fire, have jumps left                  
                                'and you are ABLE to bounce, then a higher
                                'jump is in order!

                                nojumps2 = nojumps2 - (gametype + 1) MOD 2      'use a jump
                                updatejump2 = yes               'update counter
                                jumping2 = 300                  'set JUMP=3
                                        IF (dng2 AND 2) = 2 THEN jumping2 = 400
                                                                'if you are on a bounce
                                                                'square, you can jump
                                                                'extra high!
                        ELSE
                              
                                'you have landed on a square without forcing a jump
                              
                                IF (dng2 AND 1) = 0 THEN

                                        'if landed on a normal square then depending on
                                        'previous bounce, perform a bounce-echo

                                        SELECT CASE INT(jumping2 / 100)
                                                CASE 0: jumping2 = 0
                                                CASE 1: jumping2 = 0
                                                CASE 2: jumping2 = 100
                                                CASE 3: jumping2 = 100
                                                CASE 4: jumping2 = 200
                                        END SELECT
                                ELSE
                                                            
                                        jumping2 = 0
                                        'the rest will be dealt with in the trackcheck
                             
                                END IF
                        END IF
                END IF
        END IF
END IF

IF bonusstage1 > 0 THEN
        IF bonuscounter1 > 0 AND counter& MOD 2 = 0 THEN bonuscounter1 = bonuscounter1 - 1
        IF bonuscounter1 = 1 THEN
                SELECT CASE bonusstage1
                        CASE 1: message1 "WATCH!", 101, 100, 255: bonuscounter1 = 52
                        CASE 2 TO 19: bonuscounter1 = 41: bally1 = 0
                        CASE 21, 23, 25: bonuscounter1 = 4000
                        CASE 22, 24: bonuscounter1 = 41: bally1 = 0
                END SELECT
                bonusstage1 = bonusstage1 + 1
        END IF
        jbonus = range(41 - bonuscounter1, 0, 39)
        oldx = 3: oldy = 4
      
        IF bonusstage1 > 2 AND bonusstage1 < 2 + LEN(bonusseq1$) + 1 THEN
                IF jbonus > 0 THEN bally1 = bally1 - jump(3, jbonus)
                IF bonusstage1 > 3 THEN
                        oldx = getx(MID$(bonusseq1$, bonusstage1 - 3, 1))
                        oldy = gety(MID$(bonusseq1$, bonusstage1 - 3, 1))
                END IF
                newx = getx(MID$(bonusseq1$, bonusstage1 - 2, 1))
                newy = gety(MID$(bonusseq1$, bonusstage1 - 2, 1))
                ballx1 = INT((((39 - jbonus) * oldx + jbonus * newx) / 39) * 60) - 180
                ballz1& = -158000 + INT((((39 - jbonus) * oldy + jbonus * newy) / 39) * 10000)
        END IF
       
        IF bonusstage1 = 2 + LEN(bonusseq1$) + 1 THEN
                newx = getx(RIGHT$(bonusseq1$, 1))
                newy = gety(RIGHT$(bonusseq1$, 1))
                ballx1 = 60 * newx - 180
                ballz1& = -158000 + 10000& * newy
                bonusstage1 = 20
                bonuscounter1 = 80
                message1 "READY..", 101, 100, 255
        END IF
       
        SELECT CASE bonusstage1
                CASE 21:
                ballx1 = 0
                ballz1& = -118000
                bonuscounter1 = 2
                bonusmarker1 = 0

                CASE 22:
                newx = 3: newy = 4
                IF bonusmarker1 > 0 THEN
                        newx = getx(MID$(bonusseq1$, bonusmarker1, 1))
                        newy = gety(MID$(bonusseq1$, bonusmarker1, 1))
                END IF
                ballx1 = 60 * newx - 180
                ballz1& = -158000 + 10000& * newy
                IF currentkey1 > 0 AND currentkey1 <> lastkey1 AND LEN(bonusrep1$) < 20 THEN
                        bonusrep1$ = bonusrep1$ + MID$("$%&^*", currentkey1, 1): message1 bonusrep1$, 4001, 4000, 255
                END IF
                IF currentkey1 = 5 AND lastkey1 < 5 THEN bonuscounter1 = 2
       
                CASE 23:
                IF jbonus > 0 THEN bally1 = bally1 - jump(3, jbonus)
                IF bonusmarker1 > 0 THEN
                        oldx = getx(MID$(bonusseq1$, bonusmarker1, 1))
                        oldy = gety(MID$(bonusseq1$, bonusmarker1, 1))
                END IF
                newx = oldx: newy = oldy
                FOR x = 1 TO LEN(bonusrep1$)
                        SELECT CASE MID$(bonusrep1$, x, 1)
                                CASE "$": newx = newx - 1
                                CASE "%": newx = newx + 1
                                CASE "&": newy = newy + 1
                                CASE "^": newy = newy - 1
                                newx = range(newx, 1, 5)
                                newy = range(newy, 1, 4)
                        END SELECT
                NEXT x
                IF newy = 4 THEN newx = 3
                ballx1 = INT((((39 - jbonus) * oldx + jbonus * newx) / 39) * 60) - 180
                ballz1& = -158000 + INT((((39 - jbonus) * oldy + jbonus * newy) / 39) * 10000)
                IF bonuscounter1 = 2 THEN
                        a$ = MID$("ABCDEFGHIJKLMNOPQRSTUVWXYZ", newy * 5 - 5 + newx, 1)
                        IF a$ = UCASE$(MID$(bonusseq1$, bonusmarker1 + 1, 1)) THEN
                                bonusstage1 = 22
                                bonuscounter1 = 50
                                bonusrep1$ = ""
                                bonusmarker1 = bonusmarker1 + 1
                                IF bonusmarker1 = LEN(bonusseq1$) THEN
                                        message1 "CORRECT!", 4001, 4000, 255
                                        bonusstage1 = 25
                                        score1& = score1& + 50 * LEN(bonusseq1$)
                                ELSE
                                        message1 "", 4001, 4000, 255
                                        bonuscounter1 = 4000
                                END IF
                        ELSE
                                bonusstage1 = 24
                                bonusrep1$ = ""
                                message1 "WRONG!", 4001, 4000, 255
                        END IF
                END IF
               
                CASE 24:
                IF bonuscounter1 = 2 THEN
                        message1 "GET READY FOR NEXT LEVEL", 101, 100, 255: bonuscounter1 = 4000: death1 = -1
                        bonusstage1 = 26
                END IF
                CASE 25:
                IF bonuscounter1 = 2 THEN
                        y = LEN(bonusseq1$) + 1
                        bonusseq1$ = ""
                        FOR x = 1 TO y
                                bonusseq1$ = bonusseq1$ + CHR$(65 + INT(RND(1) * 14.99))
                        NEXT x
                        l = INT(trackn1 / 3) + 2
                        bonustime1 = 50 + 20 * l
                        IF y > INT(trackn1 / 3) + 4 THEN
                                message1 "GET READY FOR NEXT LEVEL", 101, 100, 255: bonuscounter1 = 4000: death1 = -1
                        ELSE
                                message1 "WATCH!", 101, 100, 255: bonuscounter1 = 52: bonusstage1 = 2
                        END IF
                END IF
        END SELECT
END IF

END SUB

SUB movetrack (PlayerMask)

IF (PlayerMask AND 1) = 0 AND bonusstage1 = 0 THEN
        trackz1& = trackz1& + trackv1&
        IF camera1 = 0 THEN trackz1& = ballz1& - 700
        trackv1& = camerav(ballv1&, trackv1&, ballz1&, trackz1&)
        IF trackz1& > ballz1& THEN trackz1& = ballz1&
        IF trackz1& < ballz1& - 75000 THEN trackz1& = ballz1& - 75000
END IF

IF (PlayerMask AND 2) = 0 THEN
        trackz2& = trackz2& + trackv2&
        IF camera2 = 0 THEN trackz2& = ballz2& - 700
        trackv2& = camerav(ballv2&, trackv2&, ballz2&, trackz2&)
        IF trackz2& > ballz2& THEN trackz2& = ballz2&
        IF trackz2& < ballz2& - 75000 THEN trackz2& = ballz2& - 75000
END IF

END SUB

FUNCTION newfile$ (msk$)

DQBclearLayer 0
DQBremoveKeyboard
b$ = ""
setcol 1
MID$(trackpalette$, 4, 3) = CHR$(0) + CHR$(0) + CHR$(40)
MID$(trackpalette$, 7, 3) = CHR$(40) + CHR$(0) + CHR$(0)
DQBsetPal trackpalette$

DQBboxf 0, 0, 0, 319, 7, 1
DQBprint 0, "  Please Enter a Filename (<=8 chars)", 0, 0, 255

DQBboxf 0, 0, 16, 319, 39, 2

DO
DQBboxf 0, 16, 24, 303, 31, 0
DQBprint 0, b$ + "_" + msk$, 24, 24, 255
DO
a$ = INKEY$
LOOP UNTIL LEN(a$) > 0
a$ = UCASE$(a$)
a = INSTR("ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789!", a$)
IF a$ = CHR$(13) THEN a = -1
IF a$ = CHR$(8) THEN a = -2
IF a$ = CHR$(27) THEN a = -3
IF a > 0 AND LEN(b$) < 8 THEN b$ = b$ + a$
IF a = -2 AND LEN(b$) > 0 THEN b$ = LEFT$(b$, LEN(b$) - 1)
LOOP UNTIL a = -1 OR a = -3

IF LEN(b$) > 0 THEN
        IF a = -1 THEN b$ = b$ + msk$
        IF a = -3 THEN b$ = ""
END IF

DQBinstallKeyboard
newfile$ = b$

END FUNCTION

SUB newname (null)

mouse (0)
tn$ = MID$(UCASE$(alphabet$ + "?"), trackn1, 1) + ": "
DQBremoveKeyboard
tname$ = tname1$

DO
        Z = 0
        IF LEN(tname$) > 0 THEN
                IF RIGHT$(tname$, 1) = " " THEN tname$ = LEFT$(tname$, LEN(tname$) - 1): Z = 1
        END IF
LOOP UNTIL Z = 0

DO
        LINE (44, 15)-(320, 37), 0, BF
        font 0, 45, 30, tn$ + tname$ + "/"
        a$ = ""
        DO
                Z = 0
                a$ = INKEY$
                IF LEN(a$) > 0 THEN Z = INSTR("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !?,.0123456789" + CHR$(8) + CHR$(13) + CHR$(27), a$)
        LOOP UNTIL Z > 0
        IF Z < 68 AND LEN(tname$) < 20 THEN
                IF LEN(tname$) > 0 THEN
                        m$ = RIGHT$(tname$, 1)
                        IF INSTR("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", m$) > 0 THEN
                                tname$ = tname$ + LCASE$(a$)
                        ELSE
                                tname$ = tname$ + UCASE$(a$)
                        END IF
                ELSE
                        tname$ = tname$ + UCASE$(a$)
                END IF
        END IF
        IF Z = 68 AND LEN(tname$) > 0 THEN tname$ = LEFT$(tname$, LEN(tname$) - 1)
LOOP UNTIL Z > 68

DQBinstallKeyboard
IF Z = 69 THEN tname1$ = tname$
IF tname1$ = "" THEN tname1$ = "New Track"

IF LEN(tname1$) < 20 THEN tname1$ = tname1$ + STRING$(20 - LEN(tname1$), " ")
FOR y = 1 TO LEN(tname1$)
m$ = MID$(tname1$, y, 1)
Z = INSTR("abcdefghijklmnopqrstuvwxyz1234567890,.:/?!ABCDEFGHIJKLMNOPQRSTUVWXYZ", m$)
sx = (trackn1 * 20 - 21 + y)
DQBpset 2, sx MOD 160, 181 + INT(sx / 160), Z
NEXT

gettrackname (0)
LINE (44, 15)-(320, 37), 0, BF
font 0, 45, 30, tn$ + tname1$
omsex = msex
omsey = msey
mouse (1)

END SUB

FUNCTION range (ra, rb, rc)
rb2 = rb
rc2 = rc
IF rb2 > rc2 THEN SWAP rb2, rc2
ra2 = ra
IF ra2 < rb2 THEN ra2 = rb2
IF ra2 > rc2 THEN ra2 = rc2
range = ra2

END FUNCTION

SUB resetall1 (null)

death1 = 0
ballx1 = 50
bally1 = 0
nojumps1 = 2 + gametype * 20
IF nojumps1 > jumplimit THEN nojumps1 = jumplimit
jumping1 = 0
trackn1 = 1
notime1 = 0
score1& = 0
showscore1& = -1
showtime1 = 299
p1 = opp1 * 4
trackn1b = 1
IF gametype > 0 THEN trackn1 = INSTR(UCASE$(alphabet$) + "?", MID$(trackn$, trackn1b, 1))
resettrack1 (1)
final1& = 0

END SUB

SUB resetall2 (null)

death2 = 0
ballx2 = -50
bally2 = 0
nojumps2 = 2 + gametype * 20
IF nojumps2 > jumplimit THEN nojumps2 = jumplimit
jumping2 = 0
trackn2 = 1
notime2 = 0
score2& = 0
showscore2& = -1
showtime2 = 299
p2 = opp2 * 4
trackn2b = 1
IF gametype > 0 THEN trackn2 = INSTR(UCASE$(alphabet$) + "?", MID$(trackn$, trackn2b, 1))
resettrack2 (1)
final2& = 0

END SUB

SUB resettrack1 (title)

notime1 = notime1 + 300
IF notime1 > 999 THEN notime1 = 999
nojumps1 = nojumps1 + 5
IF nojumps1 > jumplimit THEN nojumps1 = jumplimit
updatejump1 = 2
ballz1& = -150000
trackz1& = -150700
trackv1& = 0
ballv1& = 0
maxv1& = 1500
reversi1 = 0
rev1 = 2
status1 = p1 + 0
lum1 = 63
msgcount1 = 101
msgdelay1 = 100
msgc1 = 255
gettrackname (0)
msg1$ = tname1$
WHILE RIGHT$(msg1$, 1) = " "
msg1$ = LEFT$(msg1$, LEN(msg1$) - 1)
WEND
IF title = 1 THEN
        DQBboxf 0, 84, 0, 91, 7, 0
        DQBprint 0, MID$("ABCDEFGHIJKLMNOPQRSTUVWXYZ?,.<>[]{}-=_+", trackn1, 1), 84, 0, 255
        DQBprint 0, "??.?", 136, 0, 255
END IF
countdown1 = 0
newlevel1 = 0
ballwait1 = 0
death1 = 0
bonusstage1 = 0
currentkey1 = 0
lastkey1 = 0
END SUB

SUB resettrack2 (title)

notime2 = notime2 + 300
IF notime2 > 999 THEN notime2 = 999
nojumps2 = nojumps2 + 5
IF nojumps2 > jumplimit THEN nojumps2 = jumplimit
updatejump2 = 2
ballz2& = -150000
trackz2& = -150700
trackv2& = 0
ballv2& = 0
maxv2& = 1500
reversi2 = 0
rev2 = 2
status2 = p2 + 0
lum2 = 63
msgcount2 = 101
msgdelay2 = 100
msgc2 = 255
gettrackname (0)
msg2$ = tname2$
WHILE RIGHT$(msg2$, 1) = " "
msg2$ = LEFT$(msg2$, LEN(msg2$) - 1)
WEND
IF title = 1 THEN
        DQBboxf 0, 84, 100 + 10 * editmode, 91, 107 + 10 * editmode, 0
        DQBprint 0, MID$("ABCDEFGHIJKLMNOPQRSTUVWXYZ?,.<>[]{}-=_+", trackn2, 1), 84, 100 + editmode * 10, 255
        DQBprint 0, "??.?", 136, 100 + editmode * 10, 255
END IF
countdown2 = 0
newlevel2 = 0
death2 = 0
ballwait2 = 0
END SUB

FUNCTION rotatex (Angle, wd, rd, sx, th)

w = Angle + th
cx = rd * SIN(w * 3.1415 / 180)
bx = 3 * SIN(Angle * 3.1415 / 180)

rotatex = sx + cx - wd + bx


END FUNCTION

FUNCTION rotatey (Angle, ht, rd, sy, th)

w = Angle + th
cy = rd * COS(w * 3.1415 / 180)
by = 3 * COS(Angle * 3.1415 / 180)

rotatey = sy - cy - ht - by

END FUNCTION

SUB savegame (file$)

OPEN file$ FOR OUTPUT AS #1
a$ = "[trackdata]"
v = 0
PRINT #1, a$

D$ = STRING$(3, CHR$(0))
D$ = D$ + CHR$(35) + CHR$(0) + CHR$(0)
D$ = D$ + CHR$(63) + CHR$(20) + CHR$(5)
FOR x = 1 TO 253
D$ = D$ + CHR$(63) + CHR$(63) + CHR$(63)
NEXT x

DQBclearLayer 0
DQBsetPal D$
DQBprint 0, "Saving...", &H8000, 80, 255
DQBwait 50

FOR l = 1 TO 27
        FOR y = 1 TO 4
                a$ = ""
                FOR x = 0 TO 319
                        Z = DQBpoint(2, x, l * 4 - 5 + y)
                        a$ = a$ + MID$("0123456789abcdefghijklmnopqrstuvwxyz", Z + 1, 1)
                        v = (v + Z) MOD 5000
                NEXT x
                IF l = 27 AND y = 4 THEN a$ = a$ + "!"
                WHILE LEN(a$) > 80
                        b$ = LEFT$(a$, 80)
                        PRINT #1, b$
                        a$ = RIGHT$(a$, LEN(a$) - 80)
                WEND
                IF LEN(a$) > 0 THEN PRINT #1, a$
                a$ = ""
        NEXT
NEXT

a$ = "[tracknames]"
PRINT #1, a$
a$ = ""

FOR x = 1 TO 27
        FOR y = 1 TO 20
                sx = (x * 20 - 21 + y)
                Z = DQBpoint(2, sx MOD 320, 181 + INT(sx / 320))
                a$ = a$ + MID$(" " + alphabet$ + "1234567890#.:/?!" + UCASE$(alphabet$), Z + 1, 1)
        NEXT
NEXT
a$ = "Ý" + a$ + "Ý"
PRINT #1, a$

a$ = "[checksum]"
PRINT #1, a$
a$ = STR$(v)
a$ = RIGHT$(a$, LEN(a$) - 1)
WHILE LEN(a$) < 4
a$ = "0" + a$
WEND
a$ = "&" + a$
FOR x = 1 TO 10
y = INT(RND(1) * 9.9)
a$ = a$ + RIGHT$(STR$(y), 1)
NEXT
PRINT #1, a$

a$ = "[end]"
PRINT #1, a$
CLOSE 1

END SUB

SUB setcol (colflag)

SELECT CASE colflag
CASE 0
CASE 1: MID$(trackpalette$, 721, 48) = grey1$
CASE 2: MID$(trackpalette$, 721, 48) = grey2$
CASE 3: MID$(trackpalette$, 583, 45) = square$
CASE 4: MID$(trackpalette$, 631, LEN(Button$)) = Button$
CASE 5: MID$(trackpalette$, 700, 21) = dot$
END SELECT

END SUB

SUB specialpower (null)

IF counter& MOD 6 = 0 THEN
        IF bonusstage1 = 0 THEN
                IF (status1 MOD 4 < 3) AND (notime1 > 0) AND editmode = 0 THEN notime1 = notime1 - 1
        ELSE
                IF bonusstage1 > 21 AND bonusstage1 < 24 THEN bonustime1 = bonustime1 - 1
        END IF
        IF (status2 MOD 4 < 3) AND (notime2 > 0) THEN notime2 = notime2 - 1
END IF
IF death1 > -1 AND (notime1 = 0 OR (bonustime1 = 0 AND bonusstage1 > 0)) THEN
        death1 = -1
        IF editmode = 0 AND bonusstage1 = 0 AND gametype = 0 THEN
                message1 "G A M E  O V E R", 1000, 1000, 255
        ELSE
                IF bonusstage1 > 0 THEN
                        message1 "OUT OF TIME!", 100, 100, 255
                        bonusstage1 = 26
                ELSE
                        message1 "T I M E  O V E R", 1000, 1000, 255
                END IF
        END IF
END IF
IF death2 > -1 AND notime2 = 0 THEN
        death2 = -1
        IF editmode = 0 AND gametype = 0 THEN
                message2 "G A M E  O V E R", 1000, 1000, 255
        ELSE
                message2 "T I M E  O V E R", 1000, 1000, 255
        END IF
END IF
IF death1 < 0 AND death1 > -100 THEN death1 = death1 - 1
IF death2 < 0 AND death2 > -100 THEN death2 = death2 - 1
IF lum1 < 63 THEN lum1 = lum1 + 1
IF lum2 < 63 THEN lum2 = lum2 + 1

IF countdown1 > 0 THEN
        countdown1 = countdown1 - 1
        IF countdown1 = 0 AND editmode = 0 THEN
                IF gametype = 0 THEN trackn1 = trackn1 + 1 ELSE trackn1b = trackn1b + 1: trackn1 = INSTR("ABCDEFGHIJKLMNOPQRSTUVWXYZ?", UCASE$(MID$(trackn$, trackn1b, 1)))
                newlevel1 = yes
        END IF
        IF countdown1 = 179 THEN
                message1 "Level Complete!", 180, 180, 255
        END IF
        IF countdown1 = 120 THEN
                a$ = "BONUS:" + STR$(notime1) + " POINTS"
                message1 a$, 120, 120, 202
        END IF
        IF countdown1 = 60 THEN
                a$ = "BONUS: 5 JUMPS"
                message1 a$, 60, 60, 196
                score1& = score1& + notime1
        END IF
END IF




IF countdown2 > 0 THEN
        countdown2 = countdown2 - 1
        IF countdown2 = 0 AND editmode = 0 THEN
                IF gametype = 0 THEN trackn2 = trackn2 + 1 ELSE trackn2b = trackn2b + 1: trackn2 = INSTR("ABCDEFGHIJKLMNOPQRSTUVWXYZ?", UCASE$(MID$(trackn$, trackn2b, 1)))
                newlevel2 = yes
        END IF
        IF countdown2 = 179 THEN
                message2 "Level Complete!", 180, 180, 255
        END IF
        IF countdown2 = 120 THEN
                a$ = "BONUS:" + STR$(notime2) + " POINTS"
                message2 a$, 120, 120, 202
        END IF
        IF countdown2 = 60 THEN
                a$ = "BONUS: 5 JUMPS"
                message2 a$, 60, 60, 196
                score2& = score2& + notime2
        END IF

END IF
IF death1 > 0 THEN
        death1 = death1 - 1
        IF death1 = 250 THEN message1 "5", 50, 50, 255
        IF death1 = 200 THEN message1 "4", 50, 50, 255
        IF death1 = 150 THEN message1 "3", 50, 50, 255
        IF death1 = 100 THEN message1 "2", 50, 50, 255
        IF death1 = 50 THEN message1 "1", 50, 50, 255
        IF death1 = 0 AND opp1 = 0 THEN p1 = p1 - 4
END IF
IF death2 > 0 THEN
        death2 = death2 - 1
        IF death2 = 250 THEN message2 "5", 50, 50, 255
        IF death2 = 200 THEN message2 "4", 50, 50, 255
        IF death2 = 150 THEN message2 "3", 50, 50, 255
        IF death2 = 100 THEN message2 "2", 50, 50, 255
        IF death2 = 50 THEN message2 "1", 50, 50, 255
        IF death2 = 0 AND opp2 = 0 THEN p2 = p2 - 4
END IF

END SUB

FUNCTION suddenstop& (ballv&, ballz&)

IF NOT (ballv& > 400 AND ballv& < 440) THEN
  suddenstop& = ballv& - SGN(ballv&) * SQR(ABS(ballv&))
ELSE
  target = ballz& MOD 20000
  IF target < 14276 OR target > 14746 THEN suddenstop& = 422 ELSE suddenstop& = 399
END IF

END FUNCTION

FUNCTION try (depth)

try = DQBpoint(2, depth MOD 320, 185 + INT(depth / 320))

END FUNCTION

SUB updatetrack1 (luminance)

IF luminance < 20 THEN luminance = 20

IF trackv1& > 0 THEN
        Z = INT((trackv1& - 100) / 50)
        IF Z < 0 THEN Z = 0
        IF Z > 63 THEN
                Z = Z - 63
                IF Z > 63 THEN Z = 63
                trackfog$ = CHR$(63) + CHR$(Z) + CHR$(Z)
        ELSE
                trackfog$ = CHR$(Z) + CHR$(0) + CHR$(0)         'dopplershift is red
        END IF
ELSE
        Z = INT((-trackv1& - 100) / 50)
        IF Z < 0 THEN Z = 0
        IF Z > 63 THEN Z = 63
        trackfog$ = CHR$(0) + CHR$(0) + CHR$(Z)         'dopplershift is violet
END IF

trackf1& = ASC(LEFT$(trackfog$, 1))
trackf2& = ASC(MID$(trackfog$, 2, 1))
trackf3& = ASC(RIGHT$(trackfog$, 1))

t1$ = ""
Z = trackz1& MOD 10000
IF trackz1& < 0 THEN Z = 10000 - ABS(trackz1&) MOD 10000: Z = Z MOD 10000
Z = INT(Z / 100)
IF bonusstage1 > 0 THEN Z = 0
c1 = 6: c2 = 7
FOR x = 1 TO 9
        y = 9 - x
        s1 = INT((trackz1& + 10000& * y) / 10000&)
        IF s1 > -1 AND s1 < 601 AND bonusstage1 = 0 THEN
                sx = s1 MOD 320
                sy = 2 * INT(s1 / 320) + trackn1 * 4 - 4
                c1 = DQBpoint(2, sx, sy)
                c2 = DQBpoint(2, sx, sy + 1)
                IF c1 = 9 AND counter& MOD 100 < 50 THEN c1 = 3
                IF c2 = 9 AND counter& MOD 100 > 49 THEN c2 = 3
        ELSE
                c1 = 10 + ABS(s1) MOD 2
                c2 = 11 - ABS(s1) MOD 2
                IF bonusstage1 > 0 AND x < 6 THEN c1 = 3: c2 = 3 ELSE IF bonusstage1 > 0 THEN c1 = 10 + x MOD 2: c2 = 11 - x MOD 2
        END IF

        c = DQBpoint(2, (Z * 9 + x - 1) MOD 320, 112 + INT((Z * 9 + x - 1) / 320))
        IF trackfog = high THEN
                c1$ = LEFT$(Col$(c1), 3)
                c2$ = LEFT$(Col$(c2), 3)
                c3& = x * 100 + Z
                IF c3& > 900 THEN c3& = 900
                c1a& = (ASC(LEFT$(c1$, 1)) * c3& + trackf1& * (900 - c3&)) / 900
                c1b& = (ASC(MID$(c1$, 2, 1)) * c3& + trackf2& * (900 - c3&)) / 900
                c1c& = (ASC(RIGHT$(c1$, 1)) * c3& + trackf3& * (900 - c3&)) / 900
                c2a& = (ASC(LEFT$(c2$, 1)) * c3& + trackf1& * (900 - c3&)) / 1000
                c2b& = (ASC(MID$(c2$, 2, 1)) * c3& + trackf2& * (900 - c3&)) / 1000
                c2c& = (ASC(RIGHT$(c2$, 1)) * c3& + trackf3& * (900 - c3&)) / 1000
                c1$ = CHR$(c1a& * luminance / 63) + CHR$(c1b& * luminance / 63) + CHR$(c1c& * luminance / 63)
                c2$ = CHR$(c2a& * luminance / 63) + CHR$(c2b& * luminance / 63) + CHR$(c2c& * luminance / 63)
                DO
                        c1$ = c1$ + c1$
                        c2$ = c2$ + c2$
                LOOP UNTIL LEN(c1$) >= c * 3
                t1$ = t1$ + LEFT$(c1$, c * 3)
                t2$ = t2$ + LEFT$(c2$, c * 3)
        ELSE
                IF c > 0 THEN
                        t1$ = t1$ + LEFT$(Col$(c1), c * 3)
                        t2$ = t2$ + LEFT$(Col$(c2), c * 3)
                END IF
        END IF
        IF tracktype = 1 AND LEN(t1$) > 2 THEN
                MID$(t1$, LEN(t1$) - 2, 3) = dimmer$(MID$(t1$, LEN(t1$) - 2, 3), 1 + x / 20)
                MID$(t2$, LEN(t2$) - 2, 3) = dimmer$(MID$(t2$, LEN(t2$) - 2, 3), 1 + x / 20)
        END IF
NEXT x
MID$(trackpalette$, 4, LEN(t1$)) = t1$
MID$(trackpalette$, 148, LEN(t2$)) = t2$

END SUB

SUB updatetrack2 (luminance)

IF luminance < 20 THEN luminance = 20

IF trackv2& > 0 THEN
Z = INT((trackv2& - 100) / 50)
IF Z < 0 THEN Z = 0
        IF Z > 63 THEN
                Z = Z - 63
                IF Z > 63 THEN Z = 63
                trackfog$ = CHR$(63) + CHR$(Z) + CHR$(Z)        'warp!
        ELSE
                trackfog$ = CHR$(Z) + CHR$(0) + CHR$(0)         'dopplershift is red
        END IF
ELSE
Z = INT((-trackv2& - 100) / 50)
IF Z < 0 THEN Z = 0
IF Z > 63 THEN Z = 63
trackfog$ = CHR$(0) + CHR$(0) + CHR$(Z)         'dopplershift is violet
END IF

trackf1& = ASC(LEFT$(trackfog$, 1))
trackf2& = ASC(MID$(trackfog$, 2, 1))
trackf3& = ASC(RIGHT$(trackfog$, 1))

t1$ = ""
t2$ = ""
Z = trackz2& MOD 10000
IF trackz2& < 0 THEN Z = 10000 - ABS(trackz2&) MOD 10000: Z = Z MOD 10000
Z = INT(Z / 100)
c1 = 6: c2 = 7
FOR x = 1 TO 9
        y = 9 - x
        s1 = INT((trackz2& + 10000& * y) / 10000&)
        IF s1 > -1 AND s1 < 601 THEN
                sx = s1 MOD 320
                sy = 2 * INT(s1 / 320) + trackn2 * 4 - 4
                c1 = DQBpoint(2, sx, sy)
                c2 = DQBpoint(2, sx, sy + 1)
                IF c1 = 9 AND counter& MOD 100 < 50 THEN c1 = 3
                IF c2 = 9 AND counter& MOD 100 > 49 THEN c2 = 3
        ELSE
                c1 = 10 + ABS(s1) MOD 2
                c2 = 11 - ABS(s1) MOD 2
        END IF
        c = DQBpoint(2, (Z * 9 + x - 1) MOD 320, 112 + INT((Z * 9 + x - 1) / 320))
        IF trackfog = high THEN
                c1$ = LEFT$(Col$(c1), 3)
                c2$ = LEFT$(Col$(c2), 3)
                c3& = x * 100 + Z
                IF c3& > 900 THEN c3& = 900
                c1a& = (ASC(LEFT$(c1$, 1)) * c3& + trackf1& * (900 - c3&)) / 900
                c1b& = (ASC(MID$(c1$, 2, 1)) * c3& + trackf2& * (900 - c3&)) / 900
                c1c& = (ASC(RIGHT$(c1$, 1)) * c3& + trackf3& * (900 - c3&)) / 900
                c2a& = (ASC(LEFT$(c2$, 1)) * c3& + trackf1& * (900 - c3&)) / 910
                c2b& = (ASC(MID$(c2$, 2, 1)) * c3& + trackf2& * (900 - c3&)) / 910
                c2c& = (ASC(RIGHT$(c2$, 1)) * c3& + trackf3& * (900 - c3&)) / 910
                c1$ = CHR$(c1a& * luminance / 63) + CHR$(c1b& * luminance / 63) + CHR$(c1c& * luminance / 63)
                c2$ = CHR$(c2a& * luminance / 63) + CHR$(c2b& * luminance / 63) + CHR$(c2c& * luminance / 63)
                DO
                        c1$ = c1$ + c1$
                        c2$ = c2$ + c2$
                LOOP UNTIL LEN(c1$) >= c * 3
                t1$ = t1$ + LEFT$(c1$, c * 3)
                t2$ = t2$ + LEFT$(c2$, c * 3)
       
        ELSE
                IF c > 0 THEN
                        t1$ = t1$ + LEFT$(Col$(c1), c * 3)
                        t2$ = t2$ + LEFT$(Col$(c2), c * 3)
                END IF
        END IF
        IF tracktype = 1 AND LEN(t1$) > 2 THEN
                MID$(t1$, LEN(t1$) - 2, 3) = dimmer$(MID$(t1$, LEN(t1$) - 2, 3), 1 + x / 20)
                MID$(t2$, LEN(t2$) - 2, 3) = dimmer$(MID$(t2$, LEN(t2$) - 2, 3), 1 + x / 20)
        END IF
NEXT x
MID$(trackpalette$, 292, LEN(t1$)) = t1$
MID$(trackpalette$, 436, LEN(t2$)) = t2$


END SUB

