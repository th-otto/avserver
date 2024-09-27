av_drag_on_window:
x10ab6:
	movem.l    d3-d7/a2-a4,-(a7)
	subq.w     #2,a7
	movea.l    a0,a2
	move.w     2(a2),d3
	move.w     6(a2),d4
	move.w     8(a2),d5
	suba.l     a3,a3
	lea.l      12(a2),a0
	move.l     a0,d0
	beq.s      x10ab6_1
	movea.l    (a0),a3
	bra.s      x10ab6_2
x10ab6_1:
	suba.l     a3,a3
x10ab6_2:
	lea.l      $000150E0,a4
	move.l     a3,d0
	beq.s      x10ab6_3
	movea.l    a3,a0
	jsr        strlen
	cmp.l      #$00000400,d0
	bls.s      x10ab6_3
	lea.l      $000149EB,a0
	moveq.l    #1,d0
	jsr        form_alert
	move.w     #$4735,(a2)
	move.w     -124(a4),2(a2) ; gl_apid
	clr.w      4(a2)
	clr.w      6(a2)
	bra        x10ab6_4
x10ab6_3:
	movea.l    a3,a0
	jsr        $00011F4E
	clr.w      d6
	lea.l      (a7),a0
	move.w     d5,d1
	move.w     d4,d0
	jsr        $00011A12
	move.w     d0,d1
	cmp.w      #$0007,d1
	bhi        x10ab6_5
	add.w      d1,d1
	move.w     $00010B42(pc,d1.w),d1
	jmp        $00010B42(pc,d1.w)
J1:
	dc.w $0210   ; x10ab6_5-J1
	dc.w $0210   ; x10ab6_5-J1
	dc.w $0074   ; x10ab6_6-J1
	dc.w $0210   ; x10ab6_5-J1
	dc.w $0010   ; x10ab6_7-J1
	dc.w $0138   ; x10ab6_8-J1
	dc.w $01a8   ; x10ab6_9-J1
	dc.w $00cc   ; x10ab6_10-J1
VA_OB_FILE
x10ab6_7:
	move.l     a3,d0
	beq        x10ab6_5
	movea.l    a3,a1
	lea.l      1024(a4),a0 ; startprog_name
	jsr        strcpy
	move.w     #$4722,(a2)
	move.w     -124(a4),2(a2) ; gl_apid
	clr.w      4(a2)
	move.l     a4,d0
	moveq.l    #16,d1
	asr.l      d1,d0
	move.w     d0,6(a2)
	move.l     a4,d2
	and.w      #$FFFF,d2
	move.w     d2,8(a2)
	lea.l      1024(a4),a0 ; startprog_name
	move.l     a0,d0
	asr.l      d1,d0
	move.w     d0,10(a2)
	move.l     a0,d2
	and.w      #$FFFF,d2
	move.w     d2,12(a2)
	move.w     #$3E80,14(a2)
	move.w     -122(a4),d0 ; magxdesk
	moveq.l    #16,d1
	movea.l    a2,a0
	jsr        appl_write
x10ab6_12:
	moveq.l    #1,d6
	bra        x10ab6_5
VA_OB_SHREDDER
x10ab6_6:
	move.l     a3,d0
	beq        x10ab6_5
	move.b     #$44,1026(a4) ; $000154E2
	moveq.l    #1,d6
	lea.l      $00014A15,a1
	movea.l    a4,a0
	jsr        strcpy
	movea.l    a4,a0
	jsr        shel_find
	tst.w      d0
	bne.s      x10ab6_11
	lea.l      $00014A20,a1
	movea.l    a4,a0
	jsr        strcpy
x10ab6_11:
	lea.l      1024(a4),a1 ; startprog_name
	movea.l    a4,a0
	moveq.l    #100,d2
	moveq.l    #1,d1
	moveq.l    #100,d0
	jsr        shel_write
	tst.w      d0
	bne        x10ab6_5
x10ab6_14:
	jsr        error_copy
	bra        x10ab6_5
VA_OB_WINDOW
x10ab6_10:
	move.w     d5,d1
	move.w     d4,d0
	jsr        wind_find
	move.w     d0,d7
	tst.w      d0
	ble        x10ab6_5
	pea.l      (a7)
	moveq.l    #20,d1
	jsr        wind_get
	addq.w     #4,a7
	move.w     (a7),d0
	bmi        x10ab6_5
	movea.l    a3,a1
	movea.l    a4,a0
	jsr        strcpy
	move.w     #$4725,(a2)
	move.w     -124(a4),2(a2) ; gl_apid
	clr.w      4(a2)
	move.w     d7,6(a2)
	move.w     d4,8(a2)
	move.w     d5,10(a2)
	move.l     a4,d0
	moveq.l    #16,d1
	asr.l      d1,d0
	move.w     d0,12(a2)
	move.l     a4,d2
	and.w      #$FFFF,d2
	move.w     d2,14(a2)
	movea.l    a2,a0
	move.w     (a7),d0
	moveq.l    #16,d1
	jsr        appl_write
	bra        x10ab6_12
VA_OB_FOLDER
x10ab6_8:
	move.w     d5,d1
	move.w     d4,d0
	jsr        wind_find
	move.w     d0,d7
	pea.l      (a7)
	moveq.l    #20,d1
	jsr        wind_get
	addq.w     #4,a7
	move.w     (a7),d0
	bmi        x10ab6_5
	move.b     #$43,1026(a4) ; $000154E2
	lea.l      $00014A3D,a1
	lea.l      1024(a4),a0 ; startprog_name
	jsr        strcat
	movea.l    a4,a1
	lea.l      1024(a4),a0 ; startprog_name
	jsr        strcat
	moveq.l    #1,d6
	lea.l      $00014A3F,a1
	movea.l    a4,a0
	jsr        strcpy
	movea.l    a4,a0
	jsr        shel_find
	tst.w      d0
	bne        x10ab6_11
	lea.l      $00014A4A,a1
	movea.l    a4,a0
	jsr        strcpy
	bra        x10ab6_11
VA_OB_DRIVE
x10ab6_9:
	move.l     a3,d0
	beq.s      x10ab6_5
	move.b     #$43,1026(a4) ; $000154E2
	lea.l      $00014A67,a1
	lea.l      1024(a4),a0 ; startprog_name
	jsr        strcat
	movea.l    a4,a1
	lea.l      1024(a4),a0 ; startprog_name
	jsr        strcat
	moveq.l    #1,d6
	lea.l      $00014A69,a1
	movea.l    a4,a0
	jsr        strcpy
	movea.l    a4,a0
	jsr        shel_find
	tst.w      d0
	bne.s      x10ab6_13
	lea.l      $00014A74,a1
	movea.l    a4,a0
	jsr        strcpy
x10ab6_13:
	lea.l      1024(a4),a1 ; startprog_name
	movea.l    a4,a0
	moveq.l    #100,d2
	moveq.l    #1,d1
	moveq.l    #100,d0
	jsr        shel_write
	tst.w      d0
	beq        x10ab6_14
x10ab6_5:
	move.w     #$4735,(a2)
	move.w     -124(a4),2(a2) ; gl_apid
	clr.w      4(a2)
	move.w     d6,6(a2)
x10ab6_4:
	clr.w      8(a2)
	clr.w      10(a2)
	clr.w      12(a2)
	clr.w      14(a2)
	movea.l    a2,a0
	moveq.l    #16,d1
	move.w     d3,d0
	jsr        appl_write
	clr.w      (a2)
	addq.w     #2,a7
	movem.l    (a7)+,d3-d7/a2-a4
	rts

av_what_izit:
x10d8a:
	movem.l    d3-d4/a2,-(a7)
	subq.w     #2,a7
	movea.l    a0,a2
	move.w     6(a2),d3
	move.w     8(a2),d4
	lea.l      (a7),a0
	move.w     d4,d1
	move.w     d3,d0
	jsr        $00011A12
	move.w     2(a2),d4
	move.w     #$4733,(a2)
	lea.l      $000150E0,a0
	move.w     -124(a0),2(a2) ; gl_apid
	clr.w      4(a2)
	move.w     (a7),6(a2)
	move.w     d0,8(a2)
	clr.w      10(a2)
	clr.w      12(a2)
	clr.w      14(a2)
	move.b     (a0),d1
	beq.s      x10d8a_1
	tst.w      d0
	beq.s      x10d8a_1
	move.l     a0,d0
	moveq.l    #16,d2
	asr.l      d2,d0
	move.w     d0,10(a2)
	move.l     a0,d1
	and.w      #$FFFF,d1
	move.w     d1,12(a2)
x10d8a_1:
	movea.l    a2,a0
	moveq.l    #16,d1
	move.w     d4,d0
	jsr        appl_write
	clr.w      (a2)
	addq.w     #2,a7
	movem.l    (a7)+,d3-d4/a2
	rts

av_xwind:
x10e04:
	move.l     a2,-(a7)
	movea.l    a0,a2
	moveq.l    #16,d1
	move.w     magxdesk,d0
	jsr        appl_write
	clr.w      (a2)
	movea.l    (a7)+,a2
	rts

av_openwind:
x10e1c:
	move.l     a2,-(a7)
	movea.l    a0,a2
	clr.w      14(a2)
	move.w     #$4740,(a0)
	moveq.l    #16,d1
	move.w     magxdesk,d0
	jsr        appl_write
	clr.w      (a2)
	movea.l    (a7)+,a2
	rts

av_view:
x10e3c:
	move.w     d3,-(a7)
	move.l     a2,-(a7)
	movea.l    a0,a2
	move.w     2(a2),d3
	move.w     #$4722,(a0)
	move.w     gl_apid,2(a2)
	clr.w      4(a2)
	clr.w      10(a2)
	clr.w      12(a2)
	move.w     #$3E81,14(a2)
	moveq.l    #16,d1
	add.w      4(a2),d1
	move.w     magxdesk,d0
	jsr        appl_write
	move.w     #$4752,(a2)
	move.w     gl_apid,2(a2)
	clr.w      4(a2)
	move.w     #$0001,6(a2)
	clr.w      8(a2)
	clr.w      10(a2)
	clr.w      12(a2)
	clr.w      14(a2)
	movea.l    a2,a0
	moveq.l    #16,d1
	move.w     d3,d0
	jsr        appl_write
	clr.w      (a2)
	movea.l    (a7)+,a2
	move.w     (a7)+,d3
	rts

av_status:
x10eb0:
	movem.l    d3-d4/a2-a6,-(a7)
	subq.w     #8,a7
	move.l     a0,4(a7)
	moveq.l    #-1,d3
	clr.w      d0
	lea.l      $000150E0,a2
	bra.s      x10eb0_1
x10eb0_3:
	move.w     d0,d1
	lsl.w      #3,d1
	sub.w      d0,d1
	add.w      d1,d1
	lea.l      2052(a2),a0 ; $000158E4
	move.w     0(a0,d1.w),d2
	movea.l    4(a7),a1
	cmp.w      2(a1),d2
	bne.s      x10eb0_2
	move.w     d0,d3
x10eb0_2:
	addq.w     #1,d0
x10eb0_1:
	cmp.w      #$0020,d0
	blt.s      x10eb0_3
	cmp.w      #$FFFF,d3
	beq        x10eb0_4
	lea.l      $00014A91,a0
	jsr        getenv
	movea.l    a0,a5
	move.l     a5,d0
	bne.s      x10eb0_5
	lea.l      $00014A98,a0
	jsr        getenv
	movea.l    a0,a5
x10eb0_5:
	move.l     a5,d0
	bne.s      x10eb0_6
	lea.l      $00014A9C,a1
	lea.l      1024(a2),a0 ; startprog_name
	jsr        strcpy
	bra.s      x10eb0_7
x10eb0_6:
	movea.l    a5,a1
	lea.l      1024(a2),a0 ; startprog_name
	jsr        strcpy
	lea.l      1024(a2),a0 ; startprog_name
	jsr        strlen
	lea.l      1023(a2),a0 ; $000154DF
	cmpi.b     #$5C,0(a0,d0.w)
	beq.s      x10eb0_8
	lea.l      $00014AAA,a1
	lea.l      1024(a2),a0 ; startprog_name
	jsr        strcat
x10eb0_8:
	lea.l      $00014AAC,a1
	lea.l      1024(a2),a0 ; startprog_name
	jsr        strcat
x10eb0_7:
	lea.l      $00014AB9,a1
	lea.l      1024(a2),a0 ; startprog_name
	jsr        fopen
	movea.l    a0,a3
	moveq.l    #46,d0
	lea.l      1024(a2),a0 ; startprog_name
	jsr        strrchr
	movea.l    a0,a5
	move.l     a5,d0
	bne.s      x10eb0_9
	movea.l    a3,a0
	jsr        fclose
	bra        x10eb0_4
x10eb0_9:
	clr.b      (a5)
	lea.l      $00014ABB,a1
	lea.l      1024(a2),a0 ; startprog_name
	jsr        strcat
	lea.l      $00014AC0,a1
	lea.l      1024(a2),a0 ; startprog_name
	jsr        fopen
	movea.l    a0,a6
	clr.w      d4
	bra        x10eb0_10
x10eb0_16:
	movea.l    a3,a1
	move.w     #$0100,d0
	movea.l    a2,a0
	jsr        fgets
	movea.l    a3,a0
	jsr        feof
	tst.w      d0
	bne        x10eb0_11
	movea.l    a2,a0
	jsr        strlen
	cmpi.b     #$0A,-1(a2,d0.w)
	bne.s      x10eb0_12
	movea.l    a2,a0
	jsr        strlen
	clr.b      -1(a2,d0.w)
x10eb0_12:
	moveq.l    #1,d0
	movea.l    a2,a0
	jsr        strchr
	movea.l    a0,a5
	move.l     a5,d0
	beq.s      x10eb0_13
	clr.b      (a0)
	addq.w     #1,a5
	move.w     d3,d0
	lsl.w      #3,d0
	sub.w      d3,d0
	add.w      d0,d0
	lea.l      2056(a2),a1 ; $000158E8
	adda.w     d0,a1
	movea.l    a2,a0
	jsr        strcmp
	tst.w      d0
	bne.s      x10eb0_14
	movea.l    4(a7),a0
	addq.w     #6,a0
	move.l     a0,(a7)
	movea.l    (a0),a4
	tst.w      d4
	bne.s      x10eb0_15
	move.l     a4,d0
	beq.s      x10eb0_15
	move.b     (a4),d1
	beq.s      x10eb0_15
	move.l     d0,-(a7)
	move.w     d3,d2
	lsl.w      #3,d2
	sub.w      d3,d2
	add.w      d2,d2
	lea.l      2056(a2),a1 ; $000158E8
	pea.l      0(a1,d2.w)
	lea.l      $00014AC2,a1
	movea.l    a6,a0
	jsr        fprintf
	addq.w     #8,a7
x10eb0_15:
	moveq.l    #1,d4
	bra.s      x10eb0_10
x10eb0_14:
	move.b     #$01,-(a5)
	pea.l      (a2)
	lea.l      $00014AC9,a1
	movea.l    a6,a0
	jsr        fprintf
	addq.w     #4,a7
	bra.s      x10eb0_10
x10eb0_13:
	pea.l      (a2)
	lea.l      $00014ACD,a1
	movea.l    a6,a0
	jsr        fprintf
	addq.w     #4,a7
x10eb0_10:
	movea.l    a3,a0
	jsr        feof
	tst.w      d0
	beq        x10eb0_16
x10eb0_11:
	tst.w      d4
	bne.s      x10eb0_17
	movea.l    4(a7),a0
	addq.w     #6,a0
	move.l     a0,(a7)
	movea.l    (a0),a4
	move.l     a4,-(a7)
	move.w     d3,d0
	lsl.w      #3,d0
	sub.w      d3,d0
	add.w      d0,d0
	lea.l      2056(a2),a1 ; $000158E8
	pea.l      0(a1,d0.w)
	lea.l      $00014AD1,a1
	movea.l    a6,a0
	jsr        fprintf
	addq.w     #8,a7
x10eb0_17:
	movea.l    a3,a0
	jsr        fclose
	movea.l    a6,a0
	jsr        fclose
	lea.l      1024(a2),a1 ; startprog_name
	movea.l    a2,a0
	jsr        strcpy
	moveq.l    #46,d0
	movea.l    a2,a0
	jsr        strrchr
	movea.l    a0,a5
	clr.b      (a0)
	lea.l      $00014AD8,a1
	movea.l    a2,a0
	jsr        strcat
	movea.l    a2,a0
	jsr        unlink
	movea.l    a2,a1
	lea.l      1024(a2),a0 ; startprog_name
	jsr        rename
	movea.l    4(a7),a0
	clr.w      (a0)
x10eb0_4:
	addq.w     #8,a7
	movem.l    (a7)+,d3-d4/a2-a6
	rts

av_getstatus:
x11128:
	movem.l    d3-d5/a2-a6,-(a7)
	movea.l    a0,a2
	move.w     2(a2),d3
	moveq.l    #-1,d4
	clr.w      d0
	lea.l      $000150E0,a3
	bra.s      x11128_1
x11128_3:
	move.w     d0,d1
	lsl.w      #3,d1
	sub.w      d0,d1
	add.w      d1,d1
	lea.l      2052(a3),a0 ; $000158E4
	cmp.w      0(a0,d1.w),d3
	bne.s      x11128_2
	move.w     d0,d4
x11128_2:
	addq.w     #1,d0
x11128_1:
	cmp.w      #$0020,d0
	blt.s      x11128_3
	cmp.w      #$FFFF,d4
	bne.s      x11128_4
	move.w     #$4705,(a2)
	move.w     -124(a3),2(a2) ; gl_apid
	clr.w      4(a2)
	clr.w      6(a2)
	clr.w      8(a2)
	clr.w      10(a2)
	clr.w      12(a2)
	clr.w      14(a2)
	movea.l    a2,a0
	moveq.l    #16,d1
	move.w     d3,d0
	jsr        appl_write
	bra        x11128_5
x11128_4:
	lea.l      $000148B4,a6
	lea.l      553(a6),a0 ; $00014ADD
	jsr        getenv
	movea.l    a0,a4
	move.l     a4,d0
	bne.s      x11128_6
	lea.l      560(a6),a0 ; $00014AE4
	jsr        getenv
	movea.l    a0,a4
x11128_6:
	lea.l      1024(a3),a5 ; startprog_name
	move.l     a4,d0
	bne.s      x11128_7
	lea.l      564(a6),a1 ; $00014AE8
	movea.l    a5,a0
	jsr        strcpy
	bra.s      x11128_8
x11128_7:
	movea.l    a4,a1
	movea.l    a5,a0
	jsr        strcpy
	movea.l    a5,a0
	jsr        strlen
	cmpi.b     #$5C,-1(a5,d0.w)
	beq.s      x11128_9
	lea.l      578(a6),a1 ; $00014AF6
	movea.l    a5,a0
	jsr        strcat
x11128_9:
	lea.l      580(a6),a1 ; $00014AF8
	movea.l    a5,a0
	jsr        strcat
x11128_8:
	clr.w      d5
	lea.l      593(a6),a1 ; $00014B05
	movea.l    a5,a0
	jsr        fopen
	movea.l    a0,a6
	move.l     a6,d0
	beq        x11128_10
	bra.s      x11128_11
x11128_15:
	movea.l    a6,a1
	move.w     #$0100,d0
	movea.l    a3,a0
	jsr        fgets
	movea.l    a6,a0
	jsr        feof
	tst.w      d0
	bne.s      x11128_12
	movea.l    a3,a0
	jsr        strlen
	cmpi.b     #$0A,-1(a3,d0.w)
	bne.s      x11128_13
	movea.l    a3,a0
	jsr        strlen
	clr.b      -1(a3,d0.w)
x11128_13:
	moveq.l    #1,d0
	movea.l    a3,a0
	jsr        strchr
	movea.l    a0,a4
	move.l     a4,d0
	beq.s      x11128_14
	clr.b      (a0)
	addq.w     #1,a4
	move.w     d4,d0
	lsl.w      #3,d0
	sub.w      d4,d0
	add.w      d0,d0
	lea.l      2056(a3),a1 ; $000158E8
	adda.w     d0,a1
	movea.l    a3,a0
	jsr        strcmp
	tst.w      d0
	bne.s      x11128_14
	moveq.l    #1,d5
	movea.l    a4,a1
	movea.l    a5,a0
	jsr        strcpy
x11128_14:
	tst.w      d5
	bne.s      x11128_12
x11128_11:
	movea.l    a6,a0
	jsr        feof
	tst.w      d0
	beq.w      x11128_15
x11128_12:
	movea.l    a6,a0
	jsr        fclose
x11128_10:
	move.w     #$4705,(a2)
	move.w     -124(a3),2(a2) ; gl_apid
	clr.w      4(a2)
	clr.w      6(a2)
	clr.w      8(a2)
	tst.w      d5
	beq.s      x11128_16
	move.l     a5,d0
	moveq.l    #16,d1
	asr.l      d1,d0
	move.w     d0,6(a2)
	move.l     a5,d2
	and.w      #$FFFF,d2
	move.w     d2,8(a2)
x11128_16:
	clr.w      10(a2)
	clr.w      12(a2)
	clr.w      14(a2)
	movea.l    a2,a0
	moveq.l    #16,d1
	move.w     d3,d0
	jsr        appl_write
	clr.w      (a2)
x11128_5:
	movem.l    (a7)+,d3-d5/a2-a6
	rts

av_copyfile:
x112ec:
	movem.l    d3/a2-a4,-(a7)
	movea.l    a0,a2
	move.w     2(a2),d3
	lea.l      6(a2),a3
	move.l     a3,d0
	beq.s      x112ec_1
	movea.l    (a3),a4
	bra.s      x112ec_2
x112ec_1:
	suba.l     a4,a4
x112ec_2:
	movea.l    a4,a0
	jsr        $00011F4E
	lea.l      10(a2),a3
	move.l     a3,d0
	beq.s      x112ec_3
	movea.l    (a3),a4
	bra.s      x112ec_4
x112ec_3:
	suba.l     a4,a4
x112ec_4:
	move.w     #$4756,(a2)
	lea.l      startprog_name,a3
	move.w     -1148(a3),2(a2) ; gl_apid
	clr.w      4(a2)
	clr.w      6(a2)
	clr.w      8(a2)
	clr.w      10(a2)
	clr.w      12(a2)
	clr.w      14(a2)
	move.l     a4,d0
	beq.w      x112ec_5
	lea.l      $00014B07,a1
	movea.l    a3,a0
	jsr        strcat
	movea.l    a4,a1
	movea.l    a3,a0
	jsr        strcat
	cmpi.w     #$0001,14(a2)
	bne.s      x112ec_6
	move.b     #$4D,2(a3) ; $000154E2
	bra.s      x112ec_7
x112ec_6:
	move.b     #$43,2(a3) ; $000154E2
x112ec_7:
	lea.l      -1024(a3),a4 ; $000150E0
	lea.l      $00014B09,a1
	movea.l    a4,a0
	jsr        strcpy
	movea.l    a4,a0
	jsr        shel_find
	tst.w      d0
	bne.s      x112ec_8
	lea.l      $00014B14,a1
	movea.l    a4,a0
	jsr        strcpy
x112ec_8:
	movea.l    a3,a1
	movea.l    a4,a0
	moveq.l    #100,d2
	moveq.l    #1,d1
	moveq.l    #100,d0
	jsr        shel_write
	tst.w      d0
	bne.s      x112ec_9
	jsr        error_copy
	bra.s      x112ec_5
x112ec_9:
	move.w     #$0001,6(a2)
x112ec_5:
	movea.l    a2,a0
	moveq.l    #16,d1
	move.w     d3,d0
	jsr        appl_write
	clr.w      (a2)
	movem.l    (a7)+,d3/a2-a4
	rts

av_delfile:
x113d8:
	movem.l    d3/a2-a3,-(a7)
	movea.l    a0,a2
	move.w     2(a2),d3
	lea.l      6(a2),a0
	move.l     a0,d0
	beq.s      x113d8_1
	movea.l    (a0),a3
	bra.s      x113d8_2
x113d8_1:
	suba.l     a3,a3
x113d8_2:
	movea.l    a3,a0
	jsr        $00011F4E
	lea.l      $000150E0,a3
	move.b     #$44,1026(a3) ; $000154E2
	move.w     #$4756,(a2)
	move.w     -124(a3),2(a2) ; gl_apid
	clr.w      4(a2)
	clr.w      6(a2)
	clr.w      8(a2)
	clr.w      10(a2)
	clr.w      12(a2)
	clr.w      14(a2)
	lea.l      $00014B31,a1
	movea.l    a3,a0
	jsr        strcpy
	movea.l    a3,a0
	jsr        shel_find
	tst.w      d0
	bne.s      x113d8_3
	lea.l      $00014B3C,a1
	movea.l    a3,a0
	jsr        strcpy
x113d8_3:
	lea.l      1024(a3),a1 ; startprog_name
	movea.l    a3,a0
	moveq.l    #100,d2
	moveq.l    #1,d1
	moveq.l    #100,d0
	jsr        shel_write
	tst.w      d0
	bne.s      x113d8_4
	jsr        error_copy
	bra.s      x113d8_5
x113d8_4:
	move.w     #$0001,6(a2)
x113d8_5:
	movea.l    a2,a0
	moveq.l    #16,d1
	move.w     d3,d0
	jsr        appl_write
	clr.w      (a2)
	movem.l    (a7)+,d3/a2-a3
	rts

x11486:
	movem.l    d3/a2-a3,-(a7)
	clr.w      d3
	lea.l      $000158E4,a2
	lea.l      windows,a3
	bra.s      x11486_1
x11486_6:
	move.w     d3,d0
	lsl.w      #3,d0
	sub.w      d3,d0
	add.w      d0,d0
	cmpi.w     #$FFFF,0(a2,d0.w)
	beq.s      x11486_2
	lea.l      4(a2,d0.w),a0
	jsr        appl_find
	tst.w      d0
	bpl.s      x11486_2
	clr.w      d0
	bra.s      x11486_3
x11486_5:
	move.w     d0,d1
	lsl.w      #2,d1
	move.w     2(a3,d1.w),d2
	move.w     d3,d1
	lsl.w      #3,d1
	sub.w      d3,d1
	add.w      d1,d1
	cmp.w      0(a2,d1.w),d2
	bne.s      x11486_4
	move.w     d3,d2
	lsl.w      #2,d2
	move.w     #$FFFF,0(a3,d2.w)
	move.w     #$FFFF,2(a3,d2.w)
x11486_4:
	addq.w     #1,d0
x11486_3:
	cmp.w      #$0020,d0
	blt.s      x11486_5
	move.w     d3,d0
	lsl.w      #3,d0
	sub.w      d3,d0
	add.w      d0,d0
	move.w     #$FFFF,0(a2,d0.w)
x11486_2:
	addq.w     #1,d3
x11486_1:
	cmp.w      #$0020,d3
	blt.s      x11486_6
	movem.l    (a7)+,d3/a2-a3
	rts

dd_reply:
x11506:
	movem.l    d3-d7/a2-a3,-(a7)
	lea.l      -38(a7),a7
	move.w     d0,d6
	move.w     d1,d7
	move.w     d2,36(a7)
	move.w     70(a7),d5
	move.w     72(a7),d4
	clr.w      d3
	move.w     d3,d0
	lea.l      $000158E0,a2
	bra.s      x11506_1
x11506_4:
	move.w     d0,d1
	lsl.w      #3,d1
	sub.w      d0,d1
	add.w      d1,d1
	cmp.w      4(a2,d1.w),d4
	bne.s      x11506_2
	moveq.l    #1,d3
x11506_2:
	tst.w      d3
	bne.s      x11506_3
	addq.w     #1,d0
x11506_1:
	cmp.w      #$0020,d0
	blt.s      x11506_4
x11506_3:
	tst.w      d3
	beq.s      x11506_5
	clr.w      d3
	move.w     d3,d0
	bra.s      x11506_6
x11506_8:
	move.w     d0,d1
	lsl.w      #2,d1
	lea.l      452(a2),a0 ; windows
	cmp.w      0(a0,d1.w),d5
	bne.s      x11506_7
	moveq.l    #1,d3
x11506_7:
	tst.w      d3
	bne.s      x11506_5
	addq.w     #1,d0
x11506_6:
	cmp.w      #$0020,d0
	blt.s      x11506_8
x11506_5:
	tst.w      d3
	bne.s      x11506_9
	clr.w      d0
	bra        x11506_10
x11506_9:
	clr.b      d1
	move.w     d6,d0
	jsr        $000119E0
	tst.w      d0
	beq        x11506_11
	lea.l      $00014B59,a0
	moveq.l    #32,d1
	move.w     d6,d0
	jsr        Fwrite
	moveq.l    #32,d1
	cmp.l      d0,d1
	beq.s      x11506_12
	move.w     d6,d0
	jsr        Fclose
	jsr        error_dragdrop
	bra        x11506_11
x11506_12:
	lea.l      16(a7),a3
	movea.l    a3,a0
	move.w     d6,d0
	jsr        $000118EC
	tst.w      d0
	beq        x11506_11
	moveq.l    #4,d0
	lea.l      2(a3),a1
	lea.l      $00014B7E,a0
	jsr        strncmp
	tst.w      d0
	beq.s      x11506_13
	moveq.l    #2,d1
	move.w     d6,d0
	jsr        $000119E0
	tst.w      d0
	bne.s      x11506_14
	bra        x11506_11
x11506_13:
	move.l     (a2),d0
	beq.s      x11506_15
	movea.l    d0,a0
	jsr        free
x11506_15:
	move.l     8(a3),d0
	jsr        malloc
	move.l     a0,(a2)
	move.l     a0,d0
	bne.s      x11506_16
	moveq.l    #3,d1
	move.w     d6,d0
	jsr        $000119E0
	tst.w      d0
	bne.s      x11506_14
	bra        x11506_11
x11506_16:
	clr.b      d1
	move.w     d6,d0
	jsr        $000119E0
	tst.w      d0
	beq        x11506_11
	movea.l    (a2),a0
	move.l     8(a3),d1
	move.w     d6,d0
	jsr        Fread
	cmp.l      8(a3),d0
	beq.s      x11506_17
	moveq.l    #1,d1
	move.w     d6,d0
	jsr        $000119E0
	move.w     d6,d0
	jsr        Fclose
	jsr        error_dragdrop
	bra.s      x11506_18
x11506_17:
	moveq.l    #1,d3
x11506_14:
	tst.w      d3
	beq        x11506_12
x11506_18:
	move.w     d6,d0
	jsr        Fclose
	tst.w      d3
	beq.s      x11506_11
	move.w     #$4725,(a7)
	move.w     -2172(a2),2(a7) ; gl_apid
	clr.w      4(a7)
	move.w     d5,6(a7)
	move.w     d7,8(a7)
	move.w     36(a7),10(a7)
	move.l     (a2),d0
	moveq.l    #16,d1
	asr.l      d1,d0
	move.w     d0,12(a7)
	move.w     2(a2),d2 ; $000158E2
	and.w      #$FFFF,d2
	move.w     d2,14(a7)
	lea.l      (a7),a0
	move.w     d4,d0
	moveq.l    #16,d1
	jsr        appl_write
x11506_11:
	moveq.l    #1,d0
x11506_10:
	lea.l      38(a7),a7
	movem.l    (a7)+,d3-d7/a2-a3
	rts

cycle_windows:
x116b4:
	movem.l    d3-d4/a2-a3,-(a7)
	lea.l      -18(a7),a7
	lea.l      16(a7),a2
	pea.l      (a2)
	moveq.l    #10,d1
	clr.w      d0
	jsr        wind_get
	addq.w     #4,a7
	move.w     (a2),d0
	beq        x116b4_1
	clr.w      d3
x116b4_14:
	lea.l      windows,a3
	moveq.l    #-1,d0
	move.w     d0,d4
	clr.w      d1
	bra.s      x116b4_2
x116b4_4:
	move.w     d1,d2
	lsl.w      #2,d2
	move.w     0(a3,d2.w),d2
	cmp.w      (a2),d2
	bne.s      x116b4_3
	move.w     d1,d0
x116b4_3:
	addq.w     #1,d1
x116b4_2:
	cmp.w      #$0020,d1
	blt.s      x116b4_4
	cmp.w      #$FFFF,d0
	bne.s      x116b4_5
	clr.w      d0
x116b4_5:
	moveq.l    #1,d1
	add.w      d0,d1
	bra.s      x116b4_6
x116b4_9:
	move.w     d1,d2
	lsl.w      #2,d2
	cmpi.w     #$FFFF,0(a3,d2.w)
	beq.s      x116b4_7
	move.w     d1,d4
	bra.s      x116b4_8
x116b4_7:
	addq.w     #1,d1
x116b4_6:
	cmp.w      #$0020,d1
	blt.s      x116b4_9
x116b4_8:
	cmp.w      #$FFFF,d4
	bne.s      x116b4_10
	clr.w      d1
	bra.s      x116b4_11
x116b4_13:
	move.w     d1,d2
	lsl.w      #2,d2
	cmpi.w     #$FFFF,0(a3,d2.w)
	beq.s      x116b4_12
	move.w     d1,d4
	bra.s      x116b4_10
x116b4_12:
	addq.w     #1,d1
x116b4_11:
	cmp.w      d1,d0
	bgt.s      x116b4_13
x116b4_10:
	cmp.w      #$FFFF,d4
	beq        x116b4_1
	move.w     #$0015,(a7)
	move.w     -2624(a3),2(a7) ; gl_apid
	clr.w      4(a7)
	move.w     d4,d0
	lsl.w      #2,d0
	move.w     0(a3,d0.w),6(a7)
	clr.w      8(a7)
	clr.w      10(a7)
	clr.w      12(a7)
	clr.w      14(a7)
	lea.l      (a7),a0
	moveq.l    #16,d1
	move.w     2(a3,d0.w),d0
	jsr        appl_write
	clr.w      d1
	move.w     #$00FA,d0
	jsr        evnt_timer
	pea.l      (a2)
	moveq.l    #10,d1
	clr.w      d0
	jsr        wind_get
	addq.w     #4,a7
	move.w     (a2),d0
	beq.s      x116b4_1
	move.w     d4,d1
	lsl.w      #2,d1
	cmp.w      0(a3,d1.w),d0
	beq.s      x116b4_1
	bsr        $00011486
	clr.w      d1
	move.w     #$01F4,d0
	jsr        evnt_timer
	pea.l      (a2)
	moveq.l    #10,d1
	clr.w      d0
	jsr        wind_get
	addq.w     #4,a7
	move.w     (a2),d0
	beq.s      x116b4_1
	move.w     d4,d1
	lsl.w      #2,d1
	cmp.w      0(a3,d1.w),d0
	beq.s      x116b4_1
	move.w     0(a3,d1.w),(a2)
	cmp.w      #$0003,d3
	blt        x116b4_14
x116b4_1:
	lea.l      18(a7),a7
	movem.l    (a7)+,d3-d4/a2-a3
	rts

x117e8:
	movem.l    a2/a4-a6,-(a7)
	lea.l      -24(a7),a7
	movea.l    a0,a4
	movea.l    a1,a5
	movea.l    44(a7),a6
	lea.l      $00015B76,a2
	move.l     a2,(a7)
	move.l     #$00015B94,4(a7)
	move.l     #$00015BB2,8(a7)
	move.l     #$00015CBA,12(a7)
	move.w     #$0068,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0005,4(a2) ; $00015B7A
	clr.w      6(a2) ; $00015B7C
	clr.w      8(a2) ; $00015B7E
	move.w     d0,60(a2) ; $00015BB2
	move.w     d1,62(a2) ; $00015BB4
	lea.l      (a7),a0
	jsr        _crystal
	move.l     a4,d0
	beq.s      x117e8_1
	move.w     326(a2),(a4) ; $00015CBC
x117e8_1:
	move.l     a5,d0
	beq.s      x117e8_2
	move.w     328(a2),(a5) ; $00015CBE
x117e8_2:
	move.l     a6,d0
	beq.s      x117e8_3
	move.w     330(a2),(a6) ; $00015CC0
x117e8_3:
	move.l     48(a7),d0
	beq.s      x117e8_4
	movea.l    d0,a0
	move.w     332(a2),(a0) ; $00015CC2
x117e8_4:
	move.w     324(a2),d0 ; $00015CBA
	lea.l      24(a7),a7
	movem.l    (a7)+,a2/a4-a6
	rts

xbra_unlink:
x11872:
	movem.l    d3-d6/a2-a3,-(a7)
	move.w     d0,d6
	moveq.l    #1,d3
	move.b     d3,d4
	clr.b      d5
	movea.l    #$FFFFFFFF,a0
	jsr        Setexc
	movea.l    a0,a2
	moveq.l    #-12,d0
	move.l     a2,d1
	add.l      d1,d0
	movea.l    d0,a3
x11872_7:
	cmpi.l     #$58425241,(a3)
	bne.s      x11872_1
	cmpi.l     #$41565356,4(a3)
	bne.s      x11872_2
	tst.b      d5
	beq.s      x11872_3
	move.l     8(a3),(a2)
	bra.s      x11872_4
x11872_3:
	movea.l    8(a3),a0
	move.w     d6,d0
	jsr        Setexc
x11872_4:
	clr.b      d3
	bra.s      x11872_5
x11872_2:
	moveq.l    #8,d0
	move.l     a3,d1
	add.l      d1,d0
	movea.l    d0,a2
	moveq.l    #-12,d2
	add.l      (a2),d2
	movea.l    d2,a3
	addq.b     #1,d5
	bra.s      x11872_5
x11872_1:
	clr.b      d4
x11872_5:
	tst.b      d3
	beq.s      x11872_6
	tst.b      d4
	bne.s      x11872_7
x11872_6:
	tst.b      d3
	beq.s      x11872_8
	clr.w      d0
	bra.s      x11872_9
x11872_8:
	moveq.l    #1,d0
x11872_9:
	movem.l    (a7)+,d3-d6/a2-a3
	rts

x118ec:
	movem.l    d3-d5/a2-a3,-(a7)
	move.w     d0,d4
	movea.l    a0,a3
	clr.w      d3
	move.l     #$00000800,d0
	jsr        malloc
	movea.l    a0,a2
	move.l     a2,d0
	bne.s      x118ec_1
	moveq.l    #1,d1
	move.w     d4,d0
	jsr        $000119E0
	move.w     d4,d0
	jsr        Fclose
	bra        x118ec_2
x118ec_1:
	movea.l    a3,a0
	moveq.l    #2,d1
	move.w     d4,d0
	jsr        Fread
	moveq.l    #2,d1
	cmp.l      d0,d1
	ble.s      x118ec_3
	moveq.l    #1,d3
x118ec_3:
	cmpi.w     #$0009,(a3)
	bge.s      x118ec_4
	moveq.l    #1,d3
x118ec_4:
	lea.l      2(a3),a0
	moveq.l    #4,d1
	move.w     d4,d0
	jsr        Fread
	moveq.l    #4,d1
	cmp.l      d0,d1
	ble.s      x118ec_5
	moveq.l    #1,d3
	clr.b      2(a3)
	bra.s      x118ec_6
x118ec_5:
	clr.b      6(a3)
x118ec_6:
	lea.l      8(a3),a0
	moveq.l    #4,d1
	move.w     d4,d0
	jsr        Fread
	moveq.l    #4,d1
	cmp.l      d0,d1
	ble.s      x118ec_7
	moveq.l    #1,d3
x118ec_7:
	clr.l      12(a3)
	clr.l      16(a3)
	tst.w      d3
	bne.s      x118ec_8
	moveq.l    #-8,d5
	add.w      (a3),d5
	bra.s      x118ec_9
x118ec_14:
	movea.l    a2,a0
	move.l     a0,-(a7)
	cmp.w      #$0800,d5
	bge.s      x118ec_10
	move.w     d5,d1
	bra.s      x118ec_11
x118ec_10:
	move.w     #$0800,d1
x118ec_11:
	ext.l      d1
	move.w     d4,d0
	movea.l    (a7)+,a0
	jsr        Fread
	moveq.l    #1,d1
	cmp.l      d0,d1
	ble.s      x118ec_12
	moveq.l    #1,d3
	bra.s      x118ec_13
x118ec_12:
	sub.w      d0,d5
x118ec_13:
	tst.w      d3
	bne.s      x118ec_8
x118ec_9:
	tst.w      d5
	bgt.s      x118ec_14
x118ec_8:
	tst.w      d3
	bne.s      x118ec_15
	tst.w      d5
	ble.s      x118ec_16
x118ec_15:
	moveq.l    #1,d1
	move.w     d4,d0
	jsr        $000119E0
	move.w     d4,d0
	jsr        Fclose
	jsr        error_dragdrop
x118ec_2:
	clr.w      d0
	bra.s      x118ec_17
x118ec_16:
	moveq.l    #1,d0
x118ec_17:
	movem.l    (a7)+,d3-d5/a2-a3
	rts

x119e0:
	move.w     d3,-(a7)
	subq.w     #2,a7
	move.w     d0,d3
	move.b     d1,(a7)
	lea.l      (a7),a0
	moveq.l    #1,d1
	jsr        Fwrite
	moveq.l    #1,d1
	cmp.l      d0,d1
	bne.s      x119e0_1
	moveq.l    #1,d0
	bra.s      x119e0_2
x119e0_1:
	move.w     d3,d0
	jsr        Fclose
	jsr        error_dragdrop
	clr.w      d0
x119e0_2:
	addq.w     #2,a7
	move.w     (a7)+,d3
	rts

x11a12:
	movem.l    d3-d6/a2-a5,-(a7)
	lea.l      -16(a7),a7
	move.w     d0,d5
	move.w     d1,d4
	move.l     a0,12(a7)
	clr.w      d3
	move.w     #$FFFF,(a0)
	lea.l      startprog_name,a5
	clr.b      -1024(a5) ; $000150E0
	move.w     d4,d1
	move.w     d5,d0
	jsr        wind_find
	move.w     d0,d6
	lea.l      6(a7),a4
	tst.w      d6
	ble        x11a12_1
	clr.w      (a4)
	lea.l      1476(a5),a0 ; windows
	bra.s      x11a12_2
x11a12_4:
	move.w     (a4),d0
	lsl.w      #2,d0
	cmp.w      0(a0,d0.w),d6
	bne.s      x11a12_3
	movea.l    12(a7),a1
	move.w     2(a0,d0.w),(a1)
x11a12_3:
	addq.w     #1,(a4)
x11a12_2:
	cmpi.w     #$0020,(a4)
	blt.s      x11a12_4
	movea.l    12(a7),a0
	cmpi.w     #$FFFF,(a0)
	bne.s      x11a12_5
	move.l     a0,-(a7)
	moveq.l    #20,d1
	move.w     d6,d0
	jsr        wind_get
	addq.w     #4,a7
	movea.l    12(a7),a0
	move.w     (a0),d0
	cmp.w      -1146(a5),d0 ; magxdesk
	beq.s      x11a12_5
	move.w     #$FFFF,(a0)
x11a12_5:
	movea.l    12(a7),a0
	cmpi.w     #$FFFF,(a0)
	beq        x11a12_1
	moveq.l    #7,d3
	clr.l      -(a7)
	clr.l      -(a7)
	suba.l     a1,a1
	lea.l      16(a7),a0
	moveq.l    #1,d1
	move.w     d6,d0
	bsr        $000117E8
	addq.w     #8,a7
	moveq.l    #1,d0
	and.w      8(a7),d0
	beq.w      x11a12_1
	lea.l      (a7),a1
	lea.l      $00014B83,a0
	jsr        $00012D3E
	tst.w      d0
	beq.s      x11a12_6
	clr.l      -(a7)
	clr.l      -(a7)
	lea.l      18(a7),a1
	lea.l      16(a7),a0
	moveq.l    #2,d1
	move.w     d6,d0
	bsr        $000117E8
	addq.w     #8,a7
	lea.l      8(a7),a2
	movea.l    (a2),a3
	move.l     a3,d0
	beq.s      x11a12_1
	cmpi.b     #$20,(a3)
	bne.s      x11a12_7
	addq.w     #1,a3
x11a12_7:
	movea.l    a3,a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strcpy
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strlen
	lea.l      -1025(a5),a0 ; $000150DF
	cmpi.b     #$20,0(a0,d0.w)
	bne.s      x11a12_1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strlen
	lea.l      -1025(a5),a0 ; $000150DF
	clr.b      0(a0,d0.w)
	bra.s      x11a12_1
x11a12_6:
	jsr        error_no_aman
	clr.w      d3
x11a12_1:
	tst.w      d6
	bne        x11a12_8
	pea.l      4(a7)
	pea.l      14(a7)
	pea.l      16(a7)
	moveq.l    #14,d1
	clr.w      d0
	jsr        wind_get
	lea.l      12(a7),a7
	lea.l      8(a7),a2
	movea.l    (a2),a2
	move.l     a2,d0
	beq        x11a12_8
	move.w     d4,-(a7)
	move.w     d5,d2
	moveq.l    #8,d1
	movea.l    a2,a0
	clr.w      d0
	jsr        objc_find
	addq.w     #2,a7
	move.w     d0,d6
	tst.w      d0
	ble        x11a12_9
	ext.l      d0
	move.l     d0,d1
	add.l      d1,d1
	add.l      d0,d1
	lsl.l      #3,d1
	cmpi.w     #$001F,6(a2,d1.l)
	beq.s      x11a12_10
	cmpi.w     #$0021,6(a2,d1.l)
	bne        x11a12_8
x11a12_10:
	move.w     d6,d1
	ext.l      d1
	move.l     d1,d0
	add.l      d0,d0
	add.l      d1,d0
	lsl.l      #3,d0
	movea.l    12(a2,d0.l),a2
	movea.l    8(a2),a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strcpy
	move.w     12(a2),(a4)
	movea.l    a4,a3
	addq.w     #1,a3
	movea.l    12(a7),a0
	move.w     -1146(a5),(a0) ; magxdesk
	move.l     a3,d0
	beq.s      x11a12_11
	move.b     (a3),d1
	beq.s      x11a12_11
	moveq.l    #6,d3
	clr.w      d2
	move.b     d1,d2
	move.w     d2,-(a7)
	lea.l      $00014B88,a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        sprintf
	addq.w     #2,a7
	bra        x11a12_8
x11a12_11:
	lea.l      $00014B8E,a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strcmp
	tst.w      d0
	bne.s      x11a12_12
	moveq.l    #2,d3
x11a12_12:
	lea.l      $00014B99,a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strcmp
	tst.w      d0
	bne.s      x11a12_13
	moveq.l    #4,d3
	lea.l      $00014BA1,a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strcpy
x11a12_13:
	tst.w      d3
	bne        x11a12_8
	lea.l      $00014BAC,a1
	movea.l    a5,a0
	jsr        strcpy
	movea.l    a5,a0
	jsr        shel_find
	tst.w      d0
	beq        x11a12_14
	lea.l      $00014BB5,a1
	movea.l    a5,a0
	jsr        fopen
	movea.l    a0,a2
	move.l     a2,d0
	beq        x11a12_14
	clr.w      (a4)
	bra        x11a12_15
x11a12_21:
	movea.l    a2,a1
	moveq.l    #126,d0
	movea.l    a5,a0
	jsr        fgets
	moveq.l    #6,d0
	lea.l      $00014BB7,a1
	movea.l    a5,a0
	jsr        strncmp
	tst.w      d0
	bne.s      x11a12_16
	addq.w     #1,(a4)
x11a12_16:
	moveq.l    #10,d0
	lea.l      $00014BBE,a1
	movea.l    a5,a0
	jsr        strncmp
	tst.w      d0
	beq.s      x11a12_17
	moveq.l    #10,d0
	lea.l      $00014BC9,a1
	movea.l    a5,a0
	jsr        strncmp
	tst.w      d0
	beq.s      x11a12_17
	moveq.l    #10,d0
	lea.l      $00014BD4,a1
	movea.l    a5,a0
	jsr        strncmp
	tst.w      d0
	bne.s      x11a12_18
x11a12_17:
	cmp.w      (a4),d6
	bne.s      x11a12_18
	moveq.l    #32,d0
	movea.l    a5,a0
	jsr        strrchr
	movea.l    a0,a3
	move.l     a3,d0
	beq.s      x11a12_18
	movea.l    a5,a0
	jsr        strlen
	cmpi.b     #$0A,-1(a5,d0.w)
	bne.s      x11a12_19
	movea.l    a5,a0
	jsr        strlen
	clr.b      -1(a5,d0.w)
x11a12_19:
	addq.w     #1,a3
	movea.l    a3,a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strcpy
	moveq.l    #4,d3
x11a12_18:
	cmp.w      (a4),d6
	ble.s      x11a12_20
x11a12_15:
	movea.l    a2,a0
	jsr        feof
	tst.w      d0
	beq        x11a12_21
x11a12_20:
	movea.l    a2,a0
	jsr        fclose
	bra.s      x11a12_22
x11a12_14:
	jsr        error_magx_inf
x11a12_22:
	tst.w      d3
	bne.s      x11a12_8
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        shel_find
	tst.w      d0
	beq.s      x11a12_8
	moveq.l    #4,d3
	bra.s      x11a12_8
x11a12_9:
	clr.w      d3
x11a12_8:
	cmp.w      #$0004,d3
	bne.s      x11a12_23
	clr.w      d1
	clr.w      d0
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        Fattrib
	and.w      #$0010,d0
	beq.s      x11a12_24
	bra.s      x11a12_25
x11a12_23:
	tst.w      d3
	beq.s      x11a12_24
	cmpi.b     #$3A,-1023(a5) ; $000150E1
	beq.s      x11a12_26
	lea.l      $00014BDF,a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strcpy
	bra.s      x11a12_24
x11a12_26:
	moveq.l    #92,d0
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strrchr
	movea.l    a0,a3
	move.l     a3,d0
	beq.s      x11a12_27
	clr.b      1(a3)
x11a12_27:
	movea.l    12(a7),a0
	move.w     (a0),d0
	cmp.w      -1146(a5),d0 ; magxdesk
	bne.s      x11a12_24
x11a12_25:
	moveq.l    #5,d3
x11a12_24:
	cmp.w      #$0005,d3
	bne.s      x11a12_28
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strlen
	lea.l      -1025(a5),a0 ; $000150DF
	cmpi.b     #$5C,0(a0,d0.w)
	beq.s      x11a12_28
	lea.l      $00014BE0,a1
	lea.l      -1024(a5),a0 ; $000150E0
	jsr        strcat
x11a12_28:
	move.w     d3,d0
	lea.l      16(a7),a7
	movem.l    (a7)+,d3-d6/a2-a5
	rts

font_select:
x11dd4:
	movem.l    d3/a2-a5,-(a7)
	lea.l      -42(a7),a7
	movea.l    a0,a2
	moveq.l    #2,d0
	suba.l     a0,a0
	jsr        graf_mouse
	move.w     8(a2),d0
	ext.l      d0
	move.l     d0,38(a7)
	move.w     10(a2),d1
	ext.l      d1
	moveq.l    #16,d2
	lsl.l      d2,d1
	move.l     d1,34(a7)
	move.l     #$00010000,30(a7)
	move.w     #$0001,(a7)
	lea.l      8(a7),a4
	bra.s      x11dd4_1
x11dd4_2:
	move.w     (a7),d0
	add.w      d0,d0
	move.w     #$0001,0(a4,d0.w)
	addq.w     #1,(a7)
x11dd4_1:
	cmpi.w     #$000A,(a7)
	blt.s      x11dd4_2
	jsr        Getrez
	addq.w     #2,d0
	move.w     d0,(a4)
	move.w     #$0002,20(a4)
	lea.l      6(a7),a3
	pea.l      (a7)
	pea.l      4(a7)
	lea.l      8(a7),a1
	lea.l      8(a7),a0
	jsr        graf_handle
	addq.w     #8,a7
	move.w     d0,(a3)
	pea.l      $0001506E
	movea.l    a3,a1
	movea.l    a4,a0
	jsr        v_opnvwk
	addq.w     #4,a7
	lea.l      4(a7),a4
	clr.w      (a4)
	movea.l    a4,a0
	clr.w      d1
	move.w     (a3),d0
	jsr        $00012F94
	move.w     (a4),d0
	beq.s      x11dd4_3
	jsr        $0001206A
x11dd4_3:
	moveq.l    #1,d0
	move.w     d0,-(a7)
	suba.l     a1,a1
	lea.l      $00014BE2,a0
	moveq.l    #15,d2
	clr.w      d1
	move.w     (a3),d0
	jsr        $00012A38
	addq.w     #2,a7
	movea.l    a0,a5
	move.w     (a4),d0
	beq.s      x11dd4_4
	jsr        $0001206A
x11dd4_4:
	suba.l     a0,a0
	clr.w      d0
	jsr        graf_mouse
	pea.l      30(a7)
	pea.l      38(a7)
	pea.l      46(a7)
	move.l     42(a7),-(a7)
	lea.l      18(a7),a1
	move.l     50(a7),d2
	move.l     54(a7),d1
	moveq.l    #7,d0
	movea.l    a5,a0
	jsr        $00012CD8
	lea.l      16(a7),a7
	move.w     d0,d3
	suba.l     a0,a0
	moveq.l    #2,d0
	jsr        graf_mouse
	cmp.w      #$0002,d3
	bne.s      x11dd4_5
	move.w     40(a7),8(a2)
	move.l     34(a7),d0
	moveq.l    #16,d1
	asr.l      d1,d0
	move.w     d0,10(a2)
x11dd4_5:
	move.w     2(a2),d3
	move.w     #$7A18,(a2)
	move.w     gl_apid,2(a2)
	clr.w      4(a2)
	movea.l    a2,a0
	moveq.l    #16,d1
	move.w     d3,d0
	jsr        appl_write
	move.w     (a4),d0
	beq.s      x11dd4_6
	jsr        $0001206A
x11dd4_6:
	move.w     (a3),d0
	movea.l    a5,a0
	jsr        $00012A78
	suba.l     a0,a0
	clr.w      d0
	jsr        graf_mouse
	move.w     (a3),d0
	jsr        $00012F8C
	clr.w      (a2)
	lea.l      42(a7),a7
	movem.l    (a7)+,d3/a2-a5
	rts

x11f4e:
	movem.l    d3-d4/a2-a5,-(a7)
	lea.l      -16(a7),a7
	movea.l    a0,a2
	move.l     a2,d0
	beq        x11f4e_1
	lea.l      $000150E0,a5
	lea.l      startprog_name,a4
	movea.l    a2,a1
	movea.l    a5,a0
	jsr        strcpy
	lea.l      $000148B4,a2
	lea.l      859(a2),a1 ; $00014C0F
	movea.l    a5,a0
	jsr        strcat
	movea.l    a5,a3
	lea.l      861(a2),a1 ; $00014C11
	movea.l    a4,a0
	jsr        strcpy
	moveq.l    #32,d0
	movea.l    a5,a0
	jsr        strchr
	movea.l    a0,a5
	bra        x11f4e_2
x11f4e_7:
	clr.b      (a5)
	movea.l    a3,a0
	jsr        strlen
	subq.l     #1,d0
	cmpi.b     #$5C,0(a3,d0.l)
	beq.s      x11f4e_3
	clr.w      d0
	movea.l    a3,a0
	jsr        Fopen
	move.l     d0,d3
	tst.l      d0
	ble.s      x11f4e_4
	move.w     d3,d4
	moveq.l    #2,d2
	move.w     d4,d1
	moveq.l    #0,d0
	jsr        Fseek
	move.l     d0,d3
	move.w     d4,d0
	jsr        Fclose
	moveq.l    #10,d1
	lea.l      (a7),a0
	move.l     d3,d0
	jsr        ltoa
	bra.s      x11f4e_5
x11f4e_4:
	lea.l      868(a2),a1 ; $00014C18
	lea.l      (a7),a0
	jsr        strcpy
x11f4e_5:
	lea.l      870(a2),a1 ; $00014C1A
	movea.l    a4,a0
	jsr        strcat
	movea.l    a3,a1
	movea.l    a4,a0
	jsr        strcat
	lea.l      872(a2),a1 ; $00014C1C
	movea.l    a4,a0
	jsr        strcat
	lea.l      (a7),a1
	movea.l    a4,a0
	jsr        strcat
	bra.s      x11f4e_6
x11f4e_3:
	lea.l      874(a2),a1 ; $00014C1E
	movea.l    a4,a0
	jsr        strcat
	movea.l    a3,a1
	movea.l    a4,a0
	jsr        strcat
	lea.l      876(a2),a1 ; $00014C20
	movea.l    a4,a0
	jsr        strcat
x11f4e_6:
	lea.l      1(a5),a3
	moveq.l    #32,d0
	movea.l    a3,a0
	jsr        strchr
	movea.l    a0,a5
x11f4e_2:
	move.l     a5,d0
	bne        x11f4e_7
x11f4e_1:
	lea.l      16(a7),a7
	movem.l    (a7)+,d3-d4/a2-a5
	rts

x1206a:
	movem.l    d3/a2-a3,-(a7)
	move.w     d0,d3
	lea.l      $000148B4,a2
	lea.l      $000150E0,a3
	move.w     d3,d0
	cmp.w      #$000B,d0
	bhi.w      x1206a_1
	add.w      d0,d0
	move.w     $00012090(pc,d0.w),d0
	jmp        $00012090(pc,d0.w)
J2:
	dc.w $0072   ; x1206a_1-J2
	dc.w $0018   ; x1206a_2-J2
	dc.w $0072   ; x1206a_1-J2
	dc.w $0072   ; x1206a_1-J2
	dc.w $0072   ; x1206a_1-J2
	dc.w $0072   ; x1206a_1-J2
	dc.w $0072   ; x1206a_1-J2
	dc.w $0072   ; x1206a_1-J2
	dc.w $002a   ; x1206a_3-J2
	dc.w $003c   ; x1206a_4-J2
	dc.w $004e   ; x1206a_5-J2
	dc.w $0060   ; x1206a_6-J2
x1206a_2:
	move.w     d3,-(a7)
	lea.l      880(a2),a1 ; $00014C24
	movea.l    a3,a0
	jsr        sprintf
	addq.w     #2,a7
	bra.s      x1206a_7
x1206a_3:
	move.w     d3,-(a7)
	lea.l      945(a2),a1 ; $00014C65
	movea.l    a3,a0
	jsr        sprintf
	addq.w     #2,a7
	bra.s      x1206a_7
x1206a_4:
	move.w     d3,-(a7)
	lea.l      1004(a2),a1 ; $00014CA0
	movea.l    a3,a0
	jsr        sprintf
	addq.w     #2,a7
	bra.s      x1206a_7
x1206a_5:
	move.w     d3,-(a7)
	lea.l      1063(a2),a1 ; $00014CDB
	movea.l    a3,a0
	jsr        sprintf
	addq.w     #2,a7
	bra.s      x1206a_7
x1206a_6:
	move.w     d3,-(a7)
	lea.l      1126(a2),a1 ; $00014D1A
	movea.l    a3,a0
	jsr        sprintf
	addq.w     #2,a7
	bra.s      x1206a_7
x1206a_1:
	move.w     d3,-(a7)
	lea.l      1195(a2),a1 ; $00014D5F
	movea.l    a3,a0
	jsr        sprintf
	addq.w     #2,a7
x1206a_7:
	movea.l    a3,a0
	moveq.l    #1,d0
	jsr        form_alert
	movem.l    (a7)+,d3/a2-a3
	rts

error_overflow:
x12122:
	lea.l      $00014D98,a0 "[3][AV-Server: Overflow!][Cancel]"
	moveq.l    #1,d0
	jsr        form_alert
	rts

error_dragdrop:
x12132:
	lea.l      $00014DBA,a0 "[3][AV-Server: Drag&Drop-Error!][Ignore]"
	moveq.l    #1,d0
	jsr        form_alert
	rts

error_internal:
x12142:
	lea.l      $00014DE3,a0 "[3][AV-Server: Internal error!][Ignore]"
	moveq.l    #1,d0
	jsr        form_alert
	rts

error_copy:
x12152:
	lea.l      $00014E0B,a0 "[3][AV-Server: Can',$27,'t start|MG-Copy!][Cancel]"
	moveq.l    #1,d0
	jsr        form_alert
	rts

error_no_aman:
x12162:
	lea.l      $00014E38,a0 "[3][AV-Server: A-MAN not installed.|Can',$27,'t execute this function!][Cancel]"
	moveq.l    #1,d0
	jsr        form_alert
	rts

error_magx_inf:
x12172:
	lea.l      $00014E82,a0 "[3][AV-Server: Can't|read MAGX.INF!][Cancel]"
	moveq.l    #1,d0
	jsr        form_alert
	rts

install_aes_trap:
x12182:
	move.l     ($00000088).w,$0001219E
	move.l     #$000121A2,($00000088).w
	clr.l      d0
	rts

CRYSTAL = 200
COOKIE_ID = 0x41565356 /* 'AVSV' */

x12196:
	.dc.l 0x58425241 /* 'XBRA' */
	.dc.l COOKIE_ID
	.dc.l 0
x121a2:
	cmpi.b     #CRYSTAL,d0 /* was it AES call? BUG: should be .w */
	bne.s      x12196_1
	move.l     a0,$00015B72
	movea.l    d1,a0
	movea.l    (a0),a0
	cmpi.w     #$000C,(a0)
	beq.s      x12196_2
	bra.s      x12196_1
x12196_2:
	movea.l    d1,a0
	movea.l    4(a0),a0
	tst.w      4(a0)
	bne.s      x12196_1
	movea.l    d1,a0
	movea.l    16(a0),a0
	movea.l    (a0),a0
	cmpi.w     #$003F,(a0)
	bne.s      x12196_1
	movea.l    d1,a0
	movea.l    8(a0),a0
	move.w     (a0),$00015068
	move.w     gl_apid,(a0)
x12196_1:
	movea.l    $00015B72,a0
	movea.l    $0001219E,a0
	jmp        (a0)
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A0,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0004,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     d0,(a2)+
	move.w     d1,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	move.l     8(a7),(a2)+
	move.l     12(a7),(a2)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x12236:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A1,(a2)
	move.w     #$0004,2(a2) ; $00015B78
	move.w     #$0003,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     d0,(a2)+
	move.w     d1,(a2)+
	move.w     d2,(a2)+
	move.w     8(a7),(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	move.l     10(a7),(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x1227a:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A2,(a2)
	clr.w      2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x122a6:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A3,(a2)
	clr.w      2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x122d2:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A4,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0003,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	clr.w      (a2)
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	move.l     8(a7),(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x1230e:
	move.l     a2,-(a7)
	move.l     a1,-(a7)
	move.w     #$FFFF,$00015CBC
	lea.l      $00015B76,a2
	move.w     #$00A4,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0001,(a2)
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a1
	lea.l      $00015CBA,a0
	move.w     (a0)+,d0
	move.w     (a0),(a1)
	movea.l    (a7)+,a2
	rts

x12356:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A4,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0002,(a2)
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x1238e:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A4,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0003,(a2)
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x123c6:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A5,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	clr.w      (a2)+
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x123fe:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A5,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0001,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12438:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A5,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0002,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12472:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A6,(a2)
	clr.w      2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x124a0:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00A7,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     d0,(a2)+
	move.w     d1,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x124d4:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AA,(a2)
	move.w     #$0008,2(a2) ; $00015B78
	move.w     #$0008,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	lea.l      8(a7),a0
	move.l     (a0)+,(a2)+
	move.l     (a0)+,(a2)+
	lea.l      $00015BB2,a1
	move.w     d0,(a1)+
	move.w     d1,(a1)+
	move.l     (a0)+,(a2)+
	move.l     (a0)+,(a2)+
	move.w     d2,(a1)+
	move.w     (a0)+,(a1)+
	move.l     (a0)+,(a2)+
	move.l     (a0)+,(a2)+
	move.w     (a0)+,(a1)+
	move.w     (a0)+,(a1)+
	move.w     (a0)+,(a1)+
	move.w     (a0)+,(a1)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x1252a:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AB,(a2)
	clr.w      2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x12552:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AC,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12588:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AD,(a2)
	clr.w      2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x125b4:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	clr.w      (a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x125ea:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0001,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x12622:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0002,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x1265a:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0003,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x12692:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0004,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x126ca:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0005,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12702:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0006,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x1273a:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0007,(a2)+
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x12774:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0008,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x127ac:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0009,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x127e6:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$000A,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x1281e:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$000B,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12856:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AE,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$000C,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x1288e:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AF,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	clr.w      (a2)+
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x128c2:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AF,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0001,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x128f6:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AF,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0002,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x12928:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AF,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0003,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x1295a:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AF,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0003,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0004,(a2)+
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	move.l     8(a7),(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x12994:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AF,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0005,(a2)+
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x129ca:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AF,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0006,(a2)+
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x129fe:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00AF,(a2)
	move.w     #$0002,2(a2) ; $00015B78
	move.w     #$0003,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0007,(a2)+
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	move.l     8(a7),(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x12a38:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B4,(a2)
	move.w     #$0004,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     d0,(a2)+
	move.w     d1,(a2)+
	move.w     d2,(a2)+
	move.w     8(a7),(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	movea.l    $00015E12,a0
	movea.l    (a7)+,a2
	rts

x12a78:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B5,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12aae:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B6,(a2)
	move.w     #$0009,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	lea.l      $00015BB2,a2
	move.w     d0,(a2)+
	move.w     d1,(a2)+
	move.w     d2,(a2)+
	lea.l      8(a7),a0
	move.l     (a0)+,(a2)+
	move.l     (a0)+,(a2)+
	move.l     (a0)+,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12af2:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B7,(a2)
	move.w     #$0000,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12b20:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B8,(a2)
	move.w     #$0003,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0000,(a2)+
	move.l     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12b5a:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B8,(a2)
	move.w     #$0004,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0001,(a2)+
	move.l     d0,(a2)+
	move.w     d1,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	move.l     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12b96:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B8,(a2)
	move.w     #$0003,2(a2) ; $00015B78
	move.w     #$0004,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0002,(a2)+
	move.l     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	move.l     8(a7),(a2)+
	move.l     12(a7),(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12bda:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B8,(a2)
	move.w     #$0003,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0003,(a2)+
	move.l     d0,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,-(a7)
	bsr        $00012D2E
	movea.l    (a7)+,a1
	movea.l    8(a7),a2
	lea.l      $00015CBA,a0
	move.w     (a0)+,d0
	move.w     (a0)+,(a1)
	move.w     (a0)+,(a2)
	movea.l    (a7)+,a2
	rts

x12c22:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B9,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0000,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr        $00012D2E
	move.w     $00015CBA,d0
	movea.l    (a7)+,a2
	rts

x12c5c:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00B9,(a2)
	move.w     #$0001,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015BB2,a2
	move.w     #$0001,(a2)+
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	bsr        $00012D2E
	movea.l    (a7)+,a2
	rts

x12c8e:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00BA,(a2)
	move.w     #$0000,2(a2) ; $00015B78
	move.w     #$0002,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	move.l     a1,(a2)+
	bsr.w      $00012D2E
	lea.l      $00015CBA,a2
	move.w     (a2)+,d0
	lea.l      8(a7),a0
	movea.l    (a0)+,a1
	move.w     (a2)+,(a1)
	movea.l    (a0)+,a1
	move.w     (a2)+,(a1)
	movea.l    (a0)+,a1
	move.l     (a2)+,(a1)
	movea.l    (a0)+,a1
	move.l     (a2)+,(a1)
	movea.l    (a0)+,a1
	move.l     (a2)+,(a1)
	movea.l    (a7)+,a2
	rts

x12cd8:
	move.l     a2,-(a7)
	lea.l      $00015B76,a2
	move.w     #$00BB,(a2)
	move.w     #$0007,2(a2) ; $00015B78
	move.w     #$0001,6(a2) ; $00015B7C
	lea.l      $00015DD2,a2
	move.l     a0,(a2)+
	lea.l      $00015BB2,a2
	move.w     d0,(a2)+
	move.l     d1,(a2)+
	move.l     d2,(a2)+
	move.l     8(a7),(a2)+
	move.l     a1,-(a7)
	bsr.w      $00012D2E
	movea.l    (a7)+,a1
	lea.l      $00015CBA,a2
	move.w     (a2)+,d0
	move.w     (a2)+,(a1)
	lea.l      12(a7),a0
	movea.l    (a0)+,a1
	move.l     (a2)+,(a1)
	movea.l    (a0)+,a1
	move.l     (a2)+,(a1)
	movea.l    (a0)+,a1
	move.l     (a2)+,(a1)
	movea.l    (a7)+,a2
	rts

x12d2e:
	lea.l      $00014EF8,a0
	move.l     a0,d1
	move.w     #$00C8,d0
	trap       #2
	rts

x12d3e:
	movem.l    d3/a2-a4,-(a7)
	movea.l    a0,a3
	movea.l    a1,a4
	suba.l     a0,a0
	jsr        Super
	move.l     d0,d3
	movea.l    ($000005A0).w,a2
	movea.l    d3,a0
	jsr        Super
	move.l     a2,d0
	beq.s      x12d3e_1
x12d3e_5:
	moveq.l    #4,d0
	movea.l    a3,a1
	movea.l    a2,a0
	jsr        strncmp
	tst.w      d0
	bne.s      x12d3e_2
	move.l     a4,d0
	beq.s      x12d3e_3
	move.l     4(a2),(a4)
	moveq.l    #1,d0
	bra.s      x12d3e_4
x12d3e_2:
	addq.w     #8,a2
x12d3e_3:
	move.l     (a2),d0
	bne.s      x12d3e_5
x12d3e_1:
	clr.w      d0
x12d3e_4:
	movem.l    (a7)+,d3/a2-a4
	rts


	.data
[0001482c]                           dc.b '@(#)AV-Server 1.3 (Jan 29 1999), Copyright (c)1996-98 by A. Barton',0
[0001486f]                           dc.b 'AVSERVER',0
[00014878]                           dc.b $00
[00014879]                           dc.b $17
[0001487a]                           dc.w $2122
[0001487c]                           dc.w $dd24
[0001487e]                           dc.b '%&/()=?`^'
[00014887]                           dc.b $08
[00014888]                           dc.b $09,'QWERTZUIOP'
[00014893]                           dc.b $9a
[00014894]                           dc.w $2b0d -
[00014896]                           dc.b $00
[00014897]                           dc.b 'ASDFGHJKL'
[000148a0]                           dc.w $998e
[000148a2]                           dc.b $00
[000148a3]                           dc.b $00
[000148a4]                           dc.b '|YXCVBNM;:_',0
[000148b0]                           dc.b $00
[000148b1]                           dc.b $00
[000148b2]                           dc.w $2000
[000148b4]                           dc.b 'AVSERVER',0
[000148bd]                           dc.b 'AVSERVER',0
[000148c6]                           dc.b 'MAGXDESK',0
[000148cf]                           dc.b '[3][AV-Server: AV-Clients are|still active. Do you really|want to quit the AV-Server?][Cancel|Quit]',0
[00014933]                           dc.b 'U:\PIPE\DRAGDROP.AA',0
[00014947]                           dc.b '[3][AV-Server 1.3 (Jan 29 1999)|Copyright (c)1996-98 by Alex Barton,|all rights reserved. This program is|freeware. E-mail: <alex@barton.de>][ OK ]',0
[000149db]                           dc.b '        ',0
[000149e4]                           dc.b '%c:\',0
[000149e9]                           dc.b $2a
[000149ea]                           dc.b $00
[000149eb]                           dc.b '[3][AV-Server: Too many objects!][Cancel]',0
[00014a15]                           dc.b 'MGCOPY.APP',0
[00014a20]                           dc.b 'C:\GEMSYS\GEMDESK\MGCOPY.APP',0
[00014a3d]                           dc.b $20
[00014a3e]                           dc.b $00
[00014a3f]                           dc.b 'MGCOPY.APP',0
[00014a4a]                           dc.b 'C:\GEMSYS\GEMDESK\MGCOPY.APP',0
[00014a67]                           dc.b $20
[00014a68]                           dc.b $00
[00014a69]                           dc.b 'MGCOPY.APP',0
[00014a74]                           dc.b 'C:\GEMSYS\GEMDESK\MGCOPY.APP',0
[00014a91]                           dc.b 'ETCDIR',0
[00014a98]                           dc.b 'ETC',0
[00014a9c]                           dc.b '\AVSERVER.INF',0
[00014aaa]                           dc.w $5c00
[00014aac]                           dc.b 'AVSERVER.INF',0
[00014ab9]                           dc.b $72
[00014aba]                           dc.b $00
[00014abb]                           dc.b '.NEW',0
[00014ac0]                           dc.w $7700
[00014ac2]                           dc.w $2573
[00014ac4]                           dc.w $0125
[00014ac6]                           dc.w $730a
[00014ac8]                           dc.b $00
[00014ac9]                           dc.b '%s',$0a,0
[00014acd]                           dc.b '%s',$0a,0
[00014ad1]                           dc.b $25
[00014ad2]                           dc.w $7301
[00014ad4]                           dc.b '%s',$0a,0
[00014ad8]                           dc.b '.INF',0
[00014add]                           dc.b 'ETCDIR',0
[00014ae4]                           dc.b 'ETC',0
[00014ae8]                           dc.b '\AVSERVER.INF',0
[00014af6]                           dc.w $5c00
[00014af8]                           dc.b 'AVSERVER.INF',0
[00014b05]                           dc.b $72
[00014b06]                           dc.b $00
[00014b07]                           dc.b $20
[00014b08]                           dc.b $00
[00014b09]                           dc.b 'MGCOPY.APP',0
[00014b14]                           dc.b 'C:\GEMSYS\GEMDESK\MGCOPY.APP',0
[00014b31]                           dc.b 'MGCOPY.APP',0
[00014b3c]                           dc.b 'C:\GEMSYS\GEMDESK\MGCOPY.APP',0
[00014b59]                           dc.b 'ARGS',0
[00014b5e]                           dc.b $00
[00014b5f]                           dc.b $00
[00014b60]                           dc.b $00
[00014b61]                           dc.b $00
[00014b62]                           dc.b $00
[00014b63]                           dc.b $00
[00014b64]                           dc.b $00
[00014b65]                           dc.b $00
[00014b66]                           dc.b $00
[00014b67]                           dc.b $00
[00014b68]                           dc.b $00
[00014b69]                           dc.b $00
[00014b6a]                           dc.b $00
[00014b6b]                           dc.b $00
[00014b6c]                           dc.b $00
[00014b6d]                           dc.b $00
[00014b6e]                           dc.b $00
[00014b6f]                           dc.b $00
[00014b70]                           dc.b $00
[00014b71]                           dc.b $00
[00014b72]                           dc.b $00
[00014b73]                           dc.b $00
[00014b74]                           dc.b $00
[00014b75]                           dc.b $00
[00014b76]                           dc.b $00
[00014b77]                           dc.b $00
[00014b78]                           dc.b $00
[00014b79]                           dc.b $00
[00014b7a]                           dc.b $00
[00014b7b]                           dc.b $00
[00014b7c]                           dc.b $00
[00014b7d]                           dc.b $00
[00014b7e]                           dc.b 'ARGS',0
[00014b83]                           dc.b 'AmAN',0
[00014b88]                           dc.b '%c:\',0
[00014b8d]                           dc.b $00
[00014b8e]                           dc.b 'PAPIERKORB',0
[00014b99]                           dc.b 'DRUCKER',0
[00014ba1]                           dc.b 'U:\DEV\PRN',0
[00014bac]                           dc.b 'MAGX.INF',0
[00014bb5]                           dc.b $72
[00014bb6]                           dc.b $00
[00014bb7]                           dc.b '#_DIC ',0
[00014bbe]                           dc.b '#_DIC 6 @ ',0
[00014bc9]                           dc.b '#_DIC 7 @ ',0
[00014bd4]                           dc.b '#_DIC 8 @ ',0
[00014bdf]                           dc.b $00
[00014be0]                           dc.w $5c00
[00014be2]                           dc.b 'The quick brown fox jumps over the lazy dog.',0
[00014c0f]                           dc.b $20
[00014c10]                           dc.b $00
[00014c11]                           dc.b $ff
[00014c12]                           dc.b '-?cfq',0
[00014c18]                           dc.w $3100
[00014c1a]                           dc.w $2000
[00014c1c]                           dc.w $2000
[00014c1e]                           dc.w $2000
[00014c20]                           dc.b ' -1',0
[00014c24]                           dc.b '[3][AV-Server: VDI Scaler Error:|Character not defined!][Ignore]',0
[00014c65]                           dc.b '[3][AV-Server: VDI Scaler Error:|Can',$27,'t read font!][Ignore]',0
[00014ca0]                           dc.b '[3][AV-Server: VDI Scaler Error:|Can',$27,'t open font!][Ignore]',0
[00014cdb]                           dc.b '[3][AV-Server: VDI Scaler Error:|Invalid file format!][Ignore]',0
[00014d1a]                           dc.b '[3][AV-Server: VDI Scaler Error:|No more memory/cache free!][Ignore]',0
[00014d5f]                           dc.b '[3][AV-Server: VDI Scaler Error:|Error code %d!][Ignore]',0
[00014d98]                           dc.b '[3][AV-Server: Overflow!][Cancel]',0
[00014dba]                           dc.b '[3][AV-Server: Drag&Drop-Error!][Ignore]',0
[00014de3]                           dc.b '[3][AV-Server: Internal error!][Ignore]',0
[00014e0b]                           dc.b '[3][AV-Server: Can',$27,'t start|MG-Copy!][Cancel]',0
[00014e38]                           dc.b '[3][AV-Server: A-MAN not installed.|Can',$27,'t execute this function!][Cancel]',0
[00014e82]                           dc.b '[3][AV-Server: Can',$27,'t|read MAGX.INF!][Cancel]',0
[00014eaf]                           dc.b $00
[00014eb0]                           dc.b 'hAruNs cONfigER',0
[00014ec0] 00014eb0                  dc.l $00014eb0 ; no symbol found
[00014ec4]                           dc.b 'AV_STARTPROG: Convert filename to upper-case:',0
[00014ef2]                           dc.b $00
[00014ef3]                           dc.b $00
[00014ef4]                           dc.w $ffff
[00014ef6]                           dc.b $00
[00014ef7]                           dc.b $00
[00014ef8] 00015b76                  dc.l $00015b76 ; no symbol found
[00014efc] 00015b94                  dc.l $00015b94 ; no symbol found
[00014f00] 00015bb2                  dc.l $00015bb2 ; no symbol found
[00014f04] 00015cba                  dc.l $00015cba ; no symbol found
[00014f08] 00015dd2                  dc.l $00015dd2 ; no symbol found
[00014f0c] 00015e12                  dc.l $00015e12 ; no symbol found
[00014f10] 00015b76                  dc.l $00015b76 ; no symbol found
[00014f14] 00015b94                  dc.l $00015b94 ; no symbol found
[00014f18] 00015bb2                  dc.l $00015bb2 ; no symbol found
[00014f1c] 00015cba                  dc.l $00015cba ; no symbol found
[00014f20] 00015dd2                  dc.l $00015dd2 ; no symbol found
[00014f24] 00015e12                  dc.l $00015e12 ; no symbol found
[00014f28] 00015e52                  dc.l $00015e52 ; no symbol found
[00014f2c] 00015e70                  dc.l $00015e70 ; no symbol found
[00014f30] 00016090                  dc.l $00016090 ; no symbol found
[00014f34] 00015f78                  dc.l $00015f78 ; no symbol found
[00014f38] 000161b2                  dc.l $000161b2 ; no symbol found
[00014f3c] 00015e52                  dc.l $00015e52 ; no symbol found
[00014f40] 00015e70                  dc.l $00015e70 ; no symbol found
[00014f44] 00015f78                  dc.l $00015f78 ; no symbol found
[00014f48] 00016090                  dc.l $00016090 ; no symbol found
[00014f4c] 000161b2                  dc.l $000161b2 ; no symbol found
[00014f50]                           dc.b $00
[00014f51]                           dc.b $00
[00014f52]                           dc.b $00
[00014f53]                           dc.b $00
[00014f54]                           dc.b $00
[00014f55]                           dc.b $00
[00014f56]                           dc.b $00
[00014f57]                           dc.b $00
[00014f58]                           dc.b $00
[00014f59]                           dc.b $00
[00014f5a]                           dc.b $00
[00014f5b]                           dc.b $00
[00014f5c]                           dc.b $00
[00014f5d]                           dc.b $00
[00014f5e]                           dc.b $00
[00014f5f]                           dc.b $00
[00014f60]                           dc.b $00
[00014f61]                           dc.b $00
[00014f62]                           dc.b $00
[00014f63]                           dc.b $00
_fpumode:
[00014f64]                           dc.b $00
[00014f65]                           dc.b $00
[00014f66]                           dc.b $00
[00014f67]                           dc.b $00
[00014f68] 00014f7e                  dc.l $00014f7e ; no symbol found
[00014f6c] 00014f7e                  dc.l $00014f7e ; no symbol found
[00014f70] 00014f7e                  dc.l $00014f7e ; no symbol found
[00014f74] 00014fce                  dc.l $00014fce ; no symbol found
[00014f78]                           dc.b $00
[00014f79]                           dc.b $00
[00014f7a]                           dc.w $0100
[00014f7c]                           dc.b $00
[00014f7d]                           dc.b $00
[00014f7e]                           dc.b $00
[00014f7f]                           dc.b $00
[00014f80]                           dc.b $00
[00014f81]                           dc.b $00
[00014f82]                           dc.b $00
[00014f83]                           dc.b $00
[00014f84]                           dc.b $00
[00014f85]                           dc.b $00
[00014f86]                           dc.b $00
[00014f87]                           dc.b $00
[00014f88]                           dc.b $00
[00014f89]                           dc.b $00
[00014f8a]                           dc.b $00
[00014f8b]                           dc.b $00
[00014f8c]                           dc.b $00
[00014f8d]                           dc.b $00
[00014f8e]                           dc.b $00
[00014f8f]                           dc.b $00
[00014f90]                           dc.b $00
[00014f91]                           dc.b $00
[00014f92]                           dc.b $00
[00014f93]                           dc.b $00
[00014f94]                           dc.b $00
[00014f95]                           dc.b $00
[00014f96]                           dc.b $00
[00014f97]                           dc.b $00
[00014f98]                           dc.b $00
[00014f99]                           dc.b $00
[00014f9a]                           dc.b $00
[00014f9b]                           dc.b $00
[00014f9c]                           dc.b $00
[00014f9d]                           dc.b $00
[00014f9e]                           dc.b $00
[00014f9f]                           dc.b $00
[00014fa0]                           dc.b $00
[00014fa1]                           dc.b $00
[00014fa2]                           dc.b $00
[00014fa3]                           dc.b $00
[00014fa4]                           dc.b $00
[00014fa5]                           dc.b $00
[00014fa6]                           dc.b $00
[00014fa7]                           dc.b $00
[00014fa8]                           dc.b $00
[00014fa9]                           dc.b $00
[00014faa]                           dc.b $00
[00014fab]                           dc.b $00
[00014fac]                           dc.b $00
[00014fad]                           dc.b $00
[00014fae]                           dc.b $00
[00014faf]                           dc.b $00
[00014fb0]                           dc.b $00
[00014fb1]                           dc.b $00
[00014fb2]                           dc.b $00
[00014fb3]                           dc.b $00
[00014fb4]                           dc.b $00
[00014fb5]                           dc.b $00
[00014fb6]                           dc.b $00
[00014fb7]                           dc.b $00
[00014fb8]                           dc.b $00
[00014fb9]                           dc.b $00
[00014fba]                           dc.b $00
[00014fbb]                           dc.b $00
[00014fbc]                           dc.b $00
[00014fbd]                           dc.b $00
[00014fbe]                           dc.b $00
[00014fbf]                           dc.b $00
[00014fc0]                           dc.b $00
[00014fc1]                           dc.b $00
[00014fc2]                           dc.b $00
[00014fc3]                           dc.b $00
[00014fc4]                           dc.b $00
[00014fc5]                           dc.b $00
[00014fc6]                           dc.b $00
[00014fc7]                           dc.b $00
[00014fc8]                           dc.b $00
[00014fc9]                           dc.b $00
[00014fca]                           dc.b $00
[00014fcb]                           dc.b $00
[00014fcc]                           dc.b $00
[00014fcd]                           dc.b $00
[00014fce]                           dc.b $00
[00014fcf]                           dc.b $00
[00014fd0]                           dc.b $00
[00014fd1]                           dc.b $00
[00014fd2]                           dc.b $00
[00014fd3]                           dc.b $00
[00014fd4]                           dc.b $00
[00014fd5]                           dc.b $00
[00014fd6]                           dc.b $00
[00014fd7]                           dc.b $00
[00014fd8]                           dc.b $00
[00014fd9]                           dc.b $00
[00014fda]                           dc.b $00
[00014fdb]                           dc.b $00
[00014fdc]                           dc.b $00
[00014fdd]                           dc.b $00
[00014fde]                           dc.b $00
[00014fdf]                           dc.b $01
[00014fe0]                           dc.w $0600
[00014fe2]                           dc.b $00
[00014fe3]                           dc.b $00
[00014fe4]                           dc.b $00
[00014fe5]                           dc.b $00
[00014fe6]                           dc.b $00
[00014fe7]                           dc.b $00
[00014fe8]                           dc.b $00
[00014fe9]                           dc.b $00
[00014fea]                           dc.b $00
[00014feb]                           dc.b $00
[00014fec]                           dc.b $00
[00014fed]                           dc.b $00
[00014fee]                           dc.b $00
[00014fef]                           dc.b $00
[00014ff0]                           dc.b $00
[00014ff1]                           dc.b $00
[00014ff2]                           dc.b $00
[00014ff3]                           dc.b $00
[00014ff4]                           dc.w $ffff
[00014ff6]                           dc.w $0600
[00014ff8]                           dc.b $00
[00014ff9]                           dc.b $00
[00014ffa]                           dc.b $00
[00014ffb]                           dc.b $00
[00014ffc]                           dc.b $00
[00014ffd]                           dc.b $00
[00014ffe]                           dc.b $00
[00014fff]                           dc.b $00
[00015000]                           dc.b $00
[00015001]                           dc.b $00
[00015002]                           dc.b $00
[00015003]                           dc.b $00
[00015004]                           dc.b $00
[00015005]                           dc.b $00
[00015006]                           dc.b $00
[00015007]                           dc.b $00
[00015008]                           dc.b $00
[00015009]                           dc.b $00
[0001500a]                           dc.b $00
[0001500b]                           dc.b $02
[0001500c]                           dc.w $0700
[0001500e]                           dc.b $00
[0001500f]                           dc.b $00
[00015010]                           dc.b $00
[00015011]                           dc.b $00
[00015012]                           dc.b $00
[00015013]                           dc.b $00
[00015014]                           dc.b $00
[00015015]                           dc.b $00
[00015016]                           dc.b $00
[00015017]                           dc.b $00
[00015018]                           dc.b $00
[00015019]                           dc.b $00
[0001501a]                           dc.b $00
[0001501b]                           dc.b $00
[0001501c]                           dc.b $00
[0001501d]                           dc.b $00
[0001501e]                           dc.b $00
[0001501f]                           dc.b $00
[00015020]                           dc.b $00
[00015021]                           dc.b $03
[00015022]                           dc.w $0600
[00015024]                           dc.b $00
[00015025]                           dc.b $00
[00015026]                           dc.b $00
[00015027]                           dc.b $00
[00015028]                           dc.b $00
[00015029]                           dc.b $00
[0001502a]                           dc.b $00
[0001502b]                           dc.b $00
[0001502c]                           dc.b $00
[0001502d]                           dc.b $00
[0001502e]                           dc.b $00
[0001502f]                           dc.b $00
[00015030]                           dc.b $00
[00015031]                           dc.b $00
[00015032]                           dc.b $00
[00015033]                           dc.b $00
;


15064-15066: apid
15066-15068: magxdesk
15068-1506A:
1506A-1506C: av_protokoll3
1506C-1506E: av_protokoll4
150e0-154e0: startprog_path
154e0-158e0: startprog_name
158E0-158E4:
158e4-15aa4: clients
15aa4-15b24: windows
15b24-15b5c: programs
15b5c-15b6e: avserver_info
15b6e-15b70: sp_offset
