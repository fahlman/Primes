	.build_version macos, 26, 0	sdk_version 26, 5
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	_$s10PrimeSwift0A5SieveC5limitACSi_tcfc ; -- Begin function $s10PrimeSwift0A5SieveC5limitACSi_tcfc
	.globl	_$s10PrimeSwift0A5SieveC5limitACSi_tcfc
	.p2align	2
_$s10PrimeSwift0A5SieveC5limitACSi_tcfc: ; @"$s10PrimeSwift0A5SieveC5limitACSi_tcfc"
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sub	x8, x0, #1
	lsr	x8, x8, #1
	cmp	x0, #2
	csel	x8, x8, xzr, gt
	stp	x0, x8, [x20, #16]
	add	x9, x8, #7
	lsr	x9, x9, #3
	str	x9, [x20, #32]
	cmp	x8, #0
	csinc	x0, x9, xzr, ne
	mov	x1, #-1                         ; =0xffffffffffffffff
	bl	_swift_slowAlloc
	str	x0, [x20, #40]
	ldr	x1, [x20, #32]
	tbnz	x1, #63, LBB0_4
; %bb.1:
	cbz	x1, LBB0_3
; %bb.2:
	bl	_bzero
LBB0_3:
	mov	x0, x20
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB0_4:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10PrimeSwift0A5SieveCfD ; -- Begin function $s10PrimeSwift0A5SieveCfD
	.globl	_$s10PrimeSwift0A5SieveCfD
	.p2align	2
_$s10PrimeSwift0A5SieveCfD:             ; @"$s10PrimeSwift0A5SieveCfD"
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	x0, [x20, #40]
	mov	x1, #-1                         ; =0xffffffffffffffff
	mov	x2, #-1                         ; =0xffffffffffffffff
	bl	_swift_slowDealloc
	mov	x0, x20
	mov	w1, #48                         ; =0x30
	mov	w2, #7                          ; =0x7
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_swift_deallocClassInstance
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function $s10PrimeSwift0A5SieveC03runC0yyF
lCPI2_0:
	.byte	0                               ; 0x0
	.byte	3                               ; 0x3
	.byte	6                               ; 0x6
	.byte	9                               ; 0x9
	.byte	12                              ; 0xc
	.byte	15                              ; 0xf
	.byte	18                              ; 0x12
	.byte	21                              ; 0x15
	.byte	24                              ; 0x18
	.byte	27                              ; 0x1b
	.byte	30                              ; 0x1e
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
lCPI2_1:
	.byte	0                               ; 0x0
	.byte	1                               ; 0x1
	.byte	2                               ; 0x2
	.byte	3                               ; 0x3
	.byte	4                               ; 0x4
	.byte	5                               ; 0x5
	.byte	6                               ; 0x6
	.byte	7                               ; 0x7
	.byte	8                               ; 0x8
	.byte	9                               ; 0x9
	.byte	10                              ; 0xa
	.byte	17                              ; 0x11
	.byte	20                              ; 0x14
	.byte	23                              ; 0x17
	.byte	26                              ; 0x1a
	.byte	29                              ; 0x1d
lCPI2_2:
	.byte	1                               ; 0x1
	.byte	4                               ; 0x4
	.byte	7                               ; 0x7
	.byte	10                              ; 0xa
	.byte	13                              ; 0xd
	.byte	16                              ; 0x10
	.byte	19                              ; 0x13
	.byte	22                              ; 0x16
	.byte	25                              ; 0x19
	.byte	28                              ; 0x1c
	.byte	31                              ; 0x1f
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
lCPI2_3:
	.byte	0                               ; 0x0
	.byte	1                               ; 0x1
	.byte	2                               ; 0x2
	.byte	3                               ; 0x3
	.byte	4                               ; 0x4
	.byte	5                               ; 0x5
	.byte	6                               ; 0x6
	.byte	7                               ; 0x7
	.byte	8                               ; 0x8
	.byte	9                               ; 0x9
	.byte	10                              ; 0xa
	.byte	18                              ; 0x12
	.byte	21                              ; 0x15
	.byte	24                              ; 0x18
	.byte	27                              ; 0x1b
	.byte	30                              ; 0x1e
lCPI2_4:
	.byte	2                               ; 0x2
	.byte	5                               ; 0x5
	.byte	8                               ; 0x8
	.byte	11                              ; 0xb
	.byte	14                              ; 0xe
	.byte	17                              ; 0x11
	.byte	20                              ; 0x14
	.byte	23                              ; 0x17
	.byte	26                              ; 0x1a
	.byte	29                              ; 0x1d
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
	.byte	255                             ; 0xff
lCPI2_5:
	.byte	0                               ; 0x0
	.byte	1                               ; 0x1
	.byte	2                               ; 0x2
	.byte	3                               ; 0x3
	.byte	4                               ; 0x4
	.byte	5                               ; 0x5
	.byte	6                               ; 0x6
	.byte	7                               ; 0x7
	.byte	8                               ; 0x8
	.byte	9                               ; 0x9
	.byte	16                              ; 0x10
	.byte	19                              ; 0x13
	.byte	22                              ; 0x16
	.byte	25                              ; 0x19
	.byte	28                              ; 0x1c
	.byte	31                              ; 0x1f
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	_$s10PrimeSwift0A5SieveC03runC0yyF
	.globl	_$s10PrimeSwift0A5SieveC03runC0yyF
	.p2align	2
_$s10PrimeSwift0A5SieveC03runC0yyF:     ; @"$s10PrimeSwift0A5SieveC03runC0yyF"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #288
	stp	x28, x27, [sp, #192]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #208]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #224]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #240]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #256]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #272]            ; 16-byte Folded Spill
	add	x29, sp, #272
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	ldp	x8, x21, [x20, #32]
	str	x8, [sp, #56]                   ; 8-byte Folded Spill
	lsl	x23, x8, #3
	ldr	x24, [x20, #16]
	mov	w19, #3                         ; =0x3
	mov	x22, #-9223372036854775808      ; =0x8000000000000000
	mov	w25, #146                       ; =0x92
	mov	w26, #36                        ; =0x24
	mov	w27, #1                         ; =0x1
	mov	w28, #73                        ; =0x49
Lloh0:
	adrp	x8, lCPI2_0@PAGE
Lloh1:
	ldr	q16, [x8, lCPI2_0@PAGEOFF]
Lloh2:
	adrp	x8, lCPI2_1@PAGE
Lloh3:
	ldr	q17, [x8, lCPI2_1@PAGEOFF]
Lloh4:
	adrp	x8, lCPI2_2@PAGE
Lloh5:
	ldr	q18, [x8, lCPI2_2@PAGEOFF]
Lloh6:
	adrp	x8, lCPI2_3@PAGE
Lloh7:
	ldr	q19, [x8, lCPI2_3@PAGEOFF]
	movi.16b	v20, #146
	movi.16b	v21, #73
Lloh8:
	adrp	x8, lCPI2_4@PAGE
Lloh9:
	ldr	q22, [x8, lCPI2_4@PAGEOFF]
Lloh10:
	adrp	x8, lCPI2_5@PAGE
Lloh11:
	ldr	q23, [x8, lCPI2_5@PAGEOFF]
	movi.16b	v24, #36
	sub	x1, x29, #112
	str	x20, [sp, #48]                  ; 8-byte Folded Spill
	stur	q16, [x29, #-128]               ; 16-byte Folded Spill
	stp	q18, q17, [sp, #112]            ; 32-byte Folded Spill
	stp	q22, q19, [sp, #80]             ; 32-byte Folded Spill
	str	q23, [sp, #64]                  ; 16-byte Folded Spill
	b	LBB2_3
LBB2_1:                                 ;   in Loop: Header=BB2_3 Depth=1
	adds	x19, x19, #2
	b.vs	LBB2_125
LBB2_2:                                 ;   in Loop: Header=BB2_3 Depth=1
	cbz	x19, LBB2_123
LBB2_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_97 Depth 2
                                        ;     Child Loop BB2_101 Depth 2
                                        ;     Child Loop BB2_43 Depth 2
                                        ;     Child Loop BB2_47 Depth 2
                                        ;     Child Loop BB2_63 Depth 2
                                        ;     Child Loop BB2_67 Depth 2
                                        ;     Child Loop BB2_80 Depth 2
                                        ;     Child Loop BB2_84 Depth 2
                                        ;     Child Loop BB2_21 Depth 2
                                        ;     Child Loop BB2_50 Depth 2
                                        ;     Child Loop BB2_106 Depth 2
                                        ;     Child Loop BB2_112 Depth 2
                                        ;     Child Loop BB2_115 Depth 2
                                        ;     Child Loop BB2_118 Depth 2
	cmp	x24, x22
	ccmn	x19, #1, #0, eq
	b.eq	LBB2_126
; %bb.4:                                ;   in Loop: Header=BB2_3 Depth=1
	sdiv	x8, x24, x19
	cmp	x8, x19
	b.lt	LBB2_120
; %bb.5:                                ;   in Loop: Header=BB2_3 Depth=1
	subs	x8, x19, #3
	b.vs	LBB2_122
; %bb.6:                                ;   in Loop: Header=BB2_3 Depth=1
	add	x8, x8, x8, lsr #63
	asr	x9, x8, #4
	ldrb	w9, [x21, x9]
	ubfx	w8, w8, #1, #3
	lsr	w8, w9, w8
	tbnz	w8, #0, LBB2_1
; %bb.7:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x19, #63
	b.gt	LBB2_19
; %bb.8:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x19, #3
	b.ne	LBB2_24
; %bb.9:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	x8, [x20, #24]
	cmp	x8, #4
	b.lt	LBB2_25
; %bb.10:                               ;   in Loop: Header=BB2_3 Depth=1
	ldr	x9, [x20, #40]
	ldrb	w10, [x9]
	orr	w11, w10, #0x8
	strb	w11, [x9]
	cmp	x8, #7
	b.lo	LBB2_25
; %bb.11:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	w11, #72                        ; =0x48
	orr	w10, w10, w11
	strb	w10, [x9]
	cmp	x8, #10
	b.lo	LBB2_25
; %bb.12:                               ;   in Loop: Header=BB2_3 Depth=1
	ldrb	w10, [x9, #1]
	orr	w11, w10, #0x2
	strb	w11, [x9, #1]
	cmp	x8, #13
	b.lo	LBB2_25
; %bb.13:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	w11, #18                        ; =0x12
	orr	w11, w10, w11
	strb	w11, [x9, #1]
	cmp	x8, #16
	b.lo	LBB2_25
; %bb.14:                               ;   in Loop: Header=BB2_3 Depth=1
	orr	w10, w10, w25
	strb	w10, [x9, #1]
	cmp	x8, #19
	b.lo	LBB2_25
; %bb.15:                               ;   in Loop: Header=BB2_3 Depth=1
	ldrb	w10, [x9, #2]
	orr	w11, w10, #0x4
	strb	w11, [x9, #2]
	cmp	x8, #22
	b.lo	LBB2_25
; %bb.16:                               ;   in Loop: Header=BB2_3 Depth=1
	orr	w10, w10, w26
	strb	w10, [x9, #2]
	cmp	x8, #25
	b.lo	LBB2_25
; %bb.17:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x8, #48
	b.hs	LBB2_109
; %bb.18:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	w10, #24                        ; =0x18
	b	LBB2_117
LBB2_19:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x19, #111
	b.hi	LBB2_26
; %bb.20:                               ;   in Loop: Header=BB2_3 Depth=1
	ldp	x10, x8, [x20, #32]
	lsl	x9, x10, #3
	mov	x11, #-3                        ; =0xfffffffffffffffd
	madd	x11, x19, x19, x11
	lsr	x11, x11, #1
LBB2_21:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	cmp	x11, x9
	b.ge	LBB2_108
; %bb.22:                               ;   in Loop: Header=BB2_21 Depth=2
	tst	x11, #0x7f
	b.eq	LBB2_48
; %bb.23:                               ;   in Loop: Header=BB2_21 Depth=2
	and	x12, x11, #0x7
	asr	x13, x11, #3
	ldrb	w14, [x8, x13]
	lsl	w12, w27, w12
	orr	w12, w14, w12
	strb	w12, [x8, x13]
	cmn	x11, x19
	add	x11, x11, x19
	b.vc	LBB2_21
	b	LBB2_121
LBB2_24:                                ;   in Loop: Header=BB2_3 Depth=1
	mov	x0, x19
	bl	_$s10PrimeSwift0A5SieveC22markWordDenseMultiples33_D113D18C9011F4014E4762B5A56EE2E5LL2ofySi_tF
	sub	x1, x29, #112
	movi.16b	v24, #36
	ldp	q23, q22, [sp, #64]             ; 32-byte Folded Reload
	movi.16b	v21, #73
	movi.16b	v20, #146
	ldp	q19, q18, [sp, #96]             ; 32-byte Folded Reload
	ldr	q17, [sp, #128]                 ; 16-byte Folded Reload
	ldur	q16, [x29, #-128]               ; 16-byte Folded Reload
LBB2_25:                                ;   in Loop: Header=BB2_3 Depth=1
	adds	x19, x19, #2
	b.vc	LBB2_2
	b	LBB2_127
LBB2_26:                                ;   in Loop: Header=BB2_3 Depth=1
	mul	x8, x19, x19
	smulh	x9, x19, x19
	cmp	x9, x8, asr #63
	b.ne	LBB2_128
; %bb.27:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x8, x8, #3
	b.vs	LBB2_129
; %bb.28:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x8, x8, x8, lsr #63
	asr	x9, x8, #1
	and	x12, x19, #0x7
	and	x8, x9, #0x7
	adds	x10, x8, x19
	cset	w11, vs
	cmp	x12, #5
	b.eq	LBB2_68
; %bb.29:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x12, #3
	b.eq	LBB2_51
; %bb.30:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x12, #1
	b.ne	LBB2_85
; %bb.31:                               ;   in Loop: Header=BB2_3 Depth=1
	tbnz	w11, #0, LBB2_134
; %bb.32:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x12, x19, #1
	adds	x13, x8, x12
	b.vs	LBB2_138
; %bb.33:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x11, x19, x19, lsl #1
	adds	x14, x8, x11
	b.vs	LBB2_143
; %bb.34:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x2, x8, x19, lsl #2
	b.vs	LBB2_146
; %bb.35:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x19, lsl #2
	adds	x3, x8, x15
	b.vs	LBB2_149
; %bb.36:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x4, x8, x11, lsl #1
	b.vs	LBB2_152
; %bb.37:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x11, x19, #3
	sub	x11, x11, x19
	mov	w15, #7                         ; =0x7
	smulh	x15, x19, x15
	cmp	x15, x11, asr #63
	b.ne	LBB2_156
; %bb.38:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x11, x8, x11
	b.vs	LBB2_161
; %bb.39:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x11, x11, #3
	ldr	x15, [sp, #56]                  ; 8-byte Folded Reload
	subs	x0, x15, x11
	b.vs	LBB2_166
; %bb.40:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x1, x0, x19
	b.vs	LBB2_168
; %bb.41:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x17, x10, #3
	asr	x16, x13, #3
	asr	x20, x14, #3
	asr	x15, x2, #3
	asr	x14, x3, #3
	asr	x13, x4, #3
	asr	x9, x9, #3
	cmp	x9, x1
	stp	x14, x13, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x15, [sp, #16]             ; 16-byte Folded Spill
	b.ge	LBB2_44
; %bb.42:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x2, x21, x19
	add	x10, x19, x17
	add	x3, x21, x10
	add	x10, x19, x16
	add	x4, x21, x10
	add	x10, x19, x20
	add	x5, x21, x10
	add	x10, x19, x15
	add	x6, x21, x10
	add	x10, x19, x14
	add	x7, x21, x10
	add	x10, x19, x13
	add	x30, x21, x10
	add	x10, x19, x11
	add	x28, x21, x10
	add	x22, x21, x11
	add	x26, x21, x13
	add	x25, x21, x14
	add	x10, x21, x15
	add	x20, x21, x20
	add	x13, x21, x16
	add	x14, x21, x17
LBB2_43:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w15, [x21, x9]
	orr	w15, w15, #0x80
	strb	w15, [x21, x9]
	ldrb	w15, [x14, x9]
	orr	w15, w15, #0x1
	strb	w15, [x14, x9]
	ldrb	w15, [x13, x9]
	orr	w15, w15, #0x2
	strb	w15, [x13, x9]
	ldrb	w15, [x20, x9]
	orr	w15, w15, #0x4
	strb	w15, [x20, x9]
	ldrb	w15, [x10, x9]
	orr	w15, w15, #0x8
	strb	w15, [x10, x9]
	ldrb	w15, [x25, x9]
	orr	w15, w15, #0x10
	strb	w15, [x25, x9]
	ldrb	w15, [x26, x9]
	orr	w15, w15, #0x20
	strb	w15, [x26, x9]
	ldrb	w15, [x22, x9]
	orr	w15, w15, #0x40
	strb	w15, [x22, x9]
	ldrb	w15, [x2, x9]
	orr	w15, w15, #0x80
	strb	w15, [x2, x9]
	ldrb	w15, [x3, x9]
	orr	w15, w15, #0x1
	strb	w15, [x3, x9]
	ldrb	w15, [x4, x9]
	orr	w15, w15, #0x2
	strb	w15, [x4, x9]
	ldrb	w15, [x5, x9]
	orr	w15, w15, #0x4
	strb	w15, [x5, x9]
	ldrb	w15, [x6, x9]
	orr	w15, w15, #0x8
	strb	w15, [x6, x9]
	ldrb	w15, [x7, x9]
	orr	w15, w15, #0x10
	strb	w15, [x7, x9]
	ldrb	w15, [x30, x9]
	orr	w15, w15, #0x20
	strb	w15, [x30, x9]
	ldrb	w15, [x28, x9]
	orr	w15, w15, #0x40
	strb	w15, [x28, x9]
	add	x9, x9, x12
	cmp	x9, x1
	b.lt	LBB2_43
LBB2_44:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x9, x0
	b.ge	LBB2_46
; %bb.45:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x10, x21, x9
	ldrb	w12, [x10]
	orr	w12, w12, #0x80
	strb	w12, [x10]
	ldrb	w12, [x10, x17]
	orr	w12, w12, #0x1
	strb	w12, [x10, x17]
	ldrb	w12, [x10, x16]
	orr	w12, w12, #0x2
	strb	w12, [x10, x16]
	ldp	x14, x13, [sp, #16]             ; 16-byte Folded Reload
	ldrb	w12, [x10, x14]
	orr	w12, w12, #0x4
	strb	w12, [x10, x14]
	ldrb	w12, [x10, x13]
	orr	w12, w12, #0x8
	strb	w12, [x10, x13]
	ldp	x14, x13, [sp, #32]             ; 16-byte Folded Reload
	ldrb	w12, [x10, x14]
	orr	w12, w12, #0x10
	strb	w12, [x10, x14]
	ldrb	w12, [x10, x13]
	orr	w12, w12, #0x20
	strb	w12, [x10, x13]
	ldrb	w12, [x10, x11]
	orr	w12, w12, #0x40
	strb	w12, [x10, x11]
	add	x9, x9, x19
LBB2_46:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	x20, [sp, #48]                  ; 8-byte Folded Reload
	mov	x22, #-9223372036854775808      ; =0x8000000000000000
	mov	w25, #146                       ; =0x92
	mov	w26, #36                        ; =0x24
	mov	w28, #73                        ; =0x49
	sub	x1, x29, #112
	orr	x8, x8, x9, lsl #3
	cmp	x8, x23
	b.ge	LBB2_1
LBB2_47:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x9, x8, #0x7
	asr	x10, x8, #3
	ldrb	w11, [x21, x10]
	lsl	w9, w27, w9
	orr	w9, w9, w11
	strb	w9, [x21, x10]
	add	x8, x8, x19
	cmp	x8, x23
	b.lt	LBB2_47
	b	LBB2_1
LBB2_48:                                ;   in Loop: Header=BB2_3 Depth=1
	asr	x15, x11, #7
	asr	x10, x10, #4
	mov	x11, #0                         ; =0x0
	subs	x12, x10, x15
	b.le	LBB2_102
; %bb.49:                               ;   in Loop: Header=BB2_3 Depth=1
	sub	x13, x19, #64
	orr	x14, x19, #0xffffffffffffff80
	add	x15, x8, x15, lsl #4
LBB2_50:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	q0, [x15]
	lsl	x16, x27, x11
	lsr	x17, x11, #3
	and	x17, x17, #0x8
	orr	x17, x1, x17
	stur	q0, [x29, #-112]
	ldr	x0, [x17]
	orr	x16, x0, x16
	str	x16, [x17]
	ldur	q0, [x29, #-112]
	add	x16, x13, x11
	lsl	x17, x27, x16
	cmp	x16, #63
	csel	x16, xzr, x17, gt
	mov.d	x17, v0[1]
	orr	x16, x17, x16
	mov.d	v0[1], x16
	str	q0, [x15], #16
	add	x11, x11, x14
	and	x16, x19, x11, asr #63
	add	x11, x16, x11
	subs	x12, x12, #1
	b.ne	LBB2_50
	b	LBB2_103
LBB2_51:                                ;   in Loop: Header=BB2_3 Depth=1
	tbnz	w11, #0, LBB2_133
; %bb.52:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x12, x19, #1
	adds	x13, x8, x12
	b.vs	LBB2_139
; %bb.53:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x11, x19, x19, lsl #1
	adds	x14, x8, x11
	b.vs	LBB2_141
; %bb.54:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x2, x8, x19, lsl #2
	b.vs	LBB2_145
; %bb.55:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x19, lsl #2
	adds	x3, x8, x15
	b.vs	LBB2_148
; %bb.56:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x4, x8, x11, lsl #1
	b.vs	LBB2_153
; %bb.57:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x11, x19, #3
	sub	x11, x11, x19
	mov	w15, #7                         ; =0x7
	smulh	x15, x19, x15
	cmp	x15, x11, asr #63
	b.ne	LBB2_158
; %bb.58:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x11, x8, x11
	b.vs	LBB2_163
; %bb.59:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x11, x11, #3
	ldr	x15, [sp, #56]                  ; 8-byte Folded Reload
	subs	x0, x15, x11
	b.vs	LBB2_165
; %bb.60:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x1, x0, x19
	b.vs	LBB2_169
; %bb.61:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x17, x10, #3
	asr	x16, x13, #3
	asr	x5, x14, #3
	asr	x15, x2, #3
	asr	x14, x3, #3
	asr	x13, x4, #3
	asr	x9, x9, #3
	cmp	x9, x1
	stp	x14, x13, [sp, #32]             ; 16-byte Folded Spill
	stp	x5, x15, [sp, #16]              ; 16-byte Folded Spill
	b.ge	LBB2_64
; %bb.62:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x2, x21, x19
	add	x10, x19, x17
	add	x3, x21, x10
	add	x10, x19, x16
	add	x4, x21, x10
	add	x10, x19, x5
	str	x17, [sp, #8]                   ; 8-byte Folded Spill
	mov	x17, x16
	mov	x16, x5
	add	x5, x21, x10
	add	x10, x19, x15
	add	x6, x21, x10
	add	x10, x19, x14
	add	x7, x21, x10
	add	x10, x19, x13
	add	x30, x21, x10
	add	x10, x19, x11
	add	x28, x21, x10
	add	x22, x21, x11
	add	x26, x21, x13
	add	x25, x21, x14
	add	x20, x21, x15
	add	x10, x21, x16
	mov	x16, x17
	ldr	x17, [sp, #8]                   ; 8-byte Folded Reload
	add	x13, x21, x16
	add	x14, x21, x17
LBB2_63:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w15, [x21, x9]
	orr	w15, w15, #0x8
	strb	w15, [x21, x9]
	ldrb	w15, [x14, x9]
	orr	w15, w15, #0x40
	strb	w15, [x14, x9]
	ldrb	w15, [x13, x9]
	orr	w15, w15, #0x2
	strb	w15, [x13, x9]
	ldrb	w15, [x10, x9]
	orr	w15, w15, #0x10
	strb	w15, [x10, x9]
	ldrb	w15, [x20, x9]
	orr	w15, w15, #0x80
	strb	w15, [x20, x9]
	ldrb	w15, [x25, x9]
	orr	w15, w15, #0x4
	strb	w15, [x25, x9]
	ldrb	w15, [x26, x9]
	orr	w15, w15, #0x20
	strb	w15, [x26, x9]
	ldrb	w15, [x22, x9]
	orr	w15, w15, #0x1
	strb	w15, [x22, x9]
	ldrb	w15, [x2, x9]
	orr	w15, w15, #0x8
	strb	w15, [x2, x9]
	ldrb	w15, [x3, x9]
	orr	w15, w15, #0x40
	strb	w15, [x3, x9]
	ldrb	w15, [x4, x9]
	orr	w15, w15, #0x2
	strb	w15, [x4, x9]
	ldrb	w15, [x5, x9]
	orr	w15, w15, #0x10
	strb	w15, [x5, x9]
	ldrb	w15, [x6, x9]
	orr	w15, w15, #0x80
	strb	w15, [x6, x9]
	ldrb	w15, [x7, x9]
	orr	w15, w15, #0x4
	strb	w15, [x7, x9]
	ldrb	w15, [x30, x9]
	orr	w15, w15, #0x20
	strb	w15, [x30, x9]
	ldrb	w15, [x28, x9]
	orr	w15, w15, #0x1
	strb	w15, [x28, x9]
	add	x9, x9, x12
	cmp	x9, x1
	b.lt	LBB2_63
LBB2_64:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x9, x0
	b.ge	LBB2_66
; %bb.65:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x10, x21, x9
	ldrb	w12, [x10]
	orr	w12, w12, #0x8
	strb	w12, [x10]
	ldrb	w12, [x10, x17]
	orr	w12, w12, #0x40
	strb	w12, [x10, x17]
	ldrb	w12, [x10, x16]
	orr	w12, w12, #0x2
	strb	w12, [x10, x16]
	ldp	x14, x13, [sp, #16]             ; 16-byte Folded Reload
	ldrb	w12, [x10, x14]
	orr	w12, w12, #0x10
	strb	w12, [x10, x14]
	ldrb	w12, [x10, x13]
	orr	w12, w12, #0x80
	strb	w12, [x10, x13]
	ldp	x14, x13, [sp, #32]             ; 16-byte Folded Reload
	ldrb	w12, [x10, x14]
	orr	w12, w12, #0x4
	strb	w12, [x10, x14]
	ldrb	w12, [x10, x13]
	orr	w12, w12, #0x20
	strb	w12, [x10, x13]
	ldrb	w12, [x10, x11]
	orr	w12, w12, #0x1
	strb	w12, [x10, x11]
	add	x9, x9, x19
LBB2_66:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	x20, [sp, #48]                  ; 8-byte Folded Reload
	mov	x22, #-9223372036854775808      ; =0x8000000000000000
	mov	w25, #146                       ; =0x92
	mov	w26, #36                        ; =0x24
	mov	w28, #73                        ; =0x49
	sub	x1, x29, #112
	orr	x8, x8, x9, lsl #3
	cmp	x8, x23
	b.ge	LBB2_1
LBB2_67:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x9, x8, #0x7
	asr	x10, x8, #3
	ldrb	w11, [x21, x10]
	lsl	w9, w27, w9
	orr	w9, w9, w11
	strb	w9, [x21, x10]
	add	x8, x8, x19
	cmp	x8, x23
	b.lt	LBB2_67
	b	LBB2_1
LBB2_68:                                ;   in Loop: Header=BB2_3 Depth=1
	tbnz	w11, #0, LBB2_135
; %bb.69:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x12, x19, #1
	adds	x13, x8, x12
	b.vs	LBB2_137
; %bb.70:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x11, x19, x19, lsl #1
	adds	x14, x8, x11
	b.vs	LBB2_142
; %bb.71:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x2, x8, x19, lsl #2
	b.vs	LBB2_144
; %bb.72:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x19, lsl #2
	adds	x3, x8, x15
	b.vs	LBB2_150
; %bb.73:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x4, x8, x11, lsl #1
	b.vs	LBB2_155
; %bb.74:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x11, x19, #3
	sub	x11, x11, x19
	mov	w15, #7                         ; =0x7
	smulh	x15, x19, x15
	cmp	x15, x11, asr #63
	b.ne	LBB2_159
; %bb.75:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x11, x8, x11
	b.vs	LBB2_162
; %bb.76:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x11, x11, #3
	ldr	x15, [sp, #56]                  ; 8-byte Folded Reload
	subs	x0, x15, x11
	b.vs	LBB2_167
; %bb.77:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x1, x0, x19
	b.vs	LBB2_170
; %bb.78:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x17, x10, #3
	asr	x16, x13, #3
	asr	x5, x14, #3
	asr	x15, x2, #3
	asr	x14, x3, #3
	asr	x13, x4, #3
	asr	x9, x9, #3
	cmp	x9, x1
	stp	x14, x13, [sp, #32]             ; 16-byte Folded Spill
	stp	x5, x15, [sp, #16]              ; 16-byte Folded Spill
	b.ge	LBB2_81
; %bb.79:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x2, x21, x19
	add	x10, x19, x17
	add	x3, x21, x10
	add	x10, x19, x16
	add	x4, x21, x10
	add	x10, x19, x5
	str	x17, [sp, #8]                   ; 8-byte Folded Spill
	mov	x17, x16
	mov	x16, x5
	add	x5, x21, x10
	add	x10, x19, x15
	add	x6, x21, x10
	add	x10, x19, x14
	add	x7, x21, x10
	add	x10, x19, x13
	add	x30, x21, x10
	add	x10, x19, x11
	add	x28, x21, x10
	add	x22, x21, x11
	add	x26, x21, x13
	add	x25, x21, x14
	add	x20, x21, x15
	add	x10, x21, x16
	mov	x16, x17
	ldr	x17, [sp, #8]                   ; 8-byte Folded Reload
	add	x13, x21, x16
	add	x14, x21, x17
LBB2_80:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w15, [x21, x9]
	orr	w15, w15, #0x8
	strb	w15, [x21, x9]
	ldrb	w15, [x14, x9]
	orr	w15, w15, #0x1
	strb	w15, [x14, x9]
	ldrb	w15, [x13, x9]
	orr	w15, w15, #0x20
	strb	w15, [x13, x9]
	ldrb	w15, [x10, x9]
	orr	w15, w15, #0x4
	strb	w15, [x10, x9]
	ldrb	w15, [x20, x9]
	orr	w15, w15, #0x80
	strb	w15, [x20, x9]
	ldrb	w15, [x25, x9]
	orr	w15, w15, #0x10
	strb	w15, [x25, x9]
	ldrb	w15, [x26, x9]
	orr	w15, w15, #0x2
	strb	w15, [x26, x9]
	ldrb	w15, [x22, x9]
	orr	w15, w15, #0x40
	strb	w15, [x22, x9]
	ldrb	w15, [x2, x9]
	orr	w15, w15, #0x8
	strb	w15, [x2, x9]
	ldrb	w15, [x3, x9]
	orr	w15, w15, #0x1
	strb	w15, [x3, x9]
	ldrb	w15, [x4, x9]
	orr	w15, w15, #0x20
	strb	w15, [x4, x9]
	ldrb	w15, [x5, x9]
	orr	w15, w15, #0x4
	strb	w15, [x5, x9]
	ldrb	w15, [x6, x9]
	orr	w15, w15, #0x80
	strb	w15, [x6, x9]
	ldrb	w15, [x7, x9]
	orr	w15, w15, #0x10
	strb	w15, [x7, x9]
	ldrb	w15, [x30, x9]
	orr	w15, w15, #0x2
	strb	w15, [x30, x9]
	ldrb	w15, [x28, x9]
	orr	w15, w15, #0x40
	strb	w15, [x28, x9]
	add	x9, x9, x12
	cmp	x9, x1
	b.lt	LBB2_80
LBB2_81:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x9, x0
	b.ge	LBB2_83
; %bb.82:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x10, x21, x9
	ldrb	w12, [x10]
	orr	w12, w12, #0x8
	strb	w12, [x10]
	ldrb	w12, [x10, x17]
	orr	w12, w12, #0x1
	strb	w12, [x10, x17]
	ldrb	w12, [x10, x16]
	orr	w12, w12, #0x20
	strb	w12, [x10, x16]
	ldp	x14, x13, [sp, #16]             ; 16-byte Folded Reload
	ldrb	w12, [x10, x14]
	orr	w12, w12, #0x4
	strb	w12, [x10, x14]
	ldrb	w12, [x10, x13]
	orr	w12, w12, #0x80
	strb	w12, [x10, x13]
	ldp	x14, x13, [sp, #32]             ; 16-byte Folded Reload
	ldrb	w12, [x10, x14]
	orr	w12, w12, #0x10
	strb	w12, [x10, x14]
	ldrb	w12, [x10, x13]
	orr	w12, w12, #0x2
	strb	w12, [x10, x13]
	ldrb	w12, [x10, x11]
	orr	w12, w12, #0x40
	strb	w12, [x10, x11]
	add	x9, x9, x19
LBB2_83:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	x20, [sp, #48]                  ; 8-byte Folded Reload
	mov	x22, #-9223372036854775808      ; =0x8000000000000000
	mov	w25, #146                       ; =0x92
	mov	w26, #36                        ; =0x24
	mov	w28, #73                        ; =0x49
	sub	x1, x29, #112
	orr	x8, x8, x9, lsl #3
	cmp	x8, x23
	b.ge	LBB2_1
LBB2_84:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x9, x8, #0x7
	asr	x10, x8, #3
	ldrb	w11, [x21, x10]
	lsl	w9, w27, w9
	orr	w9, w9, w11
	strb	w9, [x21, x10]
	add	x8, x8, x19
	cmp	x8, x23
	b.lt	LBB2_84
	b	LBB2_1
LBB2_85:                                ;   in Loop: Header=BB2_3 Depth=1
	tbnz	w11, #0, LBB2_132
; %bb.86:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x12, x19, #1
	adds	x13, x8, x12
	b.vs	LBB2_136
; %bb.87:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x11, x19, x19, lsl #1
	adds	x14, x8, x11
	b.vs	LBB2_140
; %bb.88:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x2, x8, x19, lsl #2
	b.vs	LBB2_147
; %bb.89:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x19, lsl #2
	adds	x3, x8, x15
	b.vs	LBB2_151
; %bb.90:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x4, x8, x11, lsl #1
	b.vs	LBB2_154
; %bb.91:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x11, x19, #3
	sub	x11, x11, x19
	mov	w15, #7                         ; =0x7
	smulh	x15, x19, x15
	cmp	x15, x11, asr #63
	b.ne	LBB2_157
; %bb.92:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x11, x8, x11
	b.vs	LBB2_160
; %bb.93:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x11, x11, #3
	ldr	x15, [sp, #56]                  ; 8-byte Folded Reload
	subs	x0, x15, x11
	b.vs	LBB2_164
; %bb.94:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x1, x0, x19
	b.vs	LBB2_171
; %bb.95:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x17, x10, #3
	asr	x16, x13, #3
	asr	x5, x14, #3
	asr	x15, x2, #3
	asr	x14, x3, #3
	asr	x13, x4, #3
	asr	x9, x9, #3
	cmp	x9, x1
	stp	x14, x13, [sp, #32]             ; 16-byte Folded Spill
	stp	x5, x15, [sp, #16]              ; 16-byte Folded Spill
	b.ge	LBB2_98
; %bb.96:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x2, x21, x19
	add	x10, x19, x17
	add	x3, x21, x10
	add	x10, x19, x16
	add	x4, x21, x10
	add	x10, x19, x5
	str	x17, [sp, #8]                   ; 8-byte Folded Spill
	mov	x17, x16
	mov	x16, x5
	add	x5, x21, x10
	add	x10, x19, x15
	add	x6, x21, x10
	add	x10, x19, x14
	add	x7, x21, x10
	add	x10, x19, x13
	add	x30, x21, x10
	add	x10, x19, x11
	add	x28, x21, x10
	add	x22, x21, x11
	add	x26, x21, x13
	add	x25, x21, x14
	add	x20, x21, x15
	add	x10, x21, x16
	mov	x16, x17
	ldr	x17, [sp, #8]                   ; 8-byte Folded Reload
	add	x13, x21, x16
	add	x14, x21, x17
LBB2_97:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w15, [x21, x9]
	orr	w15, w15, #0x80
	strb	w15, [x21, x9]
	ldrb	w15, [x14, x9]
	orr	w15, w15, #0x40
	strb	w15, [x14, x9]
	ldrb	w15, [x13, x9]
	orr	w15, w15, #0x20
	strb	w15, [x13, x9]
	ldrb	w15, [x10, x9]
	orr	w15, w15, #0x10
	strb	w15, [x10, x9]
	ldrb	w15, [x20, x9]
	orr	w15, w15, #0x8
	strb	w15, [x20, x9]
	ldrb	w15, [x25, x9]
	orr	w15, w15, #0x4
	strb	w15, [x25, x9]
	ldrb	w15, [x26, x9]
	orr	w15, w15, #0x2
	strb	w15, [x26, x9]
	ldrb	w15, [x22, x9]
	orr	w15, w15, #0x1
	strb	w15, [x22, x9]
	ldrb	w15, [x2, x9]
	orr	w15, w15, #0x80
	strb	w15, [x2, x9]
	ldrb	w15, [x3, x9]
	orr	w15, w15, #0x40
	strb	w15, [x3, x9]
	ldrb	w15, [x4, x9]
	orr	w15, w15, #0x20
	strb	w15, [x4, x9]
	ldrb	w15, [x5, x9]
	orr	w15, w15, #0x10
	strb	w15, [x5, x9]
	ldrb	w15, [x6, x9]
	orr	w15, w15, #0x8
	strb	w15, [x6, x9]
	ldrb	w15, [x7, x9]
	orr	w15, w15, #0x4
	strb	w15, [x7, x9]
	ldrb	w15, [x30, x9]
	orr	w15, w15, #0x2
	strb	w15, [x30, x9]
	ldrb	w15, [x28, x9]
	orr	w15, w15, #0x1
	strb	w15, [x28, x9]
	add	x9, x9, x12
	cmp	x9, x1
	b.lt	LBB2_97
LBB2_98:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x9, x0
	b.ge	LBB2_100
; %bb.99:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x10, x21, x9
	ldrb	w12, [x10]
	orr	w12, w12, #0x80
	strb	w12, [x10]
	ldrb	w12, [x10, x17]
	orr	w12, w12, #0x40
	strb	w12, [x10, x17]
	ldrb	w12, [x10, x16]
	orr	w12, w12, #0x20
	strb	w12, [x10, x16]
	ldp	x14, x13, [sp, #16]             ; 16-byte Folded Reload
	ldrb	w12, [x10, x14]
	orr	w12, w12, #0x10
	strb	w12, [x10, x14]
	ldrb	w12, [x10, x13]
	orr	w12, w12, #0x8
	strb	w12, [x10, x13]
	ldp	x14, x13, [sp, #32]             ; 16-byte Folded Reload
	ldrb	w12, [x10, x14]
	orr	w12, w12, #0x4
	strb	w12, [x10, x14]
	ldrb	w12, [x10, x13]
	orr	w12, w12, #0x2
	strb	w12, [x10, x13]
	ldrb	w12, [x10, x11]
	orr	w12, w12, #0x1
	strb	w12, [x10, x11]
	add	x9, x9, x19
LBB2_100:                               ;   in Loop: Header=BB2_3 Depth=1
	ldr	x20, [sp, #48]                  ; 8-byte Folded Reload
	mov	x22, #-9223372036854775808      ; =0x8000000000000000
	mov	w25, #146                       ; =0x92
	mov	w26, #36                        ; =0x24
	mov	w28, #73                        ; =0x49
	sub	x1, x29, #112
	orr	x8, x8, x9, lsl #3
	cmp	x8, x23
	b.ge	LBB2_1
LBB2_101:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x9, x8, #0x7
	asr	x10, x8, #3
	ldrb	w11, [x21, x10]
	lsl	w9, w27, w9
	orr	w9, w9, w11
	strb	w9, [x21, x10]
	add	x8, x8, x19
	cmp	x8, x23
	b.lt	LBB2_101
	b	LBB2_1
LBB2_102:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	x10, x15
LBB2_103:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	x12, #-72057594037927936        ; =0xff00000000000000
	add	x12, x10, x12
	lsr	x12, x12, #57
	cmp	x12, #127
	b.lo	LBB2_130
; %bb.104:                              ;   in Loop: Header=BB2_3 Depth=1
	adds	x10, x11, x10, lsl #7
	b.vs	LBB2_131
; %bb.105:                              ;   in Loop: Header=BB2_3 Depth=1
	cmp	x10, x9
	b.ge	LBB2_108
LBB2_106:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x10, #0x7
	lsl	w11, w27, w11
	asr	x12, x10, #3
	ldrb	w13, [x8, x12]
	orr	w11, w11, w13
	strb	w11, [x8, x12]
	adds	x11, x10, x19
	b.vs	LBB2_124
; %bb.107:                              ;   in Loop: Header=BB2_106 Depth=2
	add	x10, x10, x19
	cmp	x11, x9
	b.lt	LBB2_106
LBB2_108:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x19, x19, #2
	b	LBB2_2
LBB2_109:                               ;   in Loop: Header=BB2_3 Depth=1
	lsr	x11, x8, #3
	cmp	x11, #8
	mov	w10, #8                         ; =0x8
	csel	x10, x11, x10, gt
	cmp	x8, #71
	cset	w12, hi
	cinc	x13, x27, hi
	sub	x10, x10, x12
	sub	x10, x10, #8
	mov	x12, #-6148914691236517206      ; =0xaaaaaaaaaaaaaaaa
	movk	x12, #43691
	umulh	x10, x10, x12
	add	x12, x13, x10, lsr #1
	cmp	x12, #16
	b.hs	LBB2_111
; %bb.110:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	w10, #3                         ; =0x3
	b	LBB2_114
LBB2_111:                               ;   in Loop: Header=BB2_3 Depth=1
	and	x13, x12, #0x7ffffffffffffff0
	add	x10, x13, x13, lsl #1
	orr	x10, x10, #0x3
	add	x14, x9, #3
	mov	x15, x13
LBB2_112:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldp	q1, q3, [x14, #16]
	ldr	q0, [x14]
	tbl.16b	v2, { v0, v1 }, v16
	tbl.16b	v4, { v2, v3 }, v17
	tbl.16b	v2, { v0, v1 }, v18
	tbl.16b	v5, { v2, v3 }, v19
	orr.16b	v6, v5, v20
	orr.16b	v5, v4, v21
	tbl.16b	v2, { v0, v1 }, v22
	tbl.16b	v0, { v2, v3 }, v23
	orr.16b	v7, v0, v24
	st3.16b	{ v5, v6, v7 }, [x14], #48
	subs	x15, x15, #16
	b.ne	LBB2_112
; %bb.113:                              ;   in Loop: Header=BB2_3 Depth=1
	cmp	x12, x13
	b.eq	LBB2_116
LBB2_114:                               ;   in Loop: Header=BB2_3 Depth=1
	sub	x11, x11, #3
LBB2_115:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	x12, x9, x10
	ldrb	w13, [x12]
	orr	w13, w13, w28
	strb	w13, [x12]
	ldrb	w13, [x12, #1]
	orr	w13, w13, w25
	strb	w13, [x12, #1]
	ldrb	w13, [x12, #2]
	orr	w13, w13, w26
	strb	w13, [x12, #2]
	add	x10, x10, #3
	cmp	x11, x10
	b.ge	LBB2_115
LBB2_116:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x10, x10, #3
LBB2_117:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x10, x8
	b.hs	LBB2_25
LBB2_118:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x10, #0x7
	lsl	w11, w27, w11
	asr	x12, x10, #3
	ldrb	w13, [x9, x12]
	orr	w11, w11, w13
	strb	w11, [x9, x12]
	adds	x11, x10, #3
	b.vs	LBB2_172
; %bb.119:                              ;   in Loop: Header=BB2_118 Depth=2
	add	x10, x10, #3
	cmp	x11, x8
	b.lt	LBB2_118
	b	LBB2_25
LBB2_120:
	ldp	x29, x30, [sp, #272]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #256]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #240]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #224]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #208]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #192]            ; 16-byte Folded Reload
	add	sp, sp, #288
	ret
LBB2_121:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_122:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_123:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_124:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_125:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_126:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_127:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_128:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_129:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_130:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_131:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_132:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_133:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_134:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_135:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_136:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_137:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_138:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_139:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_140:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_141:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_142:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_143:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_144:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_145:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_146:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_147:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_148:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_149:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_150:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_151:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_152:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_153:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_154:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_155:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_156:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_157:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_158:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_159:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_160:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_161:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_162:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_163:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_164:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_165:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_166:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_167:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_168:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_169:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_170:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_171:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_172:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.loh AdrpLdr	Lloh10, Lloh11
	.loh AdrpAdrp	Lloh8, Lloh10
	.loh AdrpLdr	Lloh8, Lloh9
	.loh AdrpAdrp	Lloh6, Lloh8
	.loh AdrpLdr	Lloh6, Lloh7
	.loh AdrpAdrp	Lloh4, Lloh6
	.loh AdrpLdr	Lloh4, Lloh5
	.loh AdrpAdrp	Lloh2, Lloh4
	.loh AdrpLdr	Lloh2, Lloh3
	.loh AdrpAdrp	Lloh0, Lloh2
	.loh AdrpLdr	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function $s10PrimeSwift0A5SieveC22markWordDenseMultiples33_D113D18C9011F4014E4762B5A56EE2E5LL2ofySi_tF
lCPI3_0:
	.quad	-9223372036854775807            ; 0x8000000000000001
	.quad	4611686018427387904             ; 0x4000000000000000
lCPI3_1:
	.quad	2305843009213693952             ; 0x2000000000000000
	.quad	1152921504606846976             ; 0x1000000000000000
lCPI3_2:
	.quad	576460752303423488              ; 0x800000000000000
	.quad	288230376151711744              ; 0x400000000000000
lCPI3_3:
	.quad	144115188075855872              ; 0x200000000000000
	.quad	72057594037927936               ; 0x100000000000000
lCPI3_4:
	.quad	36028797018963968               ; 0x80000000000000
	.quad	18014398509481984               ; 0x40000000000000
lCPI3_5:
	.quad	9007199254740992                ; 0x20000000000000
	.quad	4503599627370496                ; 0x10000000000000
lCPI3_6:
	.quad	2251799813685248                ; 0x8000000000000
	.quad	1125899906842624                ; 0x4000000000000
lCPI3_7:
	.quad	562949953421312                 ; 0x2000000000000
	.quad	281474976710656                 ; 0x1000000000000
lCPI3_8:
	.quad	140737488355328                 ; 0x800000000000
	.quad	70368744177664                  ; 0x400000000000
lCPI3_9:
	.quad	35184372088832                  ; 0x200000000000
	.quad	17592186044416                  ; 0x100000000000
lCPI3_10:
	.quad	8796093022208                   ; 0x80000000000
	.quad	4398046511104                   ; 0x40000000000
lCPI3_11:
	.quad	2199023255552                   ; 0x20000000000
	.quad	1099511627776                   ; 0x10000000000
lCPI3_12:
	.quad	549755813888                    ; 0x8000000000
	.quad	274877906944                    ; 0x4000000000
lCPI3_13:
	.quad	137438953472                    ; 0x2000000000
	.quad	68719476736                     ; 0x1000000000
lCPI3_14:
	.quad	34359738368                     ; 0x800000000
	.quad	17179869184                     ; 0x400000000
lCPI3_15:
	.quad	8589934592                      ; 0x200000000
	.quad	4294967296                      ; 0x100000000
lCPI3_16:
	.quad	2147483648                      ; 0x80000000
	.quad	1073741824                      ; 0x40000000
lCPI3_17:
	.quad	536870912                       ; 0x20000000
	.quad	268435456                       ; 0x10000000
lCPI3_18:
	.quad	134217728                       ; 0x8000000
	.quad	67108864                        ; 0x4000000
lCPI3_19:
	.quad	33554432                        ; 0x2000000
	.quad	16777216                        ; 0x1000000
lCPI3_20:
	.quad	8388608                         ; 0x800000
	.quad	4194304                         ; 0x400000
lCPI3_21:
	.quad	2097152                         ; 0x200000
	.quad	1048576                         ; 0x100000
lCPI3_22:
	.quad	524288                          ; 0x80000
	.quad	262144                          ; 0x40000
lCPI3_23:
	.quad	131072                          ; 0x20000
	.quad	65536                           ; 0x10000
lCPI3_24:
	.quad	32768                           ; 0x8000
	.quad	16384                           ; 0x4000
lCPI3_25:
	.quad	8192                            ; 0x2000
	.quad	4096                            ; 0x1000
lCPI3_26:
	.quad	2048                            ; 0x800
	.quad	1024                            ; 0x400
lCPI3_27:
	.quad	512                             ; 0x200
	.quad	256                             ; 0x100
lCPI3_28:
	.quad	128                             ; 0x80
	.quad	64                              ; 0x40
lCPI3_29:
	.quad	32                              ; 0x20
	.quad	16                              ; 0x10
lCPI3_30:
	.quad	8                               ; 0x8
	.quad	4                               ; 0x4
lCPI3_31:
	.quad	2305843009213693953             ; 0x2000000000000001
	.quad	288230376151711744              ; 0x400000000000000
lCPI3_32:
	.quad	36028797018963968               ; 0x80000000000000
	.quad	4503599627370496                ; 0x10000000000000
lCPI3_33:
	.quad	562949953421312                 ; 0x2000000000000
	.quad	70368744177664                  ; 0x400000000000
lCPI3_34:
	.quad	8796093022208                   ; 0x80000000000
	.quad	1099511627776                   ; 0x10000000000
lCPI3_35:
	.quad	137438953472                    ; 0x2000000000
	.quad	17179869184                     ; 0x400000000
lCPI3_36:
	.quad	2147483648                      ; 0x80000000
	.quad	268435456                       ; 0x10000000
lCPI3_37:
	.quad	33554432                        ; 0x2000000
	.quad	4194304                         ; 0x400000
lCPI3_38:
	.quad	524288                          ; 0x80000
	.quad	65536                           ; 0x10000
lCPI3_39:
	.quad	8192                            ; 0x2000
	.quad	1024                            ; 0x400
lCPI3_40:
	.quad	128                             ; 0x80
	.quad	16                              ; 0x10
lCPI3_41:
	.quad	4611686018427387906             ; 0x4000000000000002
	.quad	576460752303423488              ; 0x800000000000000
lCPI3_42:
	.quad	72057594037927936               ; 0x100000000000000
	.quad	9007199254740992                ; 0x20000000000000
lCPI3_43:
	.quad	1125899906842624                ; 0x4000000000000
	.quad	140737488355328                 ; 0x800000000000
lCPI3_44:
	.quad	17592186044416                  ; 0x100000000000
	.quad	2199023255552                   ; 0x20000000000
lCPI3_45:
	.quad	274877906944                    ; 0x4000000000
	.quad	34359738368                     ; 0x800000000
lCPI3_46:
	.quad	4294967296                      ; 0x100000000
	.quad	536870912                       ; 0x20000000
lCPI3_47:
	.quad	67108864                        ; 0x4000000
	.quad	8388608                         ; 0x800000
lCPI3_48:
	.quad	1048576                         ; 0x100000
	.quad	131072                          ; 0x20000
lCPI3_49:
	.quad	16384                           ; 0x4000
	.quad	2048                            ; 0x800
lCPI3_50:
	.quad	256                             ; 0x100
	.quad	32                              ; 0x20
lCPI3_51:
	.quad	-9223372036854775804            ; 0x8000000000000004
	.quad	1152921504606846976             ; 0x1000000000000000
lCPI3_52:
	.quad	144115188075855872              ; 0x200000000000000
	.quad	18014398509481984               ; 0x40000000000000
lCPI3_53:
	.quad	2251799813685248                ; 0x8000000000000
	.quad	281474976710656                 ; 0x1000000000000
lCPI3_54:
	.quad	35184372088832                  ; 0x200000000000
	.quad	4398046511104                   ; 0x40000000000
lCPI3_55:
	.quad	549755813888                    ; 0x8000000000
	.quad	68719476736                     ; 0x1000000000
lCPI3_56:
	.quad	8589934592                      ; 0x200000000
	.quad	1073741824                      ; 0x40000000
lCPI3_57:
	.quad	134217728                       ; 0x8000000
	.quad	16777216                        ; 0x1000000
lCPI3_58:
	.quad	2097152                         ; 0x200000
	.quad	262144                          ; 0x40000
lCPI3_59:
	.quad	32768                           ; 0x8000
	.quad	4096                            ; 0x1000
lCPI3_60:
	.quad	512                             ; 0x200
	.quad	64                              ; 0x40
lCPI3_61:
	.quad	576460752303423489              ; 0x800000000000001
	.quad	18014398509481984               ; 0x40000000000000
lCPI3_62:
	.quad	562949953421312                 ; 0x2000000000000
	.quad	17592186044416                  ; 0x100000000000
lCPI3_63:
	.quad	549755813888                    ; 0x8000000000
	.quad	17179869184                     ; 0x400000000
lCPI3_64:
	.quad	536870912                       ; 0x20000000
	.quad	16777216                        ; 0x1000000
lCPI3_65:
	.quad	524288                          ; 0x80000
	.quad	16384                           ; 0x4000
lCPI3_66:
	.quad	512                             ; 0x200
	.quad	-9223372036854775792            ; 0x8000000000000010
lCPI3_67:
	.quad	288230376151711744              ; 0x400000000000000
	.quad	9007199254740992                ; 0x20000000000000
lCPI3_68:
	.quad	281474976710656                 ; 0x1000000000000
	.quad	8796093022208                   ; 0x80000000000
lCPI3_69:
	.quad	274877906944                    ; 0x4000000000
	.quad	8589934592                      ; 0x200000000
lCPI3_70:
	.quad	268435456                       ; 0x10000000
	.quad	8388608                         ; 0x800000
lCPI3_71:
	.quad	262144                          ; 0x40000
	.quad	8192                            ; 0x2000
lCPI3_72:
	.quad	256                             ; 0x100
	.quad	4611686018427387912             ; 0x4000000000000008
lCPI3_73:
	.quad	144115188075855872              ; 0x200000000000000
	.quad	4503599627370496                ; 0x10000000000000
lCPI3_74:
	.quad	140737488355328                 ; 0x800000000000
	.quad	4398046511104                   ; 0x40000000000
lCPI3_75:
	.quad	137438953472                    ; 0x2000000000
	.quad	4294967296                      ; 0x100000000
lCPI3_76:
	.quad	134217728                       ; 0x8000000
	.quad	4194304                         ; 0x400000
lCPI3_77:
	.quad	131072                          ; 0x20000
	.quad	4096                            ; 0x1000
lCPI3_78:
	.quad	128                             ; 0x80
	.quad	2305843009213693956             ; 0x2000000000000004
lCPI3_79:
	.quad	72057594037927936               ; 0x100000000000000
	.quad	2251799813685248                ; 0x8000000000000
lCPI3_80:
	.quad	70368744177664                  ; 0x400000000000
	.quad	2199023255552                   ; 0x20000000000
lCPI3_81:
	.quad	68719476736                     ; 0x1000000000
	.quad	2147483648                      ; 0x80000000
lCPI3_82:
	.quad	67108864                        ; 0x4000000
	.quad	2097152                         ; 0x200000
lCPI3_83:
	.quad	65536                           ; 0x10000
	.quad	2048                            ; 0x800
lCPI3_84:
	.quad	64                              ; 0x40
	.quad	1152921504606846978             ; 0x1000000000000002
lCPI3_85:
	.quad	36028797018963968               ; 0x80000000000000
	.quad	1125899906842624                ; 0x4000000000000
lCPI3_86:
	.quad	35184372088832                  ; 0x200000000000
	.quad	1099511627776                   ; 0x10000000000
lCPI3_87:
	.quad	34359738368                     ; 0x800000000
	.quad	1073741824                      ; 0x40000000
lCPI3_88:
	.quad	33554432                        ; 0x2000000
	.quad	1048576                         ; 0x100000
lCPI3_89:
	.quad	32768                           ; 0x8000
	.quad	1024                            ; 0x400
lCPI3_90:
	.quad	144115188075855873              ; 0x200000000000001
	.quad	1125899906842624                ; 0x4000000000000
lCPI3_91:
	.quad	8796093022208                   ; 0x80000000000
	.quad	68719476736                     ; 0x1000000000
lCPI3_92:
	.quad	536870912                       ; 0x20000000
	.quad	4194304                         ; 0x400000
lCPI3_93:
	.quad	32768                           ; 0x8000
	.quad	256                             ; 0x100
lCPI3_94:
	.quad	288230376151711746              ; 0x400000000000002
	.quad	2251799813685248                ; 0x8000000000000
lCPI3_95:
	.quad	17592186044416                  ; 0x100000000000
	.quad	137438953472                    ; 0x2000000000
lCPI3_96:
	.quad	1073741824                      ; 0x40000000
	.quad	8388608                         ; 0x800000
lCPI3_97:
	.quad	65536                           ; 0x10000
	.quad	512                             ; 0x200
lCPI3_98:
	.quad	576460752303423492              ; 0x800000000000004
	.quad	4503599627370496                ; 0x10000000000000
lCPI3_99:
	.quad	35184372088832                  ; 0x200000000000
	.quad	274877906944                    ; 0x4000000000
lCPI3_100:
	.quad	2147483648                      ; 0x80000000
	.quad	16777216                        ; 0x1000000
lCPI3_101:
	.quad	131072                          ; 0x20000
	.quad	1024                            ; 0x400
lCPI3_102:
	.quad	1152921504606846984             ; 0x1000000000000008
	.quad	9007199254740992                ; 0x20000000000000
lCPI3_103:
	.quad	70368744177664                  ; 0x400000000000
	.quad	549755813888                    ; 0x8000000000
lCPI3_104:
	.quad	4294967296                      ; 0x100000000
	.quad	33554432                        ; 0x2000000
lCPI3_105:
	.quad	262144                          ; 0x40000
	.quad	2048                            ; 0x800
lCPI3_106:
	.quad	2305843009213693968             ; 0x2000000000000010
	.quad	18014398509481984               ; 0x40000000000000
lCPI3_107:
	.quad	140737488355328                 ; 0x800000000000
	.quad	1099511627776                   ; 0x10000000000
lCPI3_108:
	.quad	8589934592                      ; 0x200000000
	.quad	67108864                        ; 0x4000000
lCPI3_109:
	.quad	524288                          ; 0x80000
	.quad	4096                            ; 0x1000
lCPI3_110:
	.quad	4611686018427387936             ; 0x4000000000000020
	.quad	36028797018963968               ; 0x80000000000000
lCPI3_111:
	.quad	281474976710656                 ; 0x1000000000000
	.quad	2199023255552                   ; 0x20000000000
lCPI3_112:
	.quad	17179869184                     ; 0x400000000
	.quad	134217728                       ; 0x8000000
lCPI3_113:
	.quad	1048576                         ; 0x100000
	.quad	8192                            ; 0x2000
lCPI3_114:
	.quad	-9223372036854775744            ; 0x8000000000000040
	.quad	72057594037927936               ; 0x100000000000000
lCPI3_115:
	.quad	562949953421312                 ; 0x2000000000000
	.quad	4398046511104                   ; 0x40000000000
lCPI3_116:
	.quad	34359738368                     ; 0x800000000
	.quad	268435456                       ; 0x10000000
lCPI3_117:
	.quad	2097152                         ; 0x200000
	.quad	16384                           ; 0x4000
lCPI3_118:
	.quad	36028797018963969               ; 0x80000000000001
	.quad	70368744177664                  ; 0x400000000000
lCPI3_119:
	.quad	137438953472                    ; 0x2000000000
	.quad	268435456                       ; 0x10000000
lCPI3_120:
	.quad	524288                          ; 0x80000
	.quad	1024                            ; 0x400
lCPI3_121:
	.quad	72057594037927938               ; 0x100000000000002
	.quad	140737488355328                 ; 0x800000000000
lCPI3_122:
	.quad	274877906944                    ; 0x4000000000
	.quad	536870912                       ; 0x20000000
lCPI3_123:
	.quad	1048576                         ; 0x100000
	.quad	2048                            ; 0x800
lCPI3_124:
	.quad	144115188075855876              ; 0x200000000000004
	.quad	281474976710656                 ; 0x1000000000000
lCPI3_125:
	.quad	549755813888                    ; 0x8000000000
	.quad	1073741824                      ; 0x40000000
lCPI3_126:
	.quad	2097152                         ; 0x200000
	.quad	4096                            ; 0x1000
lCPI3_127:
	.quad	288230376151711752              ; 0x400000000000008
	.quad	562949953421312                 ; 0x2000000000000
lCPI3_128:
	.quad	1099511627776                   ; 0x10000000000
	.quad	2147483648                      ; 0x80000000
lCPI3_129:
	.quad	4194304                         ; 0x400000
	.quad	8192                            ; 0x2000
lCPI3_130:
	.quad	576460752303423504              ; 0x800000000000010
	.quad	1125899906842624                ; 0x4000000000000
lCPI3_131:
	.quad	2199023255552                   ; 0x20000000000
	.quad	4294967296                      ; 0x100000000
lCPI3_132:
	.quad	8388608                         ; 0x800000
	.quad	16384                           ; 0x4000
lCPI3_133:
	.quad	1152921504606847008             ; 0x1000000000000020
	.quad	2251799813685248                ; 0x8000000000000
lCPI3_134:
	.quad	4398046511104                   ; 0x40000000000
	.quad	8589934592                      ; 0x200000000
lCPI3_135:
	.quad	16777216                        ; 0x1000000
	.quad	32768                           ; 0x8000
lCPI3_136:
	.quad	2305843009213694016             ; 0x2000000000000040
	.quad	4503599627370496                ; 0x10000000000000
lCPI3_137:
	.quad	8796093022208                   ; 0x80000000000
	.quad	17179869184                     ; 0x400000000
lCPI3_138:
	.quad	33554432                        ; 0x2000000
	.quad	65536                           ; 0x10000
lCPI3_139:
	.quad	4611686018427388032             ; 0x4000000000000080
	.quad	9007199254740992                ; 0x20000000000000
lCPI3_140:
	.quad	17592186044416                  ; 0x100000000000
	.quad	34359738368                     ; 0x800000000
lCPI3_141:
	.quad	67108864                        ; 0x4000000
	.quad	131072                          ; 0x20000
lCPI3_142:
	.quad	-9223372036854775552            ; 0x8000000000000100
	.quad	18014398509481984               ; 0x40000000000000
lCPI3_143:
	.quad	35184372088832                  ; 0x200000000000
	.quad	68719476736                     ; 0x1000000000
lCPI3_144:
	.quad	134217728                       ; 0x8000000
	.quad	262144                          ; 0x40000
lCPI3_145:
	.quad	9007199254740993                ; 0x20000000000001
	.quad	4398046511104                   ; 0x40000000000
lCPI3_146:
	.quad	2147483648                      ; 0x80000000
	.quad	1048576                         ; 0x100000
lCPI3_147:
	.quad	4611686018427388416             ; 0x4000000000000200
	.quad	2251799813685248                ; 0x8000000000000
lCPI3_148:
	.quad	1099511627776                   ; 0x10000000000
	.quad	536870912                       ; 0x20000000
lCPI3_149:
	.quad	262144                          ; 0x40000
	.quad	1152921504606847104             ; 0x1000000000000080
lCPI3_150:
	.quad	562949953421312                 ; 0x2000000000000
	.quad	274877906944                    ; 0x4000000000
lCPI3_151:
	.quad	134217728                       ; 0x8000000
	.quad	65536                           ; 0x10000
lCPI3_152:
	.quad	288230376151711776              ; 0x400000000000020
	.quad	140737488355328                 ; 0x800000000000
lCPI3_153:
	.quad	68719476736                     ; 0x1000000000
	.quad	33554432                        ; 0x2000000
lCPI3_154:
	.quad	16384                           ; 0x4000
	.quad	72057594037927944               ; 0x100000000000008
lCPI3_155:
	.quad	35184372088832                  ; 0x200000000000
	.quad	17179869184                     ; 0x400000000
lCPI3_156:
	.quad	8388608                         ; 0x800000
	.quad	4096                            ; 0x1000
lCPI3_157:
	.quad	18014398509481986               ; 0x40000000000002
	.quad	8796093022208                   ; 0x80000000000
lCPI3_158:
	.quad	4294967296                      ; 0x100000000
	.quad	2097152                         ; 0x200000
lCPI3_159:
	.quad	-9223372036854774784            ; 0x8000000000000400
	.quad	4503599627370496                ; 0x10000000000000
lCPI3_160:
	.quad	2199023255552                   ; 0x20000000000
	.quad	1073741824                      ; 0x40000000
lCPI3_161:
	.quad	524288                          ; 0x80000
	.quad	2305843009213694208             ; 0x2000000000000100
lCPI3_162:
	.quad	1125899906842624                ; 0x4000000000000
	.quad	549755813888                    ; 0x8000000000
lCPI3_163:
	.quad	268435456                       ; 0x10000000
	.quad	131072                          ; 0x20000
lCPI3_164:
	.quad	576460752303423552              ; 0x800000000000040
	.quad	281474976710656                 ; 0x1000000000000
lCPI3_165:
	.quad	137438953472                    ; 0x2000000000
	.quad	67108864                        ; 0x4000000
lCPI3_166:
	.quad	32768                           ; 0x8000
	.quad	144115188075855888              ; 0x200000000000010
lCPI3_167:
	.quad	70368744177664                  ; 0x400000000000
	.quad	34359738368                     ; 0x800000000
lCPI3_168:
	.quad	16777216                        ; 0x1000000
	.quad	8192                            ; 0x2000
lCPI3_169:
	.quad	36028797018963972               ; 0x80000000000004
	.quad	17592186044416                  ; 0x100000000000
lCPI3_170:
	.quad	8589934592                      ; 0x200000000
	.quad	4194304                         ; 0x400000
lCPI3_171:
	.quad	2251799813685249                ; 0x8000000000001
	.quad	274877906944                    ; 0x4000000000
lCPI3_172:
	.quad	33554432                        ; 0x2000000
	.quad	-9223372036854771712            ; 0x8000000000001000
lCPI3_173:
	.quad	1125899906842624                ; 0x4000000000000
	.quad	137438953472                    ; 0x2000000000
lCPI3_174:
	.quad	16777216                        ; 0x1000000
	.quad	4611686018427389952             ; 0x4000000000000800
lCPI3_175:
	.quad	562949953421312                 ; 0x2000000000000
	.quad	68719476736                     ; 0x1000000000
lCPI3_176:
	.quad	8388608                         ; 0x800000
	.quad	2305843009213694976             ; 0x2000000000000400
lCPI3_177:
	.quad	281474976710656                 ; 0x1000000000000
	.quad	34359738368                     ; 0x800000000
lCPI3_178:
	.quad	4194304                         ; 0x400000
	.quad	1152921504606847488             ; 0x1000000000000200
lCPI3_179:
	.quad	140737488355328                 ; 0x800000000000
	.quad	17179869184                     ; 0x400000000
lCPI3_180:
	.quad	2097152                         ; 0x200000
	.quad	576460752303423744              ; 0x800000000000100
lCPI3_181:
	.quad	70368744177664                  ; 0x400000000000
	.quad	8589934592                      ; 0x200000000
lCPI3_182:
	.quad	1048576                         ; 0x100000
	.quad	288230376151711872              ; 0x400000000000080
lCPI3_183:
	.quad	35184372088832                  ; 0x200000000000
	.quad	4294967296                      ; 0x100000000
lCPI3_184:
	.quad	524288                          ; 0x80000
	.quad	144115188075855936              ; 0x200000000000040
lCPI3_185:
	.quad	17592186044416                  ; 0x100000000000
	.quad	2147483648                      ; 0x80000000
lCPI3_186:
	.quad	262144                          ; 0x40000
	.quad	72057594037927968               ; 0x100000000000020
lCPI3_187:
	.quad	8796093022208                   ; 0x80000000000
	.quad	1073741824                      ; 0x40000000
lCPI3_188:
	.quad	131072                          ; 0x20000
	.quad	36028797018963984               ; 0x80000000000010
lCPI3_189:
	.quad	4398046511104                   ; 0x40000000000
	.quad	536870912                       ; 0x20000000
lCPI3_190:
	.quad	65536                           ; 0x10000
	.quad	18014398509481992               ; 0x40000000000008
lCPI3_191:
	.quad	2199023255552                   ; 0x20000000000
	.quad	268435456                       ; 0x10000000
lCPI3_192:
	.quad	32768                           ; 0x8000
	.quad	9007199254740996                ; 0x20000000000004
lCPI3_193:
	.quad	1099511627776                   ; 0x10000000000
	.quad	134217728                       ; 0x8000000
lCPI3_194:
	.quad	16384                           ; 0x4000
	.quad	4503599627370498                ; 0x10000000000002
lCPI3_195:
	.quad	549755813888                    ; 0x8000000000
	.quad	67108864                        ; 0x4000000
lCPI3_196:
	.quad	562949953421313                 ; 0x2000000000001
	.quad	17179869184                     ; 0x400000000
lCPI3_197:
	.quad	524288                          ; 0x80000
	.quad	9007199254741008                ; 0x20000000000010
lCPI3_198:
	.quad	274877906944                    ; 0x4000000000
	.quad	8388608                         ; 0x800000
lCPI3_199:
	.quad	144115188075856128              ; 0x200000000000100
	.quad	4398046511104                   ; 0x40000000000
lCPI3_200:
	.quad	134217728                       ; 0x8000000
	.quad	2305843009213698048             ; 0x2000000000001000
lCPI3_201:
	.quad	70368744177664                  ; 0x400000000000
	.quad	2147483648                      ; 0x80000000
lCPI3_202:
	.quad	65536                           ; 0x10000
	.quad	1125899906842626                ; 0x4000000000002
lCPI3_203:
	.quad	34359738368                     ; 0x800000000
	.quad	1048576                         ; 0x100000
lCPI3_204:
	.quad	18014398509482016               ; 0x40000000000020
	.quad	549755813888                    ; 0x8000000000
lCPI3_205:
	.quad	16777216                        ; 0x1000000
	.quad	288230376151712256              ; 0x400000000000200
lCPI3_206:
	.quad	8796093022208                   ; 0x80000000000
	.quad	268435456                       ; 0x10000000
lCPI3_207:
	.quad	4611686018427396096             ; 0x4000000000002000
	.quad	140737488355328                 ; 0x800000000000
lCPI3_208:
	.quad	4294967296                      ; 0x100000000
	.quad	131072                          ; 0x20000
lCPI3_209:
	.quad	2251799813685252                ; 0x8000000000004
	.quad	68719476736                     ; 0x1000000000
lCPI3_210:
	.quad	2097152                         ; 0x200000
	.quad	36028797018964032               ; 0x80000000000040
lCPI3_211:
	.quad	1099511627776                   ; 0x10000000000
	.quad	33554432                        ; 0x2000000
lCPI3_212:
	.quad	576460752303424512              ; 0x800000000000400
	.quad	17592186044416                  ; 0x100000000000
lCPI3_213:
	.quad	536870912                       ; 0x20000000
	.quad	-9223372036854759424            ; 0x8000000000004000
lCPI3_214:
	.quad	281474976710656                 ; 0x1000000000000
	.quad	8589934592                      ; 0x200000000
lCPI3_215:
	.quad	262144                          ; 0x40000
	.quad	4503599627370504                ; 0x10000000000008
lCPI3_216:
	.quad	137438953472                    ; 0x2000000000
	.quad	4194304                         ; 0x400000
lCPI3_217:
	.quad	72057594037928064               ; 0x100000000000080
	.quad	2199023255552                   ; 0x20000000000
lCPI3_218:
	.quad	67108864                        ; 0x4000000
	.quad	1152921504606849024             ; 0x1000000000000800
lCPI3_219:
	.quad	35184372088832                  ; 0x200000000000
	.quad	1073741824                      ; 0x40000000
lCPI3_220:
	.quad	140737488355329                 ; 0x800000000001
	.quad	1073741824                      ; 0x40000000
lCPI3_221:
	.quad	1152921504606855168             ; 0x1000000000002000
	.quad	8796093022208                   ; 0x80000000000
lCPI3_222:
	.quad	67108864                        ; 0x4000000
	.quad	72057594037928448               ; 0x100000000000200
lCPI3_223:
	.quad	549755813888                    ; 0x8000000000
	.quad	4194304                         ; 0x400000
lCPI3_224:
	.quad	4503599627370528                ; 0x10000000000020
	.quad	34359738368                     ; 0x800000000
lCPI3_225:
	.quad	262144                          ; 0x40000
	.quad	281474976710658                 ; 0x1000000000002
lCPI3_226:
	.quad	2147483648                      ; 0x80000000
	.quad	2305843009213710336             ; 0x2000000000004000
lCPI3_227:
	.quad	17592186044416                  ; 0x100000000000
	.quad	134217728                       ; 0x8000000
lCPI3_228:
	.quad	144115188075856896              ; 0x200000000000400
	.quad	1099511627776                   ; 0x10000000000
lCPI3_229:
	.quad	8388608                         ; 0x800000
	.quad	9007199254741056                ; 0x20000000000040
lCPI3_230:
	.quad	68719476736                     ; 0x1000000000
	.quad	524288                          ; 0x80000
lCPI3_231:
	.quad	562949953421316                 ; 0x2000000000004
	.quad	4294967296                      ; 0x100000000
lCPI3_232:
	.quad	4611686018427420672             ; 0x4000000000008000
	.quad	35184372088832                  ; 0x200000000000
lCPI3_233:
	.quad	268435456                       ; 0x10000000
	.quad	288230376151713792              ; 0x400000000000800
lCPI3_234:
	.quad	2199023255552                   ; 0x20000000000
	.quad	16777216                        ; 0x1000000
lCPI3_235:
	.quad	18014398509482112               ; 0x40000000000080
	.quad	137438953472                    ; 0x2000000000
lCPI3_236:
	.quad	1048576                         ; 0x100000
	.quad	1125899906842632                ; 0x4000000000008
lCPI3_237:
	.quad	8589934592                      ; 0x200000000
	.quad	-9223372036854710272            ; 0x8000000000010000
lCPI3_238:
	.quad	70368744177664                  ; 0x400000000000
	.quad	536870912                       ; 0x20000000
lCPI3_239:
	.quad	576460752303427584              ; 0x800000000001000
	.quad	4398046511104                   ; 0x40000000000
lCPI3_240:
	.quad	33554432                        ; 0x2000000
	.quad	36028797018964224               ; 0x80000000000100
lCPI3_241:
	.quad	274877906944                    ; 0x4000000000
	.quad	2097152                         ; 0x200000
lCPI3_242:
	.quad	2251799813685264                ; 0x8000000000010
	.quad	17179869184                     ; 0x400000000
lCPI3_243:
	.quad	35184372088833                  ; 0x200000000001
	.quad	67108864                        ; 0x4000000
lCPI3_244:
	.quad	4503599627370624                ; 0x10000000000080
	.quad	8589934592                      ; 0x200000000
lCPI3_245:
	.quad	576460752303439872              ; 0x800000000004000
	.quad	1099511627776                   ; 0x10000000000
lCPI3_246:
	.quad	2097152                         ; 0x200000
	.quad	140737488355332                 ; 0x800000000004
lCPI3_247:
	.quad	268435456                       ; 0x10000000
	.quad	18014398509482496               ; 0x40000000000200
lCPI3_248:
	.quad	34359738368                     ; 0x800000000
	.quad	2305843009213759488             ; 0x2000000000010000
lCPI3_249:
	.quad	4398046511104                   ; 0x40000000000
	.quad	8388608                         ; 0x800000
lCPI3_250:
	.quad	562949953421328                 ; 0x2000000000010
	.quad	1073741824                      ; 0x40000000
lCPI3_251:
	.quad	72057594037929984               ; 0x100000000000800
	.quad	137438953472                    ; 0x2000000000
lCPI3_252:
	.quad	-9223372036854513664            ; 0x8000000000040000
	.quad	17592186044416                  ; 0x100000000000
lCPI3_253:
	.quad	33554432                        ; 0x2000000
	.quad	2251799813685312                ; 0x8000000000040
lCPI3_254:
	.quad	4294967296                      ; 0x100000000
	.quad	288230376151719936              ; 0x400000000002000
lCPI3_255:
	.quad	549755813888                    ; 0x8000000000
	.quad	1048576                         ; 0x100000
lCPI3_256:
	.quad	70368744177666                  ; 0x400000000002
	.quad	134217728                       ; 0x8000000
lCPI3_257:
	.quad	9007199254741248                ; 0x20000000000100
	.quad	17179869184                     ; 0x400000000
lCPI3_258:
	.quad	1152921504606879744             ; 0x1000000000008000
	.quad	2199023255552                   ; 0x20000000000
lCPI3_259:
	.quad	4194304                         ; 0x400000
	.quad	281474976710664                 ; 0x1000000000008
lCPI3_260:
	.quad	536870912                       ; 0x20000000
	.quad	36028797018964992               ; 0x80000000000400
lCPI3_261:
	.quad	68719476736                     ; 0x1000000000
	.quad	4611686018427518976             ; 0x4000000000020000
lCPI3_262:
	.quad	8796093022208                   ; 0x80000000000
	.quad	16777216                        ; 0x1000000
lCPI3_263:
	.quad	1125899906842656                ; 0x4000000000020
	.quad	2147483648                      ; 0x80000000
lCPI3_264:
	.quad	144115188075859968              ; 0x200000000001000
	.quad	274877906944                    ; 0x4000000000
lCPI3_265:
	.quad	8796093022209                   ; 0x80000000001
	.quad	4194304                         ; 0x400000
lCPI3_266:
	.quad	17592186044418                  ; 0x100000000002
	.quad	8388608                         ; 0x800000
lCPI3_267:
	.quad	35184372088836                  ; 0x200000000004
	.quad	16777216                        ; 0x1000000
lCPI3_268:
	.quad	70368744177672                  ; 0x400000000008
	.quad	33554432                        ; 0x2000000
lCPI3_269:
	.quad	140737488355344                 ; 0x800000000010
	.quad	67108864                        ; 0x4000000
lCPI3_270:
	.quad	281474976710688                 ; 0x1000000000020
	.quad	134217728                       ; 0x8000000
lCPI3_271:
	.quad	562949953421376                 ; 0x2000000000040
	.quad	268435456                       ; 0x10000000
lCPI3_272:
	.quad	1125899906842752                ; 0x4000000000080
	.quad	536870912                       ; 0x20000000
lCPI3_273:
	.quad	2251799813685504                ; 0x8000000000100
	.quad	1073741824                      ; 0x40000000
lCPI3_274:
	.quad	4503599627371008                ; 0x10000000000200
	.quad	2147483648                      ; 0x80000000
lCPI3_275:
	.quad	9007199254742016                ; 0x20000000000400
	.quad	4294967296                      ; 0x100000000
lCPI3_276:
	.quad	18014398509484032               ; 0x40000000000800
	.quad	8589934592                      ; 0x200000000
lCPI3_277:
	.quad	36028797018968064               ; 0x80000000001000
	.quad	17179869184                     ; 0x400000000
lCPI3_278:
	.quad	72057594037936128               ; 0x100000000002000
	.quad	34359738368                     ; 0x800000000
lCPI3_279:
	.quad	144115188075872256              ; 0x200000000004000
	.quad	68719476736                     ; 0x1000000000
lCPI3_280:
	.quad	288230376151744512              ; 0x400000000008000
	.quad	137438953472                    ; 0x2000000000
lCPI3_281:
	.quad	576460752303489024              ; 0x800000000010000
	.quad	274877906944                    ; 0x4000000000
lCPI3_282:
	.quad	1152921504606978048             ; 0x1000000000020000
	.quad	549755813888                    ; 0x8000000000
lCPI3_283:
	.quad	2305843009213956096             ; 0x2000000000040000
	.quad	1099511627776                   ; 0x10000000000
lCPI3_284:
	.quad	4611686018427912192             ; 0x4000000000080000
	.quad	2199023255552                   ; 0x20000000000
lCPI3_285:
	.quad	-9223372036853727232            ; 0x8000000000100000
	.quad	4398046511104                   ; 0x40000000000
lCPI3_286:
	.quad	2199023255553                   ; 0x20000000001
	.quad	576460752303685632              ; 0x800000000040000
lCPI3_287:
	.quad	68719476736                     ; 0x1000000000
	.quad	18014398509490176               ; 0x40000000002000
lCPI3_288:
	.quad	2147483648                      ; 0x80000000
	.quad	562949953421568                 ; 0x2000000000100
lCPI3_289:
	.quad	67108864                        ; 0x4000000
	.quad	17592186044424                  ; 0x100000000008
lCPI3_290:
	.quad	4611686018429485056             ; 0x4000000000200000
	.quad	549755813888                    ; 0x8000000000
lCPI3_291:
	.quad	144115188075921408              ; 0x200000000010000
	.quad	17179869184                     ; 0x400000000
lCPI3_292:
	.quad	4503599627372544                ; 0x10000000000800
	.quad	536870912                       ; 0x20000000
lCPI3_293:
	.quad	140737488355392                 ; 0x800000000040
	.quad	16777216                        ; 0x1000000
lCPI3_294:
	.quad	4398046511106                   ; 0x40000000002
	.quad	1152921504607371264             ; 0x1000000000080000
lCPI3_295:
	.quad	137438953472                    ; 0x2000000000
	.quad	36028797018980352               ; 0x80000000004000
lCPI3_296:
	.quad	4294967296                      ; 0x100000000
	.quad	1125899906843136                ; 0x4000000000200
lCPI3_297:
	.quad	134217728                       ; 0x8000000
	.quad	35184372088848                  ; 0x200000000010
lCPI3_298:
	.quad	-9223372036850581504            ; 0x8000000000400000
	.quad	1099511627776                   ; 0x10000000000
lCPI3_299:
	.quad	288230376151842816              ; 0x400000000020000
	.quad	34359738368                     ; 0x800000000
lCPI3_300:
	.quad	9007199254745088                ; 0x20000000001000
	.quad	1073741824                      ; 0x40000000
lCPI3_301:
	.quad	281474976710784                 ; 0x1000000000080
	.quad	33554432                        ; 0x2000000
lCPI3_302:
	.quad	8796093022212                   ; 0x80000000004
	.quad	2305843009214742528             ; 0x2000000000100000
lCPI3_303:
	.quad	274877906944                    ; 0x4000000000
	.quad	72057594037960704               ; 0x100000000008000
lCPI3_304:
	.quad	8589934592                      ; 0x200000000
	.quad	2251799813686272                ; 0x8000000000400
lCPI3_305:
	.quad	268435456                       ; 0x10000000
	.quad	70368744177696                  ; 0x400000000020
lCPI3_306:
	.quad	549755813889                    ; 0x8000000001
	.quad	9007199254757376                ; 0x20000000004000
lCPI3_307:
	.quad	268435456                       ; 0x10000000
	.quad	4398046511112                   ; 0x40000000008
lCPI3_308:
	.quad	72057594038059008               ; 0x100000000020000
	.quad	2147483648                      ; 0x80000000
lCPI3_309:
	.quad	35184372088896                  ; 0x200000000040
	.quad	576460752304472064              ; 0x800000000100000
lCPI3_310:
	.quad	17179869184                     ; 0x400000000
	.quad	281474976711168                 ; 0x1000000000200
lCPI3_311:
	.quad	4611686018435776512             ; 0x4000000000800000
	.quad	137438953472                    ; 0x2000000000
lCPI3_312:
	.quad	2251799813689344                ; 0x8000000001000
	.quad	67108864                        ; 0x4000000
lCPI3_313:
	.quad	1099511627778                   ; 0x10000000002
	.quad	18014398509514752               ; 0x40000000008000
lCPI3_314:
	.quad	536870912                       ; 0x20000000
	.quad	8796093022224                   ; 0x80000000010
lCPI3_315:
	.quad	144115188076118016              ; 0x200000000040000
	.quad	4294967296                      ; 0x100000000
lCPI3_316:
	.quad	70368744177792                  ; 0x400000000080
	.quad	1152921504608944128             ; 0x1000000000200000
lCPI3_317:
	.quad	34359738368                     ; 0x800000000
	.quad	562949953422336                 ; 0x2000000000400
lCPI3_318:
	.quad	-9223372036837998592            ; 0x8000000001000000
	.quad	274877906944                    ; 0x4000000000
lCPI3_319:
	.quad	4503599627378688                ; 0x10000000002000
	.quad	134217728                       ; 0x8000000
lCPI3_320:
	.quad	2199023255556                   ; 0x20000000004
	.quad	36028797019029504               ; 0x80000000010000
lCPI3_321:
	.quad	1073741824                      ; 0x40000000
	.quad	17592186044448                  ; 0x100000000020
lCPI3_322:
	.quad	288230376152236032              ; 0x400000000080000
	.quad	8589934592                      ; 0x200000000
lCPI3_323:
	.quad	140737488355584                 ; 0x800000000100
	.quad	2305843009217888256             ; 0x2000000000400000
lCPI3_324:
	.quad	68719476736                     ; 0x1000000000
	.quad	1125899906844672                ; 0x4000000000800
lCPI3_325:
	.quad	137438953473                    ; 0x2000000001
	.quad	140737488356352                 ; 0x800000000400
lCPI3_326:
	.quad	144115188076904448              ; 0x200000000100000
	.quad	1073741824                      ; 0x40000000
lCPI3_327:
	.quad	1099511627784                   ; 0x10000000008
	.quad	1125899906850816                ; 0x4000000002000
lCPI3_328:
	.quad	1152921504615235584             ; 0x1000000000800000
	.quad	8589934592                      ; 0x200000000
lCPI3_329:
	.quad	8796093022272                   ; 0x80000000040
	.quad	9007199254806528                ; 0x20000000010000
lCPI3_330:
	.quad	-9223372036787666944            ; 0x8000000004000000
	.quad	68719476736                     ; 0x1000000000
lCPI3_331:
	.quad	70368744178176                  ; 0x400000000200
	.quad	72057594038452224               ; 0x100000000080000
lCPI3_332:
	.quad	536870912                       ; 0x20000000
	.quad	549755813892                    ; 0x8000000004
lCPI3_333:
	.quad	562949953425408                 ; 0x2000000001000
	.quad	576460752307617792              ; 0x800000000400000
lCPI3_334:
	.quad	4294967296                      ; 0x100000000
	.quad	4398046511136                   ; 0x40000000020
lCPI3_335:
	.quad	4503599627403264                ; 0x10000000008000
	.quad	4611686018460942336             ; 0x4000000002000000
lCPI3_336:
	.quad	34359738368                     ; 0x800000000
	.quad	35184372089088                  ; 0x200000000100
lCPI3_337:
	.quad	36028797019226112               ; 0x80000000040000
	.quad	268435456                       ; 0x10000000
lCPI3_338:
	.quad	274877906946                    ; 0x4000000002
	.quad	281474976712704                 ; 0x1000000000800
lCPI3_339:
	.quad	288230376153808896              ; 0x400000000200000
	.quad	2147483648                      ; 0x80000000
lCPI3_340:
	.quad	2199023255568                   ; 0x20000000010
	.quad	2251799813701632                ; 0x8000000004000
lCPI3_341:
	.quad	2305843009230471168             ; 0x2000000001000000
	.quad	17179869184                     ; 0x400000000
lCPI3_342:
	.quad	17592186044544                  ; 0x100000000080
	.quad	18014398509613056               ; 0x40000000020000
lCPI3_343:
	.quad	34359738369                     ; 0x800000001
	.quad	2199023255616                   ; 0x20000000040
lCPI3_344:
	.quad	140737488359424                 ; 0x800000001000
	.quad	9007199255003136                ; 0x20000000040000
lCPI3_345:
	.quad	576460752320200704              ; 0x800000001000000
	.quad	1073741824                      ; 0x40000000
lCPI3_346:
	.quad	68719476738                     ; 0x1000000002
	.quad	4398046511232                   ; 0x40000000080
lCPI3_347:
	.quad	281474976718848                 ; 0x1000000002000
	.quad	18014398510006272               ; 0x40000000080000
lCPI3_348:
	.quad	1152921504640401408             ; 0x1000000002000000
	.quad	2147483648                      ; 0x80000000
lCPI3_349:
	.quad	137438953476                    ; 0x2000000004
	.quad	8796093022464                   ; 0x80000000100
lCPI3_350:
	.quad	562949953437696                 ; 0x2000000004000
	.quad	36028797020012544               ; 0x80000000100000
lCPI3_351:
	.quad	2305843009280802816             ; 0x2000000004000000
	.quad	4294967296                      ; 0x100000000
lCPI3_352:
	.quad	274877906952                    ; 0x4000000008
	.quad	17592186044928                  ; 0x100000000200
lCPI3_353:
	.quad	1125899906875392                ; 0x4000000008000
	.quad	72057594040025088               ; 0x100000000200000
lCPI3_354:
	.quad	4611686018561605632             ; 0x4000000008000000
	.quad	8589934592                      ; 0x200000000
lCPI3_355:
	.quad	549755813904                    ; 0x8000000010
	.quad	35184372089856                  ; 0x200000000400
lCPI3_356:
	.quad	2251799813750784                ; 0x8000000010000
	.quad	144115188080050176              ; 0x200000000400000
lCPI3_357:
	.quad	-9223372036586340352            ; 0x8000000010000000
	.quad	17179869184                     ; 0x400000000
lCPI3_358:
	.quad	1099511627808                   ; 0x10000000020
	.quad	70368744179712                  ; 0x400000000800
lCPI3_359:
	.quad	4503599627501568                ; 0x10000000020000
	.quad	288230376160100352              ; 0x400000000800000
lCPI3_360:
	.quad	8589934593                      ; 0x200000001
	.quad	34359738372                     ; 0x800000004
lCPI3_361:
	.quad	137438953488                    ; 0x2000000010
	.quad	549755813952                    ; 0x8000000040
lCPI3_362:
	.quad	2199023255808                   ; 0x20000000100
	.quad	8796093023232                   ; 0x80000000400
lCPI3_363:
	.quad	35184372092928                  ; 0x200000001000
	.quad	140737488371712                 ; 0x800000004000
lCPI3_364:
	.quad	562949953486848                 ; 0x2000000010000
	.quad	2251799813947392                ; 0x8000000040000
lCPI3_365:
	.quad	9007199255789568                ; 0x20000000100000
	.quad	36028797023158272               ; 0x80000000400000
lCPI3_366:
	.quad	144115188092633088              ; 0x200000001000000
	.quad	576460752370532352              ; 0x800000004000000
lCPI3_367:
	.quad	2305843009482129408             ; 0x2000000010000000
	.quad	-9223372035781033984            ; 0x8000000040000000
lCPI3_368:
	.quad	4294967296                      ; 0x100000000
	.quad	17179869186                     ; 0x400000002
lCPI3_369:
	.quad	68719476744                     ; 0x1000000008
	.quad	274877906976                    ; 0x4000000020
lCPI3_370:
	.quad	1099511627904                   ; 0x10000000080
	.quad	4398046511616                   ; 0x40000000200
lCPI3_371:
	.quad	17592186046464                  ; 0x100000000800
	.quad	70368744185856                  ; 0x400000002000
lCPI3_372:
	.quad	281474976743424                 ; 0x1000000008000
	.quad	1125899906973696                ; 0x4000000020000
lCPI3_373:
	.quad	4503599627894784                ; 0x10000000080000
	.quad	18014398511579136               ; 0x40000000200000
lCPI3_374:
	.quad	72057594046316544               ; 0x100000000800000
	.quad	288230376185266176              ; 0x400000002000000
lCPI3_375:
	.quad	1152921504741064704             ; 0x1000000008000000
	.quad	4611686018964258816             ; 0x4000000020000000
lCPI3_376:
	.quad	4611686020574871553             ; 0x4000000080000001
	.quad	1152921505143717888             ; 0x1000000020000000
lCPI3_377:
	.quad	288230376285929472              ; 0x400000008000000
	.quad	72057594071482368               ; 0x100000002000000
lCPI3_378:
	.quad	18014398517870592               ; 0x40000000800000
	.quad	4503599629467648                ; 0x10000000200000
lCPI3_379:
	.quad	1125899907366912                ; 0x4000000080000
	.quad	281474976841728                 ; 0x1000000020000
lCPI3_380:
	.quad	70368744210432                  ; 0x400000008000
	.quad	17592186052608                  ; 0x100000002000
lCPI3_381:
	.quad	4398046513152                   ; 0x40000000800
	.quad	1099511628288                   ; 0x10000000200
lCPI3_382:
	.quad	274877907072                    ; 0x4000000080
	.quad	68719476768                     ; 0x1000000020
lCPI3_383:
	.quad	17179869192                     ; 0x400000008
	.quad	-9223372032559808510            ; 0x8000000100000002
lCPI3_384:
	.quad	2305843010287435776             ; 0x2000000040000000
	.quad	576460752571858944              ; 0x800000010000000
lCPI3_385:
	.quad	144115188142964736              ; 0x200000004000000
	.quad	36028797035741184               ; 0x80000001000000
lCPI3_386:
	.quad	9007199258935296                ; 0x20000000400000
	.quad	2251799814733824                ; 0x8000000100000
lCPI3_387:
	.quad	562949953683456                 ; 0x2000000040000
	.quad	140737488420864                 ; 0x800000010000
lCPI3_388:
	.quad	35184372105216                  ; 0x200000004000
	.quad	8796093026304                   ; 0x80000001000
lCPI3_389:
	.quad	2199023256576                   ; 0x20000000400
	.quad	549755814144                    ; 0x8000000100
lCPI3_390:
	.quad	137438953536                    ; 0x2000000040
	.quad	34359738384                     ; 0x800000010
lCPI3_391:
	.quad	288230376688582657              ; 0x400000020000001
	.quad	4503599635759104                ; 0x10000000800000
lCPI3_392:
	.quad	70368744308736                  ; 0x400000020000
	.quad	1099511629824                   ; 0x10000000800
lCPI3_393:
	.quad	-9223372019674906592            ; 0x8000000400000020
	.quad	144115188344291328              ; 0x200000010000000
lCPI3_394:
	.quad	2251799817879552                ; 0x8000000400000
	.quad	35184372154368                  ; 0x200000010000
lCPI3_395:
	.quad	549755814912                    ; 0x8000000400
	.quad	4611686027017322512             ; 0x4000000200000010
lCPI3_396:
	.quad	72057594172145664               ; 0x100000008000000
	.quad	1125899908939776                ; 0x4000000200000
lCPI3_397:
	.quad	17592186077184                  ; 0x100000008000
	.quad	274877907456                    ; 0x4000000200
lCPI3_398:
	.quad	2305843013508661256             ; 0x2000000100000008
	.quad	36028797086072832               ; 0x80000004000000
lCPI3_399:
	.quad	562949954469888                 ; 0x2000000100000
	.quad	8796093038592                   ; 0x80000004000
lCPI3_400:
	.quad	137438953728                    ; 0x2000000100
	.quad	1152921506754330628             ; 0x1000000080000004
lCPI3_401:
	.quad	18014398543036416               ; 0x40000002000000
	.quad	281474977234944                 ; 0x1000000080000
lCPI3_402:
	.quad	4398046519296                   ; 0x40000002000
	.quad	68719476864                     ; 0x1000000080
lCPI3_403:
	.quad	576460753377165314              ; 0x800000040000002
	.quad	9007199271518208                ; 0x20000001000000
lCPI3_404:
	.quad	140737488617472                 ; 0x800000040000
	.quad	2199023259648                   ; 0x20000001000
lCPI3_405:
	.quad	18014398643699713               ; 0x40000008000001
	.quad	17592186175488                  ; 0x100000020000
lCPI3_406:
	.quad	2305843026393563264             ; 0x2000000400000080
	.quad	2251799830462464                ; 0x8000001000000
lCPI3_407:
	.quad	2199023271936                   ; 0x20000004000
	.quad	288230378299195408              ; 0x400000080000010
lCPI3_408:
	.quad	281474978807808                 ; 0x1000000200000
	.quad	274877908992                    ; 0x4000000800
lCPI3_409:
	.quad	36028797287399426               ; 0x80000010000002
	.quad	35184372350976                  ; 0x200000040000
lCPI3_410:
	.quad	4611686052787126528             ; 0x4000000800000100
	.quad	4503599660924928                ; 0x10000002000000
lCPI3_411:
	.quad	4398046543872                   ; 0x40000008000
	.quad	576460756598390816              ; 0x800000100000020
lCPI3_412:
	.quad	562949957615616                 ; 0x2000000400000
	.quad	549755817984                    ; 0x8000001000
lCPI3_413:
	.quad	72057594574798852               ; 0x100000020000004
	.quad	70368744701952                  ; 0x400000080000
lCPI3_414:
	.quad	-9223371968135298560            ; 0x8000001000000200
	.quad	9007199321849856                ; 0x20000004000000
lCPI3_415:
	.quad	8796093087744                   ; 0x80000010000
	.quad	1152921513196781632             ; 0x1000000200000040
lCPI3_416:
	.quad	1125899915231232                ; 0x4000000800000
	.quad	1099511635968                   ; 0x10000002000
lCPI3_417:
	.quad	144115189149597704              ; 0x200000040000008
	.quad	140737489403904                 ; 0x800000100000
lCPI3_418:
	.quad	1125899940397057                ; 0x4000002000001
	.quad	2305843077933172736             ; 0x2000001000000800
lCPI3_419:
	.quad	140737492549632                 ; 0x800000400000
	.quad	288230384741646592              ; 0x400000200000100
lCPI3_420:
	.quad	17592186568704                  ; 0x100000080000
	.quad	36028798092705824               ; 0x80000040000020
lCPI3_421:
	.quad	2199023321088                   ; 0x20000010000
	.quad	4503599761588228                ; 0x10000008000004
lCPI3_422:
	.quad	-9223371761976860672            ; 0x8000004000002000
	.quad	562949970198528                 ; 0x2000001000000
lCPI3_423:
	.quad	1152921538966586368             ; 0x1000000800000400
	.quad	70368746274816                  ; 0x400000200000
lCPI3_424:
	.quad	144115192370823296              ; 0x200000100000080
	.quad	8796093284352                   ; 0x80000040000
lCPI3_425:
	.quad	18014399046352912               ; 0x40000020000010
	.quad	1099511660544                   ; 0x10000008000
lCPI3_426:
	.quad	2251799880794114                ; 0x8000004000002
	.quad	4611686155866345472             ; 0x4000002000001000
lCPI3_427:
	.quad	281474985099264                 ; 0x1000000800000
	.quad	576460769483293184              ; 0x800000400000200
lCPI3_428:
	.quad	35184373137408                  ; 0x200000100000
	.quad	72057596185411648               ; 0x100000080000040
lCPI3_429:
	.quad	4398046642176                   ; 0x40000020000
	.quad	9007199523176456                ; 0x20000010000008
lCPI3_430:
	.quad	70368752566273                  ; 0x400000800001
	.quad	2251800082120736                ; 0x8000010000020
lCPI3_431:
	.quad	72057602627863552               ; 0x100000200000400
	.quad	2305843284091633664             ; 0x2000004000008000
lCPI3_432:
	.quad	8796094070784                   ; 0x80000100000
	.quad	281475010265092                 ; 0x1000002000004
lCPI3_433:
	.quad	9007200328482944                ; 0x20000040000080
	.quad	288230410511454208              ; 0x400000800001000
lCPI3_434:
	.quad	-9223370937343016960            ; 0x8000010000020000
	.quad	35184376283136                  ; 0x200000400000
lCPI3_435:
	.quad	1125900041060368                ; 0x4000008000010
	.quad	36028801313931776               ; 0x80000100000200
lCPI3_436:
	.quad	1152921642045816832             ; 0x1000002000004000
	.quad	4398047035392                   ; 0x40000080000
lCPI3_437:
	.quad	140737505132546                 ; 0x800001000002
	.quad	4503600164241472                ; 0x10000020000040
lCPI3_438:
	.quad	144115205255727104              ; 0x200000400000800
	.quad	4611686568183267328             ; 0x4000008000010000
lCPI3_439:
	.quad	17592188141568                  ; 0x100000200000
	.quad	562950020530184                 ; 0x2000004000008
lCPI3_440:
	.quad	18014400656965888               ; 0x40000080000100
	.quad	576460821022908416              ; 0x800001000002000
lCPI3_441:
	.quad	-9223367638806167551            ; 0x8000040000200001
	.quad	4611688217451692032             ; 0x4000020000100000
lCPI3_442:
	.quad	2305844108725846016             ; 0x2000010000080000
	.quad	1152922054362923008             ; 0x1000008000040000
lCPI3_443:
	.quad	576461027181461504              ; 0x800004000020000
	.quad	288230513590730752              ; 0x400002000010000
lCPI3_444:
	.quad	144115256795365376              ; 0x200001000008000
	.quad	72057628397682688               ; 0x100000800004000
lCPI3_445:
	.quad	36028814198841344               ; 0x80000400002000
	.quad	18014407099420672               ; 0x40000200001000
lCPI3_446:
	.quad	9007203549710336                ; 0x20000100000800
	.quad	4503601774855168                ; 0x10000080000400
lCPI3_447:
	.quad	2251800887427584                ; 0x8000040000200
	.quad	1125900443713792                ; 0x4000020000100
lCPI3_448:
	.quad	562950221856896                 ; 0x2000010000080
	.quad	281475110928448                 ; 0x1000008000040
lCPI3_449:
	.quad	140737555464224                 ; 0x800004000020
	.quad	70368777732112                  ; 0x400002000010
lCPI3_450:
	.quad	35184388866056                  ; 0x200001000008
	.quad	17592194433028                  ; 0x100000800004
lCPI3_451:
	.quad	144115462954287105              ; 0x200004000080001
	.quad	1125902054330368                ; 0x4000080001000
lCPI3_452:
	.quad	4611694814537187360             ; 0x4000080001000020
	.quad	36028865738571776               ; 0x80001000020000
lCPI3_453:
	.quad	281475513582592                 ; 0x1000020000400
	.quad	1152923703634296840             ; 0x1000020000400008
lCPI3_454:
	.quad	9007216434642944                ; 0x20000400008000
	.quad	70368878395648                  ; 0x400008000100
lCPI3_455:
	.quad	288230925908574210              ; 0x400008000100002
	.quad	2251804108660736                ; 0x8000100002000
lCPI3_456:
	.quad	-9223354444635176896            ; 0x8000100002000040
	.quad	72057731477143552               ; 0x100002000040000
lCPI3_457:
	.quad	562951027165184                 ; 0x2000040000800
	.quad	2305847407268593680             ; 0x2000040000800010
lCPI3_458:
	.quad	18014432869285888               ; 0x40000800010000
	.quad	140737756791296                 ; 0x800010000200
lCPI3_459:
	.quad	576461851817148420              ; 0x800010000200004
	.quad	4503608217321472                ; 0x10000200004000
lCPI3_460:
	.quad	2251816993685505                ; 0x8000400020001
	.quad	36029071898968080               ; 0x80004000200010
lCPI3_461:
	.quad	576465150383489280              ; 0x800040002000100
	.quad	-9223301667573723136            ; 0x8000400020001000
lCPI3_462:
	.quad	1125908496842752                ; 0x4000200010000
	.quad	18014535949484040               ; 0x40002000100008
lCPI3_463:
	.quad	288232575191744640              ; 0x400020001000080
	.quad	4611721203067914240             ; 0x4000200010000800
lCPI3_464:
	.quad	562954248421376                 ; 0x2000100008000
	.quad	9007267974742020                ; 0x20001000080004
lCPI3_465:
	.quad	144116287595872320              ; 0x200010000800040
	.quad	2305860601533957120             ; 0x2000100008000400
lCPI3_466:
	.quad	281477124210688                 ; 0x1000080004000
	.quad	4503633987371010                ; 0x10000800040002
lCPI3_467:
	.quad	72058143797936160               ; 0x100008000400020
	.quad	1152930300766978560             ; 0x1000080004000200
lCPI3_468:
	.quad	1152956690052710401             ; 0x1000200040008001
	.quad	72059793128294400               ; 0x100020004000800
lCPI3_469:
	.quad	4503737070518400                ; 0x10002000400080
	.quad	-9223090553287868408            ; 0x8001000200040008
lCPI3_470:
	.quad	576478345026355200              ; 0x800100020004000
	.quad	36029896564147200               ; 0x80010002000400
lCPI3_471:
	.quad	2251868535259200                ; 0x8001000200040
	.quad	4611826760210841604             ; 0x4000800100020004
lCPI3_472:
	.quad	288239172513177600              ; 0x400080010002000
	.quad	18014948282073600               ; 0x40008001000200
lCPI3_473:
	.quad	1125934267629600                ; 0x4000800100020
	.quad	2305913380105420802             ; 0x2000400080010002
lCPI3_474:
	.quad	144119586256588800              ; 0x200040008001000
	.quad	9007474141036800                ; 0x20004000800100
lCPI3_475:
	.quad	4504149450301441                ; 0x10008004002001
	.quad	9008298900602882                ; 0x20010008004002
lCPI3_476:
	.quad	18016597801205764               ; 0x40020010008004
	.quad	36033195602411528               ; 0x80040020010008
lCPI3_477:
	.quad	72066391204823056               ; 0x100080040020010
	.quad	144132782409646112              ; 0x200100080040020
lCPI3_478:
	.quad	288265564819292224              ; 0x400200100080040
	.quad	576531129638584448              ; 0x800400200100080
lCPI3_479:
	.quad	1153062259277168896             ; 0x1000800400200100
	.quad	2306124518554337792             ; 0x2001000800400200
lCPI3_480:
	.quad	4612249037108675584             ; 0x4002001000800400
	.quad	-9222245999492200448            ; 0x8004002001000800
lCPI3_481:
	.quad	36046397799139329               ; 0x80100200400801
	.quad	144185591196557316              ; 0x200400801002004
lCPI3_482:
	.quad	576742364786229264              ; 0x801002004008010
	.quad	2306969459144917056             ; 0x2004008010020040
lCPI3_483:
	.quad	-9218866237129883392            ; 0x8010020040080100
	.quad	18023198899569664               ; 0x40080100200400
lCPI3_484:
	.quad	72092795598278658               ; 0x100200400801002
	.quad	288371182393114632              ; 0x400801002004008
lCPI3_485:
	.quad	1153484729572458528             ; 0x1002004008010020
	.quad	4613938918289834112             ; 0x4008010020040080
lCPI3_486:
	.quad	-9205322385119247871            ; 0x8040201008040201
	.quad	4620710844295151872             ; 0x4020100804020100
lCPI3_487:
	.quad	2310355422147575936             ; 0x2010080402010080
	.quad	1155177711073787968             ; 0x1008040201008040
lCPI3_488:
	.quad	577588855536893984              ; 0x804020100804020
	.quad	288794427768446992              ; 0x402010080402010
lCPI3_489:
	.quad	144397213884223496              ; 0x201008040201008
	.quad	72198606942111748               ; 0x100804020100804
lCPI3_490:
	.quad	-9150747060186627967            ; 0x8102040810204081
	.quad	4647998506761461824             ; 0x4081020408102040
lCPI3_491:
	.quad	2323999253380730912             ; 0x2040810204081020
	.quad	1161999626690365456             ; 0x1020408102040810
lCPI3_492:
	.quad	580999813345182728              ; 0x810204081020408
	.quad	290499906672591364              ; 0x408102040810204
lCPI3_493:
	.quad	1190112520884487201             ; 0x1084210842108421
	.quad	2380225041768974402             ; 0x2108421084210842
lCPI3_494:
	.quad	4760450083537948804             ; 0x4210842108421084
	.quad	-8925843906633654008            ; 0x8421084210842108
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
_$s10PrimeSwift0A5SieveC22markWordDenseMultiples33_D113D18C9011F4014E4762B5A56EE2E5LL2ofySi_tF: ; @"$s10PrimeSwift0A5SieveC22markWordDenseMultiples33_D113D18C9011F4014E4762B5A56EE2E5LL2ofySi_tF"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	stp	d15, d14, [sp, #32]             ; 16-byte Folded Spill
	stp	d13, d12, [sp, #48]             ; 16-byte Folded Spill
	stp	d11, d10, [sp, #64]             ; 16-byte Folded Spill
	stp	d9, d8, [sp, #80]               ; 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	.cfi_offset b8, -8
	.cfi_offset b9, -16
	.cfi_offset b10, -24
	.cfi_offset b11, -32
	.cfi_offset b12, -40
	.cfi_offset b13, -48
	.cfi_offset b14, -56
	.cfi_offset b15, -64
	mul	x8, x0, x0
	smulh	x9, x0, x0
	cmp	x9, x8, asr #63
	b.ne	LBB3_134
; %bb.1:
	subs	x9, x8, #3
	b.vs	LBB3_135
; %bb.2:
	ldr	x8, [x20, #40]
	add	x9, x9, x9, lsr #63
	asr	x9, x9, #1
	ldr	x10, [x20, #24]
	mov	w11, #1                         ; =0x1
LBB3_3:                                 ; =>This Inner Loop Header: Depth=1
	cmp	x9, x10
	b.ge	LBB3_132
; %bb.4:                                ;   in Loop: Header=BB3_3 Depth=1
	tst	x9, #0x3f
	b.eq	LBB3_7
; %bb.5:                                ;   in Loop: Header=BB3_3 Depth=1
	and	x12, x9, #0x7
	asr	x13, x9, #3
	ldrb	w14, [x8, x13]
	lsl	w12, w11, w12
	orr	w12, w14, w12
	strb	w12, [x8, x13]
	cmn	x9, x0
	add	x9, x9, x0
	b.vc	LBB3_3
; %bb.6:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB3_7:
	sub	x11, x0, #5
	cmp	x11, #58
	b.hi	LBB3_136
; %bb.8:
	asr	x10, x9, #6
	ldr	x9, [x20, #24]
	asr	x9, x9, #6
Lloh12:
	adrp	x12, lJTI3_0@PAGE
Lloh13:
	add	x12, x12, lJTI3_0@PAGEOFF
Ltmp0:
	adr	x13, Ltmp0
	ldrsw	x14, [x12, x11, lsl #2]
	add	x13, x13, x14
	br	x13
LBB3_9:
	add	x11, x10, #5
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.10:
	add	x11, x8, x10, lsl #3
	add	x11, x11, #32
Lloh14:
	adrp	x12, lCPI3_493@PAGE
Lloh15:
	ldr	q0, [x12, lCPI3_493@PAGEOFF]
Lloh16:
	adrp	x12, lCPI3_494@PAGE
Lloh17:
	ldr	q1, [x12, lCPI3_494@PAGEOFF]
	mov	x12, #16912                     ; =0x4210
	movk	x12, #8456, lsl #16
	movk	x12, #4228, lsl #32
	movk	x12, #2114, lsl #48
	mov	x13, x10
LBB3_11:                                ; =>This Inner Loop Header: Depth=1
	ldp	q2, q3, [x11, #-32]
	orr.16b	v2, v2, v0
	orr.16b	v3, v3, v1
	stp	q2, q3, [x11, #-32]
	ldr	x10, [x11]
	orr	x10, x10, x12
	str	x10, [x11], #40
	add	x10, x13, #5
	add	x14, x13, #10
	mov	x13, x10
	cmp	x9, x14
	b.ge	LBB3_11
	b	LBB3_128
LBB3_12:
	add	x11, x10, #51
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.13:
Lloh18:
	adrp	x12, lCPI3_171@PAGE
Lloh19:
	ldr	q0, [x12, lCPI3_171@PAGEOFF]
Lloh20:
	adrp	x12, lCPI3_172@PAGE
Lloh21:
	ldr	q1, [x12, lCPI3_172@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh22:
	adrp	x12, lCPI3_173@PAGE
Lloh23:
	ldr	q2, [x12, lCPI3_173@PAGEOFF]
	add	x10, x10, #208
Lloh24:
	adrp	x12, lCPI3_174@PAGE
Lloh25:
	ldr	q3, [x12, lCPI3_174@PAGEOFF]
Lloh26:
	adrp	x12, lCPI3_175@PAGE
Lloh27:
	ldr	q4, [x12, lCPI3_175@PAGEOFF]
Lloh28:
	adrp	x12, lCPI3_176@PAGE
Lloh29:
	ldr	q5, [x12, lCPI3_176@PAGEOFF]
Lloh30:
	adrp	x12, lCPI3_177@PAGE
Lloh31:
	ldr	q6, [x12, lCPI3_177@PAGEOFF]
Lloh32:
	adrp	x12, lCPI3_178@PAGE
Lloh33:
	ldr	q7, [x12, lCPI3_178@PAGEOFF]
Lloh34:
	adrp	x12, lCPI3_179@PAGE
Lloh35:
	ldr	q16, [x12, lCPI3_179@PAGEOFF]
Lloh36:
	adrp	x12, lCPI3_180@PAGE
Lloh37:
	ldr	q17, [x12, lCPI3_180@PAGEOFF]
Lloh38:
	adrp	x12, lCPI3_181@PAGE
Lloh39:
	ldr	q18, [x12, lCPI3_181@PAGEOFF]
Lloh40:
	adrp	x12, lCPI3_182@PAGE
Lloh41:
	ldr	q19, [x12, lCPI3_182@PAGEOFF]
Lloh42:
	adrp	x12, lCPI3_183@PAGE
Lloh43:
	ldr	q20, [x12, lCPI3_183@PAGEOFF]
Lloh44:
	adrp	x12, lCPI3_184@PAGE
Lloh45:
	ldr	q21, [x12, lCPI3_184@PAGEOFF]
Lloh46:
	adrp	x12, lCPI3_185@PAGE
Lloh47:
	ldr	q22, [x12, lCPI3_185@PAGEOFF]
Lloh48:
	adrp	x12, lCPI3_186@PAGE
Lloh49:
	ldr	q23, [x12, lCPI3_186@PAGEOFF]
Lloh50:
	adrp	x12, lCPI3_187@PAGE
Lloh51:
	ldr	q24, [x12, lCPI3_187@PAGEOFF]
Lloh52:
	adrp	x12, lCPI3_188@PAGE
Lloh53:
	ldr	q25, [x12, lCPI3_188@PAGEOFF]
Lloh54:
	adrp	x12, lCPI3_189@PAGE
Lloh55:
	ldr	q26, [x12, lCPI3_189@PAGEOFF]
Lloh56:
	adrp	x12, lCPI3_190@PAGE
Lloh57:
	ldr	q27, [x12, lCPI3_190@PAGEOFF]
Lloh58:
	adrp	x12, lCPI3_191@PAGE
Lloh59:
	ldr	q28, [x12, lCPI3_191@PAGEOFF]
Lloh60:
	adrp	x12, lCPI3_192@PAGE
Lloh61:
	ldr	q29, [x12, lCPI3_192@PAGEOFF]
Lloh62:
	adrp	x12, lCPI3_193@PAGE
Lloh63:
	ldr	q30, [x12, lCPI3_193@PAGEOFF]
Lloh64:
	adrp	x12, lCPI3_194@PAGE
Lloh65:
	ldr	q31, [x12, lCPI3_194@PAGEOFF]
Lloh66:
	adrp	x12, lCPI3_195@PAGE
Lloh67:
	ldr	q8, [x12, lCPI3_195@PAGEOFF]
LBB3_14:                                ; =>This Inner Loop Header: Depth=1
	ldp	q9, q10, [x10, #-208]
	orr.16b	v9, v9, v0
	orr.16b	v10, v10, v1
	stp	q9, q10, [x10, #-208]
	ldp	q9, q10, [x10, #-176]
	orr.16b	v9, v9, v2
	orr.16b	v10, v10, v3
	stp	q9, q10, [x10, #-176]
	ldp	q9, q10, [x10, #-144]
	orr.16b	v9, v9, v4
	orr.16b	v10, v10, v5
	stp	q9, q10, [x10, #-144]
	ldp	q9, q10, [x10, #-112]
	orr.16b	v9, v9, v6
	orr.16b	v10, v10, v7
	stp	q9, q10, [x10, #-112]
	ldp	q9, q10, [x10, #-80]
	orr.16b	v9, v9, v16
	orr.16b	v10, v10, v17
	stp	q9, q10, [x10, #-80]
	ldp	q9, q10, [x10, #-48]
	orr.16b	v9, v9, v18
	orr.16b	v10, v10, v19
	stp	q9, q10, [x10, #-48]
	ldp	q9, q10, [x10, #-16]
	orr.16b	v9, v9, v20
	orr.16b	v10, v10, v21
	stp	q9, q10, [x10, #-16]
	ldp	q9, q10, [x10, #16]
	orr.16b	v9, v9, v22
	orr.16b	v10, v10, v23
	stp	q9, q10, [x10, #16]
	ldp	q9, q10, [x10, #48]
	orr.16b	v9, v9, v24
	orr.16b	v10, v10, v25
	stp	q9, q10, [x10, #48]
	ldp	q9, q10, [x10, #80]
	orr.16b	v9, v9, v26
	orr.16b	v10, v10, v27
	stp	q9, q10, [x10, #80]
	ldp	q9, q10, [x10, #112]
	orr.16b	v9, v9, v28
	orr.16b	v10, v10, v29
	stp	q9, q10, [x10, #112]
	ldp	q9, q10, [x10, #144]
	orr.16b	v9, v9, v30
	orr.16b	v10, v10, v31
	stp	q9, q10, [x10, #144]
	ldr	q9, [x10, #176]
	orr.16b	v9, v9, v8
	ldr	x12, [x10, #192]
	orr	x12, x12, #0x2000
	add	x11, x11, #51
	str	q9, [x10, #176]
	str	x12, [x10, #192]
	add	x10, x10, #408
	cmp	x9, x11
	b.ge	LBB3_14
; %bb.15:
	sub	x10, x11, #51
	b	LBB3_128
LBB3_16:
	add	x11, x10, #41
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.17:
Lloh68:
	adrp	x12, lCPI3_286@PAGE
Lloh69:
	ldr	q0, [x12, lCPI3_286@PAGEOFF]
Lloh70:
	adrp	x12, lCPI3_287@PAGE
Lloh71:
	ldr	q1, [x12, lCPI3_287@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh72:
	adrp	x12, lCPI3_288@PAGE
Lloh73:
	ldr	q2, [x12, lCPI3_288@PAGEOFF]
	add	x10, x10, #160
Lloh74:
	adrp	x12, lCPI3_289@PAGE
Lloh75:
	ldr	q3, [x12, lCPI3_289@PAGEOFF]
Lloh76:
	adrp	x12, lCPI3_290@PAGE
Lloh77:
	ldr	q4, [x12, lCPI3_290@PAGEOFF]
Lloh78:
	adrp	x12, lCPI3_291@PAGE
Lloh79:
	ldr	q5, [x12, lCPI3_291@PAGEOFF]
Lloh80:
	adrp	x12, lCPI3_292@PAGE
Lloh81:
	ldr	q6, [x12, lCPI3_292@PAGEOFF]
Lloh82:
	adrp	x12, lCPI3_293@PAGE
Lloh83:
	ldr	q7, [x12, lCPI3_293@PAGEOFF]
Lloh84:
	adrp	x12, lCPI3_294@PAGE
Lloh85:
	ldr	q16, [x12, lCPI3_294@PAGEOFF]
Lloh86:
	adrp	x12, lCPI3_295@PAGE
Lloh87:
	ldr	q17, [x12, lCPI3_295@PAGEOFF]
Lloh88:
	adrp	x12, lCPI3_296@PAGE
Lloh89:
	ldr	q18, [x12, lCPI3_296@PAGEOFF]
Lloh90:
	adrp	x12, lCPI3_297@PAGE
Lloh91:
	ldr	q19, [x12, lCPI3_297@PAGEOFF]
Lloh92:
	adrp	x12, lCPI3_298@PAGE
Lloh93:
	ldr	q20, [x12, lCPI3_298@PAGEOFF]
Lloh94:
	adrp	x12, lCPI3_299@PAGE
Lloh95:
	ldr	q21, [x12, lCPI3_299@PAGEOFF]
Lloh96:
	adrp	x12, lCPI3_300@PAGE
Lloh97:
	ldr	q22, [x12, lCPI3_300@PAGEOFF]
Lloh98:
	adrp	x12, lCPI3_301@PAGE
Lloh99:
	ldr	q23, [x12, lCPI3_301@PAGEOFF]
Lloh100:
	adrp	x12, lCPI3_302@PAGE
Lloh101:
	ldr	q24, [x12, lCPI3_302@PAGEOFF]
Lloh102:
	adrp	x12, lCPI3_303@PAGE
Lloh103:
	ldr	q25, [x12, lCPI3_303@PAGEOFF]
Lloh104:
	adrp	x12, lCPI3_304@PAGE
Lloh105:
	ldr	q26, [x12, lCPI3_304@PAGEOFF]
Lloh106:
	adrp	x12, lCPI3_305@PAGE
Lloh107:
	ldr	q27, [x12, lCPI3_305@PAGEOFF]
LBB3_18:                                ; =>This Inner Loop Header: Depth=1
	ldp	q28, q29, [x10, #-160]
	orr.16b	v28, v28, v0
	orr.16b	v29, v29, v1
	stp	q28, q29, [x10, #-160]
	ldp	q28, q29, [x10, #-128]
	orr.16b	v28, v28, v2
	orr.16b	v29, v29, v3
	stp	q28, q29, [x10, #-128]
	ldp	q28, q29, [x10, #-96]
	orr.16b	v28, v28, v4
	orr.16b	v29, v29, v5
	stp	q28, q29, [x10, #-96]
	ldp	q28, q29, [x10, #-64]
	orr.16b	v28, v28, v6
	orr.16b	v29, v29, v7
	stp	q28, q29, [x10, #-64]
	ldp	q28, q29, [x10, #-32]
	orr.16b	v28, v28, v16
	orr.16b	v29, v29, v17
	stp	q28, q29, [x10, #-32]
	ldp	q28, q29, [x10]
	orr.16b	v28, v28, v18
	orr.16b	v29, v29, v19
	stp	q28, q29, [x10]
	ldp	q28, q29, [x10, #32]
	orr.16b	v28, v28, v20
	orr.16b	v29, v29, v21
	stp	q28, q29, [x10, #32]
	ldp	q28, q29, [x10, #64]
	orr.16b	v28, v28, v22
	orr.16b	v29, v29, v23
	stp	q28, q29, [x10, #64]
	ldp	q28, q29, [x10, #96]
	orr.16b	v28, v28, v24
	orr.16b	v29, v29, v25
	stp	q28, q29, [x10, #96]
	ldp	q28, q29, [x10, #128]
	orr.16b	v28, v28, v26
	orr.16b	v29, v29, v27
	ldr	x12, [x10, #160]
	orr	x12, x12, #0x800000
	add	x11, x11, #41
	stp	q28, q29, [x10, #128]
	str	x12, [x10, #160]
	add	x10, x10, #328
	cmp	x9, x11
	b.ge	LBB3_18
; %bb.19:
	sub	x10, x11, #41
	b	LBB3_128
LBB3_20:
	add	x11, x10, #25
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.21:
Lloh108:
	adrp	x12, lCPI3_418@PAGE
Lloh109:
	ldr	q0, [x12, lCPI3_418@PAGEOFF]
Lloh110:
	adrp	x12, lCPI3_419@PAGE
Lloh111:
	ldr	q1, [x12, lCPI3_419@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh112:
	adrp	x12, lCPI3_420@PAGE
Lloh113:
	ldr	q2, [x12, lCPI3_420@PAGEOFF]
	add	x10, x10, #96
Lloh114:
	adrp	x12, lCPI3_421@PAGE
Lloh115:
	ldr	q3, [x12, lCPI3_421@PAGEOFF]
Lloh116:
	adrp	x12, lCPI3_422@PAGE
Lloh117:
	ldr	q4, [x12, lCPI3_422@PAGEOFF]
Lloh118:
	adrp	x12, lCPI3_423@PAGE
Lloh119:
	ldr	q5, [x12, lCPI3_423@PAGEOFF]
Lloh120:
	adrp	x12, lCPI3_424@PAGE
Lloh121:
	ldr	q6, [x12, lCPI3_424@PAGEOFF]
Lloh122:
	adrp	x12, lCPI3_425@PAGE
Lloh123:
	ldr	q7, [x12, lCPI3_425@PAGEOFF]
Lloh124:
	adrp	x12, lCPI3_426@PAGE
Lloh125:
	ldr	q16, [x12, lCPI3_426@PAGEOFF]
Lloh126:
	adrp	x12, lCPI3_427@PAGE
Lloh127:
	ldr	q17, [x12, lCPI3_427@PAGEOFF]
Lloh128:
	adrp	x12, lCPI3_428@PAGE
Lloh129:
	ldr	q18, [x12, lCPI3_428@PAGEOFF]
Lloh130:
	adrp	x12, lCPI3_429@PAGE
Lloh131:
	ldr	q19, [x12, lCPI3_429@PAGEOFF]
	mov	x12, #16384                     ; =0x4000
	movk	x12, #128, lsl #32
LBB3_22:                                ; =>This Inner Loop Header: Depth=1
	ldp	q20, q21, [x10, #-96]
	orr.16b	v20, v20, v0
	orr.16b	v21, v21, v1
	stp	q20, q21, [x10, #-96]
	ldp	q20, q21, [x10, #-64]
	orr.16b	v20, v20, v2
	orr.16b	v21, v21, v3
	stp	q20, q21, [x10, #-64]
	ldp	q20, q21, [x10, #-32]
	orr.16b	v20, v20, v4
	orr.16b	v21, v21, v5
	stp	q20, q21, [x10, #-32]
	ldp	q20, q21, [x10]
	orr.16b	v20, v20, v6
	orr.16b	v21, v21, v7
	stp	q20, q21, [x10]
	ldp	q20, q21, [x10, #32]
	orr.16b	v20, v20, v16
	orr.16b	v21, v21, v17
	stp	q20, q21, [x10, #32]
	ldp	q20, q21, [x10, #64]
	orr.16b	v20, v20, v18
	orr.16b	v21, v21, v19
	ldr	x13, [x10, #96]
	orr	x13, x13, x12
	add	x11, x11, #25
	stp	q20, q21, [x10, #64]
	str	x13, [x10, #96]
	add	x10, x10, #200
	cmp	x9, x11
	b.ge	LBB3_22
; %bb.23:
	sub	x10, x11, #25
	b	LBB3_128
LBB3_24:
	add	x11, x10, #33
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.25:
Lloh132:
	adrp	x12, lCPI3_360@PAGE
Lloh133:
	ldr	q0, [x12, lCPI3_360@PAGEOFF]
Lloh134:
	adrp	x12, lCPI3_361@PAGE
Lloh135:
	ldr	q1, [x12, lCPI3_361@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh136:
	adrp	x12, lCPI3_362@PAGE
Lloh137:
	ldr	q2, [x12, lCPI3_362@PAGEOFF]
	add	x10, x10, #128
Lloh138:
	adrp	x12, lCPI3_363@PAGE
Lloh139:
	ldr	q3, [x12, lCPI3_363@PAGEOFF]
Lloh140:
	adrp	x12, lCPI3_364@PAGE
Lloh141:
	ldr	q4, [x12, lCPI3_364@PAGEOFF]
Lloh142:
	adrp	x12, lCPI3_365@PAGE
Lloh143:
	ldr	q5, [x12, lCPI3_365@PAGEOFF]
Lloh144:
	adrp	x12, lCPI3_366@PAGE
Lloh145:
	ldr	q6, [x12, lCPI3_366@PAGEOFF]
Lloh146:
	adrp	x12, lCPI3_367@PAGE
Lloh147:
	ldr	q7, [x12, lCPI3_367@PAGEOFF]
Lloh148:
	adrp	x12, lCPI3_368@PAGE
Lloh149:
	ldr	q16, [x12, lCPI3_368@PAGEOFF]
Lloh150:
	adrp	x12, lCPI3_369@PAGE
Lloh151:
	ldr	q17, [x12, lCPI3_369@PAGEOFF]
Lloh152:
	adrp	x12, lCPI3_370@PAGE
Lloh153:
	ldr	q18, [x12, lCPI3_370@PAGEOFF]
Lloh154:
	adrp	x12, lCPI3_371@PAGE
Lloh155:
	ldr	q19, [x12, lCPI3_371@PAGEOFF]
Lloh156:
	adrp	x12, lCPI3_372@PAGE
Lloh157:
	ldr	q20, [x12, lCPI3_372@PAGEOFF]
Lloh158:
	adrp	x12, lCPI3_373@PAGE
Lloh159:
	ldr	q21, [x12, lCPI3_373@PAGEOFF]
Lloh160:
	adrp	x12, lCPI3_374@PAGE
Lloh161:
	ldr	q22, [x12, lCPI3_374@PAGEOFF]
Lloh162:
	adrp	x12, lCPI3_375@PAGE
Lloh163:
	ldr	q23, [x12, lCPI3_375@PAGEOFF]
LBB3_26:                                ; =>This Inner Loop Header: Depth=1
	ldp	q24, q25, [x10, #-128]
	orr.16b	v24, v24, v0
	orr.16b	v25, v25, v1
	stp	q24, q25, [x10, #-128]
	ldp	q24, q25, [x10, #-96]
	orr.16b	v24, v24, v2
	orr.16b	v25, v25, v3
	stp	q24, q25, [x10, #-96]
	ldp	q24, q25, [x10, #-64]
	orr.16b	v24, v24, v4
	orr.16b	v25, v25, v5
	stp	q24, q25, [x10, #-64]
	ldp	q24, q25, [x10, #-32]
	orr.16b	v24, v24, v6
	orr.16b	v25, v25, v7
	stp	q24, q25, [x10, #-32]
	ldp	q24, q25, [x10]
	orr.16b	v24, v24, v16
	orr.16b	v25, v25, v17
	stp	q24, q25, [x10]
	ldp	q24, q25, [x10, #32]
	orr.16b	v24, v24, v18
	orr.16b	v25, v25, v19
	stp	q24, q25, [x10, #32]
	ldp	q24, q25, [x10, #64]
	orr.16b	v24, v24, v20
	orr.16b	v25, v25, v21
	stp	q24, q25, [x10, #64]
	ldp	q24, q25, [x10, #96]
	orr.16b	v24, v24, v22
	orr.16b	v25, v25, v23
	ldr	x12, [x10, #128]
	orr	x12, x12, #0x80000000
	add	x11, x11, #33
	stp	q24, q25, [x10, #96]
	str	x12, [x10, #128]
	add	x10, x10, #264
	cmp	x9, x11
	b.ge	LBB3_26
; %bb.27:
	sub	x10, x11, #33
	b	LBB3_128
LBB3_28:
	add	x11, x10, #37
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.29:
Lloh164:
	adrp	x12, lCPI3_325@PAGE
Lloh165:
	ldr	q0, [x12, lCPI3_325@PAGEOFF]
Lloh166:
	adrp	x12, lCPI3_326@PAGE
Lloh167:
	ldr	q1, [x12, lCPI3_326@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh168:
	adrp	x12, lCPI3_327@PAGE
Lloh169:
	ldr	q2, [x12, lCPI3_327@PAGEOFF]
	add	x10, x10, #144
Lloh170:
	adrp	x12, lCPI3_328@PAGE
Lloh171:
	ldr	q3, [x12, lCPI3_328@PAGEOFF]
Lloh172:
	adrp	x12, lCPI3_329@PAGE
Lloh173:
	ldr	q4, [x12, lCPI3_329@PAGEOFF]
Lloh174:
	adrp	x12, lCPI3_330@PAGE
Lloh175:
	ldr	q5, [x12, lCPI3_330@PAGEOFF]
Lloh176:
	adrp	x12, lCPI3_331@PAGE
Lloh177:
	ldr	q6, [x12, lCPI3_331@PAGEOFF]
Lloh178:
	adrp	x12, lCPI3_332@PAGE
Lloh179:
	ldr	q7, [x12, lCPI3_332@PAGEOFF]
Lloh180:
	adrp	x12, lCPI3_333@PAGE
Lloh181:
	ldr	q16, [x12, lCPI3_333@PAGEOFF]
Lloh182:
	adrp	x12, lCPI3_334@PAGE
Lloh183:
	ldr	q17, [x12, lCPI3_334@PAGEOFF]
Lloh184:
	adrp	x12, lCPI3_335@PAGE
Lloh185:
	ldr	q18, [x12, lCPI3_335@PAGEOFF]
Lloh186:
	adrp	x12, lCPI3_336@PAGE
Lloh187:
	ldr	q19, [x12, lCPI3_336@PAGEOFF]
Lloh188:
	adrp	x12, lCPI3_337@PAGE
Lloh189:
	ldr	q20, [x12, lCPI3_337@PAGEOFF]
Lloh190:
	adrp	x12, lCPI3_338@PAGE
Lloh191:
	ldr	q21, [x12, lCPI3_338@PAGEOFF]
Lloh192:
	adrp	x12, lCPI3_339@PAGE
Lloh193:
	ldr	q22, [x12, lCPI3_339@PAGEOFF]
Lloh194:
	adrp	x12, lCPI3_340@PAGE
Lloh195:
	ldr	q23, [x12, lCPI3_340@PAGEOFF]
Lloh196:
	adrp	x12, lCPI3_341@PAGE
Lloh197:
	ldr	q24, [x12, lCPI3_341@PAGEOFF]
Lloh198:
	adrp	x12, lCPI3_342@PAGE
Lloh199:
	ldr	q25, [x12, lCPI3_342@PAGEOFF]
LBB3_30:                                ; =>This Inner Loop Header: Depth=1
	ldp	q26, q27, [x10, #-144]
	orr.16b	v26, v26, v0
	orr.16b	v27, v27, v1
	stp	q26, q27, [x10, #-144]
	ldp	q26, q27, [x10, #-112]
	orr.16b	v26, v26, v2
	orr.16b	v27, v27, v3
	stp	q26, q27, [x10, #-112]
	ldp	q26, q27, [x10, #-80]
	orr.16b	v26, v26, v4
	orr.16b	v27, v27, v5
	stp	q26, q27, [x10, #-80]
	ldp	q26, q27, [x10, #-48]
	orr.16b	v26, v26, v6
	orr.16b	v27, v27, v7
	stp	q26, q27, [x10, #-48]
	ldp	q26, q27, [x10, #-16]
	orr.16b	v26, v26, v16
	orr.16b	v27, v27, v17
	stp	q26, q27, [x10, #-16]
	ldp	q26, q27, [x10, #16]
	orr.16b	v26, v26, v18
	orr.16b	v27, v27, v19
	stp	q26, q27, [x10, #16]
	ldp	q26, q27, [x10, #48]
	orr.16b	v26, v26, v20
	orr.16b	v27, v27, v21
	stp	q26, q27, [x10, #48]
	ldp	q26, q27, [x10, #80]
	orr.16b	v26, v26, v22
	orr.16b	v27, v27, v23
	stp	q26, q27, [x10, #80]
	ldp	q26, q27, [x10, #112]
	orr.16b	v26, v26, v24
	orr.16b	v27, v27, v25
	ldr	x12, [x10, #144]
	orr	x12, x12, #0x8000000
	add	x11, x11, #37
	stp	q26, q27, [x10, #112]
	str	x12, [x10, #144]
	add	x10, x10, #296
	cmp	x9, x11
	b.ge	LBB3_30
; %bb.31:
	sub	x10, x11, #37
	b	LBB3_128
LBB3_32:
	add	x11, x10, #29
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.33:
Lloh200:
	adrp	x12, lCPI3_391@PAGE
Lloh201:
	ldr	q0, [x12, lCPI3_391@PAGEOFF]
Lloh202:
	adrp	x12, lCPI3_392@PAGE
Lloh203:
	ldr	q1, [x12, lCPI3_392@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh204:
	adrp	x12, lCPI3_393@PAGE
Lloh205:
	ldr	q2, [x12, lCPI3_393@PAGEOFF]
	add	x10, x10, #112
Lloh206:
	adrp	x12, lCPI3_394@PAGE
Lloh207:
	ldr	q3, [x12, lCPI3_394@PAGEOFF]
Lloh208:
	adrp	x12, lCPI3_395@PAGE
Lloh209:
	ldr	q4, [x12, lCPI3_395@PAGEOFF]
Lloh210:
	adrp	x12, lCPI3_396@PAGE
Lloh211:
	ldr	q5, [x12, lCPI3_396@PAGEOFF]
Lloh212:
	adrp	x12, lCPI3_397@PAGE
Lloh213:
	ldr	q6, [x12, lCPI3_397@PAGEOFF]
Lloh214:
	adrp	x12, lCPI3_398@PAGE
Lloh215:
	ldr	q7, [x12, lCPI3_398@PAGEOFF]
Lloh216:
	adrp	x12, lCPI3_399@PAGE
Lloh217:
	ldr	q16, [x12, lCPI3_399@PAGEOFF]
Lloh218:
	adrp	x12, lCPI3_400@PAGE
Lloh219:
	ldr	q17, [x12, lCPI3_400@PAGEOFF]
Lloh220:
	adrp	x12, lCPI3_401@PAGE
Lloh221:
	ldr	q18, [x12, lCPI3_401@PAGEOFF]
Lloh222:
	adrp	x12, lCPI3_402@PAGE
Lloh223:
	ldr	q19, [x12, lCPI3_402@PAGEOFF]
Lloh224:
	adrp	x12, lCPI3_403@PAGE
Lloh225:
	ldr	q20, [x12, lCPI3_403@PAGEOFF]
Lloh226:
	adrp	x12, lCPI3_404@PAGE
Lloh227:
	ldr	q21, [x12, lCPI3_404@PAGEOFF]
	mov	x12, #64                        ; =0x40
	movk	x12, #8, lsl #32
LBB3_34:                                ; =>This Inner Loop Header: Depth=1
	ldp	q22, q23, [x10, #-112]
	orr.16b	v22, v22, v0
	orr.16b	v23, v23, v1
	stp	q22, q23, [x10, #-112]
	ldp	q22, q23, [x10, #-80]
	orr.16b	v22, v22, v2
	orr.16b	v23, v23, v3
	stp	q22, q23, [x10, #-80]
	ldp	q22, q23, [x10, #-48]
	orr.16b	v22, v22, v4
	orr.16b	v23, v23, v5
	stp	q22, q23, [x10, #-48]
	ldp	q22, q23, [x10, #-16]
	orr.16b	v22, v22, v6
	orr.16b	v23, v23, v7
	stp	q22, q23, [x10, #-16]
	ldp	q22, q23, [x10, #16]
	orr.16b	v22, v22, v16
	orr.16b	v23, v23, v17
	stp	q22, q23, [x10, #16]
	ldp	q22, q23, [x10, #48]
	orr.16b	v22, v22, v18
	orr.16b	v23, v23, v19
	stp	q22, q23, [x10, #48]
	ldp	q22, q23, [x10, #80]
	orr.16b	v22, v22, v20
	orr.16b	v23, v23, v21
	ldr	x13, [x10, #112]
	orr	x13, x13, x12
	add	x11, x11, #29
	stp	q22, q23, [x10, #80]
	str	x13, [x10, #112]
	add	x10, x10, #232
	cmp	x9, x11
	b.ge	LBB3_34
; %bb.35:
	sub	x10, x11, #29
	b	LBB3_128
LBB3_36:
	add	x11, x10, #43
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.37:
Lloh228:
	adrp	x12, lCPI3_265@PAGE
Lloh229:
	ldr	q0, [x12, lCPI3_265@PAGEOFF]
Lloh230:
	adrp	x12, lCPI3_266@PAGE
Lloh231:
	ldr	q1, [x12, lCPI3_266@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh232:
	adrp	x12, lCPI3_267@PAGE
Lloh233:
	ldr	q2, [x12, lCPI3_267@PAGEOFF]
	add	x10, x10, #176
Lloh234:
	adrp	x12, lCPI3_268@PAGE
Lloh235:
	ldr	q3, [x12, lCPI3_268@PAGEOFF]
Lloh236:
	adrp	x12, lCPI3_269@PAGE
Lloh237:
	ldr	q4, [x12, lCPI3_269@PAGEOFF]
Lloh238:
	adrp	x12, lCPI3_270@PAGE
Lloh239:
	ldr	q5, [x12, lCPI3_270@PAGEOFF]
Lloh240:
	adrp	x12, lCPI3_271@PAGE
Lloh241:
	ldr	q6, [x12, lCPI3_271@PAGEOFF]
Lloh242:
	adrp	x12, lCPI3_272@PAGE
Lloh243:
	ldr	q7, [x12, lCPI3_272@PAGEOFF]
Lloh244:
	adrp	x12, lCPI3_273@PAGE
Lloh245:
	ldr	q16, [x12, lCPI3_273@PAGEOFF]
Lloh246:
	adrp	x12, lCPI3_274@PAGE
Lloh247:
	ldr	q17, [x12, lCPI3_274@PAGEOFF]
Lloh248:
	adrp	x12, lCPI3_275@PAGE
Lloh249:
	ldr	q18, [x12, lCPI3_275@PAGEOFF]
Lloh250:
	adrp	x12, lCPI3_276@PAGE
Lloh251:
	ldr	q19, [x12, lCPI3_276@PAGEOFF]
Lloh252:
	adrp	x12, lCPI3_277@PAGE
Lloh253:
	ldr	q20, [x12, lCPI3_277@PAGEOFF]
Lloh254:
	adrp	x12, lCPI3_278@PAGE
Lloh255:
	ldr	q21, [x12, lCPI3_278@PAGEOFF]
Lloh256:
	adrp	x12, lCPI3_279@PAGE
Lloh257:
	ldr	q22, [x12, lCPI3_279@PAGEOFF]
Lloh258:
	adrp	x12, lCPI3_280@PAGE
Lloh259:
	ldr	q23, [x12, lCPI3_280@PAGEOFF]
Lloh260:
	adrp	x12, lCPI3_281@PAGE
Lloh261:
	ldr	q24, [x12, lCPI3_281@PAGEOFF]
Lloh262:
	adrp	x12, lCPI3_282@PAGE
Lloh263:
	ldr	q25, [x12, lCPI3_282@PAGEOFF]
Lloh264:
	adrp	x12, lCPI3_283@PAGE
Lloh265:
	ldr	q26, [x12, lCPI3_283@PAGEOFF]
Lloh266:
	adrp	x12, lCPI3_284@PAGE
Lloh267:
	ldr	q27, [x12, lCPI3_284@PAGEOFF]
Lloh268:
	adrp	x12, lCPI3_285@PAGE
Lloh269:
	ldr	q28, [x12, lCPI3_285@PAGEOFF]
LBB3_38:                                ; =>This Inner Loop Header: Depth=1
	ldp	q29, q30, [x10, #-176]
	orr.16b	v29, v29, v0
	orr.16b	v30, v30, v1
	stp	q29, q30, [x10, #-176]
	ldp	q29, q30, [x10, #-144]
	orr.16b	v29, v29, v2
	orr.16b	v30, v30, v3
	stp	q29, q30, [x10, #-144]
	ldp	q29, q30, [x10, #-112]
	orr.16b	v29, v29, v4
	orr.16b	v30, v30, v5
	stp	q29, q30, [x10, #-112]
	ldp	q29, q30, [x10, #-80]
	orr.16b	v29, v29, v6
	orr.16b	v30, v30, v7
	stp	q29, q30, [x10, #-80]
	ldp	q29, q30, [x10, #-48]
	orr.16b	v29, v29, v16
	orr.16b	v30, v30, v17
	stp	q29, q30, [x10, #-48]
	ldp	q29, q30, [x10, #-16]
	orr.16b	v29, v29, v18
	orr.16b	v30, v30, v19
	stp	q29, q30, [x10, #-16]
	ldp	q29, q30, [x10, #16]
	orr.16b	v29, v29, v20
	orr.16b	v30, v30, v21
	stp	q29, q30, [x10, #16]
	ldp	q29, q30, [x10, #48]
	orr.16b	v29, v29, v22
	orr.16b	v30, v30, v23
	stp	q29, q30, [x10, #48]
	ldp	q29, q30, [x10, #80]
	orr.16b	v29, v29, v24
	orr.16b	v30, v30, v25
	stp	q29, q30, [x10, #80]
	ldp	q29, q30, [x10, #112]
	orr.16b	v29, v29, v26
	orr.16b	v30, v30, v27
	stp	q29, q30, [x10, #112]
	ldr	q29, [x10, #144]
	orr.16b	v29, v29, v28
	ldr	x12, [x10, #160]
	orr	x12, x12, #0x200000
	add	x11, x11, #43
	str	q29, [x10, #144]
	str	x12, [x10, #160]
	add	x10, x10, #344
	cmp	x9, x11
	b.ge	LBB3_38
; %bb.39:
	sub	x10, x11, #43
	b	LBB3_128
LBB3_40:
	add	x11, x10, #21
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.41:
Lloh270:
	adrp	x12, lCPI3_441@PAGE
Lloh271:
	ldr	q0, [x12, lCPI3_441@PAGEOFF]
Lloh272:
	adrp	x12, lCPI3_442@PAGE
Lloh273:
	ldr	q1, [x12, lCPI3_442@PAGEOFF]
	add	x10, x8, x10, lsl #3
	add	x10, x10, #80
Lloh274:
	adrp	x12, lCPI3_443@PAGE
Lloh275:
	ldr	q2, [x12, lCPI3_443@PAGEOFF]
Lloh276:
	adrp	x12, lCPI3_444@PAGE
Lloh277:
	ldr	q3, [x12, lCPI3_444@PAGEOFF]
Lloh278:
	adrp	x12, lCPI3_445@PAGE
Lloh279:
	ldr	q4, [x12, lCPI3_445@PAGEOFF]
Lloh280:
	adrp	x12, lCPI3_446@PAGE
Lloh281:
	ldr	q5, [x12, lCPI3_446@PAGEOFF]
Lloh282:
	adrp	x12, lCPI3_447@PAGE
Lloh283:
	ldr	q6, [x12, lCPI3_447@PAGEOFF]
Lloh284:
	adrp	x12, lCPI3_448@PAGE
Lloh285:
	ldr	q7, [x12, lCPI3_448@PAGEOFF]
Lloh286:
	adrp	x12, lCPI3_449@PAGE
Lloh287:
	ldr	q16, [x12, lCPI3_449@PAGEOFF]
Lloh288:
	adrp	x12, lCPI3_450@PAGE
Lloh289:
	ldr	q17, [x12, lCPI3_450@PAGEOFF]
	mov	x12, #2                         ; =0x2
	movk	x12, #64, lsl #16
	movk	x12, #2048, lsl #32
LBB3_42:                                ; =>This Inner Loop Header: Depth=1
	ldp	q18, q19, [x10, #-80]
	orr.16b	v18, v18, v0
	orr.16b	v19, v19, v1
	stp	q18, q19, [x10, #-80]
	ldp	q18, q19, [x10, #-48]
	orr.16b	v18, v18, v2
	orr.16b	v19, v19, v3
	stp	q18, q19, [x10, #-48]
	ldp	q18, q19, [x10, #-16]
	orr.16b	v18, v18, v4
	orr.16b	v19, v19, v5
	stp	q18, q19, [x10, #-16]
	ldp	q18, q19, [x10, #16]
	orr.16b	v18, v18, v6
	orr.16b	v19, v19, v7
	stp	q18, q19, [x10, #16]
	ldp	q18, q19, [x10, #48]
	orr.16b	v18, v18, v16
	orr.16b	v19, v19, v17
	ldr	x13, [x10, #80]
	orr	x13, x13, x12
	add	x11, x11, #21
	stp	q18, q19, [x10, #48]
	str	x13, [x10, #80]
	add	x10, x10, #168
	cmp	x9, x11
	b.ge	LBB3_42
; %bb.43:
	sub	x10, x11, #21
	b	LBB3_128
LBB3_44:
	add	x11, x10, #49
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.45:
Lloh290:
	adrp	x12, lCPI3_196@PAGE
Lloh291:
	ldr	q0, [x12, lCPI3_196@PAGEOFF]
Lloh292:
	adrp	x12, lCPI3_197@PAGE
Lloh293:
	ldr	q1, [x12, lCPI3_197@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh294:
	adrp	x12, lCPI3_198@PAGE
Lloh295:
	ldr	q2, [x12, lCPI3_198@PAGEOFF]
	add	x10, x10, #192
Lloh296:
	adrp	x12, lCPI3_199@PAGE
Lloh297:
	ldr	q3, [x12, lCPI3_199@PAGEOFF]
Lloh298:
	adrp	x12, lCPI3_200@PAGE
Lloh299:
	ldr	q4, [x12, lCPI3_200@PAGEOFF]
Lloh300:
	adrp	x12, lCPI3_201@PAGE
Lloh301:
	ldr	q5, [x12, lCPI3_201@PAGEOFF]
Lloh302:
	adrp	x12, lCPI3_202@PAGE
Lloh303:
	ldr	q6, [x12, lCPI3_202@PAGEOFF]
Lloh304:
	adrp	x12, lCPI3_203@PAGE
Lloh305:
	ldr	q7, [x12, lCPI3_203@PAGEOFF]
Lloh306:
	adrp	x12, lCPI3_204@PAGE
Lloh307:
	ldr	q16, [x12, lCPI3_204@PAGEOFF]
Lloh308:
	adrp	x12, lCPI3_205@PAGE
Lloh309:
	ldr	q17, [x12, lCPI3_205@PAGEOFF]
Lloh310:
	adrp	x12, lCPI3_206@PAGE
Lloh311:
	ldr	q18, [x12, lCPI3_206@PAGEOFF]
Lloh312:
	adrp	x12, lCPI3_207@PAGE
Lloh313:
	ldr	q19, [x12, lCPI3_207@PAGEOFF]
Lloh314:
	adrp	x12, lCPI3_208@PAGE
Lloh315:
	ldr	q20, [x12, lCPI3_208@PAGEOFF]
Lloh316:
	adrp	x12, lCPI3_209@PAGE
Lloh317:
	ldr	q21, [x12, lCPI3_209@PAGEOFF]
Lloh318:
	adrp	x12, lCPI3_210@PAGE
Lloh319:
	ldr	q22, [x12, lCPI3_210@PAGEOFF]
Lloh320:
	adrp	x12, lCPI3_211@PAGE
Lloh321:
	ldr	q23, [x12, lCPI3_211@PAGEOFF]
Lloh322:
	adrp	x12, lCPI3_212@PAGE
Lloh323:
	ldr	q24, [x12, lCPI3_212@PAGEOFF]
Lloh324:
	adrp	x12, lCPI3_213@PAGE
Lloh325:
	ldr	q25, [x12, lCPI3_213@PAGEOFF]
Lloh326:
	adrp	x12, lCPI3_214@PAGE
Lloh327:
	ldr	q26, [x12, lCPI3_214@PAGEOFF]
Lloh328:
	adrp	x12, lCPI3_215@PAGE
Lloh329:
	ldr	q27, [x12, lCPI3_215@PAGEOFF]
Lloh330:
	adrp	x12, lCPI3_216@PAGE
Lloh331:
	ldr	q28, [x12, lCPI3_216@PAGEOFF]
Lloh332:
	adrp	x12, lCPI3_217@PAGE
Lloh333:
	ldr	q29, [x12, lCPI3_217@PAGEOFF]
Lloh334:
	adrp	x12, lCPI3_218@PAGE
Lloh335:
	ldr	q30, [x12, lCPI3_218@PAGEOFF]
Lloh336:
	adrp	x12, lCPI3_219@PAGE
Lloh337:
	ldr	q31, [x12, lCPI3_219@PAGEOFF]
LBB3_46:                                ; =>This Inner Loop Header: Depth=1
	ldp	q8, q9, [x10, #-192]
	orr.16b	v8, v8, v0
	orr.16b	v9, v9, v1
	stp	q8, q9, [x10, #-192]
	ldp	q8, q9, [x10, #-160]
	orr.16b	v8, v8, v2
	orr.16b	v9, v9, v3
	stp	q8, q9, [x10, #-160]
	ldp	q8, q9, [x10, #-128]
	orr.16b	v8, v8, v4
	orr.16b	v9, v9, v5
	stp	q8, q9, [x10, #-128]
	ldp	q8, q9, [x10, #-96]
	orr.16b	v8, v8, v6
	orr.16b	v9, v9, v7
	stp	q8, q9, [x10, #-96]
	ldp	q8, q9, [x10, #-64]
	orr.16b	v8, v8, v16
	orr.16b	v9, v9, v17
	stp	q8, q9, [x10, #-64]
	ldp	q8, q9, [x10, #-32]
	orr.16b	v8, v8, v18
	orr.16b	v9, v9, v19
	stp	q8, q9, [x10, #-32]
	ldp	q8, q9, [x10]
	orr.16b	v8, v8, v20
	orr.16b	v9, v9, v21
	stp	q8, q9, [x10]
	ldp	q8, q9, [x10, #32]
	orr.16b	v8, v8, v22
	orr.16b	v9, v9, v23
	stp	q8, q9, [x10, #32]
	ldp	q8, q9, [x10, #64]
	orr.16b	v8, v8, v24
	orr.16b	v9, v9, v25
	stp	q8, q9, [x10, #64]
	ldp	q8, q9, [x10, #96]
	orr.16b	v8, v8, v26
	orr.16b	v9, v9, v27
	stp	q8, q9, [x10, #96]
	ldp	q8, q9, [x10, #128]
	orr.16b	v8, v8, v28
	orr.16b	v9, v9, v29
	stp	q8, q9, [x10, #128]
	ldp	q8, q9, [x10, #160]
	orr.16b	v8, v8, v30
	orr.16b	v9, v9, v31
	ldr	x12, [x10, #192]
	orr	x12, x12, #0x8000
	add	x11, x11, #49
	stp	q8, q9, [x10, #160]
	str	x12, [x10, #192]
	add	x10, x10, #392
	cmp	x9, x11
	b.ge	LBB3_46
; %bb.47:
	sub	x10, x11, #49
	b	LBB3_128
LBB3_48:
	add	x11, x10, #17
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.49:
	add	x10, x8, x10, lsl #3
	add	x10, x10, #64
Lloh338:
	adrp	x12, lCPI3_460@PAGE
Lloh339:
	ldr	q0, [x12, lCPI3_460@PAGEOFF]
Lloh340:
	adrp	x12, lCPI3_461@PAGE
Lloh341:
	ldr	q1, [x12, lCPI3_461@PAGEOFF]
Lloh342:
	adrp	x12, lCPI3_462@PAGE
Lloh343:
	ldr	q2, [x12, lCPI3_462@PAGEOFF]
Lloh344:
	adrp	x12, lCPI3_463@PAGE
Lloh345:
	ldr	q3, [x12, lCPI3_463@PAGEOFF]
Lloh346:
	adrp	x12, lCPI3_464@PAGE
Lloh347:
	ldr	q4, [x12, lCPI3_464@PAGEOFF]
Lloh348:
	adrp	x12, lCPI3_465@PAGE
Lloh349:
	ldr	q5, [x12, lCPI3_465@PAGEOFF]
Lloh350:
	adrp	x12, lCPI3_466@PAGE
Lloh351:
	ldr	q6, [x12, lCPI3_466@PAGEOFF]
Lloh352:
	adrp	x12, lCPI3_467@PAGE
Lloh353:
	ldr	q7, [x12, lCPI3_467@PAGEOFF]
	mov	x12, #8192                      ; =0x2000
	movk	x12, #16384, lsl #16
	movk	x12, #32768, lsl #32
LBB3_50:                                ; =>This Inner Loop Header: Depth=1
	ldp	q16, q17, [x10, #-64]
	orr.16b	v16, v16, v0
	orr.16b	v17, v17, v1
	stp	q16, q17, [x10, #-64]
	ldp	q16, q17, [x10, #-32]
	orr.16b	v16, v16, v2
	orr.16b	v17, v17, v3
	stp	q16, q17, [x10, #-32]
	ldp	q16, q17, [x10]
	orr.16b	v16, v16, v4
	orr.16b	v17, v17, v5
	stp	q16, q17, [x10]
	ldp	q16, q17, [x10, #32]
	orr.16b	v16, v16, v6
	orr.16b	v17, v17, v7
	ldr	x13, [x10, #64]
	orr	x13, x13, x12
	add	x11, x11, #17
	stp	q16, q17, [x10, #32]
	str	x13, [x10, #64]
	add	x10, x10, #136
	cmp	x9, x11
	b.ge	LBB3_50
; %bb.51:
	sub	x10, x11, #17
	b	LBB3_128
LBB3_52:
	add	x11, x10, #35
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.53:
Lloh354:
	adrp	x12, lCPI3_343@PAGE
Lloh355:
	ldr	q0, [x12, lCPI3_343@PAGEOFF]
Lloh356:
	adrp	x12, lCPI3_344@PAGE
Lloh357:
	ldr	q1, [x12, lCPI3_344@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh358:
	adrp	x12, lCPI3_345@PAGE
Lloh359:
	ldr	q2, [x12, lCPI3_345@PAGEOFF]
	add	x10, x10, #144
Lloh360:
	adrp	x12, lCPI3_346@PAGE
Lloh361:
	ldr	q3, [x12, lCPI3_346@PAGEOFF]
Lloh362:
	adrp	x12, lCPI3_347@PAGE
Lloh363:
	ldr	q4, [x12, lCPI3_347@PAGEOFF]
Lloh364:
	adrp	x12, lCPI3_348@PAGE
Lloh365:
	ldr	q5, [x12, lCPI3_348@PAGEOFF]
Lloh366:
	adrp	x12, lCPI3_349@PAGE
Lloh367:
	ldr	q6, [x12, lCPI3_349@PAGEOFF]
Lloh368:
	adrp	x12, lCPI3_350@PAGE
Lloh369:
	ldr	q7, [x12, lCPI3_350@PAGEOFF]
Lloh370:
	adrp	x12, lCPI3_351@PAGE
Lloh371:
	ldr	q16, [x12, lCPI3_351@PAGEOFF]
Lloh372:
	adrp	x12, lCPI3_352@PAGE
Lloh373:
	ldr	q17, [x12, lCPI3_352@PAGEOFF]
Lloh374:
	adrp	x12, lCPI3_353@PAGE
Lloh375:
	ldr	q18, [x12, lCPI3_353@PAGEOFF]
Lloh376:
	adrp	x12, lCPI3_354@PAGE
Lloh377:
	ldr	q19, [x12, lCPI3_354@PAGEOFF]
Lloh378:
	adrp	x12, lCPI3_355@PAGE
Lloh379:
	ldr	q20, [x12, lCPI3_355@PAGEOFF]
Lloh380:
	adrp	x12, lCPI3_356@PAGE
Lloh381:
	ldr	q21, [x12, lCPI3_356@PAGEOFF]
Lloh382:
	adrp	x12, lCPI3_357@PAGE
Lloh383:
	ldr	q22, [x12, lCPI3_357@PAGEOFF]
Lloh384:
	adrp	x12, lCPI3_358@PAGE
Lloh385:
	ldr	q23, [x12, lCPI3_358@PAGEOFF]
Lloh386:
	adrp	x12, lCPI3_359@PAGE
Lloh387:
	ldr	q24, [x12, lCPI3_359@PAGEOFF]
LBB3_54:                                ; =>This Inner Loop Header: Depth=1
	ldp	q25, q26, [x10, #-144]
	orr.16b	v25, v25, v0
	orr.16b	v26, v26, v1
	stp	q25, q26, [x10, #-144]
	ldp	q25, q26, [x10, #-112]
	orr.16b	v25, v25, v2
	orr.16b	v26, v26, v3
	stp	q25, q26, [x10, #-112]
	ldp	q25, q26, [x10, #-80]
	orr.16b	v25, v25, v4
	orr.16b	v26, v26, v5
	stp	q25, q26, [x10, #-80]
	ldp	q25, q26, [x10, #-48]
	orr.16b	v25, v25, v6
	orr.16b	v26, v26, v7
	stp	q25, q26, [x10, #-48]
	ldp	q25, q26, [x10, #-16]
	orr.16b	v25, v25, v16
	orr.16b	v26, v26, v17
	stp	q25, q26, [x10, #-16]
	ldp	q25, q26, [x10, #16]
	orr.16b	v25, v25, v18
	orr.16b	v26, v26, v19
	stp	q25, q26, [x10, #16]
	ldp	q25, q26, [x10, #48]
	orr.16b	v25, v25, v20
	orr.16b	v26, v26, v21
	stp	q25, q26, [x10, #48]
	ldp	q25, q26, [x10, #80]
	orr.16b	v25, v25, v22
	orr.16b	v26, v26, v23
	stp	q25, q26, [x10, #80]
	ldr	q25, [x10, #112]
	orr.16b	v25, v25, v24
	ldr	x12, [x10, #128]
	orr	x12, x12, #0x20000000
	add	x11, x11, #35
	str	q25, [x10, #112]
	str	x12, [x10, #128]
	add	x10, x10, #280
	cmp	x9, x11
	b.ge	LBB3_54
; %bb.55:
	sub	x10, x11, #35
	b	LBB3_128
LBB3_56:
	add	x11, x10, #39
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.57:
Lloh388:
	adrp	x12, lCPI3_306@PAGE
Lloh389:
	ldr	q0, [x12, lCPI3_306@PAGEOFF]
Lloh390:
	adrp	x12, lCPI3_307@PAGE
Lloh391:
	ldr	q1, [x12, lCPI3_307@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh392:
	adrp	x12, lCPI3_308@PAGE
Lloh393:
	ldr	q2, [x12, lCPI3_308@PAGEOFF]
	add	x10, x10, #160
Lloh394:
	adrp	x12, lCPI3_309@PAGE
Lloh395:
	ldr	q3, [x12, lCPI3_309@PAGEOFF]
Lloh396:
	adrp	x12, lCPI3_310@PAGE
Lloh397:
	ldr	q4, [x12, lCPI3_310@PAGEOFF]
Lloh398:
	adrp	x12, lCPI3_311@PAGE
Lloh399:
	ldr	q5, [x12, lCPI3_311@PAGEOFF]
Lloh400:
	adrp	x12, lCPI3_312@PAGE
Lloh401:
	ldr	q6, [x12, lCPI3_312@PAGEOFF]
Lloh402:
	adrp	x12, lCPI3_313@PAGE
Lloh403:
	ldr	q7, [x12, lCPI3_313@PAGEOFF]
Lloh404:
	adrp	x12, lCPI3_314@PAGE
Lloh405:
	ldr	q16, [x12, lCPI3_314@PAGEOFF]
Lloh406:
	adrp	x12, lCPI3_315@PAGE
Lloh407:
	ldr	q17, [x12, lCPI3_315@PAGEOFF]
Lloh408:
	adrp	x12, lCPI3_316@PAGE
Lloh409:
	ldr	q18, [x12, lCPI3_316@PAGEOFF]
Lloh410:
	adrp	x12, lCPI3_317@PAGE
Lloh411:
	ldr	q19, [x12, lCPI3_317@PAGEOFF]
Lloh412:
	adrp	x12, lCPI3_318@PAGE
Lloh413:
	ldr	q20, [x12, lCPI3_318@PAGEOFF]
Lloh414:
	adrp	x12, lCPI3_319@PAGE
Lloh415:
	ldr	q21, [x12, lCPI3_319@PAGEOFF]
Lloh416:
	adrp	x12, lCPI3_320@PAGE
Lloh417:
	ldr	q22, [x12, lCPI3_320@PAGEOFF]
Lloh418:
	adrp	x12, lCPI3_321@PAGE
Lloh419:
	ldr	q23, [x12, lCPI3_321@PAGEOFF]
Lloh420:
	adrp	x12, lCPI3_322@PAGE
Lloh421:
	ldr	q24, [x12, lCPI3_322@PAGEOFF]
Lloh422:
	adrp	x12, lCPI3_323@PAGE
Lloh423:
	ldr	q25, [x12, lCPI3_323@PAGEOFF]
Lloh424:
	adrp	x12, lCPI3_324@PAGE
Lloh425:
	ldr	q26, [x12, lCPI3_324@PAGEOFF]
LBB3_58:                                ; =>This Inner Loop Header: Depth=1
	ldp	q27, q28, [x10, #-160]
	orr.16b	v27, v27, v0
	orr.16b	v28, v28, v1
	stp	q27, q28, [x10, #-160]
	ldp	q27, q28, [x10, #-128]
	orr.16b	v27, v27, v2
	orr.16b	v28, v28, v3
	stp	q27, q28, [x10, #-128]
	ldp	q27, q28, [x10, #-96]
	orr.16b	v27, v27, v4
	orr.16b	v28, v28, v5
	stp	q27, q28, [x10, #-96]
	ldp	q27, q28, [x10, #-64]
	orr.16b	v27, v27, v6
	orr.16b	v28, v28, v7
	stp	q27, q28, [x10, #-64]
	ldp	q27, q28, [x10, #-32]
	orr.16b	v27, v27, v16
	orr.16b	v28, v28, v17
	stp	q27, q28, [x10, #-32]
	ldp	q27, q28, [x10]
	orr.16b	v27, v27, v18
	orr.16b	v28, v28, v19
	stp	q27, q28, [x10]
	ldp	q27, q28, [x10, #32]
	orr.16b	v27, v27, v20
	orr.16b	v28, v28, v21
	stp	q27, q28, [x10, #32]
	ldp	q27, q28, [x10, #64]
	orr.16b	v27, v27, v22
	orr.16b	v28, v28, v23
	stp	q27, q28, [x10, #64]
	ldp	q27, q28, [x10, #96]
	orr.16b	v27, v27, v24
	orr.16b	v28, v28, v25
	stp	q27, q28, [x10, #96]
	ldr	q27, [x10, #128]
	orr.16b	v27, v27, v26
	ldr	x12, [x10, #144]
	orr	x12, x12, #0x2000000
	add	x11, x11, #39
	str	q27, [x10, #128]
	str	x12, [x10, #144]
	add	x10, x10, #312
	cmp	x9, x11
	b.ge	LBB3_58
; %bb.59:
	sub	x10, x11, #39
	b	LBB3_128
LBB3_60:
	add	x11, x10, #23
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.61:
Lloh426:
	adrp	x12, lCPI3_430@PAGE
Lloh427:
	ldr	q0, [x12, lCPI3_430@PAGEOFF]
Lloh428:
	adrp	x12, lCPI3_431@PAGE
Lloh429:
	ldr	q1, [x12, lCPI3_431@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh430:
	adrp	x12, lCPI3_432@PAGE
Lloh431:
	ldr	q2, [x12, lCPI3_432@PAGEOFF]
	add	x10, x10, #96
Lloh432:
	adrp	x12, lCPI3_433@PAGE
Lloh433:
	ldr	q3, [x12, lCPI3_433@PAGEOFF]
Lloh434:
	adrp	x12, lCPI3_434@PAGE
Lloh435:
	ldr	q4, [x12, lCPI3_434@PAGEOFF]
Lloh436:
	adrp	x12, lCPI3_435@PAGE
Lloh437:
	ldr	q5, [x12, lCPI3_435@PAGEOFF]
Lloh438:
	adrp	x12, lCPI3_436@PAGE
Lloh439:
	ldr	q6, [x12, lCPI3_436@PAGEOFF]
Lloh440:
	adrp	x12, lCPI3_437@PAGE
Lloh441:
	ldr	q7, [x12, lCPI3_437@PAGEOFF]
Lloh442:
	adrp	x12, lCPI3_438@PAGE
Lloh443:
	ldr	q16, [x12, lCPI3_438@PAGEOFF]
Lloh444:
	adrp	x12, lCPI3_439@PAGE
Lloh445:
	ldr	q17, [x12, lCPI3_439@PAGEOFF]
Lloh446:
	adrp	x12, lCPI3_440@PAGE
Lloh447:
	ldr	q18, [x12, lCPI3_440@PAGEOFF]
	mov	x12, #262144                    ; =0x40000
	movk	x12, #512, lsl #32
LBB3_62:                                ; =>This Inner Loop Header: Depth=1
	ldp	q19, q20, [x10, #-96]
	orr.16b	v19, v19, v0
	orr.16b	v20, v20, v1
	stp	q19, q20, [x10, #-96]
	ldp	q19, q20, [x10, #-64]
	orr.16b	v19, v19, v2
	orr.16b	v20, v20, v3
	stp	q19, q20, [x10, #-64]
	ldp	q19, q20, [x10, #-32]
	orr.16b	v19, v19, v4
	orr.16b	v20, v20, v5
	stp	q19, q20, [x10, #-32]
	ldp	q19, q20, [x10]
	orr.16b	v19, v19, v6
	orr.16b	v20, v20, v7
	stp	q19, q20, [x10]
	ldp	q19, q20, [x10, #32]
	orr.16b	v19, v19, v16
	orr.16b	v20, v20, v17
	stp	q19, q20, [x10, #32]
	ldr	q19, [x10, #64]
	orr.16b	v19, v19, v18
	ldr	x13, [x10, #80]
	orr	x13, x13, x12
	add	x11, x11, #23
	str	q19, [x10, #64]
	str	x13, [x10, #80]
	add	x10, x10, #184
	cmp	x9, x11
	b.ge	LBB3_62
; %bb.63:
	sub	x10, x11, #23
	b	LBB3_128
LBB3_64:
	add	x11, x10, #19
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.65:
Lloh448:
	adrp	x12, lCPI3_451@PAGE
Lloh449:
	ldr	q0, [x12, lCPI3_451@PAGEOFF]
	add	x10, x8, x10, lsl #3
	add	x10, x10, #80
Lloh450:
	adrp	x12, lCPI3_452@PAGE
Lloh451:
	ldr	q1, [x12, lCPI3_452@PAGEOFF]
Lloh452:
	adrp	x12, lCPI3_453@PAGE
Lloh453:
	ldr	q2, [x12, lCPI3_453@PAGEOFF]
Lloh454:
	adrp	x12, lCPI3_454@PAGE
Lloh455:
	ldr	q3, [x12, lCPI3_454@PAGEOFF]
Lloh456:
	adrp	x12, lCPI3_455@PAGE
Lloh457:
	ldr	q4, [x12, lCPI3_455@PAGEOFF]
Lloh458:
	adrp	x12, lCPI3_456@PAGE
Lloh459:
	ldr	q5, [x12, lCPI3_456@PAGEOFF]
Lloh460:
	adrp	x12, lCPI3_457@PAGE
Lloh461:
	ldr	q6, [x12, lCPI3_457@PAGEOFF]
Lloh462:
	adrp	x12, lCPI3_458@PAGE
Lloh463:
	ldr	q7, [x12, lCPI3_458@PAGEOFF]
Lloh464:
	adrp	x12, lCPI3_459@PAGE
Lloh465:
	ldr	q16, [x12, lCPI3_459@PAGEOFF]
	mov	x12, #128                       ; =0x80
	movk	x12, #1024, lsl #16
	movk	x12, #8192, lsl #32
LBB3_66:                                ; =>This Inner Loop Header: Depth=1
	ldp	q17, q18, [x10, #-80]
	orr.16b	v17, v17, v0
	orr.16b	v18, v18, v1
	stp	q17, q18, [x10, #-80]
	ldp	q17, q18, [x10, #-48]
	orr.16b	v17, v17, v2
	orr.16b	v18, v18, v3
	stp	q17, q18, [x10, #-48]
	ldp	q17, q18, [x10, #-16]
	orr.16b	v17, v17, v4
	orr.16b	v18, v18, v5
	stp	q17, q18, [x10, #-16]
	ldp	q17, q18, [x10, #16]
	orr.16b	v17, v17, v6
	orr.16b	v18, v18, v7
	stp	q17, q18, [x10, #16]
	ldr	q17, [x10, #48]
	orr.16b	v17, v17, v16
	ldr	x13, [x10, #64]
	orr	x13, x13, x12
	add	x11, x11, #19
	str	q17, [x10, #48]
	str	x13, [x10, #64]
	add	x10, x10, #152
	cmp	x9, x11
	b.ge	LBB3_66
; %bb.67:
	sub	x10, x11, #19
	b	LBB3_128
LBB3_68:
	add	x11, x10, #9
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.69:
	add	x10, x8, x10, lsl #3
	add	x10, x10, #32
Lloh466:
	adrp	x12, lCPI3_486@PAGE
Lloh467:
	ldr	q0, [x12, lCPI3_486@PAGEOFF]
Lloh468:
	adrp	x12, lCPI3_487@PAGE
Lloh469:
	ldr	q1, [x12, lCPI3_487@PAGEOFF]
Lloh470:
	adrp	x12, lCPI3_488@PAGE
Lloh471:
	ldr	q2, [x12, lCPI3_488@PAGEOFF]
Lloh472:
	adrp	x12, lCPI3_489@PAGE
Lloh473:
	ldr	q3, [x12, lCPI3_489@PAGEOFF]
	mov	x12, #1026                      ; =0x402
	movk	x12, #4104, lsl #16
	movk	x12, #16416, lsl #32
	movk	x12, #128, lsl #48
LBB3_70:                                ; =>This Inner Loop Header: Depth=1
	ldp	q4, q5, [x10, #-32]
	orr.16b	v4, v4, v0
	orr.16b	v5, v5, v1
	stp	q4, q5, [x10, #-32]
	ldp	q4, q5, [x10]
	orr.16b	v4, v4, v2
	orr.16b	v5, v5, v3
	stp	q4, q5, [x10]
	ldr	x13, [x10, #32]
	orr	x13, x13, x12
	str	x13, [x10, #32]
	add	x11, x11, #9
	add	x10, x10, #72
	cmp	x9, x11
	b.ge	LBB3_70
; %bb.71:
	sub	x10, x11, #9
	b	LBB3_128
LBB3_72:
	add	x11, x10, #7
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.73:
	add	x10, x8, x10, lsl #3
	add	x10, x10, #32
Lloh474:
	adrp	x12, lCPI3_490@PAGE
Lloh475:
	ldr	q0, [x12, lCPI3_490@PAGEOFF]
Lloh476:
	adrp	x12, lCPI3_491@PAGE
Lloh477:
	ldr	q1, [x12, lCPI3_491@PAGEOFF]
Lloh478:
	adrp	x12, lCPI3_492@PAGE
Lloh479:
	ldr	q2, [x12, lCPI3_492@PAGEOFF]
	mov	x12, #33026                     ; =0x8102
	movk	x12, #8256, lsl #16
	movk	x12, #2064, lsl #32
	movk	x12, #516, lsl #48
LBB3_74:                                ; =>This Inner Loop Header: Depth=1
	ldp	q3, q4, [x10, #-32]
	orr.16b	v3, v3, v0
	orr.16b	v4, v4, v1
	stp	q3, q4, [x10, #-32]
	ldr	q3, [x10]
	orr.16b	v3, v3, v2
	str	q3, [x10]
	ldr	x13, [x10, #16]
	orr	x13, x13, x12
	str	x13, [x10, #16]
	add	x11, x11, #7
	add	x10, x10, #56
	cmp	x9, x11
	b.ge	LBB3_74
; %bb.75:
	sub	x10, x11, #7
	b	LBB3_128
LBB3_76:
	add	x11, x10, #11
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.77:
	add	x10, x8, x10, lsl #3
	add	x10, x10, #48
Lloh480:
	adrp	x12, lCPI3_481@PAGE
Lloh481:
	ldr	q0, [x12, lCPI3_481@PAGEOFF]
Lloh482:
	adrp	x12, lCPI3_482@PAGE
Lloh483:
	ldr	q1, [x12, lCPI3_482@PAGEOFF]
Lloh484:
	adrp	x12, lCPI3_483@PAGE
Lloh485:
	ldr	q2, [x12, lCPI3_483@PAGEOFF]
Lloh486:
	adrp	x12, lCPI3_484@PAGE
Lloh487:
	ldr	q3, [x12, lCPI3_484@PAGEOFF]
Lloh488:
	adrp	x12, lCPI3_485@PAGE
Lloh489:
	ldr	q4, [x12, lCPI3_485@PAGEOFF]
	mov	x12, #512                       ; =0x200
	movk	x12, #32784, lsl #16
	movk	x12, #1024, lsl #32
	movk	x12, #32, lsl #48
LBB3_78:                                ; =>This Inner Loop Header: Depth=1
	ldp	q5, q6, [x10, #-48]
	orr.16b	v5, v5, v0
	orr.16b	v6, v6, v1
	stp	q5, q6, [x10, #-48]
	ldp	q5, q6, [x10, #-16]
	orr.16b	v5, v5, v2
	orr.16b	v6, v6, v3
	stp	q5, q6, [x10, #-16]
	ldr	q5, [x10, #16]
	orr.16b	v5, v5, v4
	str	q5, [x10, #16]
	ldr	x13, [x10, #32]
	orr	x13, x13, x12
	str	x13, [x10, #32]
	add	x11, x11, #11
	add	x10, x10, #88
	cmp	x9, x11
	b.ge	LBB3_78
; %bb.79:
	sub	x10, x11, #11
	b	LBB3_128
LBB3_80:
	add	x11, x10, #15
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.81:
	add	x10, x8, x10, lsl #3
	add	x10, x10, #64
Lloh490:
	adrp	x12, lCPI3_468@PAGE
Lloh491:
	ldr	q0, [x12, lCPI3_468@PAGEOFF]
Lloh492:
	adrp	x12, lCPI3_469@PAGE
Lloh493:
	ldr	q1, [x12, lCPI3_469@PAGEOFF]
Lloh494:
	adrp	x12, lCPI3_470@PAGE
Lloh495:
	ldr	q2, [x12, lCPI3_470@PAGEOFF]
Lloh496:
	adrp	x12, lCPI3_471@PAGE
Lloh497:
	ldr	q3, [x12, lCPI3_471@PAGEOFF]
Lloh498:
	adrp	x12, lCPI3_472@PAGE
Lloh499:
	ldr	q4, [x12, lCPI3_472@PAGEOFF]
Lloh500:
	adrp	x12, lCPI3_473@PAGE
Lloh501:
	ldr	q5, [x12, lCPI3_473@PAGEOFF]
Lloh502:
	adrp	x12, lCPI3_474@PAGE
Lloh503:
	ldr	q6, [x12, lCPI3_474@PAGEOFF]
	mov	x12, #16                        ; =0x10
	movk	x12, #8, lsl #16
	movk	x12, #4, lsl #32
	movk	x12, #2, lsl #48
LBB3_82:                                ; =>This Inner Loop Header: Depth=1
	ldp	q7, q16, [x10, #-64]
	orr.16b	v7, v7, v0
	orr.16b	v16, v16, v1
	stp	q7, q16, [x10, #-64]
	ldp	q7, q16, [x10, #-32]
	orr.16b	v7, v7, v2
	orr.16b	v16, v16, v3
	stp	q7, q16, [x10, #-32]
	ldp	q7, q16, [x10]
	orr.16b	v7, v7, v4
	orr.16b	v16, v16, v5
	stp	q7, q16, [x10]
	ldr	q7, [x10, #32]
	orr.16b	v7, v7, v6
	ldr	x13, [x10, #48]
	orr	x13, x13, x12
	add	x11, x11, #15
	str	q7, [x10, #32]
	str	x13, [x10, #48]
	add	x10, x10, #120
	cmp	x9, x11
	b.ge	LBB3_82
; %bb.83:
	sub	x10, x11, #15
	b	LBB3_128
LBB3_84:
	add	x11, x10, #13
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.85:
	add	x10, x8, x10, lsl #3
	add	x10, x10, #48
Lloh504:
	adrp	x12, lCPI3_475@PAGE
Lloh505:
	ldr	q0, [x12, lCPI3_475@PAGEOFF]
Lloh506:
	adrp	x12, lCPI3_476@PAGE
Lloh507:
	ldr	q1, [x12, lCPI3_476@PAGEOFF]
Lloh508:
	adrp	x12, lCPI3_477@PAGE
Lloh509:
	ldr	q2, [x12, lCPI3_477@PAGEOFF]
Lloh510:
	adrp	x12, lCPI3_478@PAGE
Lloh511:
	ldr	q3, [x12, lCPI3_478@PAGEOFF]
Lloh512:
	adrp	x12, lCPI3_479@PAGE
Lloh513:
	ldr	q4, [x12, lCPI3_479@PAGEOFF]
Lloh514:
	adrp	x12, lCPI3_480@PAGE
Lloh515:
	ldr	q5, [x12, lCPI3_480@PAGEOFF]
	mov	x12, #4096                      ; =0x1000
	movk	x12, #512, lsl #16
	movk	x12, #64, lsl #32
	movk	x12, #8, lsl #48
LBB3_86:                                ; =>This Inner Loop Header: Depth=1
	ldp	q6, q7, [x10, #-48]
	orr.16b	v6, v6, v0
	orr.16b	v7, v7, v1
	stp	q6, q7, [x10, #-48]
	ldp	q6, q7, [x10, #-16]
	orr.16b	v6, v6, v2
	orr.16b	v7, v7, v3
	stp	q6, q7, [x10, #-16]
	ldp	q6, q7, [x10, #16]
	orr.16b	v6, v6, v4
	orr.16b	v7, v7, v5
	stp	q6, q7, [x10, #16]
	ldr	x13, [x10, #48]
	orr	x13, x13, x12
	str	x13, [x10, #48]
	add	x11, x11, #13
	add	x10, x10, #104
	cmp	x9, x11
	b.ge	LBB3_86
; %bb.87:
	sub	x10, x11, #13
	b	LBB3_128
LBB3_88:
	add	x11, x10, #55
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.89:
Lloh516:
	adrp	x12, lCPI3_118@PAGE
Lloh517:
	ldr	q0, [x12, lCPI3_118@PAGEOFF]
Lloh518:
	adrp	x12, lCPI3_119@PAGE
Lloh519:
	ldr	q1, [x12, lCPI3_119@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh520:
	adrp	x12, lCPI3_120@PAGE
Lloh521:
	ldr	q2, [x12, lCPI3_120@PAGEOFF]
	add	x10, x10, #224
Lloh522:
	adrp	x12, lCPI3_121@PAGE
Lloh523:
	ldr	q3, [x12, lCPI3_121@PAGEOFF]
Lloh524:
	adrp	x12, lCPI3_122@PAGE
Lloh525:
	ldr	q4, [x12, lCPI3_122@PAGEOFF]
Lloh526:
	adrp	x12, lCPI3_123@PAGE
Lloh527:
	ldr	q5, [x12, lCPI3_123@PAGEOFF]
Lloh528:
	adrp	x12, lCPI3_124@PAGE
Lloh529:
	ldr	q6, [x12, lCPI3_124@PAGEOFF]
Lloh530:
	adrp	x12, lCPI3_125@PAGE
Lloh531:
	ldr	q7, [x12, lCPI3_125@PAGEOFF]
Lloh532:
	adrp	x12, lCPI3_126@PAGE
Lloh533:
	ldr	q16, [x12, lCPI3_126@PAGEOFF]
Lloh534:
	adrp	x12, lCPI3_127@PAGE
Lloh535:
	ldr	q17, [x12, lCPI3_127@PAGEOFF]
Lloh536:
	adrp	x12, lCPI3_128@PAGE
Lloh537:
	ldr	q18, [x12, lCPI3_128@PAGEOFF]
Lloh538:
	adrp	x12, lCPI3_129@PAGE
Lloh539:
	ldr	q19, [x12, lCPI3_129@PAGEOFF]
Lloh540:
	adrp	x12, lCPI3_130@PAGE
Lloh541:
	ldr	q20, [x12, lCPI3_130@PAGEOFF]
Lloh542:
	adrp	x12, lCPI3_131@PAGE
Lloh543:
	ldr	q21, [x12, lCPI3_131@PAGEOFF]
Lloh544:
	adrp	x12, lCPI3_132@PAGE
Lloh545:
	ldr	q22, [x12, lCPI3_132@PAGEOFF]
Lloh546:
	adrp	x12, lCPI3_133@PAGE
Lloh547:
	ldr	q23, [x12, lCPI3_133@PAGEOFF]
Lloh548:
	adrp	x12, lCPI3_134@PAGE
Lloh549:
	ldr	q24, [x12, lCPI3_134@PAGEOFF]
Lloh550:
	adrp	x12, lCPI3_135@PAGE
Lloh551:
	ldr	q25, [x12, lCPI3_135@PAGEOFF]
Lloh552:
	adrp	x12, lCPI3_136@PAGE
Lloh553:
	ldr	q26, [x12, lCPI3_136@PAGEOFF]
Lloh554:
	adrp	x12, lCPI3_137@PAGE
Lloh555:
	ldr	q27, [x12, lCPI3_137@PAGEOFF]
Lloh556:
	adrp	x12, lCPI3_138@PAGE
Lloh557:
	ldr	q28, [x12, lCPI3_138@PAGEOFF]
Lloh558:
	adrp	x12, lCPI3_139@PAGE
Lloh559:
	ldr	q29, [x12, lCPI3_139@PAGEOFF]
Lloh560:
	adrp	x12, lCPI3_140@PAGE
Lloh561:
	ldr	q30, [x12, lCPI3_140@PAGEOFF]
Lloh562:
	adrp	x12, lCPI3_141@PAGE
Lloh563:
	ldr	q31, [x12, lCPI3_141@PAGEOFF]
Lloh564:
	adrp	x12, lCPI3_142@PAGE
Lloh565:
	ldr	q8, [x12, lCPI3_142@PAGEOFF]
Lloh566:
	adrp	x12, lCPI3_143@PAGE
Lloh567:
	ldr	q9, [x12, lCPI3_143@PAGEOFF]
Lloh568:
	adrp	x12, lCPI3_144@PAGE
Lloh569:
	ldr	q10, [x12, lCPI3_144@PAGEOFF]
LBB3_90:                                ; =>This Inner Loop Header: Depth=1
	ldp	q11, q12, [x10, #-224]
	orr.16b	v11, v11, v0
	orr.16b	v12, v12, v1
	stp	q11, q12, [x10, #-224]
	ldp	q11, q12, [x10, #-192]
	orr.16b	v11, v11, v2
	orr.16b	v12, v12, v3
	stp	q11, q12, [x10, #-192]
	ldp	q11, q12, [x10, #-160]
	orr.16b	v11, v11, v4
	orr.16b	v12, v12, v5
	stp	q11, q12, [x10, #-160]
	ldp	q11, q12, [x10, #-128]
	orr.16b	v11, v11, v6
	orr.16b	v12, v12, v7
	stp	q11, q12, [x10, #-128]
	ldp	q11, q12, [x10, #-96]
	orr.16b	v11, v11, v16
	orr.16b	v12, v12, v17
	stp	q11, q12, [x10, #-96]
	ldp	q11, q12, [x10, #-64]
	orr.16b	v11, v11, v18
	orr.16b	v12, v12, v19
	stp	q11, q12, [x10, #-64]
	ldp	q11, q12, [x10, #-32]
	orr.16b	v11, v11, v20
	orr.16b	v12, v12, v21
	stp	q11, q12, [x10, #-32]
	ldp	q11, q12, [x10]
	orr.16b	v11, v11, v22
	orr.16b	v12, v12, v23
	stp	q11, q12, [x10]
	ldp	q11, q12, [x10, #32]
	orr.16b	v11, v11, v24
	orr.16b	v12, v12, v25
	stp	q11, q12, [x10, #32]
	ldp	q11, q12, [x10, #64]
	orr.16b	v11, v11, v26
	orr.16b	v12, v12, v27
	stp	q11, q12, [x10, #64]
	ldp	q11, q12, [x10, #96]
	orr.16b	v11, v11, v28
	orr.16b	v12, v12, v29
	stp	q11, q12, [x10, #96]
	ldp	q11, q12, [x10, #128]
	orr.16b	v11, v11, v30
	orr.16b	v12, v12, v31
	stp	q11, q12, [x10, #128]
	ldp	q11, q12, [x10, #160]
	orr.16b	v11, v11, v8
	orr.16b	v12, v12, v9
	stp	q11, q12, [x10, #160]
	ldr	q11, [x10, #192]
	orr.16b	v11, v11, v10
	ldr	x12, [x10, #208]
	orr	x12, x12, #0x200
	add	x11, x11, #55
	str	q11, [x10, #192]
	str	x12, [x10, #208]
	add	x10, x10, #440
	cmp	x9, x11
	b.ge	LBB3_90
; %bb.91:
	sub	x10, x11, #55
	b	LBB3_128
LBB3_92:
	add	x11, x10, #27
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.93:
Lloh570:
	adrp	x12, lCPI3_405@PAGE
Lloh571:
	ldr	q0, [x12, lCPI3_405@PAGEOFF]
Lloh572:
	adrp	x12, lCPI3_406@PAGE
Lloh573:
	ldr	q1, [x12, lCPI3_406@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh574:
	adrp	x12, lCPI3_407@PAGE
Lloh575:
	ldr	q2, [x12, lCPI3_407@PAGEOFF]
	add	x10, x10, #112
Lloh576:
	adrp	x12, lCPI3_408@PAGE
Lloh577:
	ldr	q3, [x12, lCPI3_408@PAGEOFF]
Lloh578:
	adrp	x12, lCPI3_409@PAGE
Lloh579:
	ldr	q4, [x12, lCPI3_409@PAGEOFF]
Lloh580:
	adrp	x12, lCPI3_410@PAGE
Lloh581:
	ldr	q5, [x12, lCPI3_410@PAGEOFF]
Lloh582:
	adrp	x12, lCPI3_411@PAGE
Lloh583:
	ldr	q6, [x12, lCPI3_411@PAGEOFF]
Lloh584:
	adrp	x12, lCPI3_412@PAGE
Lloh585:
	ldr	q7, [x12, lCPI3_412@PAGEOFF]
Lloh586:
	adrp	x12, lCPI3_413@PAGE
Lloh587:
	ldr	q16, [x12, lCPI3_413@PAGEOFF]
Lloh588:
	adrp	x12, lCPI3_414@PAGE
Lloh589:
	ldr	q17, [x12, lCPI3_414@PAGEOFF]
Lloh590:
	adrp	x12, lCPI3_415@PAGE
Lloh591:
	ldr	q18, [x12, lCPI3_415@PAGEOFF]
Lloh592:
	adrp	x12, lCPI3_416@PAGE
Lloh593:
	ldr	q19, [x12, lCPI3_416@PAGEOFF]
Lloh594:
	adrp	x12, lCPI3_417@PAGE
Lloh595:
	ldr	q20, [x12, lCPI3_417@PAGEOFF]
	mov	x12, #1024                      ; =0x400
	movk	x12, #32, lsl #32
LBB3_94:                                ; =>This Inner Loop Header: Depth=1
	ldp	q21, q22, [x10, #-112]
	orr.16b	v21, v21, v0
	orr.16b	v22, v22, v1
	stp	q21, q22, [x10, #-112]
	ldp	q21, q22, [x10, #-80]
	orr.16b	v21, v21, v2
	orr.16b	v22, v22, v3
	stp	q21, q22, [x10, #-80]
	ldp	q21, q22, [x10, #-48]
	orr.16b	v21, v21, v4
	orr.16b	v22, v22, v5
	stp	q21, q22, [x10, #-48]
	ldp	q21, q22, [x10, #-16]
	orr.16b	v21, v21, v6
	orr.16b	v22, v22, v7
	stp	q21, q22, [x10, #-16]
	ldp	q21, q22, [x10, #16]
	orr.16b	v21, v21, v16
	orr.16b	v22, v22, v17
	stp	q21, q22, [x10, #16]
	ldp	q21, q22, [x10, #48]
	orr.16b	v21, v21, v18
	orr.16b	v22, v22, v19
	stp	q21, q22, [x10, #48]
	ldr	q21, [x10, #80]
	orr.16b	v21, v21, v20
	ldr	x13, [x10, #96]
	orr	x13, x13, x12
	add	x11, x11, #27
	str	q21, [x10, #80]
	str	x13, [x10, #96]
	add	x10, x10, #216
	cmp	x9, x11
	b.ge	LBB3_94
; %bb.95:
	sub	x10, x11, #27
	b	LBB3_128
LBB3_96:
	add	x11, x10, #59
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.97:
Lloh596:
	adrp	x12, lCPI3_61@PAGE
Lloh597:
	ldr	q0, [x12, lCPI3_61@PAGEOFF]
Lloh598:
	adrp	x12, lCPI3_62@PAGE
Lloh599:
	ldr	q1, [x12, lCPI3_62@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh600:
	adrp	x12, lCPI3_63@PAGE
Lloh601:
	ldr	q2, [x12, lCPI3_63@PAGEOFF]
	add	x10, x10, #240
Lloh602:
	adrp	x12, lCPI3_64@PAGE
Lloh603:
	ldr	q3, [x12, lCPI3_64@PAGEOFF]
Lloh604:
	adrp	x12, lCPI3_65@PAGE
Lloh605:
	ldr	q4, [x12, lCPI3_65@PAGEOFF]
Lloh606:
	adrp	x12, lCPI3_66@PAGE
Lloh607:
	ldr	q5, [x12, lCPI3_66@PAGEOFF]
Lloh608:
	adrp	x12, lCPI3_67@PAGE
Lloh609:
	ldr	q6, [x12, lCPI3_67@PAGEOFF]
Lloh610:
	adrp	x12, lCPI3_68@PAGE
Lloh611:
	ldr	q7, [x12, lCPI3_68@PAGEOFF]
Lloh612:
	adrp	x12, lCPI3_69@PAGE
Lloh613:
	ldr	q16, [x12, lCPI3_69@PAGEOFF]
Lloh614:
	adrp	x12, lCPI3_70@PAGE
Lloh615:
	ldr	q17, [x12, lCPI3_70@PAGEOFF]
Lloh616:
	adrp	x12, lCPI3_71@PAGE
Lloh617:
	ldr	q18, [x12, lCPI3_71@PAGEOFF]
Lloh618:
	adrp	x12, lCPI3_72@PAGE
Lloh619:
	ldr	q19, [x12, lCPI3_72@PAGEOFF]
Lloh620:
	adrp	x12, lCPI3_73@PAGE
Lloh621:
	ldr	q20, [x12, lCPI3_73@PAGEOFF]
Lloh622:
	adrp	x12, lCPI3_74@PAGE
Lloh623:
	ldr	q21, [x12, lCPI3_74@PAGEOFF]
Lloh624:
	adrp	x12, lCPI3_75@PAGE
Lloh625:
	ldr	q22, [x12, lCPI3_75@PAGEOFF]
Lloh626:
	adrp	x12, lCPI3_76@PAGE
Lloh627:
	ldr	q23, [x12, lCPI3_76@PAGEOFF]
Lloh628:
	adrp	x12, lCPI3_77@PAGE
Lloh629:
	ldr	q24, [x12, lCPI3_77@PAGEOFF]
Lloh630:
	adrp	x12, lCPI3_78@PAGE
Lloh631:
	ldr	q25, [x12, lCPI3_78@PAGEOFF]
Lloh632:
	adrp	x12, lCPI3_79@PAGE
Lloh633:
	ldr	q26, [x12, lCPI3_79@PAGEOFF]
Lloh634:
	adrp	x12, lCPI3_80@PAGE
Lloh635:
	ldr	q27, [x12, lCPI3_80@PAGEOFF]
Lloh636:
	adrp	x12, lCPI3_81@PAGE
Lloh637:
	ldr	q28, [x12, lCPI3_81@PAGEOFF]
Lloh638:
	adrp	x12, lCPI3_82@PAGE
Lloh639:
	ldr	q29, [x12, lCPI3_82@PAGEOFF]
Lloh640:
	adrp	x12, lCPI3_83@PAGE
Lloh641:
	ldr	q30, [x12, lCPI3_83@PAGEOFF]
Lloh642:
	adrp	x12, lCPI3_84@PAGE
Lloh643:
	ldr	q31, [x12, lCPI3_84@PAGEOFF]
Lloh644:
	adrp	x12, lCPI3_85@PAGE
Lloh645:
	ldr	q8, [x12, lCPI3_85@PAGEOFF]
Lloh646:
	adrp	x12, lCPI3_86@PAGE
Lloh647:
	ldr	q9, [x12, lCPI3_86@PAGEOFF]
Lloh648:
	adrp	x12, lCPI3_87@PAGE
Lloh649:
	ldr	q10, [x12, lCPI3_87@PAGEOFF]
Lloh650:
	adrp	x12, lCPI3_88@PAGE
Lloh651:
	ldr	q11, [x12, lCPI3_88@PAGEOFF]
Lloh652:
	adrp	x12, lCPI3_89@PAGE
Lloh653:
	ldr	q12, [x12, lCPI3_89@PAGEOFF]
LBB3_98:                                ; =>This Inner Loop Header: Depth=1
	ldp	q13, q14, [x10, #-240]
	orr.16b	v13, v13, v0
	orr.16b	v14, v14, v1
	stp	q13, q14, [x10, #-240]
	ldp	q13, q14, [x10, #-208]
	orr.16b	v13, v13, v2
	orr.16b	v14, v14, v3
	stp	q13, q14, [x10, #-208]
	ldp	q13, q14, [x10, #-176]
	orr.16b	v13, v13, v4
	orr.16b	v14, v14, v5
	stp	q13, q14, [x10, #-176]
	ldp	q13, q14, [x10, #-144]
	orr.16b	v13, v13, v6
	orr.16b	v14, v14, v7
	stp	q13, q14, [x10, #-144]
	ldp	q13, q14, [x10, #-112]
	orr.16b	v13, v13, v16
	orr.16b	v14, v14, v17
	stp	q13, q14, [x10, #-112]
	ldp	q13, q14, [x10, #-80]
	orr.16b	v13, v13, v18
	orr.16b	v14, v14, v19
	stp	q13, q14, [x10, #-80]
	ldp	q13, q14, [x10, #-48]
	orr.16b	v13, v13, v20
	orr.16b	v14, v14, v21
	stp	q13, q14, [x10, #-48]
	ldp	q13, q14, [x10, #-16]
	orr.16b	v13, v13, v22
	orr.16b	v14, v14, v23
	stp	q13, q14, [x10, #-16]
	ldp	q13, q14, [x10, #16]
	orr.16b	v13, v13, v24
	orr.16b	v14, v14, v25
	stp	q13, q14, [x10, #16]
	ldp	q13, q14, [x10, #48]
	orr.16b	v13, v13, v26
	orr.16b	v14, v14, v27
	stp	q13, q14, [x10, #48]
	ldp	q13, q14, [x10, #80]
	orr.16b	v13, v13, v28
	orr.16b	v14, v14, v29
	stp	q13, q14, [x10, #80]
	ldp	q13, q14, [x10, #112]
	orr.16b	v13, v13, v30
	orr.16b	v14, v14, v31
	stp	q13, q14, [x10, #112]
	ldp	q13, q14, [x10, #144]
	orr.16b	v13, v13, v8
	orr.16b	v14, v14, v9
	stp	q13, q14, [x10, #144]
	ldp	q13, q14, [x10, #176]
	orr.16b	v13, v13, v10
	orr.16b	v14, v14, v11
	stp	q13, q14, [x10, #176]
	ldr	q13, [x10, #208]
	orr.16b	v13, v13, v12
	ldr	x12, [x10, #224]
	orr	x12, x12, #0x20
	add	x11, x11, #59
	str	q13, [x10, #208]
	str	x12, [x10, #224]
	add	x10, x10, #472
	cmp	x9, x11
	b.ge	LBB3_98
; %bb.99:
	sub	x10, x11, #59
	b	LBB3_128
LBB3_100:
	add	x11, x10, #31
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.101:
Lloh654:
	adrp	x12, lCPI3_376@PAGE
Lloh655:
	ldr	q0, [x12, lCPI3_376@PAGEOFF]
Lloh656:
	adrp	x12, lCPI3_377@PAGE
Lloh657:
	ldr	q1, [x12, lCPI3_377@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh658:
	adrp	x12, lCPI3_378@PAGE
Lloh659:
	ldr	q2, [x12, lCPI3_378@PAGEOFF]
	add	x10, x10, #128
Lloh660:
	adrp	x12, lCPI3_379@PAGE
Lloh661:
	ldr	q3, [x12, lCPI3_379@PAGEOFF]
Lloh662:
	adrp	x12, lCPI3_380@PAGE
Lloh663:
	ldr	q4, [x12, lCPI3_380@PAGEOFF]
Lloh664:
	adrp	x12, lCPI3_381@PAGE
Lloh665:
	ldr	q5, [x12, lCPI3_381@PAGEOFF]
Lloh666:
	adrp	x12, lCPI3_382@PAGE
Lloh667:
	ldr	q6, [x12, lCPI3_382@PAGEOFF]
Lloh668:
	adrp	x12, lCPI3_383@PAGE
Lloh669:
	ldr	q7, [x12, lCPI3_383@PAGEOFF]
Lloh670:
	adrp	x12, lCPI3_384@PAGE
Lloh671:
	ldr	q16, [x12, lCPI3_384@PAGEOFF]
Lloh672:
	adrp	x12, lCPI3_385@PAGE
Lloh673:
	ldr	q17, [x12, lCPI3_385@PAGEOFF]
Lloh674:
	adrp	x12, lCPI3_386@PAGE
Lloh675:
	ldr	q18, [x12, lCPI3_386@PAGEOFF]
Lloh676:
	adrp	x12, lCPI3_387@PAGE
Lloh677:
	ldr	q19, [x12, lCPI3_387@PAGEOFF]
Lloh678:
	adrp	x12, lCPI3_388@PAGE
Lloh679:
	ldr	q20, [x12, lCPI3_388@PAGEOFF]
Lloh680:
	adrp	x12, lCPI3_389@PAGE
Lloh681:
	ldr	q21, [x12, lCPI3_389@PAGEOFF]
Lloh682:
	adrp	x12, lCPI3_390@PAGE
Lloh683:
	ldr	q22, [x12, lCPI3_390@PAGEOFF]
	mov	x12, #4                         ; =0x4
	movk	x12, #2, lsl #32
LBB3_102:                               ; =>This Inner Loop Header: Depth=1
	ldp	q23, q24, [x10, #-128]
	orr.16b	v23, v23, v0
	orr.16b	v24, v24, v1
	stp	q23, q24, [x10, #-128]
	ldp	q23, q24, [x10, #-96]
	orr.16b	v23, v23, v2
	orr.16b	v24, v24, v3
	stp	q23, q24, [x10, #-96]
	ldp	q23, q24, [x10, #-64]
	orr.16b	v23, v23, v4
	orr.16b	v24, v24, v5
	stp	q23, q24, [x10, #-64]
	ldp	q23, q24, [x10, #-32]
	orr.16b	v23, v23, v6
	orr.16b	v24, v24, v7
	stp	q23, q24, [x10, #-32]
	ldp	q23, q24, [x10]
	orr.16b	v23, v23, v16
	orr.16b	v24, v24, v17
	stp	q23, q24, [x10]
	ldp	q23, q24, [x10, #32]
	orr.16b	v23, v23, v18
	orr.16b	v24, v24, v19
	stp	q23, q24, [x10, #32]
	ldp	q23, q24, [x10, #64]
	orr.16b	v23, v23, v20
	orr.16b	v24, v24, v21
	stp	q23, q24, [x10, #64]
	ldr	q23, [x10, #96]
	orr.16b	v23, v23, v22
	ldr	x13, [x10, #112]
	orr	x13, x13, x12
	add	x11, x11, #31
	str	q23, [x10, #96]
	str	x13, [x10, #112]
	add	x10, x10, #248
	cmp	x9, x11
	b.ge	LBB3_102
; %bb.103:
	sub	x10, x11, #31
	b	LBB3_128
LBB3_104:
	add	x11, x10, #45
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.105:
Lloh684:
	adrp	x12, lCPI3_243@PAGE
Lloh685:
	ldr	q0, [x12, lCPI3_243@PAGEOFF]
Lloh686:
	adrp	x12, lCPI3_244@PAGE
Lloh687:
	ldr	q1, [x12, lCPI3_244@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh688:
	adrp	x12, lCPI3_245@PAGE
Lloh689:
	ldr	q2, [x12, lCPI3_245@PAGEOFF]
	add	x10, x10, #176
Lloh690:
	adrp	x12, lCPI3_246@PAGE
Lloh691:
	ldr	q3, [x12, lCPI3_246@PAGEOFF]
Lloh692:
	adrp	x12, lCPI3_247@PAGE
Lloh693:
	ldr	q4, [x12, lCPI3_247@PAGEOFF]
Lloh694:
	adrp	x12, lCPI3_248@PAGE
Lloh695:
	ldr	q5, [x12, lCPI3_248@PAGEOFF]
Lloh696:
	adrp	x12, lCPI3_249@PAGE
Lloh697:
	ldr	q6, [x12, lCPI3_249@PAGEOFF]
Lloh698:
	adrp	x12, lCPI3_250@PAGE
Lloh699:
	ldr	q7, [x12, lCPI3_250@PAGEOFF]
Lloh700:
	adrp	x12, lCPI3_251@PAGE
Lloh701:
	ldr	q16, [x12, lCPI3_251@PAGEOFF]
Lloh702:
	adrp	x12, lCPI3_252@PAGE
Lloh703:
	ldr	q17, [x12, lCPI3_252@PAGEOFF]
Lloh704:
	adrp	x12, lCPI3_253@PAGE
Lloh705:
	ldr	q18, [x12, lCPI3_253@PAGEOFF]
Lloh706:
	adrp	x12, lCPI3_254@PAGE
Lloh707:
	ldr	q19, [x12, lCPI3_254@PAGEOFF]
Lloh708:
	adrp	x12, lCPI3_255@PAGE
Lloh709:
	ldr	q20, [x12, lCPI3_255@PAGEOFF]
Lloh710:
	adrp	x12, lCPI3_256@PAGE
Lloh711:
	ldr	q21, [x12, lCPI3_256@PAGEOFF]
Lloh712:
	adrp	x12, lCPI3_257@PAGE
Lloh713:
	ldr	q22, [x12, lCPI3_257@PAGEOFF]
Lloh714:
	adrp	x12, lCPI3_258@PAGE
Lloh715:
	ldr	q23, [x12, lCPI3_258@PAGEOFF]
Lloh716:
	adrp	x12, lCPI3_259@PAGE
Lloh717:
	ldr	q24, [x12, lCPI3_259@PAGEOFF]
Lloh718:
	adrp	x12, lCPI3_260@PAGE
Lloh719:
	ldr	q25, [x12, lCPI3_260@PAGEOFF]
Lloh720:
	adrp	x12, lCPI3_261@PAGE
Lloh721:
	ldr	q26, [x12, lCPI3_261@PAGEOFF]
Lloh722:
	adrp	x12, lCPI3_262@PAGE
Lloh723:
	ldr	q27, [x12, lCPI3_262@PAGEOFF]
Lloh724:
	adrp	x12, lCPI3_263@PAGE
Lloh725:
	ldr	q28, [x12, lCPI3_263@PAGEOFF]
Lloh726:
	adrp	x12, lCPI3_264@PAGE
Lloh727:
	ldr	q29, [x12, lCPI3_264@PAGEOFF]
LBB3_106:                               ; =>This Inner Loop Header: Depth=1
	ldp	q30, q31, [x10, #-176]
	orr.16b	v30, v30, v0
	orr.16b	v31, v31, v1
	stp	q30, q31, [x10, #-176]
	ldp	q30, q31, [x10, #-144]
	orr.16b	v30, v30, v2
	orr.16b	v31, v31, v3
	stp	q30, q31, [x10, #-144]
	ldp	q30, q31, [x10, #-112]
	orr.16b	v30, v30, v4
	orr.16b	v31, v31, v5
	stp	q30, q31, [x10, #-112]
	ldp	q30, q31, [x10, #-80]
	orr.16b	v30, v30, v6
	orr.16b	v31, v31, v7
	stp	q30, q31, [x10, #-80]
	ldp	q30, q31, [x10, #-48]
	orr.16b	v30, v30, v16
	orr.16b	v31, v31, v17
	stp	q30, q31, [x10, #-48]
	ldp	q30, q31, [x10, #-16]
	orr.16b	v30, v30, v18
	orr.16b	v31, v31, v19
	stp	q30, q31, [x10, #-16]
	ldp	q30, q31, [x10, #16]
	orr.16b	v30, v30, v20
	orr.16b	v31, v31, v21
	stp	q30, q31, [x10, #16]
	ldp	q30, q31, [x10, #48]
	orr.16b	v30, v30, v22
	orr.16b	v31, v31, v23
	stp	q30, q31, [x10, #48]
	ldp	q30, q31, [x10, #80]
	orr.16b	v30, v30, v24
	orr.16b	v31, v31, v25
	stp	q30, q31, [x10, #80]
	ldp	q30, q31, [x10, #112]
	orr.16b	v30, v30, v26
	orr.16b	v31, v31, v27
	stp	q30, q31, [x10, #112]
	ldp	q30, q31, [x10, #144]
	orr.16b	v30, v30, v28
	orr.16b	v31, v31, v29
	ldr	x12, [x10, #176]
	orr	x12, x12, #0x80000
	add	x11, x11, #45
	stp	q30, q31, [x10, #144]
	str	x12, [x10, #176]
	add	x10, x10, #360
	cmp	x9, x11
	b.ge	LBB3_106
; %bb.107:
	sub	x10, x11, #45
	b	LBB3_128
LBB3_108:
	add	x11, x10, #61
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.109:
Lloh728:
	adrp	x12, lCPI3_31@PAGE
Lloh729:
	ldr	q0, [x12, lCPI3_31@PAGEOFF]
Lloh730:
	adrp	x12, lCPI3_32@PAGE
Lloh731:
	ldr	q1, [x12, lCPI3_32@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh732:
	adrp	x12, lCPI3_33@PAGE
Lloh733:
	ldr	q2, [x12, lCPI3_33@PAGEOFF]
	add	x10, x10, #240
Lloh734:
	adrp	x12, lCPI3_34@PAGE
Lloh735:
	ldr	q3, [x12, lCPI3_34@PAGEOFF]
Lloh736:
	adrp	x12, lCPI3_35@PAGE
Lloh737:
	ldr	q4, [x12, lCPI3_35@PAGEOFF]
Lloh738:
	adrp	x12, lCPI3_36@PAGE
Lloh739:
	ldr	q5, [x12, lCPI3_36@PAGEOFF]
Lloh740:
	adrp	x12, lCPI3_37@PAGE
Lloh741:
	ldr	q6, [x12, lCPI3_37@PAGEOFF]
Lloh742:
	adrp	x12, lCPI3_38@PAGE
Lloh743:
	ldr	q7, [x12, lCPI3_38@PAGEOFF]
Lloh744:
	adrp	x12, lCPI3_39@PAGE
Lloh745:
	ldr	q16, [x12, lCPI3_39@PAGEOFF]
Lloh746:
	adrp	x12, lCPI3_40@PAGE
Lloh747:
	ldr	q17, [x12, lCPI3_40@PAGEOFF]
Lloh748:
	adrp	x12, lCPI3_41@PAGE
Lloh749:
	ldr	q18, [x12, lCPI3_41@PAGEOFF]
Lloh750:
	adrp	x12, lCPI3_42@PAGE
Lloh751:
	ldr	q19, [x12, lCPI3_42@PAGEOFF]
Lloh752:
	adrp	x12, lCPI3_43@PAGE
Lloh753:
	ldr	q20, [x12, lCPI3_43@PAGEOFF]
Lloh754:
	adrp	x12, lCPI3_44@PAGE
Lloh755:
	ldr	q21, [x12, lCPI3_44@PAGEOFF]
Lloh756:
	adrp	x12, lCPI3_45@PAGE
Lloh757:
	ldr	q22, [x12, lCPI3_45@PAGEOFF]
Lloh758:
	adrp	x12, lCPI3_46@PAGE
Lloh759:
	ldr	q23, [x12, lCPI3_46@PAGEOFF]
Lloh760:
	adrp	x12, lCPI3_47@PAGE
Lloh761:
	ldr	q24, [x12, lCPI3_47@PAGEOFF]
Lloh762:
	adrp	x12, lCPI3_48@PAGE
Lloh763:
	ldr	q25, [x12, lCPI3_48@PAGEOFF]
Lloh764:
	adrp	x12, lCPI3_49@PAGE
Lloh765:
	ldr	q26, [x12, lCPI3_49@PAGEOFF]
Lloh766:
	adrp	x12, lCPI3_50@PAGE
Lloh767:
	ldr	q27, [x12, lCPI3_50@PAGEOFF]
Lloh768:
	adrp	x12, lCPI3_51@PAGE
Lloh769:
	ldr	q28, [x12, lCPI3_51@PAGEOFF]
Lloh770:
	adrp	x12, lCPI3_52@PAGE
Lloh771:
	ldr	q29, [x12, lCPI3_52@PAGEOFF]
Lloh772:
	adrp	x12, lCPI3_53@PAGE
Lloh773:
	ldr	q30, [x12, lCPI3_53@PAGEOFF]
Lloh774:
	adrp	x12, lCPI3_54@PAGE
Lloh775:
	ldr	q31, [x12, lCPI3_54@PAGEOFF]
Lloh776:
	adrp	x12, lCPI3_55@PAGE
Lloh777:
	ldr	q8, [x12, lCPI3_55@PAGEOFF]
Lloh778:
	adrp	x12, lCPI3_56@PAGE
Lloh779:
	ldr	q9, [x12, lCPI3_56@PAGEOFF]
Lloh780:
	adrp	x12, lCPI3_57@PAGE
Lloh781:
	ldr	q10, [x12, lCPI3_57@PAGEOFF]
Lloh782:
	adrp	x12, lCPI3_58@PAGE
Lloh783:
	ldr	q11, [x12, lCPI3_58@PAGEOFF]
Lloh784:
	adrp	x12, lCPI3_59@PAGE
Lloh785:
	ldr	q12, [x12, lCPI3_59@PAGEOFF]
Lloh786:
	adrp	x12, lCPI3_60@PAGE
Lloh787:
	ldr	q13, [x12, lCPI3_60@PAGEOFF]
LBB3_110:                               ; =>This Inner Loop Header: Depth=1
	ldp	q14, q15, [x10, #-240]
	orr.16b	v14, v14, v0
	orr.16b	v15, v15, v1
	stp	q14, q15, [x10, #-240]
	ldp	q14, q15, [x10, #-208]
	orr.16b	v14, v14, v2
	orr.16b	v15, v15, v3
	stp	q14, q15, [x10, #-208]
	ldp	q14, q15, [x10, #-176]
	orr.16b	v14, v14, v4
	orr.16b	v15, v15, v5
	stp	q14, q15, [x10, #-176]
	ldp	q14, q15, [x10, #-144]
	orr.16b	v14, v14, v6
	orr.16b	v15, v15, v7
	stp	q14, q15, [x10, #-144]
	ldp	q14, q15, [x10, #-112]
	orr.16b	v14, v14, v16
	orr.16b	v15, v15, v17
	stp	q14, q15, [x10, #-112]
	ldp	q14, q15, [x10, #-80]
	orr.16b	v14, v14, v18
	orr.16b	v15, v15, v19
	stp	q14, q15, [x10, #-80]
	ldp	q14, q15, [x10, #-48]
	orr.16b	v14, v14, v20
	orr.16b	v15, v15, v21
	stp	q14, q15, [x10, #-48]
	ldp	q14, q15, [x10, #-16]
	orr.16b	v14, v14, v22
	orr.16b	v15, v15, v23
	stp	q14, q15, [x10, #-16]
	ldp	q14, q15, [x10, #16]
	orr.16b	v14, v14, v24
	orr.16b	v15, v15, v25
	stp	q14, q15, [x10, #16]
	ldp	q14, q15, [x10, #48]
	orr.16b	v14, v14, v26
	orr.16b	v15, v15, v27
	stp	q14, q15, [x10, #48]
	ldp	q14, q15, [x10, #80]
	orr.16b	v14, v14, v28
	orr.16b	v15, v15, v29
	stp	q14, q15, [x10, #80]
	ldp	q14, q15, [x10, #112]
	orr.16b	v14, v14, v30
	orr.16b	v15, v15, v31
	stp	q14, q15, [x10, #112]
	ldp	q14, q15, [x10, #144]
	orr.16b	v14, v14, v8
	orr.16b	v15, v15, v9
	stp	q14, q15, [x10, #144]
	ldp	q14, q15, [x10, #176]
	orr.16b	v14, v14, v10
	orr.16b	v15, v15, v11
	stp	q14, q15, [x10, #176]
	ldp	q14, q15, [x10, #208]
	orr.16b	v14, v14, v12
	orr.16b	v15, v15, v13
	ldr	x12, [x10, #240]
	orr	x12, x12, #0x8
	add	x11, x11, #61
	stp	q14, q15, [x10, #208]
	str	x12, [x10, #240]
	add	x10, x10, #488
	cmp	x9, x11
	b.ge	LBB3_110
; %bb.111:
	sub	x10, x11, #61
	b	LBB3_128
LBB3_112:
	add	x11, x10, #53
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.113:
Lloh788:
	adrp	x12, lCPI3_145@PAGE
Lloh789:
	ldr	q0, [x12, lCPI3_145@PAGEOFF]
Lloh790:
	adrp	x12, lCPI3_146@PAGE
Lloh791:
	ldr	q1, [x12, lCPI3_146@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh792:
	adrp	x12, lCPI3_147@PAGE
Lloh793:
	ldr	q2, [x12, lCPI3_147@PAGEOFF]
	add	x10, x10, #208
Lloh794:
	adrp	x12, lCPI3_148@PAGE
Lloh795:
	ldr	q3, [x12, lCPI3_148@PAGEOFF]
Lloh796:
	adrp	x12, lCPI3_149@PAGE
Lloh797:
	ldr	q4, [x12, lCPI3_149@PAGEOFF]
Lloh798:
	adrp	x12, lCPI3_150@PAGE
Lloh799:
	ldr	q5, [x12, lCPI3_150@PAGEOFF]
Lloh800:
	adrp	x12, lCPI3_151@PAGE
Lloh801:
	ldr	q6, [x12, lCPI3_151@PAGEOFF]
Lloh802:
	adrp	x12, lCPI3_152@PAGE
Lloh803:
	ldr	q7, [x12, lCPI3_152@PAGEOFF]
Lloh804:
	adrp	x12, lCPI3_153@PAGE
Lloh805:
	ldr	q16, [x12, lCPI3_153@PAGEOFF]
Lloh806:
	adrp	x12, lCPI3_154@PAGE
Lloh807:
	ldr	q17, [x12, lCPI3_154@PAGEOFF]
Lloh808:
	adrp	x12, lCPI3_155@PAGE
Lloh809:
	ldr	q18, [x12, lCPI3_155@PAGEOFF]
Lloh810:
	adrp	x12, lCPI3_156@PAGE
Lloh811:
	ldr	q19, [x12, lCPI3_156@PAGEOFF]
Lloh812:
	adrp	x12, lCPI3_157@PAGE
Lloh813:
	ldr	q20, [x12, lCPI3_157@PAGEOFF]
Lloh814:
	adrp	x12, lCPI3_158@PAGE
Lloh815:
	ldr	q21, [x12, lCPI3_158@PAGEOFF]
Lloh816:
	adrp	x12, lCPI3_159@PAGE
Lloh817:
	ldr	q22, [x12, lCPI3_159@PAGEOFF]
Lloh818:
	adrp	x12, lCPI3_160@PAGE
Lloh819:
	ldr	q23, [x12, lCPI3_160@PAGEOFF]
Lloh820:
	adrp	x12, lCPI3_161@PAGE
Lloh821:
	ldr	q24, [x12, lCPI3_161@PAGEOFF]
Lloh822:
	adrp	x12, lCPI3_162@PAGE
Lloh823:
	ldr	q25, [x12, lCPI3_162@PAGEOFF]
Lloh824:
	adrp	x12, lCPI3_163@PAGE
Lloh825:
	ldr	q26, [x12, lCPI3_163@PAGEOFF]
Lloh826:
	adrp	x12, lCPI3_164@PAGE
Lloh827:
	ldr	q27, [x12, lCPI3_164@PAGEOFF]
Lloh828:
	adrp	x12, lCPI3_165@PAGE
Lloh829:
	ldr	q28, [x12, lCPI3_165@PAGEOFF]
Lloh830:
	adrp	x12, lCPI3_166@PAGE
Lloh831:
	ldr	q29, [x12, lCPI3_166@PAGEOFF]
Lloh832:
	adrp	x12, lCPI3_167@PAGE
Lloh833:
	ldr	q30, [x12, lCPI3_167@PAGEOFF]
Lloh834:
	adrp	x12, lCPI3_168@PAGE
Lloh835:
	ldr	q31, [x12, lCPI3_168@PAGEOFF]
Lloh836:
	adrp	x12, lCPI3_169@PAGE
Lloh837:
	ldr	q8, [x12, lCPI3_169@PAGEOFF]
Lloh838:
	adrp	x12, lCPI3_170@PAGE
Lloh839:
	ldr	q9, [x12, lCPI3_170@PAGEOFF]
LBB3_114:                               ; =>This Inner Loop Header: Depth=1
	ldp	q10, q11, [x10, #-208]
	orr.16b	v10, v10, v0
	orr.16b	v11, v11, v1
	stp	q10, q11, [x10, #-208]
	ldp	q10, q11, [x10, #-176]
	orr.16b	v10, v10, v2
	orr.16b	v11, v11, v3
	stp	q10, q11, [x10, #-176]
	ldp	q10, q11, [x10, #-144]
	orr.16b	v10, v10, v4
	orr.16b	v11, v11, v5
	stp	q10, q11, [x10, #-144]
	ldp	q10, q11, [x10, #-112]
	orr.16b	v10, v10, v6
	orr.16b	v11, v11, v7
	stp	q10, q11, [x10, #-112]
	ldp	q10, q11, [x10, #-80]
	orr.16b	v10, v10, v16
	orr.16b	v11, v11, v17
	stp	q10, q11, [x10, #-80]
	ldp	q10, q11, [x10, #-48]
	orr.16b	v10, v10, v18
	orr.16b	v11, v11, v19
	stp	q10, q11, [x10, #-48]
	ldp	q10, q11, [x10, #-16]
	orr.16b	v10, v10, v20
	orr.16b	v11, v11, v21
	stp	q10, q11, [x10, #-16]
	ldp	q10, q11, [x10, #16]
	orr.16b	v10, v10, v22
	orr.16b	v11, v11, v23
	stp	q10, q11, [x10, #16]
	ldp	q10, q11, [x10, #48]
	orr.16b	v10, v10, v24
	orr.16b	v11, v11, v25
	stp	q10, q11, [x10, #48]
	ldp	q10, q11, [x10, #80]
	orr.16b	v10, v10, v26
	orr.16b	v11, v11, v27
	stp	q10, q11, [x10, #80]
	ldp	q10, q11, [x10, #112]
	orr.16b	v10, v10, v28
	orr.16b	v11, v11, v29
	stp	q10, q11, [x10, #112]
	ldp	q10, q11, [x10, #144]
	orr.16b	v10, v10, v30
	orr.16b	v11, v11, v31
	stp	q10, q11, [x10, #144]
	ldp	q10, q11, [x10, #176]
	orr.16b	v10, v10, v8
	orr.16b	v11, v11, v9
	ldr	x12, [x10, #208]
	orr	x12, x12, #0x800
	add	x11, x11, #53
	stp	q10, q11, [x10, #176]
	str	x12, [x10, #208]
	add	x10, x10, #424
	cmp	x9, x11
	b.ge	LBB3_114
; %bb.115:
	sub	x10, x11, #53
	b	LBB3_128
LBB3_116:
	add	x11, x10, #47
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.117:
Lloh840:
	adrp	x12, lCPI3_220@PAGE
Lloh841:
	ldr	q0, [x12, lCPI3_220@PAGEOFF]
Lloh842:
	adrp	x12, lCPI3_221@PAGE
Lloh843:
	ldr	q1, [x12, lCPI3_221@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh844:
	adrp	x12, lCPI3_222@PAGE
Lloh845:
	ldr	q2, [x12, lCPI3_222@PAGEOFF]
	add	x10, x10, #192
Lloh846:
	adrp	x12, lCPI3_223@PAGE
Lloh847:
	ldr	q3, [x12, lCPI3_223@PAGEOFF]
Lloh848:
	adrp	x12, lCPI3_224@PAGE
Lloh849:
	ldr	q4, [x12, lCPI3_224@PAGEOFF]
Lloh850:
	adrp	x12, lCPI3_225@PAGE
Lloh851:
	ldr	q5, [x12, lCPI3_225@PAGEOFF]
Lloh852:
	adrp	x12, lCPI3_226@PAGE
Lloh853:
	ldr	q6, [x12, lCPI3_226@PAGEOFF]
Lloh854:
	adrp	x12, lCPI3_227@PAGE
Lloh855:
	ldr	q7, [x12, lCPI3_227@PAGEOFF]
Lloh856:
	adrp	x12, lCPI3_228@PAGE
Lloh857:
	ldr	q16, [x12, lCPI3_228@PAGEOFF]
Lloh858:
	adrp	x12, lCPI3_229@PAGE
Lloh859:
	ldr	q17, [x12, lCPI3_229@PAGEOFF]
Lloh860:
	adrp	x12, lCPI3_230@PAGE
Lloh861:
	ldr	q18, [x12, lCPI3_230@PAGEOFF]
Lloh862:
	adrp	x12, lCPI3_231@PAGE
Lloh863:
	ldr	q19, [x12, lCPI3_231@PAGEOFF]
Lloh864:
	adrp	x12, lCPI3_232@PAGE
Lloh865:
	ldr	q20, [x12, lCPI3_232@PAGEOFF]
Lloh866:
	adrp	x12, lCPI3_233@PAGE
Lloh867:
	ldr	q21, [x12, lCPI3_233@PAGEOFF]
Lloh868:
	adrp	x12, lCPI3_234@PAGE
Lloh869:
	ldr	q22, [x12, lCPI3_234@PAGEOFF]
Lloh870:
	adrp	x12, lCPI3_235@PAGE
Lloh871:
	ldr	q23, [x12, lCPI3_235@PAGEOFF]
Lloh872:
	adrp	x12, lCPI3_236@PAGE
Lloh873:
	ldr	q24, [x12, lCPI3_236@PAGEOFF]
Lloh874:
	adrp	x12, lCPI3_237@PAGE
Lloh875:
	ldr	q25, [x12, lCPI3_237@PAGEOFF]
Lloh876:
	adrp	x12, lCPI3_238@PAGE
Lloh877:
	ldr	q26, [x12, lCPI3_238@PAGEOFF]
Lloh878:
	adrp	x12, lCPI3_239@PAGE
Lloh879:
	ldr	q27, [x12, lCPI3_239@PAGEOFF]
Lloh880:
	adrp	x12, lCPI3_240@PAGE
Lloh881:
	ldr	q28, [x12, lCPI3_240@PAGEOFF]
Lloh882:
	adrp	x12, lCPI3_241@PAGE
Lloh883:
	ldr	q29, [x12, lCPI3_241@PAGEOFF]
Lloh884:
	adrp	x12, lCPI3_242@PAGE
Lloh885:
	ldr	q30, [x12, lCPI3_242@PAGEOFF]
LBB3_118:                               ; =>This Inner Loop Header: Depth=1
	ldp	q31, q8, [x10, #-192]
	orr.16b	v31, v31, v0
	orr.16b	v8, v8, v1
	stp	q31, q8, [x10, #-192]
	ldp	q31, q8, [x10, #-160]
	orr.16b	v31, v31, v2
	orr.16b	v8, v8, v3
	stp	q31, q8, [x10, #-160]
	ldp	q31, q8, [x10, #-128]
	orr.16b	v31, v31, v4
	orr.16b	v8, v8, v5
	stp	q31, q8, [x10, #-128]
	ldp	q31, q8, [x10, #-96]
	orr.16b	v31, v31, v6
	orr.16b	v8, v8, v7
	stp	q31, q8, [x10, #-96]
	ldp	q31, q8, [x10, #-64]
	orr.16b	v31, v31, v16
	orr.16b	v8, v8, v17
	stp	q31, q8, [x10, #-64]
	ldp	q31, q8, [x10, #-32]
	orr.16b	v31, v31, v18
	orr.16b	v8, v8, v19
	stp	q31, q8, [x10, #-32]
	ldp	q31, q8, [x10]
	orr.16b	v31, v31, v20
	orr.16b	v8, v8, v21
	stp	q31, q8, [x10]
	ldp	q31, q8, [x10, #32]
	orr.16b	v31, v31, v22
	orr.16b	v8, v8, v23
	stp	q31, q8, [x10, #32]
	ldp	q31, q8, [x10, #64]
	orr.16b	v31, v31, v24
	orr.16b	v8, v8, v25
	stp	q31, q8, [x10, #64]
	ldp	q31, q8, [x10, #96]
	orr.16b	v31, v31, v26
	orr.16b	v8, v8, v27
	stp	q31, q8, [x10, #96]
	ldp	q31, q8, [x10, #128]
	orr.16b	v31, v31, v28
	orr.16b	v8, v8, v29
	stp	q31, q8, [x10, #128]
	ldr	q31, [x10, #160]
	orr.16b	v31, v31, v30
	ldr	x12, [x10, #176]
	orr	x12, x12, #0x20000
	add	x11, x11, #47
	str	q31, [x10, #160]
	str	x12, [x10, #176]
	add	x10, x10, #376
	cmp	x9, x11
	b.ge	LBB3_118
; %bb.119:
	sub	x10, x11, #47
	b	LBB3_128
LBB3_120:
	add	x11, x10, #57
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.121:
Lloh886:
	adrp	x12, lCPI3_90@PAGE
Lloh887:
	ldr	q0, [x12, lCPI3_90@PAGEOFF]
Lloh888:
	adrp	x12, lCPI3_91@PAGE
Lloh889:
	ldr	q1, [x12, lCPI3_91@PAGEOFF]
	add	x10, x8, x10, lsl #3
Lloh890:
	adrp	x12, lCPI3_92@PAGE
Lloh891:
	ldr	q2, [x12, lCPI3_92@PAGEOFF]
	add	x10, x10, #224
Lloh892:
	adrp	x12, lCPI3_93@PAGE
Lloh893:
	ldr	q3, [x12, lCPI3_93@PAGEOFF]
Lloh894:
	adrp	x12, lCPI3_94@PAGE
Lloh895:
	ldr	q4, [x12, lCPI3_94@PAGEOFF]
Lloh896:
	adrp	x12, lCPI3_95@PAGE
Lloh897:
	ldr	q5, [x12, lCPI3_95@PAGEOFF]
Lloh898:
	adrp	x12, lCPI3_96@PAGE
Lloh899:
	ldr	q6, [x12, lCPI3_96@PAGEOFF]
Lloh900:
	adrp	x12, lCPI3_97@PAGE
Lloh901:
	ldr	q7, [x12, lCPI3_97@PAGEOFF]
Lloh902:
	adrp	x12, lCPI3_98@PAGE
Lloh903:
	ldr	q16, [x12, lCPI3_98@PAGEOFF]
Lloh904:
	adrp	x12, lCPI3_99@PAGE
Lloh905:
	ldr	q17, [x12, lCPI3_99@PAGEOFF]
Lloh906:
	adrp	x12, lCPI3_100@PAGE
Lloh907:
	ldr	q18, [x12, lCPI3_100@PAGEOFF]
Lloh908:
	adrp	x12, lCPI3_101@PAGE
Lloh909:
	ldr	q19, [x12, lCPI3_101@PAGEOFF]
Lloh910:
	adrp	x12, lCPI3_102@PAGE
Lloh911:
	ldr	q20, [x12, lCPI3_102@PAGEOFF]
Lloh912:
	adrp	x12, lCPI3_103@PAGE
Lloh913:
	ldr	q21, [x12, lCPI3_103@PAGEOFF]
Lloh914:
	adrp	x12, lCPI3_104@PAGE
Lloh915:
	ldr	q22, [x12, lCPI3_104@PAGEOFF]
Lloh916:
	adrp	x12, lCPI3_105@PAGE
Lloh917:
	ldr	q23, [x12, lCPI3_105@PAGEOFF]
Lloh918:
	adrp	x12, lCPI3_106@PAGE
Lloh919:
	ldr	q24, [x12, lCPI3_106@PAGEOFF]
Lloh920:
	adrp	x12, lCPI3_107@PAGE
Lloh921:
	ldr	q25, [x12, lCPI3_107@PAGEOFF]
Lloh922:
	adrp	x12, lCPI3_108@PAGE
Lloh923:
	ldr	q26, [x12, lCPI3_108@PAGEOFF]
Lloh924:
	adrp	x12, lCPI3_109@PAGE
Lloh925:
	ldr	q27, [x12, lCPI3_109@PAGEOFF]
Lloh926:
	adrp	x12, lCPI3_110@PAGE
Lloh927:
	ldr	q28, [x12, lCPI3_110@PAGEOFF]
Lloh928:
	adrp	x12, lCPI3_111@PAGE
Lloh929:
	ldr	q29, [x12, lCPI3_111@PAGEOFF]
Lloh930:
	adrp	x12, lCPI3_112@PAGE
Lloh931:
	ldr	q30, [x12, lCPI3_112@PAGEOFF]
Lloh932:
	adrp	x12, lCPI3_113@PAGE
Lloh933:
	ldr	q31, [x12, lCPI3_113@PAGEOFF]
Lloh934:
	adrp	x12, lCPI3_114@PAGE
Lloh935:
	ldr	q8, [x12, lCPI3_114@PAGEOFF]
Lloh936:
	adrp	x12, lCPI3_115@PAGE
Lloh937:
	ldr	q9, [x12, lCPI3_115@PAGEOFF]
Lloh938:
	adrp	x12, lCPI3_116@PAGE
Lloh939:
	ldr	q10, [x12, lCPI3_116@PAGEOFF]
Lloh940:
	adrp	x12, lCPI3_117@PAGE
Lloh941:
	ldr	q11, [x12, lCPI3_117@PAGEOFF]
LBB3_122:                               ; =>This Inner Loop Header: Depth=1
	ldp	q12, q13, [x10, #-224]
	orr.16b	v12, v12, v0
	orr.16b	v13, v13, v1
	stp	q12, q13, [x10, #-224]
	ldp	q12, q13, [x10, #-192]
	orr.16b	v12, v12, v2
	orr.16b	v13, v13, v3
	stp	q12, q13, [x10, #-192]
	ldp	q12, q13, [x10, #-160]
	orr.16b	v12, v12, v4
	orr.16b	v13, v13, v5
	stp	q12, q13, [x10, #-160]
	ldp	q12, q13, [x10, #-128]
	orr.16b	v12, v12, v6
	orr.16b	v13, v13, v7
	stp	q12, q13, [x10, #-128]
	ldp	q12, q13, [x10, #-96]
	orr.16b	v12, v12, v16
	orr.16b	v13, v13, v17
	stp	q12, q13, [x10, #-96]
	ldp	q12, q13, [x10, #-64]
	orr.16b	v12, v12, v18
	orr.16b	v13, v13, v19
	stp	q12, q13, [x10, #-64]
	ldp	q12, q13, [x10, #-32]
	orr.16b	v12, v12, v20
	orr.16b	v13, v13, v21
	stp	q12, q13, [x10, #-32]
	ldp	q12, q13, [x10]
	orr.16b	v12, v12, v22
	orr.16b	v13, v13, v23
	stp	q12, q13, [x10]
	ldp	q12, q13, [x10, #32]
	orr.16b	v12, v12, v24
	orr.16b	v13, v13, v25
	stp	q12, q13, [x10, #32]
	ldp	q12, q13, [x10, #64]
	orr.16b	v12, v12, v26
	orr.16b	v13, v13, v27
	stp	q12, q13, [x10, #64]
	ldp	q12, q13, [x10, #96]
	orr.16b	v12, v12, v28
	orr.16b	v13, v13, v29
	stp	q12, q13, [x10, #96]
	ldp	q12, q13, [x10, #128]
	orr.16b	v12, v12, v30
	orr.16b	v13, v13, v31
	stp	q12, q13, [x10, #128]
	ldp	q12, q13, [x10, #160]
	orr.16b	v12, v12, v8
	orr.16b	v13, v13, v9
	stp	q12, q13, [x10, #160]
	ldp	q12, q13, [x10, #192]
	orr.16b	v12, v12, v10
	orr.16b	v13, v13, v11
	ldr	x12, [x10, #224]
	orr	x12, x12, #0x80
	add	x11, x11, #57
	stp	q12, q13, [x10, #192]
	str	x12, [x10, #224]
	add	x10, x10, #456
	cmp	x9, x11
	b.ge	LBB3_122
; %bb.123:
	sub	x10, x11, #57
	b	LBB3_128
LBB3_124:
	add	x11, x10, #63
	cmp	x9, x11
	b.lt	LBB3_128
; %bb.125:
Lloh942:
	adrp	x12, lCPI3_0@PAGE
Lloh943:
	ldr	q0, [x12, lCPI3_0@PAGEOFF]
	str	q0, [sp, #16]                   ; 16-byte Folded Spill
Lloh944:
	adrp	x12, lCPI3_1@PAGE
Lloh945:
	ldr	q0, [x12, lCPI3_1@PAGEOFF]
	str	q0, [sp]                        ; 16-byte Folded Spill
	add	x10, x8, x10, lsl #3
Lloh946:
	adrp	x12, lCPI3_2@PAGE
Lloh947:
	ldr	q2, [x12, lCPI3_2@PAGEOFF]
	add	x10, x10, #256
Lloh948:
	adrp	x12, lCPI3_3@PAGE
Lloh949:
	ldr	q3, [x12, lCPI3_3@PAGEOFF]
Lloh950:
	adrp	x12, lCPI3_4@PAGE
Lloh951:
	ldr	q4, [x12, lCPI3_4@PAGEOFF]
Lloh952:
	adrp	x12, lCPI3_5@PAGE
Lloh953:
	ldr	q5, [x12, lCPI3_5@PAGEOFF]
Lloh954:
	adrp	x12, lCPI3_6@PAGE
Lloh955:
	ldr	q6, [x12, lCPI3_6@PAGEOFF]
Lloh956:
	adrp	x12, lCPI3_7@PAGE
Lloh957:
	ldr	q7, [x12, lCPI3_7@PAGEOFF]
Lloh958:
	adrp	x12, lCPI3_8@PAGE
Lloh959:
	ldr	q16, [x12, lCPI3_8@PAGEOFF]
Lloh960:
	adrp	x12, lCPI3_9@PAGE
Lloh961:
	ldr	q17, [x12, lCPI3_9@PAGEOFF]
Lloh962:
	adrp	x12, lCPI3_10@PAGE
Lloh963:
	ldr	q18, [x12, lCPI3_10@PAGEOFF]
Lloh964:
	adrp	x12, lCPI3_11@PAGE
Lloh965:
	ldr	q19, [x12, lCPI3_11@PAGEOFF]
Lloh966:
	adrp	x12, lCPI3_12@PAGE
Lloh967:
	ldr	q20, [x12, lCPI3_12@PAGEOFF]
Lloh968:
	adrp	x12, lCPI3_13@PAGE
Lloh969:
	ldr	q21, [x12, lCPI3_13@PAGEOFF]
Lloh970:
	adrp	x12, lCPI3_14@PAGE
Lloh971:
	ldr	q22, [x12, lCPI3_14@PAGEOFF]
Lloh972:
	adrp	x12, lCPI3_15@PAGE
Lloh973:
	ldr	q23, [x12, lCPI3_15@PAGEOFF]
Lloh974:
	adrp	x12, lCPI3_16@PAGE
Lloh975:
	ldr	q24, [x12, lCPI3_16@PAGEOFF]
Lloh976:
	adrp	x12, lCPI3_17@PAGE
Lloh977:
	ldr	q25, [x12, lCPI3_17@PAGEOFF]
Lloh978:
	adrp	x12, lCPI3_18@PAGE
Lloh979:
	ldr	q26, [x12, lCPI3_18@PAGEOFF]
Lloh980:
	adrp	x12, lCPI3_19@PAGE
Lloh981:
	ldr	q27, [x12, lCPI3_19@PAGEOFF]
Lloh982:
	adrp	x12, lCPI3_20@PAGE
Lloh983:
	ldr	q28, [x12, lCPI3_20@PAGEOFF]
Lloh984:
	adrp	x12, lCPI3_21@PAGE
Lloh985:
	ldr	q29, [x12, lCPI3_21@PAGEOFF]
Lloh986:
	adrp	x12, lCPI3_22@PAGE
Lloh987:
	ldr	q30, [x12, lCPI3_22@PAGEOFF]
Lloh988:
	adrp	x12, lCPI3_23@PAGE
Lloh989:
	ldr	q31, [x12, lCPI3_23@PAGEOFF]
Lloh990:
	adrp	x12, lCPI3_24@PAGE
Lloh991:
	ldr	q8, [x12, lCPI3_24@PAGEOFF]
Lloh992:
	adrp	x12, lCPI3_25@PAGE
Lloh993:
	ldr	q9, [x12, lCPI3_25@PAGEOFF]
Lloh994:
	adrp	x12, lCPI3_26@PAGE
Lloh995:
	ldr	q10, [x12, lCPI3_26@PAGEOFF]
Lloh996:
	adrp	x12, lCPI3_27@PAGE
Lloh997:
	ldr	q11, [x12, lCPI3_27@PAGEOFF]
Lloh998:
	adrp	x12, lCPI3_28@PAGE
Lloh999:
	ldr	q12, [x12, lCPI3_28@PAGEOFF]
Lloh1000:
	adrp	x12, lCPI3_29@PAGE
Lloh1001:
	ldr	q13, [x12, lCPI3_29@PAGEOFF]
Lloh1002:
	adrp	x12, lCPI3_30@PAGE
Lloh1003:
	ldr	q14, [x12, lCPI3_30@PAGEOFF]
LBB3_126:                               ; =>This Inner Loop Header: Depth=1
	ldp	q15, q0, [x10, #-256]
	ldr	q1, [sp, #16]                   ; 16-byte Folded Reload
	orr.16b	v15, v15, v1
	ldr	q1, [sp]                        ; 16-byte Folded Reload
	orr.16b	v0, v0, v1
	stp	q15, q0, [x10, #-256]
	ldp	q0, q15, [x10, #-224]
	orr.16b	v0, v0, v2
	orr.16b	v15, v15, v3
	stp	q0, q15, [x10, #-224]
	ldp	q0, q15, [x10, #-192]
	orr.16b	v0, v0, v4
	orr.16b	v15, v15, v5
	stp	q0, q15, [x10, #-192]
	ldp	q0, q15, [x10, #-160]
	orr.16b	v0, v0, v6
	orr.16b	v15, v15, v7
	stp	q0, q15, [x10, #-160]
	ldp	q0, q15, [x10, #-128]
	orr.16b	v0, v0, v16
	orr.16b	v15, v15, v17
	stp	q0, q15, [x10, #-128]
	ldp	q0, q15, [x10, #-96]
	orr.16b	v0, v0, v18
	orr.16b	v15, v15, v19
	stp	q0, q15, [x10, #-96]
	ldp	q0, q15, [x10, #-64]
	orr.16b	v0, v0, v20
	orr.16b	v15, v15, v21
	stp	q0, q15, [x10, #-64]
	ldp	q0, q15, [x10, #-32]
	orr.16b	v0, v0, v22
	orr.16b	v15, v15, v23
	stp	q0, q15, [x10, #-32]
	ldp	q0, q15, [x10]
	orr.16b	v0, v0, v24
	orr.16b	v15, v15, v25
	stp	q0, q15, [x10]
	ldp	q0, q15, [x10, #32]
	orr.16b	v0, v0, v26
	orr.16b	v15, v15, v27
	stp	q0, q15, [x10, #32]
	ldp	q0, q15, [x10, #64]
	orr.16b	v0, v0, v28
	orr.16b	v15, v15, v29
	stp	q0, q15, [x10, #64]
	ldp	q0, q15, [x10, #96]
	orr.16b	v0, v0, v30
	orr.16b	v15, v15, v31
	stp	q0, q15, [x10, #96]
	ldp	q0, q15, [x10, #128]
	orr.16b	v0, v0, v8
	orr.16b	v15, v15, v9
	stp	q0, q15, [x10, #128]
	ldp	q0, q15, [x10, #160]
	orr.16b	v0, v0, v10
	orr.16b	v15, v15, v11
	stp	q0, q15, [x10, #160]
	ldp	q0, q15, [x10, #192]
	orr.16b	v0, v0, v12
	orr.16b	v15, v15, v13
	stp	q0, q15, [x10, #192]
	ldr	q0, [x10, #224]
	orr.16b	v0, v0, v14
	ldr	x12, [x10, #240]
	orr	x12, x12, #0x2
	add	x11, x11, #63
	str	q0, [x10, #224]
	str	x12, [x10, #240]
	add	x10, x10, #504
	cmp	x9, x11
	b.ge	LBB3_126
; %bb.127:
	sub	x10, x11, #63
LBB3_128:
	lsl	x9, x10, #6
	ldr	x10, [x20, #24]
	cmp	x9, x10
	b.ge	LBB3_132
; %bb.129:
	mov	w11, #1                         ; =0x1
LBB3_130:                               ; =>This Inner Loop Header: Depth=1
	and	x12, x9, #0x7
	lsl	w12, w11, w12
	asr	x13, x9, #3
	ldrb	w14, [x8, x13]
	orr	w12, w12, w14
	strb	w12, [x8, x13]
	adds	x12, x9, x0
	b.vs	LBB3_133
; %bb.131:                              ;   in Loop: Header=BB3_130 Depth=1
	add	x9, x9, x0
	cmp	x12, x10
	b.lt	LBB3_130
LBB3_132:
	ldp	d9, d8, [sp, #80]               ; 16-byte Folded Reload
	ldp	d11, d10, [sp, #64]             ; 16-byte Folded Reload
	ldp	d13, d12, [sp, #48]             ; 16-byte Folded Reload
	ldp	d15, d14, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
LBB3_133:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB3_134:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB3_135:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB3_136:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpLdr	Lloh16, Lloh17
	.loh AdrpAdrp	Lloh14, Lloh16
	.loh AdrpLdr	Lloh14, Lloh15
	.loh AdrpLdr	Lloh66, Lloh67
	.loh AdrpAdrp	Lloh64, Lloh66
	.loh AdrpLdr	Lloh64, Lloh65
	.loh AdrpAdrp	Lloh62, Lloh64
	.loh AdrpLdr	Lloh62, Lloh63
	.loh AdrpAdrp	Lloh60, Lloh62
	.loh AdrpLdr	Lloh60, Lloh61
	.loh AdrpAdrp	Lloh58, Lloh60
	.loh AdrpLdr	Lloh58, Lloh59
	.loh AdrpAdrp	Lloh56, Lloh58
	.loh AdrpLdr	Lloh56, Lloh57
	.loh AdrpAdrp	Lloh54, Lloh56
	.loh AdrpLdr	Lloh54, Lloh55
	.loh AdrpAdrp	Lloh52, Lloh54
	.loh AdrpLdr	Lloh52, Lloh53
	.loh AdrpAdrp	Lloh50, Lloh52
	.loh AdrpLdr	Lloh50, Lloh51
	.loh AdrpAdrp	Lloh48, Lloh50
	.loh AdrpLdr	Lloh48, Lloh49
	.loh AdrpAdrp	Lloh46, Lloh48
	.loh AdrpLdr	Lloh46, Lloh47
	.loh AdrpAdrp	Lloh44, Lloh46
	.loh AdrpLdr	Lloh44, Lloh45
	.loh AdrpAdrp	Lloh42, Lloh44
	.loh AdrpLdr	Lloh42, Lloh43
	.loh AdrpAdrp	Lloh40, Lloh42
	.loh AdrpLdr	Lloh40, Lloh41
	.loh AdrpAdrp	Lloh38, Lloh40
	.loh AdrpLdr	Lloh38, Lloh39
	.loh AdrpAdrp	Lloh36, Lloh38
	.loh AdrpLdr	Lloh36, Lloh37
	.loh AdrpAdrp	Lloh34, Lloh36
	.loh AdrpLdr	Lloh34, Lloh35
	.loh AdrpAdrp	Lloh32, Lloh34
	.loh AdrpLdr	Lloh32, Lloh33
	.loh AdrpAdrp	Lloh30, Lloh32
	.loh AdrpLdr	Lloh30, Lloh31
	.loh AdrpAdrp	Lloh28, Lloh30
	.loh AdrpLdr	Lloh28, Lloh29
	.loh AdrpAdrp	Lloh26, Lloh28
	.loh AdrpLdr	Lloh26, Lloh27
	.loh AdrpAdrp	Lloh24, Lloh26
	.loh AdrpLdr	Lloh24, Lloh25
	.loh AdrpAdrp	Lloh22, Lloh24
	.loh AdrpLdr	Lloh22, Lloh23
	.loh AdrpAdrp	Lloh20, Lloh22
	.loh AdrpLdr	Lloh20, Lloh21
	.loh AdrpAdrp	Lloh18, Lloh20
	.loh AdrpLdr	Lloh18, Lloh19
	.loh AdrpLdr	Lloh106, Lloh107
	.loh AdrpAdrp	Lloh104, Lloh106
	.loh AdrpLdr	Lloh104, Lloh105
	.loh AdrpAdrp	Lloh102, Lloh104
	.loh AdrpLdr	Lloh102, Lloh103
	.loh AdrpAdrp	Lloh100, Lloh102
	.loh AdrpLdr	Lloh100, Lloh101
	.loh AdrpAdrp	Lloh98, Lloh100
	.loh AdrpLdr	Lloh98, Lloh99
	.loh AdrpAdrp	Lloh96, Lloh98
	.loh AdrpLdr	Lloh96, Lloh97
	.loh AdrpAdrp	Lloh94, Lloh96
	.loh AdrpLdr	Lloh94, Lloh95
	.loh AdrpAdrp	Lloh92, Lloh94
	.loh AdrpLdr	Lloh92, Lloh93
	.loh AdrpAdrp	Lloh90, Lloh92
	.loh AdrpLdr	Lloh90, Lloh91
	.loh AdrpAdrp	Lloh88, Lloh90
	.loh AdrpLdr	Lloh88, Lloh89
	.loh AdrpAdrp	Lloh86, Lloh88
	.loh AdrpLdr	Lloh86, Lloh87
	.loh AdrpAdrp	Lloh84, Lloh86
	.loh AdrpLdr	Lloh84, Lloh85
	.loh AdrpAdrp	Lloh82, Lloh84
	.loh AdrpLdr	Lloh82, Lloh83
	.loh AdrpAdrp	Lloh80, Lloh82
	.loh AdrpLdr	Lloh80, Lloh81
	.loh AdrpAdrp	Lloh78, Lloh80
	.loh AdrpLdr	Lloh78, Lloh79
	.loh AdrpAdrp	Lloh76, Lloh78
	.loh AdrpLdr	Lloh76, Lloh77
	.loh AdrpAdrp	Lloh74, Lloh76
	.loh AdrpLdr	Lloh74, Lloh75
	.loh AdrpAdrp	Lloh72, Lloh74
	.loh AdrpLdr	Lloh72, Lloh73
	.loh AdrpAdrp	Lloh70, Lloh72
	.loh AdrpLdr	Lloh70, Lloh71
	.loh AdrpAdrp	Lloh68, Lloh70
	.loh AdrpLdr	Lloh68, Lloh69
	.loh AdrpLdr	Lloh130, Lloh131
	.loh AdrpAdrp	Lloh128, Lloh130
	.loh AdrpLdr	Lloh128, Lloh129
	.loh AdrpAdrp	Lloh126, Lloh128
	.loh AdrpLdr	Lloh126, Lloh127
	.loh AdrpAdrp	Lloh124, Lloh126
	.loh AdrpLdr	Lloh124, Lloh125
	.loh AdrpAdrp	Lloh122, Lloh124
	.loh AdrpLdr	Lloh122, Lloh123
	.loh AdrpAdrp	Lloh120, Lloh122
	.loh AdrpLdr	Lloh120, Lloh121
	.loh AdrpAdrp	Lloh118, Lloh120
	.loh AdrpLdr	Lloh118, Lloh119
	.loh AdrpAdrp	Lloh116, Lloh118
	.loh AdrpLdr	Lloh116, Lloh117
	.loh AdrpAdrp	Lloh114, Lloh116
	.loh AdrpLdr	Lloh114, Lloh115
	.loh AdrpAdrp	Lloh112, Lloh114
	.loh AdrpLdr	Lloh112, Lloh113
	.loh AdrpAdrp	Lloh110, Lloh112
	.loh AdrpLdr	Lloh110, Lloh111
	.loh AdrpAdrp	Lloh108, Lloh110
	.loh AdrpLdr	Lloh108, Lloh109
	.loh AdrpLdr	Lloh162, Lloh163
	.loh AdrpAdrp	Lloh160, Lloh162
	.loh AdrpLdr	Lloh160, Lloh161
	.loh AdrpAdrp	Lloh158, Lloh160
	.loh AdrpLdr	Lloh158, Lloh159
	.loh AdrpAdrp	Lloh156, Lloh158
	.loh AdrpLdr	Lloh156, Lloh157
	.loh AdrpAdrp	Lloh154, Lloh156
	.loh AdrpLdr	Lloh154, Lloh155
	.loh AdrpAdrp	Lloh152, Lloh154
	.loh AdrpLdr	Lloh152, Lloh153
	.loh AdrpAdrp	Lloh150, Lloh152
	.loh AdrpLdr	Lloh150, Lloh151
	.loh AdrpAdrp	Lloh148, Lloh150
	.loh AdrpLdr	Lloh148, Lloh149
	.loh AdrpAdrp	Lloh146, Lloh148
	.loh AdrpLdr	Lloh146, Lloh147
	.loh AdrpAdrp	Lloh144, Lloh146
	.loh AdrpLdr	Lloh144, Lloh145
	.loh AdrpAdrp	Lloh142, Lloh144
	.loh AdrpLdr	Lloh142, Lloh143
	.loh AdrpAdrp	Lloh140, Lloh142
	.loh AdrpLdr	Lloh140, Lloh141
	.loh AdrpAdrp	Lloh138, Lloh140
	.loh AdrpLdr	Lloh138, Lloh139
	.loh AdrpAdrp	Lloh136, Lloh138
	.loh AdrpLdr	Lloh136, Lloh137
	.loh AdrpAdrp	Lloh134, Lloh136
	.loh AdrpLdr	Lloh134, Lloh135
	.loh AdrpAdrp	Lloh132, Lloh134
	.loh AdrpLdr	Lloh132, Lloh133
	.loh AdrpLdr	Lloh198, Lloh199
	.loh AdrpAdrp	Lloh196, Lloh198
	.loh AdrpLdr	Lloh196, Lloh197
	.loh AdrpAdrp	Lloh194, Lloh196
	.loh AdrpLdr	Lloh194, Lloh195
	.loh AdrpAdrp	Lloh192, Lloh194
	.loh AdrpLdr	Lloh192, Lloh193
	.loh AdrpAdrp	Lloh190, Lloh192
	.loh AdrpLdr	Lloh190, Lloh191
	.loh AdrpAdrp	Lloh188, Lloh190
	.loh AdrpLdr	Lloh188, Lloh189
	.loh AdrpAdrp	Lloh186, Lloh188
	.loh AdrpLdr	Lloh186, Lloh187
	.loh AdrpAdrp	Lloh184, Lloh186
	.loh AdrpLdr	Lloh184, Lloh185
	.loh AdrpAdrp	Lloh182, Lloh184
	.loh AdrpLdr	Lloh182, Lloh183
	.loh AdrpAdrp	Lloh180, Lloh182
	.loh AdrpLdr	Lloh180, Lloh181
	.loh AdrpAdrp	Lloh178, Lloh180
	.loh AdrpLdr	Lloh178, Lloh179
	.loh AdrpAdrp	Lloh176, Lloh178
	.loh AdrpLdr	Lloh176, Lloh177
	.loh AdrpAdrp	Lloh174, Lloh176
	.loh AdrpLdr	Lloh174, Lloh175
	.loh AdrpAdrp	Lloh172, Lloh174
	.loh AdrpLdr	Lloh172, Lloh173
	.loh AdrpAdrp	Lloh170, Lloh172
	.loh AdrpLdr	Lloh170, Lloh171
	.loh AdrpAdrp	Lloh168, Lloh170
	.loh AdrpLdr	Lloh168, Lloh169
	.loh AdrpAdrp	Lloh166, Lloh168
	.loh AdrpLdr	Lloh166, Lloh167
	.loh AdrpAdrp	Lloh164, Lloh166
	.loh AdrpLdr	Lloh164, Lloh165
	.loh AdrpLdr	Lloh226, Lloh227
	.loh AdrpAdrp	Lloh224, Lloh226
	.loh AdrpLdr	Lloh224, Lloh225
	.loh AdrpAdrp	Lloh222, Lloh224
	.loh AdrpLdr	Lloh222, Lloh223
	.loh AdrpAdrp	Lloh220, Lloh222
	.loh AdrpLdr	Lloh220, Lloh221
	.loh AdrpAdrp	Lloh218, Lloh220
	.loh AdrpLdr	Lloh218, Lloh219
	.loh AdrpAdrp	Lloh216, Lloh218
	.loh AdrpLdr	Lloh216, Lloh217
	.loh AdrpAdrp	Lloh214, Lloh216
	.loh AdrpLdr	Lloh214, Lloh215
	.loh AdrpAdrp	Lloh212, Lloh214
	.loh AdrpLdr	Lloh212, Lloh213
	.loh AdrpAdrp	Lloh210, Lloh212
	.loh AdrpLdr	Lloh210, Lloh211
	.loh AdrpAdrp	Lloh208, Lloh210
	.loh AdrpLdr	Lloh208, Lloh209
	.loh AdrpAdrp	Lloh206, Lloh208
	.loh AdrpLdr	Lloh206, Lloh207
	.loh AdrpAdrp	Lloh204, Lloh206
	.loh AdrpLdr	Lloh204, Lloh205
	.loh AdrpAdrp	Lloh202, Lloh204
	.loh AdrpLdr	Lloh202, Lloh203
	.loh AdrpAdrp	Lloh200, Lloh202
	.loh AdrpLdr	Lloh200, Lloh201
	.loh AdrpLdr	Lloh268, Lloh269
	.loh AdrpAdrp	Lloh266, Lloh268
	.loh AdrpLdr	Lloh266, Lloh267
	.loh AdrpAdrp	Lloh264, Lloh266
	.loh AdrpLdr	Lloh264, Lloh265
	.loh AdrpAdrp	Lloh262, Lloh264
	.loh AdrpLdr	Lloh262, Lloh263
	.loh AdrpAdrp	Lloh260, Lloh262
	.loh AdrpLdr	Lloh260, Lloh261
	.loh AdrpAdrp	Lloh258, Lloh260
	.loh AdrpLdr	Lloh258, Lloh259
	.loh AdrpAdrp	Lloh256, Lloh258
	.loh AdrpLdr	Lloh256, Lloh257
	.loh AdrpAdrp	Lloh254, Lloh256
	.loh AdrpLdr	Lloh254, Lloh255
	.loh AdrpAdrp	Lloh252, Lloh254
	.loh AdrpLdr	Lloh252, Lloh253
	.loh AdrpAdrp	Lloh250, Lloh252
	.loh AdrpLdr	Lloh250, Lloh251
	.loh AdrpAdrp	Lloh248, Lloh250
	.loh AdrpLdr	Lloh248, Lloh249
	.loh AdrpAdrp	Lloh246, Lloh248
	.loh AdrpLdr	Lloh246, Lloh247
	.loh AdrpAdrp	Lloh244, Lloh246
	.loh AdrpLdr	Lloh244, Lloh245
	.loh AdrpAdrp	Lloh242, Lloh244
	.loh AdrpLdr	Lloh242, Lloh243
	.loh AdrpAdrp	Lloh240, Lloh242
	.loh AdrpLdr	Lloh240, Lloh241
	.loh AdrpAdrp	Lloh238, Lloh240
	.loh AdrpLdr	Lloh238, Lloh239
	.loh AdrpAdrp	Lloh236, Lloh238
	.loh AdrpLdr	Lloh236, Lloh237
	.loh AdrpAdrp	Lloh234, Lloh236
	.loh AdrpLdr	Lloh234, Lloh235
	.loh AdrpAdrp	Lloh232, Lloh234
	.loh AdrpLdr	Lloh232, Lloh233
	.loh AdrpAdrp	Lloh230, Lloh232
	.loh AdrpLdr	Lloh230, Lloh231
	.loh AdrpAdrp	Lloh228, Lloh230
	.loh AdrpLdr	Lloh228, Lloh229
	.loh AdrpLdr	Lloh288, Lloh289
	.loh AdrpAdrp	Lloh286, Lloh288
	.loh AdrpLdr	Lloh286, Lloh287
	.loh AdrpAdrp	Lloh284, Lloh286
	.loh AdrpLdr	Lloh284, Lloh285
	.loh AdrpAdrp	Lloh282, Lloh284
	.loh AdrpLdr	Lloh282, Lloh283
	.loh AdrpAdrp	Lloh280, Lloh282
	.loh AdrpLdr	Lloh280, Lloh281
	.loh AdrpAdrp	Lloh278, Lloh280
	.loh AdrpLdr	Lloh278, Lloh279
	.loh AdrpAdrp	Lloh276, Lloh278
	.loh AdrpLdr	Lloh276, Lloh277
	.loh AdrpAdrp	Lloh274, Lloh276
	.loh AdrpLdr	Lloh274, Lloh275
	.loh AdrpAdrp	Lloh272, Lloh274
	.loh AdrpLdr	Lloh272, Lloh273
	.loh AdrpAdrp	Lloh270, Lloh272
	.loh AdrpLdr	Lloh270, Lloh271
	.loh AdrpLdr	Lloh336, Lloh337
	.loh AdrpAdrp	Lloh334, Lloh336
	.loh AdrpLdr	Lloh334, Lloh335
	.loh AdrpAdrp	Lloh332, Lloh334
	.loh AdrpLdr	Lloh332, Lloh333
	.loh AdrpAdrp	Lloh330, Lloh332
	.loh AdrpLdr	Lloh330, Lloh331
	.loh AdrpAdrp	Lloh328, Lloh330
	.loh AdrpLdr	Lloh328, Lloh329
	.loh AdrpAdrp	Lloh326, Lloh328
	.loh AdrpLdr	Lloh326, Lloh327
	.loh AdrpAdrp	Lloh324, Lloh326
	.loh AdrpLdr	Lloh324, Lloh325
	.loh AdrpAdrp	Lloh322, Lloh324
	.loh AdrpLdr	Lloh322, Lloh323
	.loh AdrpAdrp	Lloh320, Lloh322
	.loh AdrpLdr	Lloh320, Lloh321
	.loh AdrpAdrp	Lloh318, Lloh320
	.loh AdrpLdr	Lloh318, Lloh319
	.loh AdrpAdrp	Lloh316, Lloh318
	.loh AdrpLdr	Lloh316, Lloh317
	.loh AdrpAdrp	Lloh314, Lloh316
	.loh AdrpLdr	Lloh314, Lloh315
	.loh AdrpAdrp	Lloh312, Lloh314
	.loh AdrpLdr	Lloh312, Lloh313
	.loh AdrpAdrp	Lloh310, Lloh312
	.loh AdrpLdr	Lloh310, Lloh311
	.loh AdrpAdrp	Lloh308, Lloh310
	.loh AdrpLdr	Lloh308, Lloh309
	.loh AdrpAdrp	Lloh306, Lloh308
	.loh AdrpLdr	Lloh306, Lloh307
	.loh AdrpAdrp	Lloh304, Lloh306
	.loh AdrpLdr	Lloh304, Lloh305
	.loh AdrpAdrp	Lloh302, Lloh304
	.loh AdrpLdr	Lloh302, Lloh303
	.loh AdrpAdrp	Lloh300, Lloh302
	.loh AdrpLdr	Lloh300, Lloh301
	.loh AdrpAdrp	Lloh298, Lloh300
	.loh AdrpLdr	Lloh298, Lloh299
	.loh AdrpAdrp	Lloh296, Lloh298
	.loh AdrpLdr	Lloh296, Lloh297
	.loh AdrpAdrp	Lloh294, Lloh296
	.loh AdrpLdr	Lloh294, Lloh295
	.loh AdrpAdrp	Lloh292, Lloh294
	.loh AdrpLdr	Lloh292, Lloh293
	.loh AdrpAdrp	Lloh290, Lloh292
	.loh AdrpLdr	Lloh290, Lloh291
	.loh AdrpLdr	Lloh352, Lloh353
	.loh AdrpAdrp	Lloh350, Lloh352
	.loh AdrpLdr	Lloh350, Lloh351
	.loh AdrpAdrp	Lloh348, Lloh350
	.loh AdrpLdr	Lloh348, Lloh349
	.loh AdrpAdrp	Lloh346, Lloh348
	.loh AdrpLdr	Lloh346, Lloh347
	.loh AdrpAdrp	Lloh344, Lloh346
	.loh AdrpLdr	Lloh344, Lloh345
	.loh AdrpAdrp	Lloh342, Lloh344
	.loh AdrpLdr	Lloh342, Lloh343
	.loh AdrpAdrp	Lloh340, Lloh342
	.loh AdrpLdr	Lloh340, Lloh341
	.loh AdrpAdrp	Lloh338, Lloh340
	.loh AdrpLdr	Lloh338, Lloh339
	.loh AdrpLdr	Lloh386, Lloh387
	.loh AdrpAdrp	Lloh384, Lloh386
	.loh AdrpLdr	Lloh384, Lloh385
	.loh AdrpAdrp	Lloh382, Lloh384
	.loh AdrpLdr	Lloh382, Lloh383
	.loh AdrpAdrp	Lloh380, Lloh382
	.loh AdrpLdr	Lloh380, Lloh381
	.loh AdrpAdrp	Lloh378, Lloh380
	.loh AdrpLdr	Lloh378, Lloh379
	.loh AdrpAdrp	Lloh376, Lloh378
	.loh AdrpLdr	Lloh376, Lloh377
	.loh AdrpAdrp	Lloh374, Lloh376
	.loh AdrpLdr	Lloh374, Lloh375
	.loh AdrpAdrp	Lloh372, Lloh374
	.loh AdrpLdr	Lloh372, Lloh373
	.loh AdrpAdrp	Lloh370, Lloh372
	.loh AdrpLdr	Lloh370, Lloh371
	.loh AdrpAdrp	Lloh368, Lloh370
	.loh AdrpLdr	Lloh368, Lloh369
	.loh AdrpAdrp	Lloh366, Lloh368
	.loh AdrpLdr	Lloh366, Lloh367
	.loh AdrpAdrp	Lloh364, Lloh366
	.loh AdrpLdr	Lloh364, Lloh365
	.loh AdrpAdrp	Lloh362, Lloh364
	.loh AdrpLdr	Lloh362, Lloh363
	.loh AdrpAdrp	Lloh360, Lloh362
	.loh AdrpLdr	Lloh360, Lloh361
	.loh AdrpAdrp	Lloh358, Lloh360
	.loh AdrpLdr	Lloh358, Lloh359
	.loh AdrpAdrp	Lloh356, Lloh358
	.loh AdrpLdr	Lloh356, Lloh357
	.loh AdrpAdrp	Lloh354, Lloh356
	.loh AdrpLdr	Lloh354, Lloh355
	.loh AdrpLdr	Lloh424, Lloh425
	.loh AdrpAdrp	Lloh422, Lloh424
	.loh AdrpLdr	Lloh422, Lloh423
	.loh AdrpAdrp	Lloh420, Lloh422
	.loh AdrpLdr	Lloh420, Lloh421
	.loh AdrpAdrp	Lloh418, Lloh420
	.loh AdrpLdr	Lloh418, Lloh419
	.loh AdrpAdrp	Lloh416, Lloh418
	.loh AdrpLdr	Lloh416, Lloh417
	.loh AdrpAdrp	Lloh414, Lloh416
	.loh AdrpLdr	Lloh414, Lloh415
	.loh AdrpAdrp	Lloh412, Lloh414
	.loh AdrpLdr	Lloh412, Lloh413
	.loh AdrpAdrp	Lloh410, Lloh412
	.loh AdrpLdr	Lloh410, Lloh411
	.loh AdrpAdrp	Lloh408, Lloh410
	.loh AdrpLdr	Lloh408, Lloh409
	.loh AdrpAdrp	Lloh406, Lloh408
	.loh AdrpLdr	Lloh406, Lloh407
	.loh AdrpAdrp	Lloh404, Lloh406
	.loh AdrpLdr	Lloh404, Lloh405
	.loh AdrpAdrp	Lloh402, Lloh404
	.loh AdrpLdr	Lloh402, Lloh403
	.loh AdrpAdrp	Lloh400, Lloh402
	.loh AdrpLdr	Lloh400, Lloh401
	.loh AdrpAdrp	Lloh398, Lloh400
	.loh AdrpLdr	Lloh398, Lloh399
	.loh AdrpAdrp	Lloh396, Lloh398
	.loh AdrpLdr	Lloh396, Lloh397
	.loh AdrpAdrp	Lloh394, Lloh396
	.loh AdrpLdr	Lloh394, Lloh395
	.loh AdrpAdrp	Lloh392, Lloh394
	.loh AdrpLdr	Lloh392, Lloh393
	.loh AdrpAdrp	Lloh390, Lloh392
	.loh AdrpLdr	Lloh390, Lloh391
	.loh AdrpAdrp	Lloh388, Lloh390
	.loh AdrpLdr	Lloh388, Lloh389
	.loh AdrpLdr	Lloh446, Lloh447
	.loh AdrpAdrp	Lloh444, Lloh446
	.loh AdrpLdr	Lloh444, Lloh445
	.loh AdrpAdrp	Lloh442, Lloh444
	.loh AdrpLdr	Lloh442, Lloh443
	.loh AdrpAdrp	Lloh440, Lloh442
	.loh AdrpLdr	Lloh440, Lloh441
	.loh AdrpAdrp	Lloh438, Lloh440
	.loh AdrpLdr	Lloh438, Lloh439
	.loh AdrpAdrp	Lloh436, Lloh438
	.loh AdrpLdr	Lloh436, Lloh437
	.loh AdrpAdrp	Lloh434, Lloh436
	.loh AdrpLdr	Lloh434, Lloh435
	.loh AdrpAdrp	Lloh432, Lloh434
	.loh AdrpLdr	Lloh432, Lloh433
	.loh AdrpAdrp	Lloh430, Lloh432
	.loh AdrpLdr	Lloh430, Lloh431
	.loh AdrpAdrp	Lloh428, Lloh430
	.loh AdrpLdr	Lloh428, Lloh429
	.loh AdrpAdrp	Lloh426, Lloh428
	.loh AdrpLdr	Lloh426, Lloh427
	.loh AdrpLdr	Lloh464, Lloh465
	.loh AdrpAdrp	Lloh462, Lloh464
	.loh AdrpLdr	Lloh462, Lloh463
	.loh AdrpAdrp	Lloh460, Lloh462
	.loh AdrpLdr	Lloh460, Lloh461
	.loh AdrpAdrp	Lloh458, Lloh460
	.loh AdrpLdr	Lloh458, Lloh459
	.loh AdrpAdrp	Lloh456, Lloh458
	.loh AdrpLdr	Lloh456, Lloh457
	.loh AdrpAdrp	Lloh454, Lloh456
	.loh AdrpLdr	Lloh454, Lloh455
	.loh AdrpAdrp	Lloh452, Lloh454
	.loh AdrpLdr	Lloh452, Lloh453
	.loh AdrpAdrp	Lloh450, Lloh452
	.loh AdrpLdr	Lloh450, Lloh451
	.loh AdrpAdrp	Lloh448, Lloh450
	.loh AdrpLdr	Lloh448, Lloh449
	.loh AdrpLdr	Lloh472, Lloh473
	.loh AdrpAdrp	Lloh470, Lloh472
	.loh AdrpLdr	Lloh470, Lloh471
	.loh AdrpAdrp	Lloh468, Lloh470
	.loh AdrpLdr	Lloh468, Lloh469
	.loh AdrpAdrp	Lloh466, Lloh468
	.loh AdrpLdr	Lloh466, Lloh467
	.loh AdrpLdr	Lloh478, Lloh479
	.loh AdrpAdrp	Lloh476, Lloh478
	.loh AdrpLdr	Lloh476, Lloh477
	.loh AdrpAdrp	Lloh474, Lloh476
	.loh AdrpLdr	Lloh474, Lloh475
	.loh AdrpLdr	Lloh488, Lloh489
	.loh AdrpAdrp	Lloh486, Lloh488
	.loh AdrpLdr	Lloh486, Lloh487
	.loh AdrpAdrp	Lloh484, Lloh486
	.loh AdrpLdr	Lloh484, Lloh485
	.loh AdrpAdrp	Lloh482, Lloh484
	.loh AdrpLdr	Lloh482, Lloh483
	.loh AdrpAdrp	Lloh480, Lloh482
	.loh AdrpLdr	Lloh480, Lloh481
	.loh AdrpLdr	Lloh502, Lloh503
	.loh AdrpAdrp	Lloh500, Lloh502
	.loh AdrpLdr	Lloh500, Lloh501
	.loh AdrpAdrp	Lloh498, Lloh500
	.loh AdrpLdr	Lloh498, Lloh499
	.loh AdrpAdrp	Lloh496, Lloh498
	.loh AdrpLdr	Lloh496, Lloh497
	.loh AdrpAdrp	Lloh494, Lloh496
	.loh AdrpLdr	Lloh494, Lloh495
	.loh AdrpAdrp	Lloh492, Lloh494
	.loh AdrpLdr	Lloh492, Lloh493
	.loh AdrpAdrp	Lloh490, Lloh492
	.loh AdrpLdr	Lloh490, Lloh491
	.loh AdrpLdr	Lloh514, Lloh515
	.loh AdrpAdrp	Lloh512, Lloh514
	.loh AdrpLdr	Lloh512, Lloh513
	.loh AdrpAdrp	Lloh510, Lloh512
	.loh AdrpLdr	Lloh510, Lloh511
	.loh AdrpAdrp	Lloh508, Lloh510
	.loh AdrpLdr	Lloh508, Lloh509
	.loh AdrpAdrp	Lloh506, Lloh508
	.loh AdrpLdr	Lloh506, Lloh507
	.loh AdrpAdrp	Lloh504, Lloh506
	.loh AdrpLdr	Lloh504, Lloh505
	.loh AdrpLdr	Lloh568, Lloh569
	.loh AdrpAdrp	Lloh566, Lloh568
	.loh AdrpLdr	Lloh566, Lloh567
	.loh AdrpAdrp	Lloh564, Lloh566
	.loh AdrpLdr	Lloh564, Lloh565
	.loh AdrpAdrp	Lloh562, Lloh564
	.loh AdrpLdr	Lloh562, Lloh563
	.loh AdrpAdrp	Lloh560, Lloh562
	.loh AdrpLdr	Lloh560, Lloh561
	.loh AdrpAdrp	Lloh558, Lloh560
	.loh AdrpLdr	Lloh558, Lloh559
	.loh AdrpAdrp	Lloh556, Lloh558
	.loh AdrpLdr	Lloh556, Lloh557
	.loh AdrpAdrp	Lloh554, Lloh556
	.loh AdrpLdr	Lloh554, Lloh555
	.loh AdrpAdrp	Lloh552, Lloh554
	.loh AdrpLdr	Lloh552, Lloh553
	.loh AdrpAdrp	Lloh550, Lloh552
	.loh AdrpLdr	Lloh550, Lloh551
	.loh AdrpAdrp	Lloh548, Lloh550
	.loh AdrpLdr	Lloh548, Lloh549
	.loh AdrpAdrp	Lloh546, Lloh548
	.loh AdrpLdr	Lloh546, Lloh547
	.loh AdrpAdrp	Lloh544, Lloh546
	.loh AdrpLdr	Lloh544, Lloh545
	.loh AdrpAdrp	Lloh542, Lloh544
	.loh AdrpLdr	Lloh542, Lloh543
	.loh AdrpAdrp	Lloh540, Lloh542
	.loh AdrpLdr	Lloh540, Lloh541
	.loh AdrpAdrp	Lloh538, Lloh540
	.loh AdrpLdr	Lloh538, Lloh539
	.loh AdrpAdrp	Lloh536, Lloh538
	.loh AdrpLdr	Lloh536, Lloh537
	.loh AdrpAdrp	Lloh534, Lloh536
	.loh AdrpLdr	Lloh534, Lloh535
	.loh AdrpAdrp	Lloh532, Lloh534
	.loh AdrpLdr	Lloh532, Lloh533
	.loh AdrpAdrp	Lloh530, Lloh532
	.loh AdrpLdr	Lloh530, Lloh531
	.loh AdrpAdrp	Lloh528, Lloh530
	.loh AdrpLdr	Lloh528, Lloh529
	.loh AdrpAdrp	Lloh526, Lloh528
	.loh AdrpLdr	Lloh526, Lloh527
	.loh AdrpAdrp	Lloh524, Lloh526
	.loh AdrpLdr	Lloh524, Lloh525
	.loh AdrpAdrp	Lloh522, Lloh524
	.loh AdrpLdr	Lloh522, Lloh523
	.loh AdrpAdrp	Lloh520, Lloh522
	.loh AdrpLdr	Lloh520, Lloh521
	.loh AdrpAdrp	Lloh518, Lloh520
	.loh AdrpLdr	Lloh518, Lloh519
	.loh AdrpAdrp	Lloh516, Lloh518
	.loh AdrpLdr	Lloh516, Lloh517
	.loh AdrpLdr	Lloh594, Lloh595
	.loh AdrpAdrp	Lloh592, Lloh594
	.loh AdrpLdr	Lloh592, Lloh593
	.loh AdrpAdrp	Lloh590, Lloh592
	.loh AdrpLdr	Lloh590, Lloh591
	.loh AdrpAdrp	Lloh588, Lloh590
	.loh AdrpLdr	Lloh588, Lloh589
	.loh AdrpAdrp	Lloh586, Lloh588
	.loh AdrpLdr	Lloh586, Lloh587
	.loh AdrpAdrp	Lloh584, Lloh586
	.loh AdrpLdr	Lloh584, Lloh585
	.loh AdrpAdrp	Lloh582, Lloh584
	.loh AdrpLdr	Lloh582, Lloh583
	.loh AdrpAdrp	Lloh580, Lloh582
	.loh AdrpLdr	Lloh580, Lloh581
	.loh AdrpAdrp	Lloh578, Lloh580
	.loh AdrpLdr	Lloh578, Lloh579
	.loh AdrpAdrp	Lloh576, Lloh578
	.loh AdrpLdr	Lloh576, Lloh577
	.loh AdrpAdrp	Lloh574, Lloh576
	.loh AdrpLdr	Lloh574, Lloh575
	.loh AdrpAdrp	Lloh572, Lloh574
	.loh AdrpLdr	Lloh572, Lloh573
	.loh AdrpAdrp	Lloh570, Lloh572
	.loh AdrpLdr	Lloh570, Lloh571
	.loh AdrpLdr	Lloh652, Lloh653
	.loh AdrpAdrp	Lloh650, Lloh652
	.loh AdrpLdr	Lloh650, Lloh651
	.loh AdrpAdrp	Lloh648, Lloh650
	.loh AdrpLdr	Lloh648, Lloh649
	.loh AdrpAdrp	Lloh646, Lloh648
	.loh AdrpLdr	Lloh646, Lloh647
	.loh AdrpAdrp	Lloh644, Lloh646
	.loh AdrpLdr	Lloh644, Lloh645
	.loh AdrpAdrp	Lloh642, Lloh644
	.loh AdrpLdr	Lloh642, Lloh643
	.loh AdrpAdrp	Lloh640, Lloh642
	.loh AdrpLdr	Lloh640, Lloh641
	.loh AdrpAdrp	Lloh638, Lloh640
	.loh AdrpLdr	Lloh638, Lloh639
	.loh AdrpAdrp	Lloh636, Lloh638
	.loh AdrpLdr	Lloh636, Lloh637
	.loh AdrpAdrp	Lloh634, Lloh636
	.loh AdrpLdr	Lloh634, Lloh635
	.loh AdrpAdrp	Lloh632, Lloh634
	.loh AdrpLdr	Lloh632, Lloh633
	.loh AdrpAdrp	Lloh630, Lloh632
	.loh AdrpLdr	Lloh630, Lloh631
	.loh AdrpAdrp	Lloh628, Lloh630
	.loh AdrpLdr	Lloh628, Lloh629
	.loh AdrpAdrp	Lloh626, Lloh628
	.loh AdrpLdr	Lloh626, Lloh627
	.loh AdrpAdrp	Lloh624, Lloh626
	.loh AdrpLdr	Lloh624, Lloh625
	.loh AdrpAdrp	Lloh622, Lloh624
	.loh AdrpLdr	Lloh622, Lloh623
	.loh AdrpAdrp	Lloh620, Lloh622
	.loh AdrpLdr	Lloh620, Lloh621
	.loh AdrpAdrp	Lloh618, Lloh620
	.loh AdrpLdr	Lloh618, Lloh619
	.loh AdrpAdrp	Lloh616, Lloh618
	.loh AdrpLdr	Lloh616, Lloh617
	.loh AdrpAdrp	Lloh614, Lloh616
	.loh AdrpLdr	Lloh614, Lloh615
	.loh AdrpAdrp	Lloh612, Lloh614
	.loh AdrpLdr	Lloh612, Lloh613
	.loh AdrpAdrp	Lloh610, Lloh612
	.loh AdrpLdr	Lloh610, Lloh611
	.loh AdrpAdrp	Lloh608, Lloh610
	.loh AdrpLdr	Lloh608, Lloh609
	.loh AdrpAdrp	Lloh606, Lloh608
	.loh AdrpLdr	Lloh606, Lloh607
	.loh AdrpAdrp	Lloh604, Lloh606
	.loh AdrpLdr	Lloh604, Lloh605
	.loh AdrpAdrp	Lloh602, Lloh604
	.loh AdrpLdr	Lloh602, Lloh603
	.loh AdrpAdrp	Lloh600, Lloh602
	.loh AdrpLdr	Lloh600, Lloh601
	.loh AdrpAdrp	Lloh598, Lloh600
	.loh AdrpLdr	Lloh598, Lloh599
	.loh AdrpAdrp	Lloh596, Lloh598
	.loh AdrpLdr	Lloh596, Lloh597
	.loh AdrpLdr	Lloh682, Lloh683
	.loh AdrpAdrp	Lloh680, Lloh682
	.loh AdrpLdr	Lloh680, Lloh681
	.loh AdrpAdrp	Lloh678, Lloh680
	.loh AdrpLdr	Lloh678, Lloh679
	.loh AdrpAdrp	Lloh676, Lloh678
	.loh AdrpLdr	Lloh676, Lloh677
	.loh AdrpAdrp	Lloh674, Lloh676
	.loh AdrpLdr	Lloh674, Lloh675
	.loh AdrpAdrp	Lloh672, Lloh674
	.loh AdrpLdr	Lloh672, Lloh673
	.loh AdrpAdrp	Lloh670, Lloh672
	.loh AdrpLdr	Lloh670, Lloh671
	.loh AdrpAdrp	Lloh668, Lloh670
	.loh AdrpLdr	Lloh668, Lloh669
	.loh AdrpAdrp	Lloh666, Lloh668
	.loh AdrpLdr	Lloh666, Lloh667
	.loh AdrpAdrp	Lloh664, Lloh666
	.loh AdrpLdr	Lloh664, Lloh665
	.loh AdrpAdrp	Lloh662, Lloh664
	.loh AdrpLdr	Lloh662, Lloh663
	.loh AdrpAdrp	Lloh660, Lloh662
	.loh AdrpLdr	Lloh660, Lloh661
	.loh AdrpAdrp	Lloh658, Lloh660
	.loh AdrpLdr	Lloh658, Lloh659
	.loh AdrpAdrp	Lloh656, Lloh658
	.loh AdrpLdr	Lloh656, Lloh657
	.loh AdrpAdrp	Lloh654, Lloh656
	.loh AdrpLdr	Lloh654, Lloh655
	.loh AdrpLdr	Lloh726, Lloh727
	.loh AdrpAdrp	Lloh724, Lloh726
	.loh AdrpLdr	Lloh724, Lloh725
	.loh AdrpAdrp	Lloh722, Lloh724
	.loh AdrpLdr	Lloh722, Lloh723
	.loh AdrpAdrp	Lloh720, Lloh722
	.loh AdrpLdr	Lloh720, Lloh721
	.loh AdrpAdrp	Lloh718, Lloh720
	.loh AdrpLdr	Lloh718, Lloh719
	.loh AdrpAdrp	Lloh716, Lloh718
	.loh AdrpLdr	Lloh716, Lloh717
	.loh AdrpAdrp	Lloh714, Lloh716
	.loh AdrpLdr	Lloh714, Lloh715
	.loh AdrpAdrp	Lloh712, Lloh714
	.loh AdrpLdr	Lloh712, Lloh713
	.loh AdrpAdrp	Lloh710, Lloh712
	.loh AdrpLdr	Lloh710, Lloh711
	.loh AdrpAdrp	Lloh708, Lloh710
	.loh AdrpLdr	Lloh708, Lloh709
	.loh AdrpAdrp	Lloh706, Lloh708
	.loh AdrpLdr	Lloh706, Lloh707
	.loh AdrpAdrp	Lloh704, Lloh706
	.loh AdrpLdr	Lloh704, Lloh705
	.loh AdrpAdrp	Lloh702, Lloh704
	.loh AdrpLdr	Lloh702, Lloh703
	.loh AdrpAdrp	Lloh700, Lloh702
	.loh AdrpLdr	Lloh700, Lloh701
	.loh AdrpAdrp	Lloh698, Lloh700
	.loh AdrpLdr	Lloh698, Lloh699
	.loh AdrpAdrp	Lloh696, Lloh698
	.loh AdrpLdr	Lloh696, Lloh697
	.loh AdrpAdrp	Lloh694, Lloh696
	.loh AdrpLdr	Lloh694, Lloh695
	.loh AdrpAdrp	Lloh692, Lloh694
	.loh AdrpLdr	Lloh692, Lloh693
	.loh AdrpAdrp	Lloh690, Lloh692
	.loh AdrpLdr	Lloh690, Lloh691
	.loh AdrpAdrp	Lloh688, Lloh690
	.loh AdrpLdr	Lloh688, Lloh689
	.loh AdrpAdrp	Lloh686, Lloh688
	.loh AdrpLdr	Lloh686, Lloh687
	.loh AdrpAdrp	Lloh684, Lloh686
	.loh AdrpLdr	Lloh684, Lloh685
	.loh AdrpLdr	Lloh786, Lloh787
	.loh AdrpAdrp	Lloh784, Lloh786
	.loh AdrpLdr	Lloh784, Lloh785
	.loh AdrpAdrp	Lloh782, Lloh784
	.loh AdrpLdr	Lloh782, Lloh783
	.loh AdrpAdrp	Lloh780, Lloh782
	.loh AdrpLdr	Lloh780, Lloh781
	.loh AdrpAdrp	Lloh778, Lloh780
	.loh AdrpLdr	Lloh778, Lloh779
	.loh AdrpAdrp	Lloh776, Lloh778
	.loh AdrpLdr	Lloh776, Lloh777
	.loh AdrpAdrp	Lloh774, Lloh776
	.loh AdrpLdr	Lloh774, Lloh775
	.loh AdrpAdrp	Lloh772, Lloh774
	.loh AdrpLdr	Lloh772, Lloh773
	.loh AdrpAdrp	Lloh770, Lloh772
	.loh AdrpLdr	Lloh770, Lloh771
	.loh AdrpAdrp	Lloh768, Lloh770
	.loh AdrpLdr	Lloh768, Lloh769
	.loh AdrpAdrp	Lloh766, Lloh768
	.loh AdrpLdr	Lloh766, Lloh767
	.loh AdrpAdrp	Lloh764, Lloh766
	.loh AdrpLdr	Lloh764, Lloh765
	.loh AdrpAdrp	Lloh762, Lloh764
	.loh AdrpLdr	Lloh762, Lloh763
	.loh AdrpAdrp	Lloh760, Lloh762
	.loh AdrpLdr	Lloh760, Lloh761
	.loh AdrpAdrp	Lloh758, Lloh760
	.loh AdrpLdr	Lloh758, Lloh759
	.loh AdrpAdrp	Lloh756, Lloh758
	.loh AdrpLdr	Lloh756, Lloh757
	.loh AdrpAdrp	Lloh754, Lloh756
	.loh AdrpLdr	Lloh754, Lloh755
	.loh AdrpAdrp	Lloh752, Lloh754
	.loh AdrpLdr	Lloh752, Lloh753
	.loh AdrpAdrp	Lloh750, Lloh752
	.loh AdrpLdr	Lloh750, Lloh751
	.loh AdrpAdrp	Lloh748, Lloh750
	.loh AdrpLdr	Lloh748, Lloh749
	.loh AdrpAdrp	Lloh746, Lloh748
	.loh AdrpLdr	Lloh746, Lloh747
	.loh AdrpAdrp	Lloh744, Lloh746
	.loh AdrpLdr	Lloh744, Lloh745
	.loh AdrpAdrp	Lloh742, Lloh744
	.loh AdrpLdr	Lloh742, Lloh743
	.loh AdrpAdrp	Lloh740, Lloh742
	.loh AdrpLdr	Lloh740, Lloh741
	.loh AdrpAdrp	Lloh738, Lloh740
	.loh AdrpLdr	Lloh738, Lloh739
	.loh AdrpAdrp	Lloh736, Lloh738
	.loh AdrpLdr	Lloh736, Lloh737
	.loh AdrpAdrp	Lloh734, Lloh736
	.loh AdrpLdr	Lloh734, Lloh735
	.loh AdrpAdrp	Lloh732, Lloh734
	.loh AdrpLdr	Lloh732, Lloh733
	.loh AdrpAdrp	Lloh730, Lloh732
	.loh AdrpLdr	Lloh730, Lloh731
	.loh AdrpAdrp	Lloh728, Lloh730
	.loh AdrpLdr	Lloh728, Lloh729
	.loh AdrpLdr	Lloh838, Lloh839
	.loh AdrpAdrp	Lloh836, Lloh838
	.loh AdrpLdr	Lloh836, Lloh837
	.loh AdrpAdrp	Lloh834, Lloh836
	.loh AdrpLdr	Lloh834, Lloh835
	.loh AdrpAdrp	Lloh832, Lloh834
	.loh AdrpLdr	Lloh832, Lloh833
	.loh AdrpAdrp	Lloh830, Lloh832
	.loh AdrpLdr	Lloh830, Lloh831
	.loh AdrpAdrp	Lloh828, Lloh830
	.loh AdrpLdr	Lloh828, Lloh829
	.loh AdrpAdrp	Lloh826, Lloh828
	.loh AdrpLdr	Lloh826, Lloh827
	.loh AdrpAdrp	Lloh824, Lloh826
	.loh AdrpLdr	Lloh824, Lloh825
	.loh AdrpAdrp	Lloh822, Lloh824
	.loh AdrpLdr	Lloh822, Lloh823
	.loh AdrpAdrp	Lloh820, Lloh822
	.loh AdrpLdr	Lloh820, Lloh821
	.loh AdrpAdrp	Lloh818, Lloh820
	.loh AdrpLdr	Lloh818, Lloh819
	.loh AdrpAdrp	Lloh816, Lloh818
	.loh AdrpLdr	Lloh816, Lloh817
	.loh AdrpAdrp	Lloh814, Lloh816
	.loh AdrpLdr	Lloh814, Lloh815
	.loh AdrpAdrp	Lloh812, Lloh814
	.loh AdrpLdr	Lloh812, Lloh813
	.loh AdrpAdrp	Lloh810, Lloh812
	.loh AdrpLdr	Lloh810, Lloh811
	.loh AdrpAdrp	Lloh808, Lloh810
	.loh AdrpLdr	Lloh808, Lloh809
	.loh AdrpAdrp	Lloh806, Lloh808
	.loh AdrpLdr	Lloh806, Lloh807
	.loh AdrpAdrp	Lloh804, Lloh806
	.loh AdrpLdr	Lloh804, Lloh805
	.loh AdrpAdrp	Lloh802, Lloh804
	.loh AdrpLdr	Lloh802, Lloh803
	.loh AdrpAdrp	Lloh800, Lloh802
	.loh AdrpLdr	Lloh800, Lloh801
	.loh AdrpAdrp	Lloh798, Lloh800
	.loh AdrpLdr	Lloh798, Lloh799
	.loh AdrpAdrp	Lloh796, Lloh798
	.loh AdrpLdr	Lloh796, Lloh797
	.loh AdrpAdrp	Lloh794, Lloh796
	.loh AdrpLdr	Lloh794, Lloh795
	.loh AdrpAdrp	Lloh792, Lloh794
	.loh AdrpLdr	Lloh792, Lloh793
	.loh AdrpAdrp	Lloh790, Lloh792
	.loh AdrpLdr	Lloh790, Lloh791
	.loh AdrpAdrp	Lloh788, Lloh790
	.loh AdrpLdr	Lloh788, Lloh789
	.loh AdrpLdr	Lloh884, Lloh885
	.loh AdrpAdrp	Lloh882, Lloh884
	.loh AdrpLdr	Lloh882, Lloh883
	.loh AdrpAdrp	Lloh880, Lloh882
	.loh AdrpLdr	Lloh880, Lloh881
	.loh AdrpAdrp	Lloh878, Lloh880
	.loh AdrpLdr	Lloh878, Lloh879
	.loh AdrpAdrp	Lloh876, Lloh878
	.loh AdrpLdr	Lloh876, Lloh877
	.loh AdrpAdrp	Lloh874, Lloh876
	.loh AdrpLdr	Lloh874, Lloh875
	.loh AdrpAdrp	Lloh872, Lloh874
	.loh AdrpLdr	Lloh872, Lloh873
	.loh AdrpAdrp	Lloh870, Lloh872
	.loh AdrpLdr	Lloh870, Lloh871
	.loh AdrpAdrp	Lloh868, Lloh870
	.loh AdrpLdr	Lloh868, Lloh869
	.loh AdrpAdrp	Lloh866, Lloh868
	.loh AdrpLdr	Lloh866, Lloh867
	.loh AdrpAdrp	Lloh864, Lloh866
	.loh AdrpLdr	Lloh864, Lloh865
	.loh AdrpAdrp	Lloh862, Lloh864
	.loh AdrpLdr	Lloh862, Lloh863
	.loh AdrpAdrp	Lloh860, Lloh862
	.loh AdrpLdr	Lloh860, Lloh861
	.loh AdrpAdrp	Lloh858, Lloh860
	.loh AdrpLdr	Lloh858, Lloh859
	.loh AdrpAdrp	Lloh856, Lloh858
	.loh AdrpLdr	Lloh856, Lloh857
	.loh AdrpAdrp	Lloh854, Lloh856
	.loh AdrpLdr	Lloh854, Lloh855
	.loh AdrpAdrp	Lloh852, Lloh854
	.loh AdrpLdr	Lloh852, Lloh853
	.loh AdrpAdrp	Lloh850, Lloh852
	.loh AdrpLdr	Lloh850, Lloh851
	.loh AdrpAdrp	Lloh848, Lloh850
	.loh AdrpLdr	Lloh848, Lloh849
	.loh AdrpAdrp	Lloh846, Lloh848
	.loh AdrpLdr	Lloh846, Lloh847
	.loh AdrpAdrp	Lloh844, Lloh846
	.loh AdrpLdr	Lloh844, Lloh845
	.loh AdrpAdrp	Lloh842, Lloh844
	.loh AdrpLdr	Lloh842, Lloh843
	.loh AdrpAdrp	Lloh840, Lloh842
	.loh AdrpLdr	Lloh840, Lloh841
	.loh AdrpLdr	Lloh940, Lloh941
	.loh AdrpAdrp	Lloh938, Lloh940
	.loh AdrpLdr	Lloh938, Lloh939
	.loh AdrpAdrp	Lloh936, Lloh938
	.loh AdrpLdr	Lloh936, Lloh937
	.loh AdrpAdrp	Lloh934, Lloh936
	.loh AdrpLdr	Lloh934, Lloh935
	.loh AdrpAdrp	Lloh932, Lloh934
	.loh AdrpLdr	Lloh932, Lloh933
	.loh AdrpAdrp	Lloh930, Lloh932
	.loh AdrpLdr	Lloh930, Lloh931
	.loh AdrpAdrp	Lloh928, Lloh930
	.loh AdrpLdr	Lloh928, Lloh929
	.loh AdrpAdrp	Lloh926, Lloh928
	.loh AdrpLdr	Lloh926, Lloh927
	.loh AdrpAdrp	Lloh924, Lloh926
	.loh AdrpLdr	Lloh924, Lloh925
	.loh AdrpAdrp	Lloh922, Lloh924
	.loh AdrpLdr	Lloh922, Lloh923
	.loh AdrpAdrp	Lloh920, Lloh922
	.loh AdrpLdr	Lloh920, Lloh921
	.loh AdrpAdrp	Lloh918, Lloh920
	.loh AdrpLdr	Lloh918, Lloh919
	.loh AdrpAdrp	Lloh916, Lloh918
	.loh AdrpLdr	Lloh916, Lloh917
	.loh AdrpAdrp	Lloh914, Lloh916
	.loh AdrpLdr	Lloh914, Lloh915
	.loh AdrpAdrp	Lloh912, Lloh914
	.loh AdrpLdr	Lloh912, Lloh913
	.loh AdrpAdrp	Lloh910, Lloh912
	.loh AdrpLdr	Lloh910, Lloh911
	.loh AdrpAdrp	Lloh908, Lloh910
	.loh AdrpLdr	Lloh908, Lloh909
	.loh AdrpAdrp	Lloh906, Lloh908
	.loh AdrpLdr	Lloh906, Lloh907
	.loh AdrpAdrp	Lloh904, Lloh906
	.loh AdrpLdr	Lloh904, Lloh905
	.loh AdrpAdrp	Lloh902, Lloh904
	.loh AdrpLdr	Lloh902, Lloh903
	.loh AdrpAdrp	Lloh900, Lloh902
	.loh AdrpLdr	Lloh900, Lloh901
	.loh AdrpAdrp	Lloh898, Lloh900
	.loh AdrpLdr	Lloh898, Lloh899
	.loh AdrpAdrp	Lloh896, Lloh898
	.loh AdrpLdr	Lloh896, Lloh897
	.loh AdrpAdrp	Lloh894, Lloh896
	.loh AdrpLdr	Lloh894, Lloh895
	.loh AdrpAdrp	Lloh892, Lloh894
	.loh AdrpLdr	Lloh892, Lloh893
	.loh AdrpAdrp	Lloh890, Lloh892
	.loh AdrpLdr	Lloh890, Lloh891
	.loh AdrpAdrp	Lloh888, Lloh890
	.loh AdrpLdr	Lloh888, Lloh889
	.loh AdrpAdrp	Lloh886, Lloh888
	.loh AdrpLdr	Lloh886, Lloh887
	.loh AdrpLdr	Lloh1002, Lloh1003
	.loh AdrpAdrp	Lloh1000, Lloh1002
	.loh AdrpLdr	Lloh1000, Lloh1001
	.loh AdrpAdrp	Lloh998, Lloh1000
	.loh AdrpLdr	Lloh998, Lloh999
	.loh AdrpAdrp	Lloh996, Lloh998
	.loh AdrpLdr	Lloh996, Lloh997
	.loh AdrpAdrp	Lloh994, Lloh996
	.loh AdrpLdr	Lloh994, Lloh995
	.loh AdrpAdrp	Lloh992, Lloh994
	.loh AdrpLdr	Lloh992, Lloh993
	.loh AdrpAdrp	Lloh990, Lloh992
	.loh AdrpLdr	Lloh990, Lloh991
	.loh AdrpAdrp	Lloh988, Lloh990
	.loh AdrpLdr	Lloh988, Lloh989
	.loh AdrpAdrp	Lloh986, Lloh988
	.loh AdrpLdr	Lloh986, Lloh987
	.loh AdrpAdrp	Lloh984, Lloh986
	.loh AdrpLdr	Lloh984, Lloh985
	.loh AdrpAdrp	Lloh982, Lloh984
	.loh AdrpLdr	Lloh982, Lloh983
	.loh AdrpAdrp	Lloh980, Lloh982
	.loh AdrpLdr	Lloh980, Lloh981
	.loh AdrpAdrp	Lloh978, Lloh980
	.loh AdrpLdr	Lloh978, Lloh979
	.loh AdrpAdrp	Lloh976, Lloh978
	.loh AdrpLdr	Lloh976, Lloh977
	.loh AdrpAdrp	Lloh974, Lloh976
	.loh AdrpLdr	Lloh974, Lloh975
	.loh AdrpAdrp	Lloh972, Lloh974
	.loh AdrpLdr	Lloh972, Lloh973
	.loh AdrpAdrp	Lloh970, Lloh972
	.loh AdrpLdr	Lloh970, Lloh971
	.loh AdrpAdrp	Lloh968, Lloh970
	.loh AdrpLdr	Lloh968, Lloh969
	.loh AdrpAdrp	Lloh966, Lloh968
	.loh AdrpLdr	Lloh966, Lloh967
	.loh AdrpAdrp	Lloh964, Lloh966
	.loh AdrpLdr	Lloh964, Lloh965
	.loh AdrpAdrp	Lloh962, Lloh964
	.loh AdrpLdr	Lloh962, Lloh963
	.loh AdrpAdrp	Lloh960, Lloh962
	.loh AdrpLdr	Lloh960, Lloh961
	.loh AdrpAdrp	Lloh958, Lloh960
	.loh AdrpLdr	Lloh958, Lloh959
	.loh AdrpAdrp	Lloh956, Lloh958
	.loh AdrpLdr	Lloh956, Lloh957
	.loh AdrpAdrp	Lloh954, Lloh956
	.loh AdrpLdr	Lloh954, Lloh955
	.loh AdrpAdrp	Lloh952, Lloh954
	.loh AdrpLdr	Lloh952, Lloh953
	.loh AdrpAdrp	Lloh950, Lloh952
	.loh AdrpLdr	Lloh950, Lloh951
	.loh AdrpAdrp	Lloh948, Lloh950
	.loh AdrpLdr	Lloh948, Lloh949
	.loh AdrpAdrp	Lloh946, Lloh948
	.loh AdrpLdr	Lloh946, Lloh947
	.loh AdrpAdrp	Lloh944, Lloh946
	.loh AdrpLdr	Lloh944, Lloh945
	.loh AdrpAdrp	Lloh942, Lloh944
	.loh AdrpLdr	Lloh942, Lloh943
	.cfi_endproc
	.p2align	2
lJTI3_0:
	.long	LBB3_9-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_72-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_68-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_76-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_84-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_80-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_48-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_64-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_40-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_60-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_20-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_92-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_32-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_100-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_24-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_52-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_28-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_56-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_16-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_36-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_104-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_116-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_44-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_12-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_112-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_88-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_120-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_96-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_108-Ltmp0
	.long	LBB3_136-Ltmp0
	.long	LBB3_124-Ltmp0
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function $s10PrimeSwift0A5SieveC6primesSaySiGyF
lCPI4_0:
	.quad	1                               ; 0x1
	.quad	2                               ; 0x2
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	_$s10PrimeSwift0A5SieveC6primesSaySiGyF
	.globl	_$s10PrimeSwift0A5SieveC6primesSaySiGyF
	.p2align	2
_$s10PrimeSwift0A5SieveC6primesSaySiGyF: ; @"$s10PrimeSwift0A5SieveC6primesSaySiGyF"
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	ldr	x8, [x20, #16]
	cmp	x8, #2
	b.lt	LBB4_14
; %bb.1:
Lloh1004:
	adrp	x0, _$ss23_ContiguousArrayStorageCySiGMd@PAGE
Lloh1005:
	add	x0, x0, _$ss23_ContiguousArrayStorageCySiGMd@PAGEOFF
Lloh1006:
	adrp	x1, _$ss23_ContiguousArrayStorageCySiGMR@PAGE
Lloh1007:
	add	x1, x1, _$ss23_ContiguousArrayStorageCySiGMR@PAGEOFF
	bl	___swift_instantiateConcreteTypeFromMangledNameV2
	mov	w1, #40                         ; =0x28
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
Lloh1008:
	adrp	x8, lCPI4_0@PAGE
Lloh1009:
	ldr	q0, [x8, lCPI4_0@PAGEOFF]
	str	q0, [x0, #16]
	mov	w8, #2                          ; =0x2
	str	x8, [x0, #32]
	ldr	x21, [x20, #32]
	tbnz	x21, #63, LBB4_19
; %bb.2:
	mov	x3, x0
	cbz	x21, LBB4_15
; %bb.3:
	mov	x22, #0                         ; =0x0
	ldr	x23, [x20, #40]
	sub	x24, x21, #1
	mov	w10, #-1                        ; =0xffffffff
	mov	x11, #-1152921504606846976      ; =0xf000000000000000
	mov	x12, #4611686018427387904       ; =0x4000000000000000
	b	LBB4_5
LBB4_4:                                 ;   in Loop: Header=BB4_5 Depth=1
	add	x22, x22, #1
	cmp	x22, x21
	b.eq	LBB4_15
LBB4_5:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_10 Depth 2
	ldrb	w8, [x23, x22]
	mvn	w28, w8
	cmp	x22, x24
	b.ne	LBB4_7
; %bb.6:                                ;   in Loop: Header=BB4_5 Depth=1
	ldr	x9, [x20, #24]
	ands	x9, x9, #0x7
	lsl	w9, w10, w9
	bic	w9, w28, w9
	csinv	w28, w9, w8, ne
LBB4_7:                                 ;   in Loop: Header=BB4_5 Depth=1
	tst	w28, #0xff
	b.eq	LBB4_4
; %bb.8:                                ;   in Loop: Header=BB4_5 Depth=1
	add	x8, x22, x11
	lsr	x8, x8, #61
	cmp	x8, #7
	b.lo	LBB4_17
; %bb.9:                                ;   in Loop: Header=BB4_5 Depth=1
	lsl	x25, x22, #3
	cmn	x25, x12
	b.mi	LBB4_18
LBB4_10:                                ;   Parent Loop BB4_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	rbit	w8, w28
	clz	w8, w8
	orr	x8, x25, x8
	lsl	x8, x8, #1
	adds	x26, x8, #3
	b.vs	LBB4_16
; %bb.11:                               ;   in Loop: Header=BB4_10 Depth=2
	ldp	x27, x8, [x3, #16]
	add	x19, x27, #1
	cmp	x27, x8, lsr #1
	b.hs	LBB4_13
LBB4_12:                                ;   in Loop: Header=BB4_10 Depth=2
	str	x19, [x3, #16]
	add	x8, x3, x27, lsl #3
	str	x26, [x8, #32]
	sub	w8, w28, #1
	and	w28, w8, w28
	tst	w28, #0xff
	b.ne	LBB4_10
	b	LBB4_4
LBB4_13:                                ;   in Loop: Header=BB4_10 Depth=2
	cmp	x8, #1
	cset	w0, hi
	mov	x1, x19
	mov	w2, #1                          ; =0x1
	bl	_$ss12_ArrayBufferV20_consumeAndCreateNew14bufferIsUnique15minimumCapacity13growForAppendAByxGSb_SiSbtFSi_Tg5
	mov	x12, #4611686018427387904       ; =0x4000000000000000
	mov	x11, #-1152921504606846976      ; =0xf000000000000000
	mov	w10, #-1                        ; =0xffffffff
	mov	x3, x0
	b	LBB4_12
LBB4_14:
Lloh1010:
	adrp	x3, __swiftEmptyArrayStorage@GOTPAGE
Lloh1011:
	ldr	x3, [x3, __swiftEmptyArrayStorage@GOTPAGEOFF]
LBB4_15:
	mov	x0, x3
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB4_16:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB4_17:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB4_18:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB4_19:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.loh AdrpLdr	Lloh1008, Lloh1009
	.loh AdrpAdd	Lloh1006, Lloh1007
	.loh AdrpAdd	Lloh1004, Lloh1005
	.loh AdrpLdrGot	Lloh1010, Lloh1011
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10PrimeSwift13completedPass5limit6offsets6UInt64VSi_SitF ; -- Begin function $s10PrimeSwift13completedPass5limit6offsets6UInt64VSi_SitF
	.globl	_$s10PrimeSwift13completedPass5limit6offsets6UInt64VSi_SitF
	.p2align	2
_$s10PrimeSwift13completedPass5limit6offsets6UInt64VSi_SitF: ; @"$s10PrimeSwift13completedPass5limit6offsets6UInt64VSi_SitF"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x1
	mov	x21, x0
	bl	_$s10PrimeSwift0A5SieveCMa
	mov	x1, sp
	bl	_swift_initStackObject
	mov	x20, x0
	mov	x0, x21
	bl	_$s10PrimeSwift0A5SieveC5limitACSi_tcfc
	bl	_$s10PrimeSwift0A5SieveC03runC0yyF
	ldr	x8, [x20, #32]
	cbz	x8, LBB5_2
; %bb.1:
	ldr	x0, [x20, #40]
	b	LBB5_3
LBB5_2:
	mov	x0, #0                          ; =0x0
LBB5_3:
	mov	x1, x19
	bl	_$s17BenchmarkObserver7observe_2ats6UInt64VSVSg_SitF
	mov	x19, x0
	mov	x0, x20
	bl	_swift_release
	mov	x0, x19
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufCSS8UTF8ViewV_Tt0g5 ; -- Begin function $s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufCSS8UTF8ViewV_Tt0g5
	.globl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufCSS8UTF8ViewV_Tt0g5
	.weak_def_can_be_hidden	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufCSS8UTF8ViewV_Tt0g5
	.p2align	2
_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufCSS8UTF8ViewV_Tt0g5: ; @"$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufCSS8UTF8ViewV_Tt0g5"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #288
	stp	x28, x27, [sp, #192]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #208]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #224]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #240]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #256]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #272]            ; 16-byte Folded Spill
	add	x29, sp, #272
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	mov	x19, x1
	mov	x20, x0
	mov	x21, #0                         ; =0x0
Lloh1012:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh1013:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh1014:
	ldr	x8, [x8]
	stur	x8, [x29, #-96]
	stp	x0, x1, [sp, #64]
	stp	x0, x1, [sp, #48]
	mov	x0, x1
	bl	_swift_bridgeObjectRetain
Lloh1015:
	adrp	x0, _$s10Foundation15ContiguousBytes_pMd@PAGE
Lloh1016:
	add	x0, x0, _$s10Foundation15ContiguousBytes_pMd@PAGEOFF
Lloh1017:
	adrp	x1, _$s10Foundation15ContiguousBytes_pMR@PAGE
Lloh1018:
	add	x1, x1, _$s10Foundation15ContiguousBytes_pMR@PAGEOFF
	bl	___swift_instantiateConcreteTypeFromMangledNameV2
	mov	x3, x0
Lloh1019:
	adrp	x2, _$sSS8UTF8ViewVN@GOTPAGE
Lloh1020:
	ldr	x2, [x2, _$sSS8UTF8ViewVN@GOTPAGEOFF]
	add	x0, sp, #80
	add	x1, sp, #48
	mov	w4, #6                          ; =0x6
	bl	_swift_dynamicCast
	cbz	w0, LBB6_2
; %bb.1:
	add	x0, sp, #80
	add	x1, sp, #128
	bl	_$s10Foundation15ContiguousBytes_pWOb
	ldp	x22, x23, [sp, #152]
	add	x0, sp, #128
	mov	x1, x22
	bl	___swift_project_boxed_opaque_existential_1
	mov	x20, x0
Lloh1021:
	adrp	x0, _$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_@PAGE
Lloh1022:
	add	x0, x0, _$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_@PAGEOFF
Lloh1023:
	adrp	x2, _$s10Foundation4DataV15_RepresentationON@GOTPAGE
Lloh1024:
	ldr	x2, [x2, _$s10Foundation4DataV15_RepresentationON@GOTPAGEOFF]
	add	x8, sp, #80
	mov	x1, #0                          ; =0x0
	mov	x21, #0                         ; =0x0
	mov	x3, x22
	mov	x4, x23
	bl	_$s10Foundation15ContiguousBytesP010withUnsafeC0yqd__qd__SWKXEKlFTj
	add	x0, sp, #128
	bl	___swift_destroy_boxed_opaque_existential_1
	b	LBB6_54
LBB6_2:
	str	xzr, [sp, #112]
	movi.2d	v0, #0000000000000000
	stp	q0, q0, [sp, #80]
	add	x0, sp, #80
	bl	_$s10Foundation15ContiguousBytes_pSgWOh
	tbnz	x19, #60, LBB6_59
; %bb.3:
	tbnz	x19, #61, LBB6_7
; %bb.4:
	tbz	x20, #60, LBB6_60
; %bb.5:
	and	x8, x19, #0xfffffffffffffff
	add	x0, x8, #32
	and	x1, x20, #0xffffffffffff
LBB6_6:
	add	x8, x1, x0
	cmp	x0, #0
	csel	x1, xzr, x8, eq
	bl	_$s10Foundation4DataV15_RepresentationOyAESWcfCTf4nd_n
	mov	x22, x0
	mov	x23, x1
	b	LBB6_9
LBB6_7:
	ubfx	x1, x19, #56, #4
	and	x8, x19, #0xffffffffffffff
	stp	x20, x8, [sp, #80]
	add	x8, sp, #128
	add	x0, sp, #80
	mov	x21, #0                         ; =0x0
	bl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSRyAEGXEfU0_
	cbnz	x21, LBB6_65
; %bb.8:
	ldp	x22, x23, [sp, #128]
LBB6_9:
	lsr	x8, x23, #60
	cmp	x8, #14
	b.ls	LBB6_14
; %bb.10:
	and	x8, x20, #0xffffffffffff
	ubfx	x9, x19, #56, #4
	tst	x19, #0x2000000000000000
	csel	x0, x8, x9, eq
LBB6_11:
	bl	_$s10Foundation4DataV15_RepresentationO5countAESi_tcfCTf4nd_n
	stp	x0, x1, [sp, #80]
	add	x8, sp, #64
	str	x8, [sp, #144]
Lloh1025:
	adrp	x0, _$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5TA@PAGE
Lloh1026:
	add	x0, x0, _$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5TA@PAGEOFF
	add	x1, sp, #128
	add	x20, sp, #80
	bl	_$s10Foundation4DataV15_RepresentationO22withUnsafeMutableBytesyxxSwKXEKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	mov	x24, x0
	mov	x21, x1
	mov	x25, x2
	ldp	x8, x9, [sp, #80]
	lsr	x10, x9, #62
	cmp	w10, #1
	b.gt	LBB6_15
; %bb.12:
	cbnz	w10, LBB6_18
; %bb.13:
	ubfx	x11, x9, #48, #8
	cmp	x3, x11
	b.ne	LBB6_20
	b	LBB6_25
LBB6_14:
	stp	x22, x23, [sp, #80]
	b	LBB6_54
LBB6_15:
	cmp	w10, #2
	b.ne	LBB6_23
; %bb.16:
	ldp	x12, x11, [x8, #16]
	subs	x11, x11, x12
	b.vs	LBB6_62
; %bb.17:
	cmp	x3, x11
	b.ne	LBB6_20
	b	LBB6_25
LBB6_18:
	lsr	x11, x8, #32
	subs	w11, w11, w8
	b.vs	LBB6_63
; %bb.19:
	sxtw	x11, w11
	cmp	x3, x11
	b.eq	LBB6_25
LBB6_20:
	cmp	w10, #2
	b.eq	LBB6_49
; %bb.21:
	cmp	w10, #1
	b.ne	LBB6_50
; %bb.22:
	asr	x1, x8, #32
	b	LBB6_51
LBB6_23:
	cbz	x3, LBB6_25
; %bb.24:
	mov	x1, #0                          ; =0x0
	b	LBB6_51
LBB6_25:
	str	x23, [sp, #16]                  ; 8-byte Folded Spill
	and	x8, x24, #0xffffffffffff
	ubfx	x9, x21, #56, #4
	tst	x21, #0x2000000000000000
	csel	x26, x8, x9, eq
	lsl	x27, x26, #2
	stur	xzr, [sp, #54]
	str	xzr, [sp, #48]
	cmp	x27, x25, lsr #14
	b.eq	LBB6_48
; %bb.26:
	str	x22, [sp, #8]                   ; 8-byte Folded Spill
	mov	w28, #0                         ; =0x0
	tst	x21, #0x1000000000000000
	ubfx	x8, x24, #59, #1
	csinc	w8, w8, wzr, ne
	mov	w9, #4                          ; =0x4
	lsl	x22, x9, x8
	and	x9, x21, #0xffffffffffffff
	and	x8, x21, #0xfffffffffffffff
	add	x8, x8, #32
	stp	x8, x9, [sp, #24]               ; 16-byte Folded Spill
	b	LBB6_28
LBB6_27:                                ;   in Loop: Header=BB6_28 Depth=1
	cmp	x27, x25, lsr #14
	b.eq	LBB6_46
LBB6_28:                                ; =>This Inner Loop Header: Depth=1
	and	x23, x25, #0xc
	mov	x0, x25
	cmp	x23, x22
	b.eq	LBB6_37
LBB6_29:                                ;   in Loop: Header=BB6_28 Depth=1
	lsr	x20, x0, #16
	cmp	x20, x26
	b.hs	LBB6_56
; %bb.30:                               ;   in Loop: Header=BB6_28 Depth=1
	tbnz	x21, #60, LBB6_38
; %bb.31:                               ;   in Loop: Header=BB6_28 Depth=1
	tbnz	x21, #61, LBB6_34
; %bb.32:                               ;   in Loop: Header=BB6_28 Depth=1
	ldr	x0, [sp, #24]                   ; 8-byte Folded Reload
	tbz	x24, #60, LBB6_45
LBB6_33:                                ;   in Loop: Header=BB6_28 Depth=1
	ldrb	w20, [x0, x20]
	cmp	x23, x22
	b.ne	LBB6_35
	b	LBB6_39
LBB6_34:                                ;   in Loop: Header=BB6_28 Depth=1
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	stp	x24, x8, [sp, #128]
	add	x8, sp, #128
	ldrb	w20, [x8, x20]
	cmp	x23, x22
	b.eq	LBB6_39
LBB6_35:                                ;   in Loop: Header=BB6_28 Depth=1
	tbnz	x21, #60, LBB6_40
LBB6_36:                                ;   in Loop: Header=BB6_28 Depth=1
	and	x8, x25, #0xffffffffffff0000
	mov	w9, #4                          ; =0x4
	movk	w9, #1, lsl #16
	add	x25, x8, x9
	b	LBB6_42
LBB6_37:                                ;   in Loop: Header=BB6_28 Depth=1
	mov	x0, x25
	mov	x1, x24
	mov	x2, x21
	bl	_$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF
	b	LBB6_29
LBB6_38:                                ;   in Loop: Header=BB6_28 Depth=1
	mov	x1, x24
	mov	x2, x21
	bl	_$sSS8UTF8ViewV17_foreignSubscript8positions5UInt8VSS5IndexV_tF
	mov	x20, x0
	cmp	x23, x22
	b.ne	LBB6_35
LBB6_39:                                ;   in Loop: Header=BB6_28 Depth=1
	mov	x0, x25
	mov	x1, x24
	mov	x2, x21
	bl	_$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF
	mov	x25, x0
	tbz	x21, #60, LBB6_36
LBB6_40:                                ;   in Loop: Header=BB6_28 Depth=1
	cmp	x26, x25, lsr #16
	b.ls	LBB6_58
; %bb.41:                               ;   in Loop: Header=BB6_28 Depth=1
	mov	x0, x25
	mov	x1, x24
	mov	x2, x21
	bl	_$sSS8UTF8ViewV13_foreignIndex5afterSS0D0VAF_tF
	mov	x25, x0
LBB6_42:                                ;   in Loop: Header=BB6_28 Depth=1
	and	x8, x28, #0xff
	and	w9, w28, #0xff
	add	x10, sp, #48
	strb	w20, [x10, x8]
	add	w28, w9, #1
	lsr	w8, w28, #8
	tbnz	w8, #0, LBB6_57
; %bb.43:                               ;   in Loop: Header=BB6_28 Depth=1
	and	w8, w28, #0xff
	cmp	w8, #14
	b.ne	LBB6_27
; %bb.44:                               ;   in Loop: Header=BB6_28 Depth=1
	ldr	x8, [sp, #48]
	str	x8, [sp, #128]
	ldur	x8, [sp, #54]
	stur	x8, [sp, #134]
	add	x0, sp, #128
	add	x8, sp, #128
	add	x1, x8, #14
	add	x20, sp, #80
	bl	_$s10Foundation4DataV15_RepresentationO6append10contentsOfySW_tF
	mov	w28, #0                         ; =0x0
	b	LBB6_27
LBB6_45:                                ;   in Loop: Header=BB6_28 Depth=1
	mov	x0, x24
	mov	x1, x21
	bl	_$ss13_StringObjectV10sharedUTF8SRys5UInt8VGvg
	b	LBB6_33
LBB6_46:
	tst	w28, #0xff
	ldr	x22, [sp, #8]                   ; 8-byte Folded Reload
	b.eq	LBB6_48
; %bb.47:
	ldr	x8, [sp, #48]
	str	x8, [sp, #128]
	ldur	x8, [sp, #54]
	stur	x8, [sp, #134]
	add	x8, sp, #128
	add	x1, x8, w28, uxtb
	add	x0, sp, #128
	add	x20, sp, #80
	bl	_$s10Foundation4DataV15_RepresentationO6append10contentsOfySW_tF
	mov	x0, x22
	ldr	x1, [sp, #16]                   ; 8-byte Folded Reload
	bl	_$s10Foundation4DataV15_RepresentationOSgWOe
	b	LBB6_53
LBB6_48:
	mov	x0, x21
	bl	_swift_bridgeObjectRelease
	mov	x0, x22
	ldr	x1, [sp, #16]                   ; 8-byte Folded Reload
	bl	_$s10Foundation4DataV15_RepresentationOSgWOe
	b	LBB6_54
LBB6_49:
	ldr	x1, [x8, #24]
	b	LBB6_51
LBB6_50:
	ubfx	x1, x9, #48, #8
LBB6_51:
	cmp	x1, x3
	b.lt	LBB6_61
; %bb.52:
	add	x20, sp, #80
	mov	x0, x3
	mov	x2, #0                          ; =0x0
	mov	x3, #0                          ; =0x0
	bl	_$s10Foundation4DataV15_RepresentationO15replaceSubrange_4with5countySnySiG_SVSgSitF
LBB6_53:
	mov	x0, x21
	bl	_swift_bridgeObjectRelease
LBB6_54:
	ldp	x20, x21, [sp, #80]
	mov	x0, x20
	mov	x1, x21
	bl	_$s10Foundation4DataV15_RepresentationOWOy
	mov	x0, x19
	bl	_swift_bridgeObjectRelease
	ldp	x0, x1, [sp, #80]
	bl	_$s10Foundation4DataV15_RepresentationOWOe
	ldur	x8, [x29, #-96]
Lloh1027:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh1028:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh1029:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB6_64
; %bb.55:
	mov	x0, x20
	mov	x1, x21
	ldp	x29, x30, [sp, #272]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #256]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #240]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #224]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #208]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #192]            ; 16-byte Folded Reload
	add	sp, sp, #288
	ret
LBB6_56:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB6_57:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB6_58:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB6_59:
	mov	x0, x20
	mov	x1, x19
	bl	_$sSS8UTF8ViewV13_foreignCountSiyF
	mov	x22, #0                         ; =0x0
	mov	x23, #-1152921504606846976      ; =0xf000000000000000
	b	LBB6_11
LBB6_60:
	mov	x0, x20
	mov	x1, x19
	bl	_$ss13_StringObjectV10sharedUTF8SRys5UInt8VGvg
	b	LBB6_6
LBB6_61:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB6_62:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB6_63:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB6_64:
	bl	___stack_chk_fail
LBB6_65:
	mov	x0, x21
	bl	_swift_errorRelease
	brk	#0x1
	.loh AdrpLdrGot	Lloh1019, Lloh1020
	.loh AdrpAdd	Lloh1017, Lloh1018
	.loh AdrpAdd	Lloh1015, Lloh1016
	.loh AdrpLdrGotLdr	Lloh1012, Lloh1013, Lloh1014
	.loh AdrpLdrGot	Lloh1023, Lloh1024
	.loh AdrpAdd	Lloh1021, Lloh1022
	.loh AdrpAdd	Lloh1025, Lloh1026
	.loh AdrpLdrGotLdr	Lloh1027, Lloh1028, Lloh1029
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_$s10PrimeSwift9BenchmarkV4mainyyFZTf4d_n
	mov	w0, #0                          ; =0x0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$ss12_ArrayBufferV20_consumeAndCreateNew14bufferIsUnique15minimumCapacity13growForAppendAByxGSb_SiSbtFSi_Tg5 ; -- Begin function $ss12_ArrayBufferV20_consumeAndCreateNew14bufferIsUnique15minimumCapacity13growForAppendAByxGSb_SiSbtFSi_Tg5
	.globl	_$ss12_ArrayBufferV20_consumeAndCreateNew14bufferIsUnique15minimumCapacity13growForAppendAByxGSb_SiSbtFSi_Tg5
	.weak_def_can_be_hidden	_$ss12_ArrayBufferV20_consumeAndCreateNew14bufferIsUnique15minimumCapacity13growForAppendAByxGSb_SiSbtFSi_Tg5
	.p2align	2
_$ss12_ArrayBufferV20_consumeAndCreateNew14bufferIsUnique15minimumCapacity13growForAppendAByxGSb_SiSbtFSi_Tg5: ; @"$ss12_ArrayBufferV20_consumeAndCreateNew14bufferIsUnique15minimumCapacity13growForAppendAByxGSb_SiSbtFSi_Tg5"
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x3
	mov	x20, x0
	tbz	w2, #0, LBB8_4
; %bb.1:
	ldr	x9, [x19, #24]
	lsr	x8, x9, #1
	cmp	x8, x1
	b.ge	LBB8_5
; %bb.2:
	mov	x10, #4611686018427387904       ; =0x4000000000000000
	cmn	x8, x10
	b.mi	LBB8_14
; %bb.3:
	and	x8, x9, #0xfffffffffffffffe
	cmp	x8, x1
	csel	x8, x8, x1, gt
	b	LBB8_5
LBB8_4:
	mov	x8, x1
LBB8_5:
	ldr	x22, [x19, #16]
	cmp	x8, x22
	csel	x21, x8, x22, gt
	cbz	x21, LBB8_7
; %bb.6:
Lloh1030:
	adrp	x0, _$ss23_ContiguousArrayStorageCySiGMd@PAGE
Lloh1031:
	add	x0, x0, _$ss23_ContiguousArrayStorageCySiGMd@PAGEOFF
Lloh1032:
	adrp	x1, _$ss23_ContiguousArrayStorageCySiGMR@PAGE
Lloh1033:
	add	x1, x1, _$ss23_ContiguousArrayStorageCySiGMR@PAGEOFF
	bl	___swift_instantiateConcreteTypeFromMangledNameV2
	lsl	x8, x21, #3
	add	x1, x8, #32
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
	mov	x21, x0
	bl	_malloc_size
	subs	x8, x0, #32
	sub	x9, x0, #25
	csel	x8, x9, x8, lt
	asr	x8, x8, #3
	lsl	x8, x8, #1
	stp	x22, x8, [x21, #16]
	b	LBB8_8
LBB8_7:
Lloh1034:
	adrp	x21, __swiftEmptyArrayStorage@GOTPAGE
Lloh1035:
	ldr	x21, [x21, __swiftEmptyArrayStorage@GOTPAGEOFF]
LBB8_8:
	add	x0, x21, #32
	add	x1, x19, #32
	tbz	w20, #0, LBB8_12
; %bb.9:
	add	x8, x1, x22, lsl #3
	cmp	x21, x19
	ccmp	x0, x8, #2, eq
	b.lo	LBB8_11
; %bb.10:
	lsl	x2, x22, #3
	bl	_memmove
LBB8_11:
	str	xzr, [x19, #16]
	b	LBB8_13
LBB8_12:
	lsl	x2, x22, #3
	bl	_memcpy
LBB8_13:
	mov	x0, x19
	bl	_swift_bridgeObjectRelease
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB8_14:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.loh AdrpAdd	Lloh1032, Lloh1033
	.loh AdrpAdd	Lloh1030, Lloh1031
	.loh AdrpLdrGot	Lloh1034, Lloh1035
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSRyAEGXEfU0_ ; -- Begin function $s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSRyAEGXEfU0_
	.globl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSRyAEGXEfU0_
	.weak_def_can_be_hidden	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSRyAEGXEfU0_
	.p2align	2
_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSRyAEGXEfU0_: ; @"$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSRyAEGXEfU0_"
	.cfi_startproc
; %bb.0:
	stp	x23, x22, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w22, -40
	.cfi_offset w23, -48
	mov	x19, x8
	cbz	x0, LBB9_5
; %bb.1:
	mov	x22, x1
	cbz	x1, LBB9_4
; %bb.2:
	mov	x23, x21
	cmp	x22, #15
	b.hs	LBB9_7
; %bb.3:
	add	x1, x22, x0
	bl	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	and	x8, x1, #0xffffffffffffff
	mov	x21, x23
	b	LBB9_6
LBB9_4:
	mov	x0, #0                          ; =0x0
LBB9_5:
	mov	x8, #-4611686018427387904       ; =0xc000000000000000
LBB9_6:
	stp	x0, x8, [x19]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x23, x22, [sp], #48             ; 16-byte Folded Reload
	ret
LBB9_7:
	mov	x20, x0
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation13__DataStorageCMa
	ldr	w1, [x0, #48]
	ldrh	w2, [x0, #52]
	bl	_swift_allocObject
	mov	x2, x0
	mov	x0, x20
	mov	x1, x22
	mov	x20, x2
	bl	_$s10Foundation13__DataStorageC5bytes6lengthACSVSg_Sitcfc
	mov	x20, x0
	mov	w8, #2147483646                 ; =0x7ffffffe
	cmp	x22, x8
	b.hi	LBB9_9
; %bb.8:
	lsl	x0, x22, #32
	orr	x8, x20, #0x4000000000000000
	mov	x21, x23
	b	LBB9_6
LBB9_9:
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation4DataV14RangeReferenceCMa
	mov	w1, #32                         ; =0x20
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
	stp	xzr, x22, [x0, #16]
	orr	x8, x20, #0x8000000000000000
	mov	x21, x23
	b	LBB9_6
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function $s10Foundation4DataV15_RepresentationO22withUnsafeMutableBytesyxxSwKXEKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
lCPI10_0:
	.quad	0                               ; 0x0
	.quad	-4611686018427387904            ; 0xc000000000000000
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	_$s10Foundation4DataV15_RepresentationO22withUnsafeMutableBytesyxxSwKXEKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	.globl	_$s10Foundation4DataV15_RepresentationO22withUnsafeMutableBytesyxxSwKXEKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	.weak_def_can_be_hidden	_$s10Foundation4DataV15_RepresentationO22withUnsafeMutableBytesyxxSwKXEKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	.p2align	2
_$s10Foundation4DataV15_RepresentationO22withUnsafeMutableBytesyxxSwKXEKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5: ; @"$s10Foundation4DataV15_RepresentationO22withUnsafeMutableBytesyxxSwKXEKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #240
	str	x28, [sp, #144]                 ; 8-byte Folded Spill
	stp	x27, x26, [sp, #160]            ; 16-byte Folded Spill
	stp	x25, x24, [sp, #176]            ; 16-byte Folded Spill
	stp	x23, x22, [sp, #192]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #208]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #224]            ; 16-byte Folded Spill
	add	x29, sp, #224
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w22, -40
	.cfi_offset w23, -48
	.cfi_offset w24, -56
	.cfi_offset w25, -64
	.cfi_offset w26, -72
	.cfi_offset w27, -80
	.cfi_offset w28, -96
	mov	x23, x21
	mov	x19, x20
	mov	x26, x1
	mov	x24, x0
Lloh1036:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh1037:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh1038:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	ldp	x25, x20, [x20]
	lsr	x8, x20, #62
	cmp	w8, #1
	b.gt	LBB10_4
; %bb.1:
	str	x26, [sp, #80]                  ; 8-byte Folded Spill
	cbnz	w8, LBB10_7
; %bb.2:
	lsr	x22, x25, #8
	lsr	x26, x25, #16
	lsr	x27, x25, #24
	lsr	x28, x25, #32
	stp	x24, x23, [sp, #64]             ; 16-byte Folded Spill
	lsr	x23, x25, #40
	lsr	x9, x25, #48
	lsr	x8, x25, #56
	stp	x9, x8, [sp, #8]                ; 16-byte Folded Spill
	lsr	x9, x20, #8
	lsr	x8, x20, #16
	stp	x9, x8, [sp, #24]               ; 16-byte Folded Spill
	lsr	x9, x20, #24
	lsr	x8, x20, #32
	str	x8, [sp, #56]                   ; 8-byte Folded Spill
	lsr	x8, x20, #40
	stp	x9, x8, [sp, #40]               ; 16-byte Folded Spill
	lsr	x24, x20, #48
	mov	x0, x25
	mov	x1, x20
	bl	_$s10Foundation4DataV15_RepresentationOWOe
	sturb	w25, [x29, #-104]
	sturb	w22, [x29, #-103]
	sturb	w26, [x29, #-102]
	sturb	w27, [x29, #-101]
	sturb	w28, [x29, #-100]
	sturb	w23, [x29, #-99]
	ldp	x9, x8, [sp, #8]                ; 16-byte Folded Reload
	sturb	w9, [x29, #-98]
	sturb	w8, [x29, #-97]
	sturb	w20, [x29, #-96]
	ldp	x10, x8, [sp, #24]              ; 16-byte Folded Reload
	sturb	w10, [x29, #-95]
	sturb	w8, [x29, #-94]
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	sturb	w8, [x29, #-93]
	sub	x8, x29, #104
	ldp	x9, x11, [sp, #48]              ; 16-byte Folded Reload
	sturb	w11, [x29, #-92]
	sturb	w9, [x29, #-91]
	add	x1, x8, w24, uxtb
	sturb	w24, [x29, #-90]
	add	x8, sp, #88
	sub	x0, x29, #104
	ldp	x21, x20, [sp, #72]             ; 16-byte Folded Reload
	ldr	x9, [sp, #64]                   ; 8-byte Folded Reload
	blr	x9
	cbz	x21, LBB10_14
; %bb.3:
	ldur	x8, [x29, #-104]
	ldurb	w9, [x29, #-90]
	ldurh	w10, [x29, #-92]
	orr	w9, w10, w9, lsl #16
	ldur	w10, [x29, #-96]
	orr	x9, x10, x9, lsl #32
	stp	x8, x9, [x19]
	b	LBB10_22
LBB10_4:
	cmp	w8, #2
	b.ne	LBB10_12
; %bb.5:
	and	x22, x20, #0x3fffffffffffffff
	mov	x0, x25
	bl	_swift_retain
	mov	x0, x22
	bl	_swift_retain
	mov	x0, x25
	mov	x1, x20
	bl	_$s10Foundation4DataV15_RepresentationOWOe
	stp	x25, x22, [sp, #88]
Lloh1039:
	adrp	x8, lCPI10_0@PAGE
Lloh1040:
	ldr	q0, [x8, lCPI10_0@PAGEOFF]
	str	q0, [x19]
	mov	x0, #0                          ; =0x0
	mov	x1, #-4611686018427387904       ; =0xc000000000000000
	bl	_$s10Foundation4DataV15_RepresentationOWOe
	add	x20, sp, #88
	bl	_$s10Foundation4DataV10LargeSliceV21ensureUniqueReferenceyyF
	ldp	x22, x20, [sp, #88]
	ldp	x0, x1, [x22, #16]
	mov	x2, x24
	mov	x3, x26
	mov	x21, x23
	bl	_$s10Foundation13__DataStorageC22withUnsafeMutableBytes2in5applyxSnySiG_xSwKXEtKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	orr	x8, x20, #0x8000000000000000
	cbz	x21, LBB10_15
; %bb.6:
	str	x22, [x19]
	b	LBB10_21
LBB10_7:
	and	x26, x20, #0x3fffffffffffffff
	mov	x0, x26
	bl	_swift_retain
	mov	x0, x25
	mov	x1, x20
	bl	_$s10Foundation4DataV15_RepresentationOWOe
Lloh1041:
	adrp	x8, lCPI10_0@PAGE
Lloh1042:
	ldr	q0, [x8, lCPI10_0@PAGEOFF]
	str	q0, [x19]
	mov	x0, #0                          ; =0x0
	mov	x1, #-4611686018427387904       ; =0xc000000000000000
	bl	_$s10Foundation4DataV15_RepresentationOWOe
	mov	x0, x26
	bl	_swift_isUniquelyReferenced_nonNull_native
	sxtw	x27, w25
	asr	x28, x25, #32
	tbnz	w0, #0, LBB10_18
; %bb.8:
	subs	x8, x28, x27
	str	x8, [sp, #72]                   ; 8-byte Folded Spill
	b.lt	LBB10_27
; %bb.9:
	mov	x0, x26
	bl	_swift_retain
	mov	x20, x26
	bl	_$s10Foundation13__DataStorageC6_bytesSvSgvg
	cbz	x0, LBB10_16
; %bb.10:
	mov	x22, x0
	mov	x20, x26
	bl	_$s10Foundation13__DataStorageC7_offsetSivg
	subs	x8, x27, x0
	b.vs	LBB10_28
; %bb.11:
	add	x20, x8, x22
	b	LBB10_17
LBB10_12:
	stur	xzr, [x29, #-98]
	stur	xzr, [x29, #-104]
	add	x8, sp, #88
	sub	x0, x29, #104
	sub	x1, x29, #104
	mov	x20, x26
	mov	x21, x23
	blr	x24
	cbnz	x21, LBB10_22
; %bb.13:
	ldp	x0, x1, [sp, #88]
	ldp	x2, x3, [sp, #104]
	b	LBB10_23
LBB10_14:
	ldp	x0, x1, [sp, #88]
	ldp	x2, x3, [sp, #104]
	ldur	x8, [x29, #-104]
	ldurb	w9, [x29, #-90]
	ldurh	w10, [x29, #-92]
	orr	w9, w10, w9, lsl #16
	ldur	w10, [x29, #-96]
	orr	x9, x10, x9, lsl #32
	stp	x8, x9, [x19]
	b	LBB10_23
LBB10_15:
	stp	x22, x8, [x19]
	b	LBB10_23
LBB10_16:
	mov	x20, #0                         ; =0x0
LBB10_17:
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation13__DataStorageCMa
	ldr	w1, [x0, #48]
	ldrh	w2, [x0, #52]
	bl	_swift_allocObject
	mov	x6, x0
	mov	x0, x20
	ldr	x1, [sp, #72]                   ; 8-byte Folded Reload
	mov	w2, #1                          ; =0x1
	mov	x3, #0                          ; =0x0
	mov	x4, #0                          ; =0x0
	mov	x5, x27
	mov	x20, x6
	bl	_$s10Foundation13__DataStorageC5bytes6length4copy11deallocator6offsetACSvSg_SiSbySv_SitcSgSitcfc
	mov	x20, x0
	mov	x0, x26
	mov	w1, #2                          ; =0x2
	bl	_swift_release_n
	mov	x26, x20
LBB10_18:
	cmp	x28, x27
	b.lt	LBB10_26
; %bb.19:
	mov	x0, x26
	bl	_swift_retain
	mov	x0, x27
	mov	x1, x28
	mov	x2, x24
	ldr	x3, [sp, #80]                   ; 8-byte Folded Reload
	mov	x20, x26
	mov	x21, x23
	bl	_$s10Foundation13__DataStorageC22withUnsafeMutableBytes2in5applyxSnySiG_xSwKXEtKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	mov	x20, x0
	mov	x22, x1
	mov	x23, x2
	mov	x24, x3
	mov	x27, x21
	mov	x0, x26
	bl	_swift_release
	mov	x21, x27
	orr	x8, x26, #0x4000000000000000
	cbz	x27, LBB10_25
; %bb.20:
	str	x25, [x19]
LBB10_21:
	str	x8, [x19, #8]
LBB10_22:
                                        ; implicit-def: $x0
                                        ; implicit-def: $x1
                                        ; implicit-def: $x2
                                        ; implicit-def: $x3
LBB10_23:
	ldur	x8, [x29, #-88]
Lloh1043:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh1044:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh1045:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB10_29
; %bb.24:
	ldp	x29, x30, [sp, #224]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #208]            ; 16-byte Folded Reload
	ldp	x23, x22, [sp, #192]            ; 16-byte Folded Reload
	ldp	x25, x24, [sp, #176]            ; 16-byte Folded Reload
	ldp	x27, x26, [sp, #160]            ; 16-byte Folded Reload
	ldr	x28, [sp, #144]                 ; 8-byte Folded Reload
	add	sp, sp, #240
	ret
LBB10_25:
	stp	x25, x8, [x19]
	mov	x0, x20
	mov	x1, x22
	mov	x2, x23
	mov	x3, x24
	b	LBB10_23
LBB10_26:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB10_27:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB10_28:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB10_29:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh1036, Lloh1037, Lloh1038
	.loh AdrpLdr	Lloh1039, Lloh1040
	.loh AdrpLdr	Lloh1041, Lloh1042
	.loh AdrpLdrGotLdr	Lloh1043, Lloh1044, Lloh1045
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_ ; -- Begin function $s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_
	.globl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_
	.weak_definition	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_
	.p2align	2
_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_: ; @"$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_"
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB11_3
; %bb.1:
	subs	x9, x1, x0
	b.ne	LBB11_4
; %bb.2:
	mov	x0, #0                          ; =0x0
LBB11_3:
	mov	x9, #-4611686018427387904       ; =0xc000000000000000
	stp	x0, x9, [x8]
	ret
LBB11_4:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	cmp	x9, #15
	b.hs	LBB11_6
; %bb.5:
	mov	x19, x21
	mov	x20, x8
	bl	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	mov	x8, x20
	mov	x21, x19
	and	x9, x1, #0xffffffffffffff
	b	LBB11_10
LBB11_6:
	mov	x19, x8
	mov	x20, x21
	mov	w8, #2147483646                 ; =0x7ffffffe
	cmp	x9, x8
	b.hi	LBB11_8
; %bb.7:
	bl	_$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n
	orr	x9, x1, #0x4000000000000000
	b	LBB11_9
LBB11_8:
	bl	_$s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n
	orr	x9, x1, #0x8000000000000000
LBB11_9:
	mov	x21, x20
	mov	x8, x19
LBB11_10:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	stp	x0, x9, [x8]
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation13__DataStorageC22withUnsafeMutableBytes2in5applyxSnySiG_xSwKXEtKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5 ; -- Begin function $s10Foundation13__DataStorageC22withUnsafeMutableBytes2in5applyxSnySiG_xSwKXEtKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	.globl	_$s10Foundation13__DataStorageC22withUnsafeMutableBytes2in5applyxSnySiG_xSwKXEtKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	.weak_def_can_be_hidden	_$s10Foundation13__DataStorageC22withUnsafeMutableBytes2in5applyxSnySiG_xSwKXEtKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
	.p2align	2
_$s10Foundation13__DataStorageC22withUnsafeMutableBytes2in5applyxSnySiG_xSwKXEtKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5: ; @"$s10Foundation13__DataStorageC22withUnsafeMutableBytes2in5applyxSnySiG_xSwKXEtKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	stp	x27, x26, [sp, #32]             ; 16-byte Folded Spill
	stp	x25, x24, [sp, #48]             ; 16-byte Folded Spill
	stp	x23, x22, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w22, -40
	.cfi_offset w23, -48
	.cfi_offset w24, -56
	.cfi_offset w25, -64
	.cfi_offset w26, -72
	.cfi_offset w27, -80
	mov	x19, x21
	mov	x23, x3
	mov	x22, x2
	mov	x25, x1
	mov	x26, x0
	bl	_$s10Foundation13__DataStorageC6_bytesSvSgvg
	cbz	x0, LBB12_9
; %bb.1:
	mov	x24, x0
	bl	_$s10Foundation13__DataStorageC7_offsetSivg
	subs	x27, x26, x0
	b.vs	LBB12_7
; %bb.2:
	subs	x25, x25, x26
	b.vs	LBB12_8
; %bb.3:
	bl	_$s10Foundation13__DataStorageC7_lengthSivg
	cmp	x0, x25
	csel	x9, x0, x25, lt
	add	x0, x24, x27
	mov	x8, sp
	add	x1, x0, x9
	mov	x20, x23
	mov	x21, x19
	blr	x22
	cbz	x21, LBB12_5
; %bb.4:
                                        ; implicit-def: $x0
                                        ; implicit-def: $x1
                                        ; implicit-def: $x2
                                        ; implicit-def: $x3
	b	LBB12_6
LBB12_5:
	ldp	x0, x1, [sp]
	ldp	x2, x3, [sp, #16]
LBB12_6:
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x23, x22, [sp, #64]             ; 16-byte Folded Reload
	ldp	x25, x24, [sp, #48]             ; 16-byte Folded Reload
	ldp	x27, x26, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB12_7:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB12_8:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB12_9:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF ; -- Begin function $ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF
	.globl	_$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF
	.weak_def_can_be_hidden	_$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF
	.p2align	2
_$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF: ; @"$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF"
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x3, x2
	mov	x2, x1
	mov	x19, x0
	lsr	x1, x0, #16
	ubfx	x20, x0, #14, #2
	tbz	x3, #60, LBB13_3
; %bb.1:
	tbnz	x2, #59, LBB13_3
; %bb.2:
	mov	w0, #15                         ; =0xf
	bl	_$sSS8UTF8ViewV13_foreignIndex_8offsetBySS0D0VAF_SitF
	add	x8, x0, x20, lsl #16
	and	x8, x8, #0xffffffffffff0000
	bfxil	x0, x19, #0, #2
	cmp	x20, #0
	csel	x8, x8, x0, ne
	orr	x0, x8, #0x8
	b	LBB13_4
LBB13_3:
	mov	w0, #15                         ; =0xf
	bl	_$sSS9UTF16ViewV5index_8offsetBySS5IndexVAF_SitF
	add	x8, x0, x20, lsl #16
	and	x8, x8, #0xffffffffffff0000
	bfxil	x0, x19, #0, #2
	cmp	x20, #0
	csel	x8, x8, x0, ne
	orr	x0, x8, #0x4
LBB13_4:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5 ; -- Begin function $s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5
	.globl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5
	.weak_def_can_be_hidden	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5
	.p2align	2
_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5: ; @"$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5"
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	cbz	x0, LBB14_3
; %bb.1:
	mov	x19, x21
	mov	x20, x8
	ldp	x2, x3, [x2]
	sub	x1, x1, x0
	bl	_$ss11_StringGutsV8copyUTF84intoSiSgSrys5UInt8VG_tF
	and	w8, w1, #0xff
	cmp	w8, #1
	b.eq	LBB14_4
; %bb.2:
	mov	x8, #-2305843009213693952       ; =0xe000000000000000
	stp	xzr, x8, [x20]
	mov	w8, #15                         ; =0xf
	stp	x8, x0, [x20, #16]
	mov	x21, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB14_3:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB14_4:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n ; -- Begin function $s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	.globl	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	.weak_def_can_be_hidden	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	.p2align	2
_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n: ; @"$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh1046:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh1047:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh1048:
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	sub	x2, x1, x0
	cmp	x0, #0
	csel	x9, xzr, x2, eq
	tbnz	x9, #63, LBB15_8
; %bb.1:
	cmp	x9, #255
	b.hi	LBB15_9
; %bb.2:
	str	xzr, [sp, #8]
	lsl	x8, x9, #48
	strb	w9, [sp, #22]
	strh	wzr, [sp, #20]
	str	w8, [sp, #16]
	cbz	x0, LBB15_6
; %bb.3:
	cmp	x1, x0
	b.ne	LBB15_5
; %bb.4:
	mov	x0, #0                          ; =0x0
	b	LBB15_6
LBB15_5:
	mov	x1, x0
	add	x0, sp, #8
	bl	_memcpy
	ldr	x0, [sp, #8]
	ldrb	w8, [sp, #22]
	ldrh	w9, [sp, #20]
	orr	w8, w9, w8, lsl #16
	ldr	w9, [sp, #16]
	orr	x8, x9, x8, lsl #32
LBB15_6:
	ldur	x9, [x29, #-8]
Lloh1049:
	adrp	x10, ___stack_chk_guard@GOTPAGE
Lloh1050:
	ldr	x10, [x10, ___stack_chk_guard@GOTPAGEOFF]
Lloh1051:
	ldr	x10, [x10]
	cmp	x10, x9
	b.ne	LBB15_10
; %bb.7:
	and	x1, x8, #0xffffffffffffff
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB15_8:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB15_9:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB15_10:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh1046, Lloh1047, Lloh1048
	.loh AdrpLdrGotLdr	Lloh1049, Lloh1050, Lloh1051
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n ; -- Begin function $s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n
	.globl	_$s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n
	.weak_def_can_be_hidden	_$s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n
	.p2align	2
_$s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n: ; @"$s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n"
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x0
	sub	x8, x1, x0
	cmp	x0, #0
	csel	x21, xzr, x8, eq
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation13__DataStorageCMa
	ldr	w1, [x0, #48]
	ldrh	w2, [x0, #52]
	bl	_swift_allocObject
	mov	x20, x0
	mov	x0, x19
	mov	x1, x21
	bl	_$s10Foundation13__DataStorageC5bytes6lengthACSVSg_Sitcfc
	mov	x19, x0
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation4DataV14RangeReferenceCMa
	mov	w1, #32                         ; =0x20
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
	stp	xzr, x21, [x0, #16]
	mov	x1, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n ; -- Begin function $s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n
	.globl	_$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n
	.weak_def_can_be_hidden	_$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n
	.p2align	2
_$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n: ; @"$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n"
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x20, x0
	sub	x8, x1, x0
	cmp	x0, #0
	csel	x19, xzr, x8, eq
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation13__DataStorageCMa
	ldr	w1, [x0, #48]
	ldrh	w2, [x0, #52]
	bl	_swift_allocObject
	mov	x2, x0
	mov	x0, x20
	mov	x1, x19
	mov	x20, x2
	bl	_$s10Foundation13__DataStorageC5bytes6lengthACSVSg_Sitcfc
	lsr	x8, x19, #31
	cbnz	x8, LBB17_2
; %bb.1:
	mov	x1, x0
	lsl	x0, x19, #32
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB17_2:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataV15_RepresentationOyAESWcfCTf4nd_n ; -- Begin function $s10Foundation4DataV15_RepresentationOyAESWcfCTf4nd_n
	.globl	_$s10Foundation4DataV15_RepresentationOyAESWcfCTf4nd_n
	.weak_def_can_be_hidden	_$s10Foundation4DataV15_RepresentationOyAESWcfCTf4nd_n
	.p2align	2
_$s10Foundation4DataV15_RepresentationOyAESWcfCTf4nd_n: ; @"$s10Foundation4DataV15_RepresentationOyAESWcfCTf4nd_n"
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB18_3
; %bb.1:
	subs	x8, x1, x0
	b.ne	LBB18_4
; %bb.2:
	mov	x0, #0                          ; =0x0
LBB18_3:
	mov	x1, #-4611686018427387904       ; =0xc000000000000000
	ret
LBB18_4:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	cmp	x8, #15
	b.hs	LBB18_6
; %bb.5:
	bl	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	and	x1, x1, #0xffffffffffffff
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB18_6:
	mov	w9, #2147483647                 ; =0x7fffffff
	cmp	x8, x9
	b.hs	LBB18_8
; %bb.7:
	bl	_$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n
	orr	x1, x1, #0x4000000000000000
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB18_8:
	bl	_$s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n
	orr	x1, x1, #0x8000000000000000
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataV15_RepresentationO5countAESi_tcfCTf4nd_n ; -- Begin function $s10Foundation4DataV15_RepresentationO5countAESi_tcfCTf4nd_n
	.globl	_$s10Foundation4DataV15_RepresentationO5countAESi_tcfCTf4nd_n
	.weak_def_can_be_hidden	_$s10Foundation4DataV15_RepresentationO5countAESi_tcfCTf4nd_n
	.p2align	2
_$s10Foundation4DataV15_RepresentationO5countAESi_tcfCTf4nd_n: ; @"$s10Foundation4DataV15_RepresentationO5countAESi_tcfCTf4nd_n"
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	cbz	x0, LBB19_4
; %bb.1:
	mov	x19, x0
	cmp	x0, #15
	b.ge	LBB19_5
; %bb.2:
	tbnz	x19, #63, LBB19_9
; %bb.3:
	mov	x0, #0                          ; =0x0
	lsl	x1, x19, #48
	b	LBB19_8
LBB19_4:
	mov	x1, #-4611686018427387904       ; =0xc000000000000000
	b	LBB19_8
LBB19_5:
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation13__DataStorageCMa
	ldr	w1, [x0, #48]
	ldrh	w2, [x0, #52]
	bl	_swift_allocObject
	mov	x20, x0
	mov	x0, x19
	bl	_$s10Foundation13__DataStorageC6lengthACSi_tcfc
	mov	x20, x0
	mov	w8, #2147483647                 ; =0x7fffffff
	cmp	x19, x8
	b.hs	LBB19_7
; %bb.6:
	lsl	x0, x19, #32
	orr	x1, x20, #0x4000000000000000
	b	LBB19_8
LBB19_7:
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation4DataV14RangeReferenceCMa
	mov	w1, #32                         ; =0x20
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
	stp	xzr, x19, [x0, #16]
	orr	x1, x20, #0x8000000000000000
LBB19_8:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB19_9:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function $s10PrimeSwift9BenchmarkV4mainyyFZTf4d_n
lCPI20_0:
	.quad	1                               ; 0x1
	.quad	2                               ; 0x2
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	_$s10PrimeSwift9BenchmarkV4mainyyFZTf4d_n
	.globl	_$s10PrimeSwift9BenchmarkV4mainyyFZTf4d_n
	.weak_def_can_be_hidden	_$s10PrimeSwift9BenchmarkV4mainyyFZTf4d_n
	.p2align	2
_$s10PrimeSwift9BenchmarkV4mainyyFZTf4d_n: ; @"$s10PrimeSwift9BenchmarkV4mainyyFZTf4d_n"
	.cfi_startproc
; %bb.0:
	stp	d9, d8, [sp, #-112]!            ; 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	sub	sp, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	.cfi_offset b8, -104
	.cfi_offset b9, -112
	mov	x0, #0                          ; =0x0
	bl	_$s8Dispatch0A4TimeVMa
	mov	x21, x0
	ldur	x24, [x0, #-8]
	ldr	x8, [x24, #64]
	mov	x9, x8
Lloh1052:
	adrp	x16, ___chkstk_darwin@GOTPAGE
Lloh1053:
	ldr	x16, [x16, ___chkstk_darwin@GOTPAGEOFF]
	blr	x16
	mov	x9, sp
	add	x8, x8, #15
	and	x8, x8, #0xfffffffffffffff0
	sub	x22, x9, x8
	mov	sp, x22
	bl	_$s10PrimeSwift0A5SieveCMa
	sub	x1, x29, #144
	bl	_swift_initStackObject
	mov	x20, x0
	mov	w0, #16960                      ; =0x4240
	movk	w0, #15, lsl #16
	bl	_$s10PrimeSwift0A5SieveC5limitACSi_tcfc
	bl	_$s10PrimeSwift0A5SieveC03runC0yyF
	bl	_$s10PrimeSwift0A5SieveC6primesSaySiGyF
	ldr	x19, [x0, #16]
	bl	_swift_bridgeObjectRelease
	sub	x8, x19, #19, lsl #12           ; =77824
	cmp	x8, #674
	b.ne	LBB20_8
; %bb.1:
	stur	x20, [x29, #-176]               ; 8-byte Folded Spill
	mov	x8, x22
	bl	_$s8Dispatch0A4TimeV3nowACyFZ
	mov	x20, x22
	bl	_$s8Dispatch0A4TimeV17uptimeNanosecondss6UInt64Vvg
	mov	x23, x0
	ldr	x27, [x24, #8]
	mov	x0, x22
	mov	x1, x21
	blr	x27
	mov	x28, #0                         ; =0x0
	mov	x25, #0                         ; =0x0
	mov	x19, #61952                     ; =0xf200
	movk	x19, #10757, lsl #16
	movk	x19, #1, lsl #32
LBB20_2:                                ; =>This Inner Loop Header: Depth=1
	mov	x8, #13531                      ; =0x34db
	movk	x8, #55222, lsl #16
	movk	x8, #56962, lsl #32
	movk	x8, #17179, lsl #48
	umulh	x8, x28, x8
	lsr	x8, x8, #14
	mov	w9, #62500                      ; =0xf424
	msub	x1, x8, x9, x28
	mov	w0, #16960                      ; =0x4240
	movk	w0, #15, lsl #16
	bl	_$s10PrimeSwift13completedPass5limit6offsets6UInt64VSi_SitF
	adds	x26, x28, #1
	b.vs	LBB20_6
; %bb.3:                                ;   in Loop: Header=BB20_2 Depth=1
	mov	x24, x0
	mov	x8, x22
	bl	_$s8Dispatch0A4TimeV3nowACyFZ
	mov	x20, x22
	bl	_$s8Dispatch0A4TimeV17uptimeNanosecondss6UInt64Vvg
	mov	x20, x0
	mov	x0, x22
	mov	x1, x21
	blr	x27
	subs	x8, x20, x23
	b.lo	LBB20_7
; %bb.4:                                ;   in Loop: Header=BB20_2 Depth=1
	add	x25, x24, x25
	add	x28, x28, #1
	cmp	x8, x19
	b.lo	LBB20_2
; %bb.5:
	ucvtf	d0, x8
	mov	x8, #225833675390976            ; =0xcd6500000000
	movk	x8, #16845, lsl #48
	fmov	d1, x8
	fdiv	d8, d0, d1
Lloh1054:
	adrp	x0, _$ss23_ContiguousArrayStorageCyypGMd@PAGE
Lloh1055:
	add	x0, x0, _$ss23_ContiguousArrayStorageCyypGMd@PAGEOFF
Lloh1056:
	adrp	x1, _$ss23_ContiguousArrayStorageCyypGMR@PAGE
Lloh1057:
	add	x1, x1, _$ss23_ContiguousArrayStorageCyypGMR@PAGEOFF
	bl	___swift_instantiateConcreteTypeFromMangledNameV2
	mov	w1, #64                         ; =0x40
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
	mov	x21, x0
Lloh1058:
	adrp	x8, lCPI20_0@PAGE
Lloh1059:
	ldr	q0, [x8, lCPI20_0@PAGEOFF]
	str	q0, [x0, #16]
	mov	x23, #-2305843009213693952      ; =0xe000000000000000
	stp	xzr, x23, [x29, #-160]
	sub	x20, x29, #160
	mov	w0, #73                         ; =0x49
	bl	_$ss11_StringGutsV4growyySiF
	ldp	x8, x9, [x29, #-160]
	stp	x8, x9, [x29, #-160]
Lloh1060:
	adrp	x8, "l_.str.31.fahlman_swift_striped_unrolled;"@PAGE
Lloh1061:
	add	x8, x8, "l_.str.31.fahlman_swift_striped_unrolled;"@PAGEOFF
	sub	x8, x8, #32
	mov	x24, #31                        ; =0x1f
	movk	x24, #53248, lsl #48
	orr	x1, x8, #0x8000000000000000
	mov	x0, #31                         ; =0x1f
	movk	x0, #53248, lsl #48
	bl	_$sSS6appendyySSF
	stur	x26, [x29, #-168]
Lloh1062:
	adrp	x0, _$sSiN@GOTPAGE
Lloh1063:
	ldr	x0, [x0, _$sSiN@GOTPAGEOFF]
Lloh1064:
	adrp	x1, _$sSis23CustomStringConvertiblesWP@GOTPAGE
Lloh1065:
	ldr	x1, [x1, _$sSis23CustomStringConvertiblesWP@GOTPAGEOFF]
	sub	x20, x29, #168
	bl	_$ss23CustomStringConvertibleP11descriptionSSvgTj
	mov	x22, x1
	sub	x20, x29, #160
	bl	_$sSS6appendyySSF
	mov	x0, x22
	bl	_swift_bridgeObjectRelease
	mov	w0, #59                         ; =0x3b
	mov	x1, #-2233785415175766016       ; =0xe100000000000000
	bl	_$sSS6appendyySSF
Lloh1066:
	adrp	x1, _$ss26DefaultStringInterpolationVN@GOTPAGE
Lloh1067:
	ldr	x1, [x1, _$ss26DefaultStringInterpolationVN@GOTPAGEOFF]
Lloh1068:
	adrp	x2, _$ss26DefaultStringInterpolationVs16TextOutputStreamsWP@GOTPAGE
Lloh1069:
	ldr	x2, [x2, _$ss26DefaultStringInterpolationVs16TextOutputStreamsWP@GOTPAGEOFF]
	sub	x0, x29, #160
	mov.16b	v0, v8
	bl	_$sSd5write2toyxz_ts16TextOutputStreamRzlF
Lloh1070:
	adrp	x8, "l_.str.37.;1;algorithm=base,faithful=yes,bits=1"@PAGE
Lloh1071:
	add	x8, x8, "l_.str.37.;1;algorithm=base,faithful=yes,bits=1"@PAGEOFF
	sub	x8, x8, #32
	add	x0, x24, #6
	orr	x1, x8, #0x8000000000000000
	bl	_$sSS6appendyySSF
	ldp	x8, x9, [x29, #-160]
Lloh1072:
	adrp	x10, _$sSSN@GOTPAGE
Lloh1073:
	ldr	x10, [x10, _$sSSN@GOTPAGEOFF]
	str	x10, [x21, #56]
	stp	x8, x9, [x21, #32]
	mov	x0, x21
	mov	w1, #32                         ; =0x20
	mov	x2, #-2233785415175766016       ; =0xe100000000000000
	mov	w3, #10                         ; =0xa
	mov	x4, #-2233785415175766016       ; =0xe100000000000000
	bl	_$ss5print_9separator10terminatoryypd_S2StF
	mov	x0, x21
	bl	_swift_release
Lloh1074:
	adrp	x8, l_OBJC_CLASS_REF_$_NSFileHandle@PAGE
Lloh1075:
	ldr	x0, [x8, l_OBJC_CLASS_REF_$_NSFileHandle@PAGEOFF]
	bl	_objc_opt_self
	bl	_objc_msgSend$fileHandleWithStandardError
	; InlineAsm Start
	mov	x29, x29	; marker for objc_retainAutoreleaseReturnValue
	; InlineAsm End
	bl	_objc_retainAutoreleasedReturnValue
	mov	x21, x0
	stp	xzr, x23, [x29, #-160]
	mov	w0, #38                         ; =0x26
	bl	_$ss11_StringGutsV4growyySiF
	ldur	x0, [x29, #-152]
	bl	_swift_bridgeObjectRelease
Lloh1076:
	adrp	x8, "l_.str.35.Validated: 78498 primes; checksum: "@PAGE
Lloh1077:
	add	x8, x8, "l_.str.35.Validated: 78498 primes; checksum: "@PAGEOFF
	sub	x8, x8, #32
	orr	x8, x8, #0x8000000000000000
	add	x9, x24, #4
	stp	x9, x8, [x29, #-160]
	stur	x25, [x29, #-168]
Lloh1078:
	adrp	x0, _$ss6UInt64VN@GOTPAGE
Lloh1079:
	ldr	x0, [x0, _$ss6UInt64VN@GOTPAGEOFF]
Lloh1080:
	adrp	x1, _$ss6UInt64Vs23CustomStringConvertiblesWP@GOTPAGE
Lloh1081:
	ldr	x1, [x1, _$ss6UInt64Vs23CustomStringConvertiblesWP@GOTPAGEOFF]
	sub	x20, x29, #168
	bl	_$ss23CustomStringConvertibleP11descriptionSSvgTj
	mov	x22, x1
	sub	x20, x29, #160
	bl	_$sSS6appendyySSF
	mov	x0, x22
	bl	_swift_bridgeObjectRelease
	mov	w0, #10                         ; =0xa
	mov	x1, #-2233785415175766016       ; =0xe100000000000000
	bl	_$sSS6appendyySSF
	ldp	x0, x1, [x29, #-160]
	bl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufCSS8UTF8ViewV_Tt0g5
	mov	x20, x0
	mov	x22, x1
	bl	_$s10Foundation4DataV19_bridgeToObjectiveCSo6NSDataCyF
	mov	x23, x0
	mov	x0, x20
	mov	x1, x22
	bl	_$s10Foundation4DataV15_RepresentationOWOe
	mov	x0, x21
	mov	x2, x23
	bl	"_objc_msgSend$writeData:"
	ldur	x0, [x29, #-176]                ; 8-byte Folded Reload
	bl	_swift_release
	mov	x0, x21
	bl	_objc_release
	mov	x0, x23
	bl	_objc_release
	sub	sp, x29, #96
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp], #112              ; 16-byte Folded Reload
	ret
LBB20_6:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB20_7:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB20_8:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.loh AdrpLdrGot	Lloh1080, Lloh1081
	.loh AdrpLdrGot	Lloh1078, Lloh1079
	.loh AdrpAdd	Lloh1076, Lloh1077
	.loh AdrpLdr	Lloh1074, Lloh1075
	.loh AdrpLdrGot	Lloh1072, Lloh1073
	.loh AdrpAdd	Lloh1070, Lloh1071
	.loh AdrpLdrGot	Lloh1068, Lloh1069
	.loh AdrpLdrGot	Lloh1066, Lloh1067
	.loh AdrpLdrGot	Lloh1064, Lloh1065
	.loh AdrpLdrGot	Lloh1062, Lloh1063
	.loh AdrpAdd	Lloh1060, Lloh1061
	.loh AdrpLdr	Lloh1058, Lloh1059
	.loh AdrpAdd	Lloh1056, Lloh1057
	.loh AdrpAdd	Lloh1054, Lloh1055
	.loh AdrpLdrGot	Lloh1052, Lloh1053
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10PrimeSwift0A5SieveCMa ; -- Begin function $s10PrimeSwift0A5SieveCMa
	.globl	_$s10PrimeSwift0A5SieveCMa
	.p2align	2
_$s10PrimeSwift0A5SieveCMa:             ; @"$s10PrimeSwift0A5SieveCMa"
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh1082:
	adrp	x0, _$s10PrimeSwift0A5SieveCMf@PAGE+24
Lloh1083:
	add	x0, x0, _$s10PrimeSwift0A5SieveCMf@PAGEOFF+24
	bl	_objc_opt_self
	mov	x1, #0                          ; =0x0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh1082, Lloh1083
                                        ; -- End function
	.private_extern	___swift_instantiateConcreteTypeFromMangledNameV2 ; -- Begin function __swift_instantiateConcreteTypeFromMangledNameV2
	.globl	___swift_instantiateConcreteTypeFromMangledNameV2
	.weak_def_can_be_hidden	___swift_instantiateConcreteTypeFromMangledNameV2
	.p2align	2
___swift_instantiateConcreteTypeFromMangledNameV2: ; @__swift_instantiateConcreteTypeFromMangledNameV2
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	ldr	x0, [x0]
	and	x8, x0, #0x1
	cmp	x0, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB22_2
; %bb.1:
	ldr	x9, [x1]
	asr	x8, x9, #32
	add	x0, x1, w9, sxtw
	mov	x1, x8
	mov	x2, #0                          ; =0x0
	mov	x3, #0                          ; =0x0
	bl	_swift_getTypeByMangledNameInContext2
	str	x0, [x19]
LBB22_2:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.private_extern	_$s10Foundation4DataV15_RepresentationOWOe ; -- Begin function $s10Foundation4DataV15_RepresentationOWOe
	.globl	_$s10Foundation4DataV15_RepresentationOWOe
	.weak_def_can_be_hidden	_$s10Foundation4DataV15_RepresentationOWOe
	.p2align	2
_$s10Foundation4DataV15_RepresentationOWOe: ; @"$s10Foundation4DataV15_RepresentationOWOe"
; %bb.0:
	lsr	x8, x1, #62
	cmp	w8, #1
	b.eq	LBB23_3
; %bb.1:
	cmp	w8, #2
	b.ne	LBB23_4
; %bb.2:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	bl	_swift_release
	mov	x1, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
LBB23_3:
	and	x0, x1, #0x3fffffffffffffff
	b	_swift_release
LBB23_4:
	ret
                                        ; -- End function
	.private_extern	_$s10Foundation15ContiguousBytes_pSgWOh ; -- Begin function $s10Foundation15ContiguousBytes_pSgWOh
	.globl	_$s10Foundation15ContiguousBytes_pSgWOh
	.weak_def_can_be_hidden	_$s10Foundation15ContiguousBytes_pSgWOh
	.p2align	2
_$s10Foundation15ContiguousBytes_pSgWOh: ; @"$s10Foundation15ContiguousBytes_pSgWOh"
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
Lloh1084:
	adrp	x0, _$s10Foundation15ContiguousBytes_pSgMd@PAGE
Lloh1085:
	add	x0, x0, _$s10Foundation15ContiguousBytes_pSgMd@PAGEOFF
Lloh1086:
	adrp	x1, _$s10Foundation15ContiguousBytes_pSgMR@PAGE
Lloh1087:
	add	x1, x1, _$s10Foundation15ContiguousBytes_pSgMR@PAGEOFF
	bl	___swift_instantiateConcreteTypeFromMangledNameV2
	mov	x1, x0
	ldur	x8, [x0, #-8]
	ldr	x8, [x8, #8]
	mov	x0, x19
	blr	x8
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh1086, Lloh1087
	.loh AdrpAdd	Lloh1084, Lloh1085
                                        ; -- End function
	.p2align	2                               ; -- Begin function $s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5TA
_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5TA: ; @"$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5TA"
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x2, [x20, #16]
	bl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataV15_RepresentationOWOy ; -- Begin function $s10Foundation4DataV15_RepresentationOWOy
	.globl	_$s10Foundation4DataV15_RepresentationOWOy
	.weak_def_can_be_hidden	_$s10Foundation4DataV15_RepresentationOWOy
	.p2align	2
_$s10Foundation4DataV15_RepresentationOWOy: ; @"$s10Foundation4DataV15_RepresentationOWOy"
; %bb.0:
	lsr	x8, x1, #62
	cmp	w8, #1
	b.eq	LBB26_3
; %bb.1:
	cmp	w8, #2
	b.ne	LBB26_4
; %bb.2:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	bl	_swift_retain
	mov	x1, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
LBB26_3:
	and	x0, x1, #0x3fffffffffffffff
	b	_swift_retain
LBB26_4:
	ret
                                        ; -- End function
	.private_extern	_$s10Foundation4DataV15_RepresentationOSgWOe ; -- Begin function $s10Foundation4DataV15_RepresentationOSgWOe
	.globl	_$s10Foundation4DataV15_RepresentationOSgWOe
	.weak_def_can_be_hidden	_$s10Foundation4DataV15_RepresentationOSgWOe
	.p2align	2
_$s10Foundation4DataV15_RepresentationOSgWOe: ; @"$s10Foundation4DataV15_RepresentationOSgWOe"
; %bb.0:
	lsr	x8, x1, #60
	cmp	x8, #14
	b.ls	LBB27_2
; %bb.1:
	ret
LBB27_2:
	b	_$s10Foundation4DataV15_RepresentationOWOe
                                        ; -- End function
	.private_extern	_$s10Foundation15ContiguousBytes_pWOb ; -- Begin function $s10Foundation15ContiguousBytes_pWOb
	.globl	_$s10Foundation15ContiguousBytes_pWOb
	.weak_def_can_be_hidden	_$s10Foundation15ContiguousBytes_pWOb
	.p2align	2
_$s10Foundation15ContiguousBytes_pWOb:  ; @"$s10Foundation15ContiguousBytes_pWOb"
; %bb.0:
	ldp	q0, q1, [x0]
	ldr	x8, [x0, #32]
	str	x8, [x1, #32]
	stp	q0, q1, [x1]
	mov	x0, x1
	ret
                                        ; -- End function
	.private_extern	___swift_project_boxed_opaque_existential_1 ; -- Begin function __swift_project_boxed_opaque_existential_1
	.globl	___swift_project_boxed_opaque_existential_1
	.weak_def_can_be_hidden	___swift_project_boxed_opaque_existential_1
	.p2align	2
___swift_project_boxed_opaque_existential_1: ; @__swift_project_boxed_opaque_existential_1
; %bb.0:
	ldur	x8, [x1, #-8]
	ldr	w8, [x8, #80]
	tbz	w8, #17, LBB29_2
; %bb.1:
	ldr	x9, [x0]
	and	x8, x8, #0xff
	add	x10, x8, #16
	bic	x8, x10, x8
	add	x0, x9, x8
LBB29_2:
	ret
                                        ; -- End function
	.private_extern	___swift_destroy_boxed_opaque_existential_1 ; -- Begin function __swift_destroy_boxed_opaque_existential_1
	.globl	___swift_destroy_boxed_opaque_existential_1
	.weak_def_can_be_hidden	___swift_destroy_boxed_opaque_existential_1
	.p2align	2
___swift_destroy_boxed_opaque_existential_1: ; @__swift_destroy_boxed_opaque_existential_1
; %bb.0:
	ldr	x1, [x0, #24]
	ldur	x8, [x1, #-8]
	ldrb	w9, [x8, #82]
	tbnz	w9, #1, LBB30_2
; %bb.1:
	ldr	x2, [x8, #8]
	br	x2
LBB30_2:
	ldr	x0, [x0]
	b	_swift_release
                                        ; -- End function
	.section	__TEXT,__swift5_entry,regular,no_dead_strip
	.p2align	2, 0x0                          ; @"\01l_entry_point"
l_entry_point:
	.long	_main-l_entry_point
	.long	1                               ; 0x1

	.section	__TEXT,__const
	.p2align	3, 0x0                          ; @"$s10PrimeSwift0A5SieveC5limit33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd"
_$s10PrimeSwift0A5SieveC5limit33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd:
	.quad	16                              ; 0x10

	.p2align	3, 0x0                          ; @"$s10PrimeSwift0A5SieveC8oddCount33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd"
_$s10PrimeSwift0A5SieveC8oddCount33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd:
	.quad	24                              ; 0x18

	.p2align	3, 0x0                          ; @"$s10PrimeSwift0A5SieveC9byteCount33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd"
_$s10PrimeSwift0A5SieveC9byteCount33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd:
	.quad	32                              ; 0x20

	.p2align	3, 0x0                          ; @"$s10PrimeSwift0A5SieveC7storage33_D113D18C9011F4014E4762B5A56EE2E5LLSpys5UInt8VGvpWvd"
_$s10PrimeSwift0A5SieveC7storage33_D113D18C9011F4014E4762B5A56EE2E5LLSpys5UInt8VGvpWvd:
	.quad	40                              ; 0x28

	.private_extern	_$s10PrimeSwift0A5SieveCMm ; @"$s10PrimeSwift0A5SieveCMm"
	.section	__DATA,__data
	.globl	_$s10PrimeSwift0A5SieveCMm
	.p2align	3, 0x0
_$s10PrimeSwift0A5SieveCMm:
	.quad	_OBJC_METACLASS_$__TtCs12_SwiftObject
	.quad	_OBJC_METACLASS_$__TtCs12_SwiftObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	__METACLASS_DATA__TtC10PrimeSwift10PrimeSieve

	.section	__TEXT,__objc_classname,cstring_literals
	.p2align	4, 0x0                          ; @.str.28._TtC10PrimeSwift10PrimeSieve
l_.str.28._TtC10PrimeSwift10PrimeSieve:
	.asciz	"_TtC10PrimeSwift10PrimeSieve"

	.section	__DATA,__objc_const
	.p2align	3, 0x0                          ; @_METACLASS_DATA__TtC10PrimeSwift10PrimeSieve
__METACLASS_DATA__TtC10PrimeSwift10PrimeSieve:
	.long	129                             ; 0x81
	.long	40                              ; 0x28
	.long	40                              ; 0x28
	.long	0                               ; 0x0
	.quad	0
	.quad	l_.str.28._TtC10PrimeSwift10PrimeSieve
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__TEXT,__objc_methname,cstring_literals
l_.str.5.limit:                         ; @.str.5.limit
	.asciz	"limit"

	.section	__TEXT,__objc_methtype,cstring_literals
l_.str.0.:                              ; @.str.0.
	.space	1

	.section	__TEXT,__objc_methname,cstring_literals
l_.str.8.oddCount:                      ; @.str.8.oddCount
	.asciz	"oddCount"

l_.str.9.byteCount:                     ; @.str.9.byteCount
	.asciz	"byteCount"

l_.str.7.storage:                       ; @.str.7.storage
	.asciz	"storage"

	.section	__DATA,__objc_const
	.p2align	3, 0x0                          ; @_IVARS__TtC10PrimeSwift10PrimeSieve
__IVARS__TtC10PrimeSwift10PrimeSieve:
	.long	32                              ; 0x20
	.long	4                               ; 0x4
	.quad	_$s10PrimeSwift0A5SieveC5limit33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd
	.quad	l_.str.5.limit
	.quad	l_.str.0.
	.long	3                               ; 0x3
	.long	8                               ; 0x8
	.quad	_$s10PrimeSwift0A5SieveC8oddCount33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd
	.quad	l_.str.8.oddCount
	.quad	l_.str.0.
	.long	3                               ; 0x3
	.long	8                               ; 0x8
	.quad	_$s10PrimeSwift0A5SieveC9byteCount33_D113D18C9011F4014E4762B5A56EE2E5LLSivpWvd
	.quad	l_.str.9.byteCount
	.quad	l_.str.0.
	.long	3                               ; 0x3
	.long	8                               ; 0x8
	.quad	_$s10PrimeSwift0A5SieveC7storage33_D113D18C9011F4014E4762B5A56EE2E5LLSpys5UInt8VGvpWvd
	.quad	l_.str.7.storage
	.quad	l_.str.0.
	.long	3                               ; 0x3
	.long	8                               ; 0x8

	.p2align	3, 0x0                          ; @_DATA__TtC10PrimeSwift10PrimeSieve
__DATA__TtC10PrimeSwift10PrimeSieve:
	.long	128                             ; 0x80
	.long	16                              ; 0x10
	.long	48                              ; 0x30
	.long	0                               ; 0x0
	.quad	0
	.quad	l_.str.28._TtC10PrimeSwift10PrimeSieve
	.quad	0
	.quad	0
	.quad	__IVARS__TtC10PrimeSwift10PrimeSieve
	.quad	0
	.quad	0

	.section	__TEXT,__const
l_.str.10.PrimeSwift:                   ; @.str.10.PrimeSwift
	.asciz	"PrimeSwift"

	.private_extern	_$s10PrimeSwiftMXM      ; @"$s10PrimeSwiftMXM"
	.section	__TEXT,__constg_swiftt
	.globl	_$s10PrimeSwiftMXM
	.weak_definition	_$s10PrimeSwiftMXM
	.p2align	2, 0x0
_$s10PrimeSwiftMXM:
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.long	l_.str.10.PrimeSwift-_$s10PrimeSwiftMXM-8

	.section	__TEXT,__const
l_.str.10.PrimeSieve:                   ; @.str.10.PrimeSieve
	.asciz	"PrimeSieve"

	.private_extern	_$s10PrimeSwift0A5SieveCMn ; @"$s10PrimeSwift0A5SieveCMn"
	.section	__TEXT,__constg_swiftt
	.globl	_$s10PrimeSwift0A5SieveCMn
	.p2align	2, 0x0
_$s10PrimeSwift0A5SieveCMn:
	.long	2147483728                      ; 0x80000050
	.long	_$s10PrimeSwiftMXM-_$s10PrimeSwift0A5SieveCMn-4
	.long	l_.str.10.PrimeSieve-_$s10PrimeSwift0A5SieveCMn-8
	.long	_$s10PrimeSwift0A5SieveCMa-_$s10PrimeSwift0A5SieveCMn-12
	.long	_$s10PrimeSwift0A5SieveCMF-_$s10PrimeSwift0A5SieveCMn-16
	.long	0                               ; 0x0
	.long	3                               ; 0x3
	.long	15                              ; 0xf
	.long	5                               ; 0x5
	.long	4                               ; 0x4
	.long	10                              ; 0xa
	.long	14                              ; 0xe
	.long	1                               ; 0x1
	.long	1                               ; 0x1
	.long	0                               ; 0x0

	.section	__DATA,__data
	.p2align	3, 0x0                          ; @"$s10PrimeSwift0A5SieveCMf"
_$s10PrimeSwift0A5SieveCMf:
	.quad	0
	.quad	_$s10PrimeSwift0A5SieveCfD
	.quad	_$sBoWV
	.quad	_$s10PrimeSwift0A5SieveCMm
	.quad	_OBJC_CLASS_$__TtCs12_SwiftObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	__DATA__TtC10PrimeSwift10PrimeSieve+2
	.long	2                               ; 0x2
	.long	0                               ; 0x0
	.long	48                              ; 0x30
	.short	7                               ; 0x7
	.short	0                               ; 0x0
	.long	144                             ; 0x90
	.long	24                              ; 0x18
	.quad	_$s10PrimeSwift0A5SieveCMn
	.quad	0
	.quad	16                              ; 0x10
	.quad	24                              ; 0x18
	.quad	32                              ; 0x20
	.quad	40                              ; 0x28
	.quad	_swift_deletedMethodError

	.private_extern	"_symbolic _____ 10PrimeSwift0A5SieveC" ; @"symbolic _____ 10PrimeSwift0A5SieveC"
	.section	__TEXT,__swift5_typeref
	.globl	"_symbolic _____ 10PrimeSwift0A5SieveC"
	.weak_definition	"_symbolic _____ 10PrimeSwift0A5SieveC"
	.p2align	1, 0x0
"_symbolic _____ 10PrimeSwift0A5SieveC":
	.byte	1                               ; 0x1
	.long	_$s10PrimeSwift0A5SieveCMn-"_symbolic _____ 10PrimeSwift0A5SieveC"-1
	.byte	0                               ; 0x0

	.private_extern	"_symbolic Si"          ; @"symbolic Si"
	.globl	"_symbolic Si"
	.weak_definition	"_symbolic Si"
	.p2align	1, 0x0
"_symbolic Si":
	.ascii	"Si"
	.byte	0                               ; 0x0

	.section	__TEXT,__swift5_reflstr
l___unnamed_1:                          ; @0
	.asciz	"limit"

l___unnamed_2:                          ; @1
	.asciz	"oddCount"

l___unnamed_3:                          ; @2
	.asciz	"byteCount"

	.private_extern	"_symbolic Spy_____G s5UInt8V" ; @"symbolic Spy_____G s5UInt8V"
	.section	__TEXT,__swift5_typeref
	.globl	"_symbolic Spy_____G s5UInt8V"
	.weak_definition	"_symbolic Spy_____G s5UInt8V"
	.p2align	1, 0x0
"_symbolic Spy_____G s5UInt8V":
	.ascii	"Spy"
	.byte	2                               ; 0x2
Ltmp1:
	.long	_$ss5UInt8VMn@GOT-Ltmp1
	.byte	71
	.byte	0                               ; 0x0

	.section	__TEXT,__swift5_reflstr
l___unnamed_4:                          ; @3
	.asciz	"storage"

	.section	__TEXT,__swift5_fieldmd
	.p2align	2, 0x0                          ; @"$s10PrimeSwift0A5SieveCMF"
_$s10PrimeSwift0A5SieveCMF:
	.long	"_symbolic _____ 10PrimeSwift0A5SieveC"-_$s10PrimeSwift0A5SieveCMF
	.long	0                               ; 0x0
	.short	1                               ; 0x1
	.short	12                              ; 0xc
	.long	4                               ; 0x4
	.long	0                               ; 0x0
	.long	"_symbolic Si"-_$s10PrimeSwift0A5SieveCMF-20
	.long	l___unnamed_1-_$s10PrimeSwift0A5SieveCMF-24
	.long	0                               ; 0x0
	.long	"_symbolic Si"-_$s10PrimeSwift0A5SieveCMF-32
	.long	l___unnamed_2-_$s10PrimeSwift0A5SieveCMF-36
	.long	0                               ; 0x0
	.long	"_symbolic Si"-_$s10PrimeSwift0A5SieveCMF-44
	.long	l___unnamed_3-_$s10PrimeSwift0A5SieveCMF-48
	.long	0                               ; 0x0
	.long	"_symbolic Spy_____G s5UInt8V"-_$s10PrimeSwift0A5SieveCMF-56
	.long	l___unnamed_4-_$s10PrimeSwift0A5SieveCMF-60

	.private_extern	__swift_FORCE_LOAD_$_swiftFoundation_$_PrimeSwift ; @"_swift_FORCE_LOAD_$_swiftFoundation_$_PrimeSwift"
	.section	__DATA,__const
	.globl	__swift_FORCE_LOAD_$_swiftFoundation_$_PrimeSwift
	.weak_definition	__swift_FORCE_LOAD_$_swiftFoundation_$_PrimeSwift
	.p2align	3, 0x0
__swift_FORCE_LOAD_$_swiftFoundation_$_PrimeSwift:
	.quad	__swift_FORCE_LOAD_$_swiftFoundation

	.private_extern	__swift_FORCE_LOAD_$_swift_Builtin_float_$_PrimeSwift ; @"_swift_FORCE_LOAD_$_swift_Builtin_float_$_PrimeSwift"
	.globl	__swift_FORCE_LOAD_$_swift_Builtin_float_$_PrimeSwift
	.weak_definition	__swift_FORCE_LOAD_$_swift_Builtin_float_$_PrimeSwift
	.p2align	3, 0x0
__swift_FORCE_LOAD_$_swift_Builtin_float_$_PrimeSwift:
	.quad	__swift_FORCE_LOAD_$_swift_Builtin_float

	.private_extern	__swift_FORCE_LOAD_$_swiftObjectiveC_$_PrimeSwift ; @"_swift_FORCE_LOAD_$_swiftObjectiveC_$_PrimeSwift"
	.globl	__swift_FORCE_LOAD_$_swiftObjectiveC_$_PrimeSwift
	.weak_definition	__swift_FORCE_LOAD_$_swiftObjectiveC_$_PrimeSwift
	.p2align	3, 0x0
__swift_FORCE_LOAD_$_swiftObjectiveC_$_PrimeSwift:
	.quad	__swift_FORCE_LOAD_$_swiftObjectiveC

	.private_extern	__swift_FORCE_LOAD_$_swiftCoreFoundation_$_PrimeSwift ; @"_swift_FORCE_LOAD_$_swiftCoreFoundation_$_PrimeSwift"
	.globl	__swift_FORCE_LOAD_$_swiftCoreFoundation_$_PrimeSwift
	.weak_definition	__swift_FORCE_LOAD_$_swiftCoreFoundation_$_PrimeSwift
	.p2align	3, 0x0
__swift_FORCE_LOAD_$_swiftCoreFoundation_$_PrimeSwift:
	.quad	__swift_FORCE_LOAD_$_swiftCoreFoundation

	.private_extern	__swift_FORCE_LOAD_$_swiftDispatch_$_PrimeSwift ; @"_swift_FORCE_LOAD_$_swiftDispatch_$_PrimeSwift"
	.globl	__swift_FORCE_LOAD_$_swiftDispatch_$_PrimeSwift
	.weak_definition	__swift_FORCE_LOAD_$_swiftDispatch_$_PrimeSwift
	.p2align	3, 0x0
__swift_FORCE_LOAD_$_swiftDispatch_$_PrimeSwift:
	.quad	__swift_FORCE_LOAD_$_swiftDispatch

	.private_extern	__swift_FORCE_LOAD_$_swiftXPC_$_PrimeSwift ; @"_swift_FORCE_LOAD_$_swiftXPC_$_PrimeSwift"
	.globl	__swift_FORCE_LOAD_$_swiftXPC_$_PrimeSwift
	.weak_definition	__swift_FORCE_LOAD_$_swiftXPC_$_PrimeSwift
	.p2align	3, 0x0
__swift_FORCE_LOAD_$_swiftXPC_$_PrimeSwift:
	.quad	__swift_FORCE_LOAD_$_swiftXPC

	.private_extern	__swift_FORCE_LOAD_$_swiftIOKit_$_PrimeSwift ; @"_swift_FORCE_LOAD_$_swiftIOKit_$_PrimeSwift"
	.globl	__swift_FORCE_LOAD_$_swiftIOKit_$_PrimeSwift
	.weak_definition	__swift_FORCE_LOAD_$_swiftIOKit_$_PrimeSwift
	.p2align	3, 0x0
__swift_FORCE_LOAD_$_swiftIOKit_$_PrimeSwift:
	.quad	__swift_FORCE_LOAD_$_swiftIOKit

	.private_extern	"_symbolic _____yypG s23_ContiguousArrayStorageC" ; @"symbolic _____yypG s23_ContiguousArrayStorageC"
	.section	__TEXT,__swift5_typeref
	.globl	"_symbolic _____yypG s23_ContiguousArrayStorageC"
	.weak_definition	"_symbolic _____yypG s23_ContiguousArrayStorageC"
	.p2align	1, 0x0
"_symbolic _____yypG s23_ContiguousArrayStorageC":
	.byte	2                               ; 0x2
Ltmp2:
	.long	_$ss23_ContiguousArrayStorageCMn@GOT-Ltmp2
	.ascii	"yypG"
	.byte	0                               ; 0x0

	.private_extern	_$ss23_ContiguousArrayStorageCyypGMd ; @"$ss23_ContiguousArrayStorageCyypGMd"
	.section	__DATA,__data
	.globl	_$ss23_ContiguousArrayStorageCyypGMd
	.weak_definition	_$ss23_ContiguousArrayStorageCyypGMd
	.p2align	3, 0x0
_$ss23_ContiguousArrayStorageCyypGMd:
	.space	8

	.private_extern	_$ss23_ContiguousArrayStorageCyypGMR ; @"$ss23_ContiguousArrayStorageCyypGMR"
	.section	__TEXT,__const
	.globl	_$ss23_ContiguousArrayStorageCyypGMR
	.weak_definition	_$ss23_ContiguousArrayStorageCyypGMR
	.p2align	3, 0x0
_$ss23_ContiguousArrayStorageCyypGMR:
	.long	"_symbolic _____yypG s23_ContiguousArrayStorageC"-_$ss23_ContiguousArrayStorageCyypGMR
	.long	9                               ; 0x9

	.section	__TEXT,__cstring,cstring_literals
	.p2align	4, 0x0                          ; @".str.31.fahlman_swift_striped_unrolled;"
"l_.str.31.fahlman_swift_striped_unrolled;":
	.asciz	"fahlman_swift_striped_unrolled;"

	.p2align	4, 0x0                          ; @".str.37.;1;algorithm=base,faithful=yes,bits=1"
"l_.str.37.;1;algorithm=base,faithful=yes,bits=1":
	.asciz	";1;algorithm=base,faithful=yes,bits=1"

	.section	__DATA,__objc_classrefs,regular,no_dead_strip
	.p2align	3, 0x0                          ; @"OBJC_CLASS_REF_$_NSFileHandle"
l_OBJC_CLASS_REF_$_NSFileHandle:
	.quad	_OBJC_CLASS_$_NSFileHandle

	.section	__TEXT,__cstring,cstring_literals
	.p2align	4, 0x0                          ; @".str.35.Validated: 78498 primes; checksum: "
"l_.str.35.Validated: 78498 primes; checksum: ":
	.asciz	"Validated: 78498 primes; checksum: "

	.private_extern	"_symbolic ______p 10Foundation15ContiguousBytesP" ; @"symbolic ______p 10Foundation15ContiguousBytesP"
	.section	__TEXT,__swift5_typeref
	.globl	"_symbolic ______p 10Foundation15ContiguousBytesP"
	.weak_definition	"_symbolic ______p 10Foundation15ContiguousBytesP"
	.p2align	1, 0x0
"_symbolic ______p 10Foundation15ContiguousBytesP":
	.byte	2                               ; 0x2
Ltmp3:
	.long	_$s10Foundation15ContiguousBytesMp@GOT-Ltmp3
	.ascii	"_p"
	.byte	0                               ; 0x0

	.private_extern	_$s10Foundation15ContiguousBytes_pMd ; @"$s10Foundation15ContiguousBytes_pMd"
	.section	__DATA,__data
	.globl	_$s10Foundation15ContiguousBytes_pMd
	.weak_definition	_$s10Foundation15ContiguousBytes_pMd
	.p2align	3, 0x0
_$s10Foundation15ContiguousBytes_pMd:
	.space	8

	.private_extern	_$s10Foundation15ContiguousBytes_pMR ; @"$s10Foundation15ContiguousBytes_pMR"
	.section	__TEXT,__const
	.globl	_$s10Foundation15ContiguousBytes_pMR
	.weak_definition	_$s10Foundation15ContiguousBytes_pMR
	.p2align	3, 0x0
_$s10Foundation15ContiguousBytes_pMR:
	.long	"_symbolic ______p 10Foundation15ContiguousBytesP"-_$s10Foundation15ContiguousBytes_pMR
	.long	7                               ; 0x7

	.private_extern	"_symbolic ______pSg 10Foundation15ContiguousBytesP" ; @"symbolic ______pSg 10Foundation15ContiguousBytesP"
	.section	__TEXT,__swift5_typeref
	.globl	"_symbolic ______pSg 10Foundation15ContiguousBytesP"
	.weak_definition	"_symbolic ______pSg 10Foundation15ContiguousBytesP"
	.p2align	1, 0x0
"_symbolic ______pSg 10Foundation15ContiguousBytesP":
	.byte	2                               ; 0x2
Ltmp4:
	.long	_$s10Foundation15ContiguousBytesMp@GOT-Ltmp4
	.ascii	"_pSg"
	.byte	0                               ; 0x0

	.private_extern	_$s10Foundation15ContiguousBytes_pSgMd ; @"$s10Foundation15ContiguousBytes_pSgMd"
	.section	__DATA,__data
	.globl	_$s10Foundation15ContiguousBytes_pSgMd
	.weak_definition	_$s10Foundation15ContiguousBytes_pSgMd
	.p2align	3, 0x0
_$s10Foundation15ContiguousBytes_pSgMd:
	.space	8

	.private_extern	_$s10Foundation15ContiguousBytes_pSgMR ; @"$s10Foundation15ContiguousBytes_pSgMR"
	.section	__TEXT,__const
	.globl	_$s10Foundation15ContiguousBytes_pSgMR
	.weak_definition	_$s10Foundation15ContiguousBytes_pSgMR
	.p2align	3, 0x0
_$s10Foundation15ContiguousBytes_pSgMR:
	.long	"_symbolic ______pSg 10Foundation15ContiguousBytesP"-_$s10Foundation15ContiguousBytes_pSgMR
	.long	9                               ; 0x9

	.private_extern	"_symbolic _____ySiG s23_ContiguousArrayStorageC" ; @"symbolic _____ySiG s23_ContiguousArrayStorageC"
	.section	__TEXT,__swift5_typeref
	.globl	"_symbolic _____ySiG s23_ContiguousArrayStorageC"
	.weak_definition	"_symbolic _____ySiG s23_ContiguousArrayStorageC"
	.p2align	1, 0x0
"_symbolic _____ySiG s23_ContiguousArrayStorageC":
	.byte	2                               ; 0x2
Ltmp5:
	.long	_$ss23_ContiguousArrayStorageCMn@GOT-Ltmp5
	.ascii	"ySiG"
	.byte	0                               ; 0x0

	.private_extern	_$ss23_ContiguousArrayStorageCySiGMd ; @"$ss23_ContiguousArrayStorageCySiGMd"
	.section	__DATA,__data
	.globl	_$ss23_ContiguousArrayStorageCySiGMd
	.weak_definition	_$ss23_ContiguousArrayStorageCySiGMd
	.p2align	3, 0x0
_$ss23_ContiguousArrayStorageCySiGMd:
	.space	8

	.private_extern	_$ss23_ContiguousArrayStorageCySiGMR ; @"$ss23_ContiguousArrayStorageCySiGMR"
	.section	__TEXT,__const
	.globl	_$ss23_ContiguousArrayStorageCySiGMR
	.weak_definition	_$ss23_ContiguousArrayStorageCySiGMR
	.p2align	3, 0x0
_$ss23_ContiguousArrayStorageCySiGMR:
	.long	"_symbolic _____ySiG s23_ContiguousArrayStorageC"-_$ss23_ContiguousArrayStorageCySiGMR
	.long	9                               ; 0x9

	.section	__TEXT,__swift5_types
	.p2align	2, 0x0                          ; @"$s10PrimeSwift0A5SieveCHn"
l_$s10PrimeSwift0A5SieveCHn:
	.long	_$s10PrimeSwift0A5SieveCMn-l_$s10PrimeSwift0A5SieveCHn

	.private_extern	___swift_reflection_version ; @__swift_reflection_version
	.section	__TEXT,__const
	.globl	___swift_reflection_version
	.weak_definition	___swift_reflection_version
	.p2align	1, 0x0
___swift_reflection_version:
	.short	3                               ; 0x3

	.section	__DATA,__objc_classlist,regular,no_dead_strip
	.p2align	3, 0x0                          ; @"objc_classes_$s10PrimeSwift0A5SieveCN"
_objc_classes_$s10PrimeSwift0A5SieveCN:
	.quad	_$s10PrimeSwift0A5SieveCN

	.no_dead_strip	l_entry_point
	.no_dead_strip	l_$s10PrimeSwift0A5SieveCHn
	.no_dead_strip	_$s10PrimeSwift0A5SieveCMF
	.no_dead_strip	___swift_reflection_version
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftCoreFoundation_$_PrimeSwift
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftDispatch_$_PrimeSwift
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftFoundation_$_PrimeSwift
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftIOKit_$_PrimeSwift
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftObjectiveC_$_PrimeSwift
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftXPC_$_PrimeSwift
	.no_dead_strip	__swift_FORCE_LOAD_$_swift_Builtin_float_$_PrimeSwift
	.no_dead_strip	_main
	.no_dead_strip	_objc_classes_$s10PrimeSwift0A5SieveCN
	.linker_option "-lswiftCore"
	.linker_option "-lswift_StringProcessing"
	.linker_option "-lswift_Concurrency"
	.linker_option "-lswiftFoundation"
	.linker_option "-framework", "Foundation"
	.linker_option "-lswift_DarwinFoundation3"
	.linker_option "-lswift_DarwinFoundation1"
	.linker_option "-lswift_DarwinFoundation2"
	.linker_option "-lswiftSystem"
	.linker_option "-lswiftDarwin"
	.linker_option "-lswift_Builtin_float"
	.linker_option "-lswiftObservation"
	.linker_option "-lswiftObjectiveC"
	.linker_option "-lswiftCoreFoundation"
	.linker_option "-framework", "CoreFoundation"
	.linker_option "-lswiftDispatch"
	.linker_option "-framework", "Combine"
	.linker_option "-framework", "CoreServices"
	.linker_option "-framework", "Security"
	.linker_option "-lswiftXPC"
	.linker_option "-framework", "CFNetwork"
	.linker_option "-framework", "DiskArbitration"
	.linker_option "-lswiftIOKit"
	.linker_option "-framework", "IOKit"
	.linker_option "-lobjc"
	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	100861760

	.globl	_$s10PrimeSwift0A5SieveC5limitACSi_tcfCTq
	.private_extern	_$s10PrimeSwift0A5SieveC5limitACSi_tcfCTq
	.alt_entry	_$s10PrimeSwift0A5SieveC5limitACSi_tcfCTq
_$s10PrimeSwift0A5SieveC5limitACSi_tcfCTq = _$s10PrimeSwift0A5SieveCMn+52
	.globl	_$s10PrimeSwift0A5SieveCN
	.private_extern	_$s10PrimeSwift0A5SieveCN
	.alt_entry	_$s10PrimeSwift0A5SieveCN
_$s10PrimeSwift0A5SieveCN = _$s10PrimeSwift0A5SieveCMf+24
	.weak_reference __swift_FORCE_LOAD_$_swiftFoundation
	.weak_reference __swift_FORCE_LOAD_$_swift_Builtin_float
	.weak_reference __swift_FORCE_LOAD_$_swiftObjectiveC
	.weak_reference __swift_FORCE_LOAD_$_swiftCoreFoundation
	.weak_reference __swift_FORCE_LOAD_$_swiftDispatch
	.weak_reference __swift_FORCE_LOAD_$_swiftXPC
	.weak_reference __swift_FORCE_LOAD_$_swiftIOKit
.subsections_via_symbols
