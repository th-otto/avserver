	.text

get_cookie:
	movem.l    d3/a2-a4,-(a7)
	movea.l    a0,a3
	movea.l    a1,a4
	suba.l     a0,a0
	jsr        Super
	move.l     d0,d3
	movea.l    (0x000005A0).w,a2
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
15068-1506A: ap_dragdrop_id
1506A-1506C: av_protokoll3
1506C-1506E: av_protokoll4
1506e-150e0: workout
150e0-154e0: startprog_path
154e0-158e0: startprog_name
158E0-158E4: dd_data
158e4-15aa4: clients
15aa4-15b24: windows
15b24-15b5c: programs
15b5c-15b6e: avserver_info
15b6e-15b70: sp_offset
15b72:
