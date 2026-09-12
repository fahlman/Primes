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
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3, 0x0                          ; -- Begin function $s10PrimeSwift0A5SieveC03runC0yyF
lCPI2_0:
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI2_1:
	.quad	0                               ; 0x0
	.quad	61                              ; 0x3d
lCPI2_2:
	.quad	0                               ; 0x0
	.quad	1                               ; 0x1
lCPI2_3:
	.quad	0                               ; 0x0
	.quad	59                              ; 0x3b
lCPI2_4:
	.quad	0                               ; 0x0
	.quad	57                              ; 0x39
lCPI2_5:
	.quad	0                               ; 0x0
	.quad	55                              ; 0x37
lCPI2_6:
	.quad	0                               ; 0x0
	.quad	53                              ; 0x35
lCPI2_7:
	.quad	0                               ; 0x0
	.quad	51                              ; 0x33
lCPI2_8:
	.quad	0                               ; 0x0
	.quad	49                              ; 0x31
lCPI2_9:
	.quad	0                               ; 0x0
	.quad	47                              ; 0x2f
lCPI2_10:
	.quad	0                               ; 0x0
	.quad	45                              ; 0x2d
lCPI2_11:
	.quad	0                               ; 0x0
	.quad	43                              ; 0x2b
lCPI2_12:
	.quad	0                               ; 0x0
	.quad	41                              ; 0x29
lCPI2_13:
	.quad	0                               ; 0x0
	.quad	39                              ; 0x27
lCPI2_14:
	.quad	0                               ; 0x0
	.quad	37                              ; 0x25
lCPI2_15:
	.quad	0                               ; 0x0
	.quad	35                              ; 0x23
lCPI2_16:
	.quad	0                               ; 0x0
	.quad	33                              ; 0x21
lCPI2_17:
	.quad	1                               ; 0x1
	.quad	2147483648                      ; 0x80000000
lCPI2_18:
	.quad	1                               ; 0x1
	.quad	536870912                       ; 0x20000000
lCPI2_19:
	.quad	1                               ; 0x1
	.quad	134217728                       ; 0x8000000
lCPI2_20:
	.quad	1                               ; 0x1
	.quad	33554432                        ; 0x2000000
lCPI2_21:
	.quad	1                               ; 0x1
	.quad	8388608                         ; 0x800000
lCPI2_22:
	.quad	1                               ; 0x1
	.quad	2097152                         ; 0x200000
lCPI2_23:
	.quad	4398046511105                   ; 0x40000000001
	.quad	-9223372036852678656            ; 0x8000000000200000
lCPI2_24:
	.quad	1                               ; 0x1
	.quad	524288                          ; 0x80000
lCPI2_25:
	.quad	274877906945                    ; 0x4000000001
	.quad	144115188076380160              ; 0x200000000080000
lCPI2_26:
	.quad	1                               ; 0x1
	.quad	131072                          ; 0x20000
lCPI2_27:
	.quad	17179869185                     ; 0x400000001
	.quad	2251799813816320                ; 0x8000000020000
lCPI2_28:
	.quad	1                               ; 0x1
	.quad	32768                           ; 0x8000
lCPI2_29:
	.quad	1073741825                      ; 0x40000001
	.quad	35184372121600                  ; 0x200000008000
lCPI2_30:
	.quad	1                               ; 0x1
	.quad	8192                            ; 0x2000
lCPI2_31:
	.quad	67108865                        ; 0x4000001
	.quad	549755822080                    ; 0x8000002000
lCPI2_32:
	.quad	1                               ; 0x1
	.quad	2048                            ; 0x800
lCPI2_33:
	.quad	4194305                         ; 0x400001
	.quad	8589936640                      ; 0x200000800
lCPI2_34:
	.quad	17592190238721                  ; 0x100000400001
	.quad	36028805608900608               ; 0x80000200000800
lCPI2_35:
	.quad	1                               ; 0x1
	.quad	512                             ; 0x200
lCPI2_36:
	.quad	262145                          ; 0x40001
	.quad	134218240                       ; 0x8000200
lCPI2_37:
	.quad	68719738881                     ; 0x1000040001
	.quad	35184506307072                  ; 0x200008000200
lCPI2_38:
	.quad	18014467229220865               ; 0x40001000040001
	.quad	-9223336852348468736            ; 0x8000200008000200
lCPI2_39:
	.quad	-9150747060186627967            ; 0x8102040810204081
	.quad	4647998506761461824             ; 0x4081020408102040
lCPI2_40:
	.quad	2323999253380730912             ; 0x2040810204081020
	.quad	1161999626690365456             ; 0x1020408102040810
lCPI2_41:
	.quad	580999813345182728              ; 0x810204081020408
	.quad	290499906672591364              ; 0x408102040810204
lCPI2_42:
	.quad	1190112520884487201             ; 0x1084210842108421
	.quad	2380225041768974402             ; 0x2108421084210842
lCPI2_43:
	.quad	4760450083537948804             ; 0x4210842108421084
	.quad	-8925843906633654008            ; 0x8421084210842108
lCPI2_44:
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
lCPI2_45:
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
lCPI2_46:
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
lCPI2_47:
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
lCPI2_48:
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
lCPI2_49:
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
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	sub	sp, sp, #816
	.cfi_def_cfa_offset 912
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
	ldp	x9, x8, [x20, #32]
	stp	x9, x20, [sp, #32]              ; 16-byte Folded Spill
	lsl	x9, x9, #3
	str	x9, [sp, #24]                   ; 8-byte Folded Spill
	mov	w11, #3                         ; =0x3
	mov	x0, #-9223372036854775808       ; =0x8000000000000000
	ldr	x3, [x20, #16]
	mov	w4, #146                        ; =0x92
	mov	w5, #36                         ; =0x24
	mov	w6, #1                          ; =0x1
	mov	w7, #73                         ; =0x49
Lloh0:
	adrp	x9, lCPI2_44@PAGE
Lloh1:
	ldr	q0, [x9, lCPI2_44@PAGEOFF]
Lloh2:
	adrp	x9, lCPI2_45@PAGE
Lloh3:
	ldr	q1, [x9, lCPI2_45@PAGEOFF]
Lloh4:
	adrp	x9, lCPI2_46@PAGE
Lloh5:
	ldr	q2, [x9, lCPI2_46@PAGEOFF]
Lloh6:
	adrp	x9, lCPI2_47@PAGE
Lloh7:
	ldr	q3, [x9, lCPI2_47@PAGEOFF]
	movi.16b	v4, #146
	movi.16b	v5, #73
Lloh8:
	adrp	x9, lCPI2_48@PAGE
Lloh9:
	ldr	q6, [x9, lCPI2_48@PAGEOFF]
Lloh10:
	adrp	x9, lCPI2_49@PAGE
Lloh11:
	ldr	q7, [x9, lCPI2_49@PAGEOFF]
	movi.16b	v16, #36
	str	x3, [sp, #16]                   ; 8-byte Folded Spill
	b	LBB2_3
LBB2_1:                                 ;   in Loop: Header=BB2_3 Depth=1
	adds	x11, x11, #2
	b.vs	LBB2_503
LBB2_2:                                 ;   in Loop: Header=BB2_3 Depth=1
	cbz	x11, LBB2_500
LBB2_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_115 Depth 2
                                        ;     Child Loop BB2_119 Depth 2
                                        ;     Child Loop BB2_47 Depth 2
                                        ;     Child Loop BB2_51 Depth 2
                                        ;     Child Loop BB2_79 Depth 2
                                        ;     Child Loop BB2_83 Depth 2
                                        ;     Child Loop BB2_97 Depth 2
                                        ;     Child Loop BB2_101 Depth 2
                                        ;     Child Loop BB2_21 Depth 2
                                        ;     Child Loop BB2_481 Depth 2
                                        ;       Child Loop BB2_483 Depth 3
                                        ;     Child Loop BB2_172 Depth 2
                                        ;       Child Loop BB2_174 Depth 3
                                        ;     Child Loop BB2_270 Depth 2
                                        ;       Child Loop BB2_272 Depth 3
                                        ;     Child Loop BB2_263 Depth 2
                                        ;       Child Loop BB2_265 Depth 3
                                        ;     Child Loop BB2_158 Depth 2
                                        ;       Child Loop BB2_160 Depth 3
                                        ;     Child Loop BB2_130 Depth 2
                                        ;       Child Loop BB2_132 Depth 3
                                        ;     Child Loop BB2_200 Depth 2
                                        ;       Child Loop BB2_202 Depth 3
                                        ;     Child Loop BB2_151 Depth 2
                                        ;       Child Loop BB2_153 Depth 3
                                        ;     Child Loop BB2_193 Depth 2
                                        ;       Child Loop BB2_195 Depth 3
                                        ;     Child Loop BB2_137 Depth 2
                                        ;       Child Loop BB2_139 Depth 3
                                        ;     Child Loop BB2_123 Depth 2
                                        ;       Child Loop BB2_125 Depth 3
                                        ;     Child Loop BB2_165 Depth 2
                                        ;       Child Loop BB2_167 Depth 3
                                        ;     Child Loop BB2_256 Depth 2
                                        ;       Child Loop BB2_258 Depth 3
                                        ;     Child Loop BB2_144 Depth 2
                                        ;       Child Loop BB2_146 Depth 3
                                        ;     Child Loop BB2_228 Depth 2
                                        ;       Child Loop BB2_230 Depth 3
                                        ;     Child Loop BB2_186 Depth 2
                                        ;       Child Loop BB2_188 Depth 3
                                        ;     Child Loop BB2_235 Depth 2
                                        ;       Child Loop BB2_237 Depth 3
                                        ;     Child Loop BB2_214 Depth 2
                                        ;       Child Loop BB2_216 Depth 3
                                        ;     Child Loop BB2_179 Depth 2
                                        ;       Child Loop BB2_181 Depth 3
                                        ;     Child Loop BB2_242 Depth 2
                                        ;       Child Loop BB2_244 Depth 3
                                        ;     Child Loop BB2_249 Depth 2
                                        ;       Child Loop BB2_251 Depth 3
                                        ;     Child Loop BB2_207 Depth 2
                                        ;       Child Loop BB2_209 Depth 3
                                        ;     Child Loop BB2_221 Depth 2
                                        ;       Child Loop BB2_223 Depth 3
                                        ;     Child Loop BB2_63 Depth 2
                                        ;       Child Loop BB2_65 Depth 3
                                        ;     Child Loop BB2_277 Depth 2
                                        ;     Child Loop BB2_27 Depth 2
                                        ;     Child Loop BB2_472 Depth 2
                                        ;       Child Loop BB2_473 Depth 3
                                        ;     Child Loop BB2_444 Depth 2
                                        ;       Child Loop BB2_445 Depth 3
                                        ;         Child Loop BB2_446 Depth 4
                                        ;     Child Loop BB2_425 Depth 2
                                        ;       Child Loop BB2_426 Depth 3
                                        ;         Child Loop BB2_427 Depth 4
                                        ;     Child Loop BB2_465 Depth 2
                                        ;       Child Loop BB2_466 Depth 3
                                        ;         Child Loop BB2_467 Depth 4
                                        ;     Child Loop BB2_413 Depth 2
                                        ;       Child Loop BB2_414 Depth 3
                                        ;         Child Loop BB2_415 Depth 4
                                        ;     Child Loop BB2_451 Depth 2
                                        ;       Child Loop BB2_452 Depth 3
                                        ;         Child Loop BB2_453 Depth 4
                                        ;     Child Loop BB2_282 Depth 2
                                        ;       Child Loop BB2_283 Depth 3
                                        ;         Child Loop BB2_284 Depth 4
                                        ;     Child Loop BB2_332 Depth 2
                                        ;       Child Loop BB2_333 Depth 3
                                        ;         Child Loop BB2_334 Depth 4
                                        ;     Child Loop BB2_458 Depth 2
                                        ;       Child Loop BB2_459 Depth 3
                                        ;         Child Loop BB2_460 Depth 4
                                        ;     Child Loop BB2_437 Depth 2
                                        ;       Child Loop BB2_438 Depth 3
                                        ;         Child Loop BB2_439 Depth 4
                                        ;     Child Loop BB2_320 Depth 2
                                        ;       Child Loop BB2_321 Depth 3
                                        ;         Child Loop BB2_322 Depth 4
                                        ;     Child Loop BB2_289 Depth 2
                                        ;       Child Loop BB2_290 Depth 3
                                        ;         Child Loop BB2_291 Depth 4
                                        ;     Child Loop BB2_351 Depth 2
                                        ;       Child Loop BB2_352 Depth 3
                                        ;         Child Loop BB2_353 Depth 4
                                        ;     Child Loop BB2_308 Depth 2
                                        ;       Child Loop BB2_309 Depth 3
                                        ;         Child Loop BB2_310 Depth 4
                                        ;     Child Loop BB2_344 Depth 2
                                        ;       Child Loop BB2_345 Depth 3
                                        ;         Child Loop BB2_346 Depth 4
                                        ;     Child Loop BB2_301 Depth 2
                                        ;       Child Loop BB2_302 Depth 3
                                        ;         Child Loop BB2_303 Depth 4
                                        ;     Child Loop BB2_432 Depth 2
                                        ;       Child Loop BB2_433 Depth 3
                                        ;     Child Loop BB2_315 Depth 2
                                        ;       Child Loop BB2_316 Depth 3
                                        ;     Child Loop BB2_420 Depth 2
                                        ;       Child Loop BB2_421 Depth 3
                                        ;     Child Loop BB2_296 Depth 2
                                        ;       Child Loop BB2_297 Depth 3
                                        ;     Child Loop BB2_358 Depth 2
                                        ;       Child Loop BB2_359 Depth 3
                                        ;     Child Loop BB2_327 Depth 2
                                        ;       Child Loop BB2_328 Depth 3
                                        ;     Child Loop BB2_363 Depth 2
                                        ;       Child Loop BB2_364 Depth 3
                                        ;     Child Loop BB2_339 Depth 2
                                        ;       Child Loop BB2_340 Depth 3
                                        ;     Child Loop BB2_394 Depth 2
                                        ;       Child Loop BB2_397 Depth 3
                                        ;     Child Loop BB2_404 Depth 2
                                        ;       Child Loop BB2_407 Depth 3
                                        ;     Child Loop BB2_384 Depth 2
                                        ;       Child Loop BB2_387 Depth 3
                                        ;     Child Loop BB2_369 Depth 2
                                        ;       Child Loop BB2_372 Depth 3
                                        ;     Child Loop BB2_380 Depth 2
                                        ;     Child Loop BB2_61 Depth 2
                                        ;     Child Loop BB2_476 Depth 2
                                        ;     Child Loop BB2_488 Depth 2
                                        ;     Child Loop BB2_491 Depth 2
                                        ;     Child Loop BB2_494 Depth 2
	cmp	x3, x0
	ccmn	x11, #1, #0, eq
	b.eq	LBB2_504
; %bb.4:                                ;   in Loop: Header=BB2_3 Depth=1
	sdiv	x9, x3, x11
	cmp	x9, x11
	b.lt	LBB2_496
; %bb.5:                                ;   in Loop: Header=BB2_3 Depth=1
	subs	x9, x11, #3
	b.vs	LBB2_499
; %bb.6:                                ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x9, x9, lsr #63
	asr	x10, x9, #4
	ldrb	w10, [x8, x10]
	ubfx	w9, w9, #1, #3
	lsr	w9, w10, w9
	tbnz	w9, #0, LBB2_1
; %bb.7:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x11, #63
	b.gt	LBB2_19
; %bb.8:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	ldr	x19, [x9, #40]
	cmp	x11, #3
	b.ne	LBB2_24
; %bb.9:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	ldr	x21, [x9, #24]
	cmp	x21, #4
	b.lt	LBB2_478
; %bb.10:                               ;   in Loop: Header=BB2_3 Depth=1
	ldrb	w9, [x19]
	orr	w10, w9, #0x8
	strb	w10, [x19]
	cmp	x21, #7
	b.lo	LBB2_478
; %bb.11:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	w10, #72                        ; =0x48
	orr	w9, w9, w10
	strb	w9, [x19]
	cmp	x21, #10
	b.lo	LBB2_478
; %bb.12:                               ;   in Loop: Header=BB2_3 Depth=1
	ldrb	w9, [x19, #1]
	orr	w10, w9, #0x2
	strb	w10, [x19, #1]
	cmp	x21, #13
	b.lo	LBB2_478
; %bb.13:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	w10, #18                        ; =0x12
	orr	w10, w9, w10
	strb	w10, [x19, #1]
	cmp	x21, #16
	b.lo	LBB2_478
; %bb.14:                               ;   in Loop: Header=BB2_3 Depth=1
	orr	w9, w9, w4
	strb	w9, [x19, #1]
	cmp	x21, #19
	b.lo	LBB2_478
; %bb.15:                               ;   in Loop: Header=BB2_3 Depth=1
	ldrb	w9, [x19, #2]
	orr	w10, w9, #0x4
	strb	w10, [x19, #2]
	cmp	x21, #22
	b.lo	LBB2_478
; %bb.16:                               ;   in Loop: Header=BB2_3 Depth=1
	orr	w9, w9, w5
	strb	w9, [x19, #2]
	cmp	x21, #25
	b.lo	LBB2_478
; %bb.17:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x21, #48
	b.hs	LBB2_485
; %bb.18:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	w9, #24                         ; =0x18
	b	LBB2_493
LBB2_19:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x11, #111
	b.hi	LBB2_30
; %bb.20:                               ;   in Loop: Header=BB2_3 Depth=1
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	ldp	x9, x19, [x9, #32]
	lsl	x21, x9, #3
	mov	x10, #-3                        ; =0xfffffffffffffffd
	madd	x10, x11, x11, x10
	lsr	x10, x10, #1
LBB2_21:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	cmp	x10, x21
	b.ge	LBB2_279
; %bb.22:                               ;   in Loop: Header=BB2_21 Depth=2
	tst	x10, #0x7f
	b.eq	LBB2_53
; %bb.23:                               ;   in Loop: Header=BB2_21 Depth=2
	and	x12, x10, #0x7
	asr	x13, x10, #3
	ldrb	w14, [x19, x13]
	lsl	w12, w6, w12
	orr	w12, w14, w12
	strb	w12, [x19, x13]
	cmn	x10, x11
	add	x10, x10, x11
	b.vc	LBB2_21
	b	LBB2_497
LBB2_24:                                ;   in Loop: Header=BB2_3 Depth=1
	mul	x9, x11, x11
	smulh	x10, x11, x11
	cmp	x10, x9, asr #63
	b.ne	LBB2_506
; %bb.25:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x9, x9, #3
	b.vs	LBB2_508
; %bb.26:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x9, x9, lsr #63
	asr	x9, x9, #1
	ldr	x10, [sp, #40]                  ; 8-byte Folded Reload
	ldr	x21, [x10, #24]
LBB2_27:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	cmp	x9, x21
	b.ge	LBB2_478
; %bb.28:                               ;   in Loop: Header=BB2_27 Depth=2
	tst	x9, #0x3f
	b.eq	LBB2_57
; %bb.29:                               ;   in Loop: Header=BB2_27 Depth=2
	and	x10, x9, #0x7
	asr	x12, x9, #3
	ldrb	w13, [x19, x12]
	lsl	w10, w6, w10
	orr	w10, w13, w10
	strb	w10, [x19, x12]
	cmn	x9, x11
	add	x9, x9, x11
	b.vc	LBB2_27
	b	LBB2_498
LBB2_30:                                ;   in Loop: Header=BB2_3 Depth=1
	mul	x9, x11, x11
	smulh	x10, x11, x11
	cmp	x10, x9, asr #63
	b.ne	LBB2_507
; %bb.31:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x9, x9, #3
	b.vs	LBB2_509
; %bb.32:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x9, x9, lsr #63
	asr	x21, x9, #1
	and	x10, x11, #0x7
	and	x19, x21, #0x7
	adds	x22, x19, x11
	cset	w9, vs
	cmp	x10, #5
	b.eq	LBB2_85
; %bb.33:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x10, #3
	b.eq	LBB2_67
; %bb.34:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x10, #1
	b.ne	LBB2_103
; %bb.35:                               ;   in Loop: Header=BB2_3 Depth=1
	tbnz	w9, #0, LBB2_512
; %bb.36:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x24, x11, #1
	adds	x9, x19, x24
	b.vs	LBB2_516
; %bb.37:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x14, x11, x11, lsl #1
	adds	x10, x19, x14
	b.vs	LBB2_520
; %bb.38:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x12, x19, x11, lsl #2
	b.vs	LBB2_524
; %bb.39:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x13, x11, x11, lsl #2
	adds	x13, x19, x13
	b.vs	LBB2_527
; %bb.40:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x14, x19, x14, lsl #1
	b.vs	LBB2_531
; %bb.41:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x15, x11, #3
	sub	x15, x15, x11
	mov	w16, #7                         ; =0x7
	smulh	x16, x11, x16
	cmp	x16, x15, asr #63
	b.ne	LBB2_537
; %bb.42:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x15, x19, x15
	b.vs	LBB2_539
; %bb.43:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x23, x15, #3
	ldr	x15, [sp, #32]                  ; 8-byte Folded Reload
	subs	x1, x15, x23
	b.vs	LBB2_546
; %bb.44:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x2, x1, x11
	b.vs	LBB2_548
; %bb.45:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x30, x22, #3
	asr	x28, x9, #3
	asr	x27, x10, #3
	asr	x26, x12, #3
	asr	x25, x13, #3
	asr	x10, x14, #3
	asr	x21, x21, #3
	cmp	x21, x2
	str	x10, [sp, #8]                   ; 8-byte Folded Spill
	b.ge	LBB2_48
; %bb.46:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x3, x8, x11
	add	x9, x11, x30
	add	x17, x8, x9
	add	x9, x11, x28
	add	x15, x8, x9
	add	x9, x11, x27
	add	x16, x8, x9
	add	x9, x11, x26
	add	x14, x8, x9
	add	x9, x11, x25
	add	x4, x8, x9
	add	x9, x11, x10
	add	x6, x8, x9
	add	x9, x11, x23
	add	x7, x8, x9
	add	x5, x8, x23
	add	x9, x8, x10
	add	x12, x8, x25
	add	x10, x8, x26
	add	x20, x8, x27
	add	x13, x8, x28
	add	x0, x8, x30
LBB2_47:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w22, [x8, x21]
	orr	w22, w22, #0x80
	strb	w22, [x8, x21]
	ldrb	w22, [x0, x21]
	orr	w22, w22, #0x1
	strb	w22, [x0, x21]
	ldrb	w22, [x13, x21]
	orr	w22, w22, #0x2
	strb	w22, [x13, x21]
	ldrb	w22, [x20, x21]
	orr	w22, w22, #0x4
	strb	w22, [x20, x21]
	ldrb	w22, [x10, x21]
	orr	w22, w22, #0x8
	strb	w22, [x10, x21]
	ldrb	w22, [x12, x21]
	orr	w22, w22, #0x10
	strb	w22, [x12, x21]
	ldrb	w22, [x9, x21]
	orr	w22, w22, #0x20
	strb	w22, [x9, x21]
	ldrb	w22, [x5, x21]
	orr	w22, w22, #0x40
	strb	w22, [x5, x21]
	ldrb	w22, [x3, x21]
	orr	w22, w22, #0x80
	strb	w22, [x3, x21]
	ldrb	w22, [x17, x21]
	orr	w22, w22, #0x1
	strb	w22, [x17, x21]
	ldrb	w22, [x15, x21]
	orr	w22, w22, #0x2
	strb	w22, [x15, x21]
	ldrb	w22, [x16, x21]
	orr	w22, w22, #0x4
	strb	w22, [x16, x21]
	ldrb	w22, [x14, x21]
	orr	w22, w22, #0x8
	strb	w22, [x14, x21]
	ldrb	w22, [x4, x21]
	orr	w22, w22, #0x10
	strb	w22, [x4, x21]
	ldrb	w22, [x6, x21]
	orr	w22, w22, #0x20
	strb	w22, [x6, x21]
	ldrb	w22, [x7, x21]
	orr	w22, w22, #0x40
	strb	w22, [x7, x21]
	add	x21, x21, x24
	cmp	x21, x2
	b.lt	LBB2_47
LBB2_48:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x21, x1
	b.ge	LBB2_50
; %bb.49:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x8, x21
	ldrb	w10, [x9]
	orr	w10, w10, #0x80
	strb	w10, [x9]
	ldrb	w10, [x9, x30]
	orr	w10, w10, #0x1
	strb	w10, [x9, x30]
	ldrb	w10, [x9, x28]
	orr	w10, w10, #0x2
	strb	w10, [x9, x28]
	ldrb	w10, [x9, x27]
	orr	w10, w10, #0x4
	strb	w10, [x9, x27]
	ldrb	w10, [x9, x26]
	orr	w10, w10, #0x8
	strb	w10, [x9, x26]
	ldrb	w10, [x9, x25]
	orr	w10, w10, #0x10
	strb	w10, [x9, x25]
	ldr	x12, [sp, #8]                   ; 8-byte Folded Reload
	ldrb	w10, [x9, x12]
	orr	w10, w10, #0x20
	strb	w10, [x9, x12]
	ldrb	w10, [x9, x23]
	orr	w10, w10, #0x40
	strb	w10, [x9, x23]
	add	x21, x21, x11
LBB2_50:                                ;   in Loop: Header=BB2_3 Depth=1
	ldp	x3, x14, [sp, #16]              ; 16-byte Folded Reload
	mov	x0, #-9223372036854775808       ; =0x8000000000000000
	mov	w4, #146                        ; =0x92
	mov	w5, #36                         ; =0x24
	mov	w6, #1                          ; =0x1
	mov	w7, #73                         ; =0x49
	orr	x9, x19, x21, lsl #3
LBB2_51:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	cmp	x9, x14
	b.ge	LBB2_1
; %bb.52:                               ;   in Loop: Header=BB2_51 Depth=2
	and	x10, x9, #0x7
	asr	x12, x9, #3
	ldrb	w13, [x8, x12]
	lsl	w10, w6, w10
	orr	w10, w10, w13
	strb	w10, [x8, x12]
	add	x9, x9, x11
	b	LBB2_51
LBB2_53:                                ;   in Loop: Header=BB2_3 Depth=1
	sub	x12, x11, #65
	cmp	x12, #46
	b.hi	LBB2_552
; %bb.54:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x23, x10, #7
	asr	x22, x9, #4
Lloh12:
	adrp	x13, lJTI2_0@PAGE
Lloh13:
	add	x13, x13, lJTI2_0@PAGEOFF
Ltmp0:
	adr	x9, Ltmp0
	ldrsw	x10, [x13, x12, lsl #2]
	add	x9, x9, x10
	br	x9
LBB2_55:                                ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #65
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.56:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x17, x19, x23, lsl #4
	b	LBB2_63
LBB2_57:                                ;   in Loop: Header=BB2_3 Depth=1
	sub	x10, x11, #5
	cmp	x10, #58
	b.hi	LBB2_553
; %bb.58:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x23, x9, #6
	asr	x22, x21, #6
Lloh14:
	adrp	x13, lJTI2_1@PAGE
Lloh15:
	add	x13, x13, lJTI2_1@PAGEOFF
Ltmp1:
	adr	x9, Ltmp1
	ldrsw	x12, [x13, x10, lsl #2]
	add	x9, x9, x12
	adrp	x24, lCPI2_2@PAGE
	br	x9
LBB2_59:                                ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #5
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.60:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x19, x23, lsl #3
	add	x9, x9, #32
	mov	x10, x23
LBB2_61:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
Lloh16:
	adrp	x12, lCPI2_42@PAGE
Lloh17:
	ldr	q17, [x12, lCPI2_42@PAGEOFF]
	ldp	q18, q19, [x9, #-32]
	orr.16b	v17, v18, v17
Lloh18:
	adrp	x12, lCPI2_43@PAGE
Lloh19:
	ldr	q18, [x12, lCPI2_43@PAGEOFF]
	orr.16b	v18, v19, v18
	stp	q17, q18, [x9, #-32]
	ldr	x12, [x9]
	mov	x13, #16912                     ; =0x4210
	movk	x13, #8456, lsl #16
	movk	x13, #4228, lsl #32
	movk	x13, #2114, lsl #48
	orr	x12, x12, x13
	str	x12, [x9], #40
	add	x23, x10, #5
	add	x12, x10, #10
	mov	x10, x23
	cmp	x22, x12
	b.ge	LBB2_61
	b	LBB2_475
LBB2_62:                                ;   in Loop: Header=BB2_63 Depth=2
	add	x9, x23, #65
	add	x17, x17, #1040
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_63:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_65 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_65
LBB2_64:                                ;   in Loop: Header=BB2_65 Depth=3
	str	q17, [x17, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #65
	b.eq	LBB2_62
LBB2_65:                                ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_63 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x17, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #4033                      ; =0xfc1
	mul	w10, w10, w12
	lsr	w10, w10, #18
	add	w10, w10, w10, lsl #6
	mov	w12, #65                        ; =0x41
	sub	w9, w9, w10
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x15, x9, #6, #10
	add	x16, sp, #64
	and	x12, x12, #0x8
	orr	x12, x16, x12
	bfi	x16, x15, #3, #1
	str	q17, [sp, #64]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x16]
	ldr	q17, [sp, #64]
	cmp	w10, #62
	b.hi	LBB2_64
; %bb.66:                               ;   in Loop: Header=BB2_65 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #65
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #48
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #48]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #48]
	b	LBB2_64
LBB2_67:                                ;   in Loop: Header=BB2_3 Depth=1
	tbnz	w9, #0, LBB2_511
; %bb.68:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x24, x11, #1
	adds	x9, x19, x24
	b.vs	LBB2_518
; %bb.69:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x14, x11, x11, lsl #1
	adds	x10, x19, x14
	b.vs	LBB2_522
; %bb.70:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x12, x19, x11, lsl #2
	b.vs	LBB2_525
; %bb.71:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x13, x11, x11, lsl #2
	adds	x13, x19, x13
	b.vs	LBB2_529
; %bb.72:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x14, x19, x14, lsl #1
	b.vs	LBB2_532
; %bb.73:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x15, x11, #3
	sub	x15, x15, x11
	mov	w16, #7                         ; =0x7
	smulh	x16, x11, x16
	cmp	x16, x15, asr #63
	b.ne	LBB2_535
; %bb.74:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x15, x19, x15
	b.vs	LBB2_542
; %bb.75:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x23, x15, #3
	ldr	x15, [sp, #32]                  ; 8-byte Folded Reload
	subs	x1, x15, x23
	b.vs	LBB2_544
; %bb.76:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x2, x1, x11
	b.vs	LBB2_547
; %bb.77:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x30, x22, #3
	asr	x28, x9, #3
	asr	x27, x10, #3
	asr	x26, x12, #3
	asr	x25, x13, #3
	asr	x10, x14, #3
	asr	x21, x21, #3
	cmp	x21, x2
	str	x10, [sp, #8]                   ; 8-byte Folded Spill
	b.ge	LBB2_80
; %bb.78:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x3, x8, x11
	add	x9, x11, x30
	add	x17, x8, x9
	add	x9, x11, x28
	add	x15, x8, x9
	add	x9, x11, x27
	add	x16, x8, x9
	add	x9, x11, x26
	add	x14, x8, x9
	add	x9, x11, x25
	add	x4, x8, x9
	add	x9, x11, x10
	add	x6, x8, x9
	add	x9, x11, x23
	add	x7, x8, x9
	add	x5, x8, x23
	add	x9, x8, x10
	add	x12, x8, x25
	add	x10, x8, x26
	add	x20, x8, x27
	add	x13, x8, x28
	add	x0, x8, x30
LBB2_79:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w22, [x8, x21]
	orr	w22, w22, #0x8
	strb	w22, [x8, x21]
	ldrb	w22, [x0, x21]
	orr	w22, w22, #0x40
	strb	w22, [x0, x21]
	ldrb	w22, [x13, x21]
	orr	w22, w22, #0x2
	strb	w22, [x13, x21]
	ldrb	w22, [x20, x21]
	orr	w22, w22, #0x10
	strb	w22, [x20, x21]
	ldrb	w22, [x10, x21]
	orr	w22, w22, #0x80
	strb	w22, [x10, x21]
	ldrb	w22, [x12, x21]
	orr	w22, w22, #0x4
	strb	w22, [x12, x21]
	ldrb	w22, [x9, x21]
	orr	w22, w22, #0x20
	strb	w22, [x9, x21]
	ldrb	w22, [x5, x21]
	orr	w22, w22, #0x1
	strb	w22, [x5, x21]
	ldrb	w22, [x3, x21]
	orr	w22, w22, #0x8
	strb	w22, [x3, x21]
	ldrb	w22, [x17, x21]
	orr	w22, w22, #0x40
	strb	w22, [x17, x21]
	ldrb	w22, [x15, x21]
	orr	w22, w22, #0x2
	strb	w22, [x15, x21]
	ldrb	w22, [x16, x21]
	orr	w22, w22, #0x10
	strb	w22, [x16, x21]
	ldrb	w22, [x14, x21]
	orr	w22, w22, #0x80
	strb	w22, [x14, x21]
	ldrb	w22, [x4, x21]
	orr	w22, w22, #0x4
	strb	w22, [x4, x21]
	ldrb	w22, [x6, x21]
	orr	w22, w22, #0x20
	strb	w22, [x6, x21]
	ldrb	w22, [x7, x21]
	orr	w22, w22, #0x1
	strb	w22, [x7, x21]
	add	x21, x21, x24
	cmp	x21, x2
	b.lt	LBB2_79
LBB2_80:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x21, x1
	b.ge	LBB2_82
; %bb.81:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x8, x21
	ldrb	w10, [x9]
	orr	w10, w10, #0x8
	strb	w10, [x9]
	ldrb	w10, [x9, x30]
	orr	w10, w10, #0x40
	strb	w10, [x9, x30]
	ldrb	w10, [x9, x28]
	orr	w10, w10, #0x2
	strb	w10, [x9, x28]
	ldrb	w10, [x9, x27]
	orr	w10, w10, #0x10
	strb	w10, [x9, x27]
	ldrb	w10, [x9, x26]
	orr	w10, w10, #0x80
	strb	w10, [x9, x26]
	ldrb	w10, [x9, x25]
	orr	w10, w10, #0x4
	strb	w10, [x9, x25]
	ldr	x12, [sp, #8]                   ; 8-byte Folded Reload
	ldrb	w10, [x9, x12]
	orr	w10, w10, #0x20
	strb	w10, [x9, x12]
	ldrb	w10, [x9, x23]
	orr	w10, w10, #0x1
	strb	w10, [x9, x23]
	add	x21, x21, x11
LBB2_82:                                ;   in Loop: Header=BB2_3 Depth=1
	ldp	x3, x14, [sp, #16]              ; 16-byte Folded Reload
	mov	x0, #-9223372036854775808       ; =0x8000000000000000
	mov	w4, #146                        ; =0x92
	mov	w5, #36                         ; =0x24
	mov	w6, #1                          ; =0x1
	mov	w7, #73                         ; =0x49
	orr	x9, x19, x21, lsl #3
LBB2_83:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	cmp	x9, x14
	b.ge	LBB2_1
; %bb.84:                               ;   in Loop: Header=BB2_83 Depth=2
	and	x10, x9, #0x7
	asr	x12, x9, #3
	ldrb	w13, [x8, x12]
	lsl	w10, w6, w10
	orr	w10, w10, w13
	strb	w10, [x8, x12]
	add	x9, x9, x11
	b	LBB2_83
LBB2_85:                                ;   in Loop: Header=BB2_3 Depth=1
	tbnz	w9, #0, LBB2_513
; %bb.86:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x24, x11, #1
	adds	x9, x19, x24
	b.vs	LBB2_515
; %bb.87:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x14, x11, x11, lsl #1
	adds	x10, x19, x14
	b.vs	LBB2_519
; %bb.88:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x12, x19, x11, lsl #2
	b.vs	LBB2_523
; %bb.89:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x13, x11, x11, lsl #2
	adds	x13, x19, x13
	b.vs	LBB2_528
; %bb.90:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x14, x19, x14, lsl #1
	b.vs	LBB2_534
; %bb.91:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x15, x11, #3
	sub	x15, x15, x11
	mov	w16, #7                         ; =0x7
	smulh	x16, x11, x16
	cmp	x16, x15, asr #63
	b.ne	LBB2_538
; %bb.92:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x15, x19, x15
	b.vs	LBB2_541
; %bb.93:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x23, x15, #3
	ldr	x15, [sp, #32]                  ; 8-byte Folded Reload
	subs	x1, x15, x23
	b.vs	LBB2_543
; %bb.94:                               ;   in Loop: Header=BB2_3 Depth=1
	subs	x2, x1, x11
	b.vs	LBB2_550
; %bb.95:                               ;   in Loop: Header=BB2_3 Depth=1
	asr	x30, x22, #3
	asr	x28, x9, #3
	asr	x27, x10, #3
	asr	x26, x12, #3
	asr	x25, x13, #3
	asr	x10, x14, #3
	asr	x21, x21, #3
	cmp	x21, x2
	str	x10, [sp, #8]                   ; 8-byte Folded Spill
	b.ge	LBB2_98
; %bb.96:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x3, x8, x11
	add	x9, x11, x30
	add	x17, x8, x9
	add	x9, x11, x28
	add	x15, x8, x9
	add	x9, x11, x27
	add	x16, x8, x9
	add	x9, x11, x26
	add	x14, x8, x9
	add	x9, x11, x25
	add	x4, x8, x9
	add	x9, x11, x10
	add	x6, x8, x9
	add	x9, x11, x23
	add	x7, x8, x9
	add	x5, x8, x23
	add	x9, x8, x10
	add	x12, x8, x25
	add	x10, x8, x26
	add	x20, x8, x27
	add	x13, x8, x28
	add	x0, x8, x30
LBB2_97:                                ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w22, [x8, x21]
	orr	w22, w22, #0x8
	strb	w22, [x8, x21]
	ldrb	w22, [x0, x21]
	orr	w22, w22, #0x1
	strb	w22, [x0, x21]
	ldrb	w22, [x13, x21]
	orr	w22, w22, #0x20
	strb	w22, [x13, x21]
	ldrb	w22, [x20, x21]
	orr	w22, w22, #0x4
	strb	w22, [x20, x21]
	ldrb	w22, [x10, x21]
	orr	w22, w22, #0x80
	strb	w22, [x10, x21]
	ldrb	w22, [x12, x21]
	orr	w22, w22, #0x10
	strb	w22, [x12, x21]
	ldrb	w22, [x9, x21]
	orr	w22, w22, #0x2
	strb	w22, [x9, x21]
	ldrb	w22, [x5, x21]
	orr	w22, w22, #0x40
	strb	w22, [x5, x21]
	ldrb	w22, [x3, x21]
	orr	w22, w22, #0x8
	strb	w22, [x3, x21]
	ldrb	w22, [x17, x21]
	orr	w22, w22, #0x1
	strb	w22, [x17, x21]
	ldrb	w22, [x15, x21]
	orr	w22, w22, #0x20
	strb	w22, [x15, x21]
	ldrb	w22, [x16, x21]
	orr	w22, w22, #0x4
	strb	w22, [x16, x21]
	ldrb	w22, [x14, x21]
	orr	w22, w22, #0x80
	strb	w22, [x14, x21]
	ldrb	w22, [x4, x21]
	orr	w22, w22, #0x10
	strb	w22, [x4, x21]
	ldrb	w22, [x6, x21]
	orr	w22, w22, #0x2
	strb	w22, [x6, x21]
	ldrb	w22, [x7, x21]
	orr	w22, w22, #0x40
	strb	w22, [x7, x21]
	add	x21, x21, x24
	cmp	x21, x2
	b.lt	LBB2_97
LBB2_98:                                ;   in Loop: Header=BB2_3 Depth=1
	cmp	x21, x1
	b.ge	LBB2_100
; %bb.99:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x8, x21
	ldrb	w10, [x9]
	orr	w10, w10, #0x8
	strb	w10, [x9]
	ldrb	w10, [x9, x30]
	orr	w10, w10, #0x1
	strb	w10, [x9, x30]
	ldrb	w10, [x9, x28]
	orr	w10, w10, #0x20
	strb	w10, [x9, x28]
	ldrb	w10, [x9, x27]
	orr	w10, w10, #0x4
	strb	w10, [x9, x27]
	ldrb	w10, [x9, x26]
	orr	w10, w10, #0x80
	strb	w10, [x9, x26]
	ldrb	w10, [x9, x25]
	orr	w10, w10, #0x10
	strb	w10, [x9, x25]
	ldr	x12, [sp, #8]                   ; 8-byte Folded Reload
	ldrb	w10, [x9, x12]
	orr	w10, w10, #0x2
	strb	w10, [x9, x12]
	ldrb	w10, [x9, x23]
	orr	w10, w10, #0x40
	strb	w10, [x9, x23]
	add	x21, x21, x11
LBB2_100:                               ;   in Loop: Header=BB2_3 Depth=1
	ldp	x3, x14, [sp, #16]              ; 16-byte Folded Reload
	mov	x0, #-9223372036854775808       ; =0x8000000000000000
	mov	w4, #146                        ; =0x92
	mov	w5, #36                         ; =0x24
	mov	w6, #1                          ; =0x1
	mov	w7, #73                         ; =0x49
	orr	x9, x19, x21, lsl #3
LBB2_101:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	cmp	x9, x14
	b.ge	LBB2_1
; %bb.102:                              ;   in Loop: Header=BB2_101 Depth=2
	and	x10, x9, #0x7
	asr	x12, x9, #3
	ldrb	w13, [x8, x12]
	lsl	w10, w6, w10
	orr	w10, w10, w13
	strb	w10, [x8, x12]
	add	x9, x9, x11
	b	LBB2_101
LBB2_103:                               ;   in Loop: Header=BB2_3 Depth=1
	tbnz	w9, #0, LBB2_514
; %bb.104:                              ;   in Loop: Header=BB2_3 Depth=1
	lsl	x24, x11, #1
	adds	x9, x19, x24
	b.vs	LBB2_517
; %bb.105:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x14, x11, x11, lsl #1
	adds	x10, x19, x14
	b.vs	LBB2_521
; %bb.106:                              ;   in Loop: Header=BB2_3 Depth=1
	adds	x12, x19, x11, lsl #2
	b.vs	LBB2_526
; %bb.107:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x13, x11, x11, lsl #2
	adds	x13, x19, x13
	b.vs	LBB2_530
; %bb.108:                              ;   in Loop: Header=BB2_3 Depth=1
	adds	x14, x19, x14, lsl #1
	b.vs	LBB2_533
; %bb.109:                              ;   in Loop: Header=BB2_3 Depth=1
	lsl	x15, x11, #3
	sub	x15, x15, x11
	mov	w16, #7                         ; =0x7
	smulh	x16, x11, x16
	cmp	x16, x15, asr #63
	b.ne	LBB2_536
; %bb.110:                              ;   in Loop: Header=BB2_3 Depth=1
	adds	x15, x19, x15
	b.vs	LBB2_540
; %bb.111:                              ;   in Loop: Header=BB2_3 Depth=1
	asr	x23, x15, #3
	ldr	x15, [sp, #32]                  ; 8-byte Folded Reload
	subs	x1, x15, x23
	b.vs	LBB2_545
; %bb.112:                              ;   in Loop: Header=BB2_3 Depth=1
	subs	x2, x1, x11
	b.vs	LBB2_549
; %bb.113:                              ;   in Loop: Header=BB2_3 Depth=1
	asr	x30, x22, #3
	asr	x28, x9, #3
	asr	x27, x10, #3
	asr	x26, x12, #3
	asr	x25, x13, #3
	asr	x10, x14, #3
	asr	x21, x21, #3
	cmp	x21, x2
	str	x10, [sp, #8]                   ; 8-byte Folded Spill
	b.ge	LBB2_116
; %bb.114:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x3, x8, x11
	add	x9, x11, x30
	add	x17, x8, x9
	add	x9, x11, x28
	add	x15, x8, x9
	add	x9, x11, x27
	add	x16, x8, x9
	add	x9, x11, x26
	add	x14, x8, x9
	add	x9, x11, x25
	add	x4, x8, x9
	add	x9, x11, x10
	add	x6, x8, x9
	add	x9, x11, x23
	add	x7, x8, x9
	add	x5, x8, x23
	add	x9, x8, x10
	add	x12, x8, x25
	add	x10, x8, x26
	add	x20, x8, x27
	add	x13, x8, x28
	add	x0, x8, x30
LBB2_115:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w22, [x8, x21]
	orr	w22, w22, #0x80
	strb	w22, [x8, x21]
	ldrb	w22, [x0, x21]
	orr	w22, w22, #0x40
	strb	w22, [x0, x21]
	ldrb	w22, [x13, x21]
	orr	w22, w22, #0x20
	strb	w22, [x13, x21]
	ldrb	w22, [x20, x21]
	orr	w22, w22, #0x10
	strb	w22, [x20, x21]
	ldrb	w22, [x10, x21]
	orr	w22, w22, #0x8
	strb	w22, [x10, x21]
	ldrb	w22, [x12, x21]
	orr	w22, w22, #0x4
	strb	w22, [x12, x21]
	ldrb	w22, [x9, x21]
	orr	w22, w22, #0x2
	strb	w22, [x9, x21]
	ldrb	w22, [x5, x21]
	orr	w22, w22, #0x1
	strb	w22, [x5, x21]
	ldrb	w22, [x3, x21]
	orr	w22, w22, #0x80
	strb	w22, [x3, x21]
	ldrb	w22, [x17, x21]
	orr	w22, w22, #0x40
	strb	w22, [x17, x21]
	ldrb	w22, [x15, x21]
	orr	w22, w22, #0x20
	strb	w22, [x15, x21]
	ldrb	w22, [x16, x21]
	orr	w22, w22, #0x10
	strb	w22, [x16, x21]
	ldrb	w22, [x14, x21]
	orr	w22, w22, #0x8
	strb	w22, [x14, x21]
	ldrb	w22, [x4, x21]
	orr	w22, w22, #0x4
	strb	w22, [x4, x21]
	ldrb	w22, [x6, x21]
	orr	w22, w22, #0x2
	strb	w22, [x6, x21]
	ldrb	w22, [x7, x21]
	orr	w22, w22, #0x1
	strb	w22, [x7, x21]
	add	x21, x21, x24
	cmp	x21, x2
	b.lt	LBB2_115
LBB2_116:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x21, x1
	b.ge	LBB2_118
; %bb.117:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x8, x21
	ldrb	w10, [x9]
	orr	w10, w10, #0x80
	strb	w10, [x9]
	ldrb	w10, [x9, x30]
	orr	w10, w10, #0x40
	strb	w10, [x9, x30]
	ldrb	w10, [x9, x28]
	orr	w10, w10, #0x20
	strb	w10, [x9, x28]
	ldrb	w10, [x9, x27]
	orr	w10, w10, #0x10
	strb	w10, [x9, x27]
	ldrb	w10, [x9, x26]
	orr	w10, w10, #0x8
	strb	w10, [x9, x26]
	ldrb	w10, [x9, x25]
	orr	w10, w10, #0x4
	strb	w10, [x9, x25]
	ldr	x12, [sp, #8]                   ; 8-byte Folded Reload
	ldrb	w10, [x9, x12]
	orr	w10, w10, #0x2
	strb	w10, [x9, x12]
	ldrb	w10, [x9, x23]
	orr	w10, w10, #0x1
	strb	w10, [x9, x23]
	add	x21, x21, x11
LBB2_118:                               ;   in Loop: Header=BB2_3 Depth=1
	ldp	x3, x14, [sp, #16]              ; 16-byte Folded Reload
	mov	x0, #-9223372036854775808       ; =0x8000000000000000
	mov	w4, #146                        ; =0x92
	mov	w5, #36                         ; =0x24
	mov	w6, #1                          ; =0x1
	mov	w7, #73                         ; =0x49
	orr	x9, x19, x21, lsl #3
	cmp	x9, x14
	b.ge	LBB2_1
LBB2_119:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x10, x9, #0x7
	asr	x12, x9, #3
	ldrb	w13, [x8, x12]
	lsl	w10, w6, w10
	orr	w10, w10, w13
	strb	w10, [x8, x12]
	add	x9, x9, x11
	cmp	x9, x14
	b.lt	LBB2_119
	b	LBB2_1
LBB2_120:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #91
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.121:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #4
	b	LBB2_123
LBB2_122:                               ;   in Loop: Header=BB2_123 Depth=2
	add	x9, x23, #91
	add	x1, x1, #1456
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_123:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_125 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_125
LBB2_124:                               ;   in Loop: Header=BB2_125 Depth=3
	str	q17, [x1, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #91
	b.eq	LBB2_122
LBB2_125:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_123 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x1, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #26647                     ; =0x6817
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #6
	mov	w12, #91                        ; =0x5b
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x15, x9, #6, #10
	add	x16, sp, #480
	and	x12, x12, #0x8
	orr	x12, x16, x12
	bfi	x16, x15, #3, #1
	str	q17, [sp, #480]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x16]
	ldr	q17, [sp, #480]
	cmp	w10, #36
	b.hi	LBB2_124
; %bb.126:                              ;   in Loop: Header=BB2_125 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #91
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #464
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #464]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #464]
	b	LBB2_124
LBB2_127:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #101
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.128:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_130
LBB2_129:                               ;   in Loop: Header=BB2_130 Depth=2
	add	x9, x23, #101
	add	x15, x15, #1616
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_130:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_132 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_132
LBB2_131:                               ;   in Loop: Header=BB2_132 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #101
	b.eq	LBB2_129
LBB2_132:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_130 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #5191                      ; =0x1447
	mul	w10, w10, w12
	lsr	w10, w10, #19
	mov	w12, #101                       ; =0x65
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #640
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #640]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #640]
	cmp	w10, #26
	b.hi	LBB2_131
; %bb.133:                              ;   in Loop: Header=BB2_132 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #101
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #624
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #624]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #624]
	b	LBB2_131
LBB2_134:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #93
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.135:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #4
	b	LBB2_137
LBB2_136:                               ;   in Loop: Header=BB2_137 Depth=2
	add	x9, x23, #93
	add	x1, x1, #1488
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_137:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_139 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_139
LBB2_138:                               ;   in Loop: Header=BB2_139 Depth=3
	str	q17, [x1, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #93
	b.eq	LBB2_136
LBB2_139:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_137 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x1, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #24665                     ; =0x6059
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #6
	mov	w12, #93                        ; =0x5d
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x15, x9, #6, #10
	add	x16, sp, #512
	and	x12, x12, #0x8
	orr	x12, x16, x12
	bfi	x16, x15, #3, #1
	str	q17, [sp, #512]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x16]
	ldr	q17, [sp, #512]
	cmp	w10, #34
	b.hi	LBB2_138
; %bb.140:                              ;   in Loop: Header=BB2_139 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #93
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #496
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #496]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #496]
	b	LBB2_138
LBB2_141:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #85
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.142:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_144
LBB2_143:                               ;   in Loop: Header=BB2_144 Depth=2
	add	x9, x23, #85
	add	x15, x15, #1360
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_144:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_146 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_146
LBB2_145:                               ;   in Loop: Header=BB2_146 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #85
	b.eq	LBB2_143
LBB2_146:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_144 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #49345                     ; =0xc0c1
	mul	w10, w10, w12
	lsr	w10, w10, #22
	mov	w12, #85                        ; =0x55
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #384
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #384]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #384]
	cmp	w10, #42
	b.hi	LBB2_145
; %bb.147:                              ;   in Loop: Header=BB2_146 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #85
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #368
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #368]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #368]
	b	LBB2_145
LBB2_148:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #97
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.149:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #4
	b	LBB2_151
LBB2_150:                               ;   in Loop: Header=BB2_151 Depth=2
	add	x9, x23, #97
	add	x1, x1, #1552
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_151:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_153 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_153
LBB2_152:                               ;   in Loop: Header=BB2_153 Depth=3
	str	q17, [x1, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #97
	b.eq	LBB2_150
LBB2_153:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_151 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x1, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #20945                     ; =0x51d1
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #6
	mov	w12, #97                        ; =0x61
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x15, x9, #6, #10
	add	x16, sp, #576
	and	x12, x12, #0x8
	orr	x12, x16, x12
	bfi	x16, x15, #3, #1
	str	q17, [sp, #576]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x16]
	ldr	q17, [sp, #576]
	cmp	w10, #30
	b.hi	LBB2_152
; %bb.154:                              ;   in Loop: Header=BB2_153 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #97
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #560
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #560]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #560]
	b	LBB2_152
LBB2_155:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #103
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.156:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_158
LBB2_157:                               ;   in Loop: Header=BB2_158 Depth=2
	add	x9, x23, #103
	add	x15, x15, #1648
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_158:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_160 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_160
LBB2_159:                               ;   in Loop: Header=BB2_160 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #103
	b.eq	LBB2_157
LBB2_160:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_158 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #20361                     ; =0x4f89
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #103                       ; =0x67
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #672
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #672]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #672]
	cmp	w10, #24
	b.hi	LBB2_159
; %bb.161:                              ;   in Loop: Header=BB2_160 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #103
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #656
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #656]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #656]
	b	LBB2_159
LBB2_162:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #89
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.163:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #4
	b	LBB2_165
LBB2_164:                               ;   in Loop: Header=BB2_165 Depth=2
	add	x9, x23, #89
	add	x1, x1, #1424
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_165:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_167 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_167
LBB2_166:                               ;   in Loop: Header=BB2_167 Depth=3
	str	q17, [x1, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #89
	b.eq	LBB2_164
LBB2_167:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_165 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x1, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #28719                     ; =0x702f
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #6
	mov	w12, #89                        ; =0x59
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x15, x9, #6, #10
	add	x16, sp, #448
	and	x12, x12, #0x8
	orr	x12, x16, x12
	bfi	x16, x15, #3, #1
	str	q17, [sp, #448]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x16]
	ldr	q17, [sp, #448]
	cmp	w10, #38
	b.hi	LBB2_166
; %bb.168:                              ;   in Loop: Header=BB2_167 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #89
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #432
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #432]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #432]
	b	LBB2_166
LBB2_169:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #109
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.170:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_172
LBB2_171:                               ;   in Loop: Header=BB2_172 Depth=2
	add	x9, x23, #109
	add	x15, x15, #1744
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_172:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_174 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_174
LBB2_173:                               ;   in Loop: Header=BB2_174 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #109
	b.eq	LBB2_171
LBB2_174:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_172 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #2405                      ; =0x965
	mul	w10, w10, w12
	lsr	w10, w10, #18
	mov	w12, #109                       ; =0x6d
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #768
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #768]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #768]
	cmp	w10, #18
	b.hi	LBB2_173
; %bb.175:                              ;   in Loop: Header=BB2_174 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #109
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #752
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #752]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #752]
	b	LBB2_173
LBB2_176:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #75
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.177:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #4
	b	LBB2_179
LBB2_178:                               ;   in Loop: Header=BB2_179 Depth=2
	add	x9, x23, #75
	add	x1, x1, #1200
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_179:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_181 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_181
LBB2_180:                               ;   in Loop: Header=BB2_181 Depth=3
	str	q17, [x1, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #75
	b.eq	LBB2_178
LBB2_181:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_179 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x1, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #46313                     ; =0xb4e9
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	ubfx	w10, w10, #6, #10
	mov	w12, #75                        ; =0x4b
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x15, x9, #6, #10
	add	x16, sp, #224
	and	x12, x12, #0x8
	orr	x12, x16, x12
	bfi	x16, x15, #3, #1
	str	q17, [sp, #224]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x16]
	ldr	q17, [sp, #224]
	cmp	w10, #52
	b.hi	LBB2_180
; %bb.182:                              ;   in Loop: Header=BB2_181 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #75
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #208
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #208]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #208]
	b	LBB2_180
LBB2_183:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #81
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.184:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_186
LBB2_185:                               ;   in Loop: Header=BB2_186 Depth=2
	add	x9, x23, #81
	add	x15, x15, #1296
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_186:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_188 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_188
LBB2_187:                               ;   in Loop: Header=BB2_188 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #81
	b.eq	LBB2_185
LBB2_188:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_186 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #25891                     ; =0x6523
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #81                        ; =0x51
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #320
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #320]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #320]
	cmp	w10, #46
	b.hi	LBB2_187
; %bb.189:                              ;   in Loop: Header=BB2_188 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #81
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #304
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #304]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #304]
	b	LBB2_187
LBB2_190:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #95
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.191:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_193
LBB2_192:                               ;   in Loop: Header=BB2_193 Depth=2
	add	x9, x23, #95
	add	x15, x15, #1520
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_193:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_195 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_195
LBB2_194:                               ;   in Loop: Header=BB2_195 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #95
	b.eq	LBB2_192
LBB2_195:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_193 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #44151                     ; =0xac77
	mul	w10, w10, w12
	lsr	w10, w10, #22
	mov	w12, #95                        ; =0x5f
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #544
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #544]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #544]
	cmp	w10, #32
	b.hi	LBB2_194
; %bb.196:                              ;   in Loop: Header=BB2_195 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #95
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #528
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #528]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #528]
	b	LBB2_194
LBB2_197:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #99
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.198:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_200
LBB2_199:                               ;   in Loop: Header=BB2_200 Depth=2
	add	x9, x23, #99
	add	x15, x15, #1584
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_200:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_202 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_202
LBB2_201:                               ;   in Loop: Header=BB2_202 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #99
	b.eq	LBB2_199
LBB2_202:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_200 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #42367                     ; =0xa57f
	mul	w10, w10, w12
	lsr	w10, w10, #22
	mov	w12, #99                        ; =0x63
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #608
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #608]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #608]
	cmp	w10, #28
	b.hi	LBB2_201
; %bb.203:                              ;   in Loop: Header=BB2_202 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #99
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #592
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #592]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #592]
	b	LBB2_201
LBB2_204:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #69
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.205:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #4
	b	LBB2_207
LBB2_206:                               ;   in Loop: Header=BB2_207 Depth=2
	add	x9, x23, #69
	add	x1, x1, #1104
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_207:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_209 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_209
LBB2_208:                               ;   in Loop: Header=BB2_209 Depth=3
	str	q17, [x1, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #69
	b.eq	LBB2_206
LBB2_209:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_207 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x1, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #56039                     ; =0xdae7
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	ubfx	w10, w10, #6, #10
	mov	w12, #69                        ; =0x45
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x15, x9, #6, #10
	add	x16, sp, #128
	and	x12, x12, #0x8
	orr	x12, x16, x12
	bfi	x16, x15, #3, #1
	str	q17, [sp, #128]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x16]
	ldr	q17, [sp, #128]
	cmp	w10, #58
	b.hi	LBB2_208
; %bb.210:                              ;   in Loop: Header=BB2_209 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #69
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #112
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #112]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #112]
	b	LBB2_208
LBB2_211:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #77
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.212:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_214
LBB2_213:                               ;   in Loop: Header=BB2_214 Depth=2
	add	x9, x23, #77
	add	x15, x15, #1232
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_214:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_216 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_216
LBB2_215:                               ;   in Loop: Header=BB2_216 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #77
	b.eq	LBB2_213
LBB2_216:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_214 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #6809                      ; =0x1a99
	mul	w10, w10, w12
	lsr	w10, w10, #19
	mov	w12, #77                        ; =0x4d
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #256
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #256]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #256]
	cmp	w10, #50
	b.hi	LBB2_215
; %bb.217:                              ;   in Loop: Header=BB2_216 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #77
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #240
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #240]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #240]
	b	LBB2_215
LBB2_218:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #67
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.219:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_221
LBB2_220:                               ;   in Loop: Header=BB2_221 Depth=2
	add	x9, x23, #67
	add	x15, x15, #1072
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_221:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_223 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_223
LBB2_222:                               ;   in Loop: Header=BB2_223 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #67
	b.eq	LBB2_220
LBB2_223:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_221 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #31301                     ; =0x7a45
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #67                        ; =0x43
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #96
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #96]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #96]
	cmp	w10, #60
	b.hi	LBB2_222
; %bb.224:                              ;   in Loop: Header=BB2_223 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #67
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #80
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #80]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #80]
	b	LBB2_222
LBB2_225:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #83
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.226:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_228
LBB2_227:                               ;   in Loop: Header=BB2_228 Depth=2
	add	x9, x23, #83
	add	x15, x15, #1328
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_228:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_230 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_230
LBB2_229:                               ;   in Loop: Header=BB2_230 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #83
	b.eq	LBB2_227
LBB2_230:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_228 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #25267                     ; =0x62b3
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #83                        ; =0x53
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #352
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #352]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #352]
	cmp	w10, #44
	b.hi	LBB2_229
; %bb.231:                              ;   in Loop: Header=BB2_230 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #83
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #336
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #336]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #336]
	b	LBB2_229
LBB2_232:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #79
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.233:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_235
LBB2_234:                               ;   in Loop: Header=BB2_235 Depth=2
	add	x9, x23, #79
	add	x15, x15, #1264
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_235:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_237 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_237
LBB2_236:                               ;   in Loop: Header=BB2_237 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #79
	b.eq	LBB2_234
LBB2_237:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_235 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #53093                     ; =0xcf65
	mul	w10, w10, w12
	lsr	w10, w10, #22
	mov	w12, #79                        ; =0x4f
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #288
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #288]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #288]
	cmp	w10, #48
	b.hi	LBB2_236
; %bb.238:                              ;   in Loop: Header=BB2_237 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #79
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #272
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #272]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #272]
	b	LBB2_236
LBB2_239:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #73
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.240:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_242
LBB2_241:                               ;   in Loop: Header=BB2_242 Depth=2
	add	x9, x23, #73
	add	x15, x15, #1168
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_242:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_244 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_244
LBB2_243:                               ;   in Loop: Header=BB2_244 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #73
	b.eq	LBB2_241
LBB2_244:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_242 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #57457                     ; =0xe071
	mul	w10, w10, w12
	lsr	w10, w10, #22
	mov	w12, #73                        ; =0x49
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #192
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #192]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #192]
	cmp	w10, #54
	b.hi	LBB2_243
; %bb.245:                              ;   in Loop: Header=BB2_244 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #73
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #176
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #176]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #176]
	b	LBB2_243
LBB2_246:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #71
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.247:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_249
LBB2_248:                               ;   in Loop: Header=BB2_249 Depth=2
	add	x9, x23, #71
	add	x15, x15, #1136
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_249:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_251 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_251
LBB2_250:                               ;   in Loop: Header=BB2_251 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #71
	b.eq	LBB2_248
LBB2_251:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_249 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #59075                     ; =0xe6c3
	mul	w10, w10, w12
	lsr	w10, w10, #22
	mov	w12, #71                        ; =0x47
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #160
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #160]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #160]
	cmp	w10, #56
	b.hi	LBB2_250
; %bb.252:                              ;   in Loop: Header=BB2_251 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #71
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #144
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #144]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #144]
	b	LBB2_250
LBB2_253:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #87
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.254:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_256
LBB2_255:                               ;   in Loop: Header=BB2_256 Depth=2
	add	x9, x23, #87
	add	x15, x15, #1392
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_256:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_258 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_258
LBB2_257:                               ;   in Loop: Header=BB2_258 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #87
	b.eq	LBB2_255
LBB2_258:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_256 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #48211                     ; =0xbc53
	mul	w10, w10, w12
	lsr	w10, w10, #22
	mov	w12, #87                        ; =0x57
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #416
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #416]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #416]
	cmp	w10, #40
	b.hi	LBB2_257
; %bb.259:                              ;   in Loop: Header=BB2_258 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #87
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #400
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #400]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #400]
	b	LBB2_257
LBB2_260:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #105
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.261:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_263
LBB2_262:                               ;   in Loop: Header=BB2_263 Depth=2
	add	x9, x23, #105
	add	x15, x15, #1680
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_263:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_265 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_265
LBB2_264:                               ;   in Loop: Header=BB2_265 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #105
	b.eq	LBB2_262
LBB2_265:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_263 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #19973                     ; =0x4e05
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #105                       ; =0x69
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #704
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #704]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #704]
	cmp	w10, #22
	b.hi	LBB2_264
; %bb.266:                              ;   in Loop: Header=BB2_265 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #105
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #688
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #688]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #688]
	b	LBB2_264
LBB2_267:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #107
	cmp	x22, x9
	b.lt	LBB2_275
; %bb.268:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #4
	b	LBB2_270
LBB2_269:                               ;   in Loop: Header=BB2_270 Depth=2
	add	x9, x23, #107
	add	x1, x1, #1712
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_270:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_272 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_272
LBB2_271:                               ;   in Loop: Header=BB2_272 Depth=3
	str	q17, [x1, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #107
	b.eq	LBB2_269
LBB2_272:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_270 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x1, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #12863                     ; =0x323f
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #6
	mov	w12, #107                       ; =0x6b
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x15, x9, #6, #10
	add	x16, sp, #736
	and	x12, x12, #0x8
	orr	x12, x16, x12
	bfi	x16, x15, #3, #1
	str	q17, [sp, #736]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x16]
	ldr	q17, [sp, #736]
	cmp	w10, #20
	b.hi	LBB2_271
; %bb.273:                              ;   in Loop: Header=BB2_272 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #107
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #720
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #720]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #720]
	b	LBB2_271
LBB2_274:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #111
	cmp	x22, x9
	b.ge	LBB2_479
LBB2_275:                               ;   in Loop: Header=BB2_3 Depth=1
	mov	x9, #-72057594037927936         ; =0xff00000000000000
	add	x9, x23, x9
	lsr	x9, x9, #57
	cmp	x9, #127
	b.lo	LBB2_510
; %bb.276:                              ;   in Loop: Header=BB2_3 Depth=1
	lsl	x9, x23, #7
	cmp	x9, x21
	b.ge	LBB2_279
LBB2_277:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x10, x9, #0x7
	mov	w12, #1                         ; =0x1
	lsl	w10, w12, w10
	asr	x12, x9, #3
	ldrb	w13, [x19, x12]
	orr	w10, w10, w13
	strb	w10, [x19, x12]
	adds	x10, x9, x11
	b.vs	LBB2_501
; %bb.278:                              ;   in Loop: Header=BB2_277 Depth=2
	add	x9, x9, x11
	cmp	x10, x21
	b.lt	LBB2_277
LBB2_279:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x11, x11, #2
	b	LBB2_2
LBB2_280:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #51
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.281:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_282:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_283 Depth 3
                                        ;         Child Loop BB2_284 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_283:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_282 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_284 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #41121                     ; =0xa0a1
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #51                        ; =0x33
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #13
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #13                         ; =0xd
	cmp	x13, #13
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #41121                     ; =0xa0a1
	movk	x10, #41120, lsl #16
	movk	x10, #41120, lsl #32
	movk	x10, #41120, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh20:
	adrp	x10, lCPI2_7@PAGE
Lloh21:
	ldr	q20, [x10, lCPI2_7@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_284:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_282 Depth=2
                                        ;       Parent Loop BB2_283 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #102                       ; =0x66
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_284
; %bb.285:                              ;   in Loop: Header=BB2_283 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #51
	b.ne	LBB2_283
; %bb.286:                              ;   in Loop: Header=BB2_282 Depth=2
	add	x9, x23, #51
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_282
	b	LBB2_475
LBB2_287:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #41
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.288:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_289:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_290 Depth 3
                                        ;         Child Loop BB2_291 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_290:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_289 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_291 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #36765                     ; =0x8f9d
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	ubfx	w10, w10, #5, #11
	mov	w12, #41                        ; =0x29
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #23
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #23                         ; =0x17
	cmp	x13, #23
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #52749                     ; =0xce0d
	movk	x10, #57543, lsl #16
	movk	x10, #3196, lsl #32
	movk	x10, #51150, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh22:
	adrp	x10, lCPI2_12@PAGE
Lloh23:
	ldr	q20, [x10, lCPI2_12@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_291:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_289 Depth=2
                                        ;       Parent Loop BB2_290 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #82                        ; =0x52
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_291
; %bb.292:                              ;   in Loop: Header=BB2_290 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #41
	b.ne	LBB2_290
; %bb.293:                              ;   in Loop: Header=BB2_289 Depth=2
	add	x9, x23, #41
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_289
	b	LBB2_475
LBB2_294:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #25
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.295:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
LBB2_296:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_297 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
LBB2_297:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_296 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w14, #6
	mov	w10, #28836                     ; =0x70a4
	movk	w10, #2621, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	mov	w12, #25                        ; =0x19
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	cmp	w9, #0
	csel	w9, wzr, w10, eq
	mov	w10, #38                        ; =0x26
	sub	x10, x10, x9
	mov	x12, #15729                     ; =0x3d71
	movk	x12, #55050, lsl #16
	movk	x12, #28835, lsl #32
	movk	x12, #2621, lsl #48
	umulh	x10, x10, x12
	add	x12, x10, #1
	dup.2d	v17, x12
	dup.2d	v18, x9
	ldr	d19, [x1, x14, lsl #3]
	add	w9, w10, #3
	and	x9, x9, #0x6
Lloh24:
	adrp	x10, lCPI2_20@PAGE
Lloh25:
	ldr	q20, [x10, lCPI2_20@PAGEOFF]
	ushl.2d	v20, v20, v18
	orr.16b	v20, v20, v19
	fmov	d21, x9
	mov	w10, #2                         ; =0x2
	cmp	x9, #2
	csel	x9, xzr, x10, eq
	fmov	d22, x10
	cmeq.2d	v21, v21, v22
	dup.2d	v21, v21[0]
	mov	x10, #1                         ; =0x1
	movk	x10, #4, lsl #48
	fmov	d22, x10
	ushl.2d	v18, v22, v18
	orr.16b	v18, v18, v19
	bit.16b	v18, v20, v21
	dup.2d	v22, x9
	bif.16b	v19, v20, v21
	ldr	q20, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v22, v20
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x14, lsl #3]
	add	x14, x14, #1
	cmp	x14, #25
	b.ne	LBB2_297
; %bb.298:                              ;   in Loop: Header=BB2_296 Depth=2
	add	x9, x23, #25
	add	x1, x1, #200
	cmp	x22, x9
	b.ge	LBB2_296
	b	LBB2_475
LBB2_299:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #33
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.300:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_301:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_302 Depth 3
                                        ;         Child Loop BB2_303 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_302:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_301 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_303 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #63551                     ; =0xf83f
	mul	w10, w10, w12
	lsr	w10, w10, #21
	add	w10, w10, w10, lsl #5
	mov	w12, #33                        ; =0x21
	sub	w9, w9, w10
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #31
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	tst	x9, #0xffe0
	mov	w9, #31                         ; =0x1f
	csel	x9, x13, x9, ne
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #33761                     ; =0x83e1
	movk	x10, #15887, lsl #16
	movk	x10, #57592, lsl #32
	movk	x10, #3971, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #1
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh26:
	adrp	x10, lCPI2_16@PAGE
Lloh27:
	ldr	q20, [x10, lCPI2_16@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_303:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_301 Depth=2
                                        ;       Parent Loop BB2_302 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #66                        ; =0x42
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_303
; %bb.304:                              ;   in Loop: Header=BB2_302 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #33
	b.ne	LBB2_302
; %bb.305:                              ;   in Loop: Header=BB2_301 Depth=2
	add	x9, x23, #33
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_301
	b	LBB2_475
LBB2_306:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #37
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.307:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_308:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_309 Depth 3
                                        ;         Child Loop BB2_310 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_309:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_308 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_310 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #7085                      ; =0x1bad
	mul	w10, w10, w12
	lsr	w10, w10, #18
	mov	w12, #37                        ; =0x25
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #27
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #27                         ; =0x1b
	cmp	x13, #27
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #31883                     ; =0x7c8b
	movk	x10, #3542, lsl #16
	movk	x10, #51366, lsl #32
	movk	x10, #56679, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh28:
	adrp	x10, lCPI2_14@PAGE
Lloh29:
	ldr	q20, [x10, lCPI2_14@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_310:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_308 Depth=2
                                        ;       Parent Loop BB2_309 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #74                        ; =0x4a
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_310
; %bb.311:                              ;   in Loop: Header=BB2_309 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #37
	b.ne	LBB2_309
; %bb.312:                              ;   in Loop: Header=BB2_308 Depth=2
	add	x9, x23, #37
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_308
	b	LBB2_475
LBB2_313:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #29
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.314:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
LBB2_315:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_316 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
LBB2_316:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_315 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w14, #6
	mov	w10, #56497                     ; =0xdcb1
	movk	w10, #2259, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	mov	w12, #29                        ; =0x1d
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	cmp	w9, #0
	csel	w9, wzr, w10, eq
	mov	w10, #34                        ; =0x22
	sub	x10, x10, x9
	mov	x12, #51977                     ; =0xcb09
	movk	x12, #36157, lsl #16
	movk	x12, #56496, lsl #32
	movk	x12, #2259, lsl #48
	umulh	x10, x10, x12
	add	x12, x10, #1
	dup.2d	v17, x12
	dup.2d	v18, x9
	ldr	d19, [x1, x14, lsl #3]
	add	w9, w10, #3
	and	x9, x9, #0x6
Lloh30:
	adrp	x10, lCPI2_18@PAGE
Lloh31:
	ldr	q20, [x10, lCPI2_18@PAGEOFF]
	ushl.2d	v20, v20, v18
	orr.16b	v20, v20, v19
	fmov	d21, x9
	mov	w10, #2                         ; =0x2
	cmp	x9, #2
	csel	x9, xzr, x10, eq
	fmov	d22, x10
	cmeq.2d	v21, v21, v22
	dup.2d	v21, v21[0]
	mov	x10, #1                         ; =0x1
	movk	x10, #1024, lsl #48
	fmov	d22, x10
	ushl.2d	v18, v22, v18
	orr.16b	v18, v18, v19
	bit.16b	v18, v20, v21
	dup.2d	v22, x9
	bif.16b	v19, v20, v21
	ldr	q20, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v22, v20
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x14, lsl #3]
	add	x14, x14, #1
	cmp	x14, #29
	b.ne	LBB2_316
; %bb.317:                              ;   in Loop: Header=BB2_315 Depth=2
	add	x9, x23, #29
	add	x1, x1, #232
	cmp	x22, x9
	b.ge	LBB2_315
	b	LBB2_475
LBB2_318:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #43
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.319:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_320:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_321 Depth 3
                                        ;         Child Loop BB2_322 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_321:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_320 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_322 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #48771                     ; =0xbe83
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #43                        ; =0x2b
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #21
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #21                         ; =0x15
	cmp	x13, #21
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #41151                     ; =0xa0bf
	movk	x10, #59439, lsl #16
	movk	x10, #64011, lsl #32
	movk	x10, #48770, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh32:
	adrp	x10, lCPI2_11@PAGE
Lloh33:
	ldr	q20, [x10, lCPI2_11@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_322:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_320 Depth=2
                                        ;       Parent Loop BB2_321 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #86                        ; =0x56
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_322
; %bb.323:                              ;   in Loop: Header=BB2_321 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #43
	b.ne	LBB2_321
; %bb.324:                              ;   in Loop: Header=BB2_320 Depth=2
	add	x9, x23, #43
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_320
	b	LBB2_475
LBB2_325:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #21
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.326:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
LBB2_327:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_328 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
LBB2_328:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_327 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w14, #6
	mov	w10, #49933                     ; =0xc30d
	movk	w10, #3120, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	mov	w12, #21                        ; =0x15
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	cmp	w9, #0
	csel	w9, wzr, w10, eq
	mov	w10, #42                        ; =0x2a
	sub	x10, x10, x9
	mov	x12, #3121                      ; =0xc31
	movk	x12, #12483, lsl #16
	movk	x12, #49932, lsl #32
	movk	x12, #3120, lsl #48
	umulh	x10, x10, x12
	add	x12, x10, #1
	dup.2d	v17, x12
	dup.2d	v18, x9
	ldr	d19, [x1, x14, lsl #3]
	add	w9, w10, #3
	and	x9, x9, #0x6
Lloh34:
	adrp	x10, lCPI2_22@PAGE
Lloh35:
	ldr	q20, [x10, lCPI2_22@PAGEOFF]
	ushl.2d	v20, v20, v18
	orr.16b	v20, v20, v19
	fmov	d21, x9
	mov	w10, #2                         ; =0x2
	cmp	x9, #2
	csel	x9, xzr, x10, eq
	fmov	d22, x10
	cmeq.2d	v21, v21, v22
	dup.2d	v21, v21[0]
Lloh36:
	adrp	x10, lCPI2_23@PAGE
Lloh37:
	ldr	q22, [x10, lCPI2_23@PAGEOFF]
	ushl.2d	v18, v22, v18
	orr.16b	v18, v18, v19
	bit.16b	v18, v20, v21
	dup.2d	v22, x9
	bif.16b	v19, v20, v21
	ldr	q20, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v22, v20
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x14, lsl #3]
	add	x14, x14, #1
	cmp	x14, #21
	b.ne	LBB2_328
; %bb.329:                              ;   in Loop: Header=BB2_327 Depth=2
	add	x9, x23, #21
	add	x1, x1, #168
	cmp	x22, x9
	b.ge	LBB2_327
	b	LBB2_475
LBB2_330:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #49
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.331:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_332:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_333 Depth 3
                                        ;         Child Loop BB2_334 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_333:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_332 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_334 Depth 4
	add	x17, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #20063                     ; =0x4e5f
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #5
	mov	w12, #49                        ; =0x31
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #15
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	tst	x9, #0xfff0
	mov	w9, #15                         ; =0xf
	csel	x9, x13, x9, ne
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #38787                     ; =0x9783
	movk	x10, #61523, lsl #16
	movk	x10, #2674, lsl #32
	movk	x10, #20062, lsl #48
	umulh	x10, x9, x10
	sub	x9, x9, x10
	add	x9, x10, x9, lsr #1
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x17, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh38:
	adrp	x10, lCPI2_8@PAGE
Lloh39:
	ldr	q20, [x10, lCPI2_8@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_334:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_332 Depth=2
                                        ;       Parent Loop BB2_333 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #98                        ; =0x62
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_334
; %bb.335:                              ;   in Loop: Header=BB2_333 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x17, lsl #3]
	cmp	x2, #49
	b.ne	LBB2_333
; %bb.336:                              ;   in Loop: Header=BB2_332 Depth=2
	add	x9, x23, #49
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_332
	b	LBB2_475
LBB2_337:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #17
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.338:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
LBB2_339:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_340 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
LBB2_340:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_339 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w14, #6
	mov	w10, #3856                      ; =0xf10
	movk	w10, #3855, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	add	w10, w10, w10, lsl #4
	mov	w12, #17                        ; =0x11
	subs	w9, w9, w10
	sub	w9, w12, w9
	csel	w9, wzr, w9, eq
	mov	w10, #46                        ; =0x2e
	sub	x10, x10, x9
	mov	x12, #1085102592571150095       ; =0xf0f0f0f0f0f0f0f
	movk	x12, #3856
	umulh	x10, x10, x12
	add	x12, x10, #1
	dup.2d	v17, x12
	dup.2d	v18, x9
	ldr	d19, [x1, x14, lsl #3]
	add	w9, w10, #3
	and	x9, x9, #0x6
Lloh40:
	adrp	x10, lCPI2_26@PAGE
Lloh41:
	ldr	q20, [x10, lCPI2_26@PAGEOFF]
	ushl.2d	v20, v20, v18
	orr.16b	v20, v20, v19
	fmov	d21, x9
	mov	w10, #2                         ; =0x2
	cmp	x9, #2
	csel	x9, xzr, x10, eq
	fmov	d22, x10
	cmeq.2d	v21, v21, v22
	dup.2d	v21, v21[0]
Lloh42:
	adrp	x10, lCPI2_27@PAGE
Lloh43:
	ldr	q22, [x10, lCPI2_27@PAGEOFF]
	ushl.2d	v18, v22, v18
	orr.16b	v18, v18, v19
	bit.16b	v18, v20, v21
	dup.2d	v22, x9
	bif.16b	v19, v20, v21
	ldr	q20, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v22, v20
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x14, lsl #3]
	add	x14, x14, #1
	cmp	x14, #17
	b.ne	LBB2_340
; %bb.341:                              ;   in Loop: Header=BB2_339 Depth=2
	add	x9, x23, #17
	add	x1, x1, #136
	cmp	x22, x9
	b.ge	LBB2_339
	b	LBB2_475
LBB2_342:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #35
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.343:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_344:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_345 Depth 3
                                        ;         Child Loop BB2_346 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_345:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_344 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_346 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #59919                     ; =0xea0f
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #35                        ; =0x23
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #29
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #29                         ; =0x1d
	cmp	x13, #29
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #59919                     ; =0xea0f
	movk	x10, #3744, lsl #16
	movk	x10, #41194, lsl #32
	movk	x10, #59918, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh44:
	adrp	x10, lCPI2_15@PAGE
Lloh45:
	ldr	q20, [x10, lCPI2_15@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_346:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_344 Depth=2
                                        ;       Parent Loop BB2_345 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #70                        ; =0x46
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_346
; %bb.347:                              ;   in Loop: Header=BB2_345 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #35
	b.ne	LBB2_345
; %bb.348:                              ;   in Loop: Header=BB2_344 Depth=2
	add	x9, x23, #35
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_344
	b	LBB2_475
LBB2_349:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #39
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.350:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_351:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_352 Depth 3
                                        ;         Child Loop BB2_353 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_352:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_351 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_353 Depth 4
	add	x17, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #42011                     ; =0xa41b
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	ubfx	w10, w10, #5, #11
	mov	w12, #39                        ; =0x27
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #25
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #25                         ; =0x19
	cmp	x13, #25
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #42011                     ; =0xa41b
	movk	x10, #6721, lsl #16
	movk	x10, #16804, lsl #32
	movk	x10, #42010, lsl #48
	umulh	x10, x9, x10
	sub	x9, x9, x10
	add	x9, x10, x9, lsr #1
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x17, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh46:
	adrp	x10, lCPI2_13@PAGE
Lloh47:
	ldr	q20, [x10, lCPI2_13@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_353:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_351 Depth=2
                                        ;       Parent Loop BB2_352 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #78                        ; =0x4e
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_353
; %bb.354:                              ;   in Loop: Header=BB2_352 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x17, lsl #3]
	cmp	x2, #39
	b.ne	LBB2_352
; %bb.355:                              ;   in Loop: Header=BB2_351 Depth=2
	add	x9, x23, #39
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_351
	b	LBB2_475
LBB2_356:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #23
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.357:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
LBB2_358:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_359 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
LBB2_359:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_358 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w14, #6
	mov	w10, #25645                     ; =0x642d
	movk	w10, #2849, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	mov	w12, #23                        ; =0x17
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	cmp	w9, #0
	csel	w9, wzr, w10, eq
	mov	w10, #40                        ; =0x28
	sub	x10, x10, x9
	mov	x12, #45591                     ; =0xb217
	movk	x12, #34192, lsl #16
	movk	x12, #25644, lsl #32
	movk	x12, #2849, lsl #48
	umulh	x10, x10, x12
	add	x12, x10, #1
	dup.2d	v17, x12
	dup.2d	v18, x9
	ldr	d19, [x1, x14, lsl #3]
	add	w9, w10, #3
	and	x9, x9, #0x6
Lloh48:
	adrp	x10, lCPI2_21@PAGE
Lloh49:
	ldr	q20, [x10, lCPI2_21@PAGEOFF]
	ushl.2d	v20, v20, v18
	orr.16b	v20, v20, v19
	fmov	d21, x9
	mov	w10, #2                         ; =0x2
	cmp	x9, #2
	csel	x9, xzr, x10, eq
	fmov	d22, x10
	cmeq.2d	v21, v21, v22
	dup.2d	v21, v21[0]
	mov	x10, #1                         ; =0x1
	movk	x10, #16384, lsl #32
	fmov	d22, x10
	ushl.2d	v18, v22, v18
	orr.16b	v18, v18, v19
	bit.16b	v18, v20, v21
	dup.2d	v22, x9
	bif.16b	v19, v20, v21
	ldr	q20, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v22, v20
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x14, lsl #3]
	add	x14, x14, #1
	cmp	x14, #23
	b.ne	LBB2_359
; %bb.360:                              ;   in Loop: Header=BB2_358 Depth=2
	add	x9, x23, #23
	add	x1, x1, #184
	cmp	x22, x9
	b.ge	LBB2_358
	b	LBB2_475
LBB2_361:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #19
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.362:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
LBB2_363:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_364 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
LBB2_364:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_363 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w14, #6
	mov	w10, #17247                     ; =0x435f
	movk	w10, #3449, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	mov	w12, #19                        ; =0x13
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	cmp	w9, #0
	csel	w9, wzr, w10, eq
	mov	w10, #44                        ; =0x2c
	sub	x10, x10, x9
	mov	x12, #37942                     ; =0x9436
	movk	x12, #20695, lsl #16
	movk	x12, #17246, lsl #32
	movk	x12, #3449, lsl #48
	umulh	x10, x10, x12
	add	x12, x10, #1
	dup.2d	v17, x12
	dup.2d	v18, x9
	ldr	d19, [x1, x14, lsl #3]
	add	w9, w10, #3
	and	x9, x9, #0x6
Lloh50:
	adrp	x10, lCPI2_24@PAGE
Lloh51:
	ldr	q20, [x10, lCPI2_24@PAGEOFF]
	ushl.2d	v20, v20, v18
	orr.16b	v20, v20, v19
	fmov	d21, x9
	mov	w10, #2                         ; =0x2
	cmp	x9, #2
	csel	x9, xzr, x10, eq
	fmov	d22, x10
	cmeq.2d	v21, v21, v22
	dup.2d	v21, v21[0]
Lloh52:
	adrp	x10, lCPI2_25@PAGE
Lloh53:
	ldr	q22, [x10, lCPI2_25@PAGEOFF]
	ushl.2d	v18, v22, v18
	orr.16b	v18, v18, v19
	bit.16b	v18, v20, v21
	dup.2d	v22, x9
	bif.16b	v19, v20, v21
	ldr	q20, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v22, v20
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x14, lsl #3]
	add	x14, x14, #1
	cmp	x14, #19
	b.ne	LBB2_364
; %bb.365:                              ;   in Loop: Header=BB2_363 Depth=2
	add	x9, x23, #19
	add	x1, x1, #152
	cmp	x22, x9
	b.ge	LBB2_363
	b	LBB2_475
LBB2_366:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #9
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.367:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x25, x19, x23, lsl #3
	b	LBB2_369
LBB2_368:                               ;   in Loop: Header=BB2_369 Depth=2
	add	x9, x23, #9
	add	x25, x25, #72
	cmp	x22, x9
	b.lt	LBB2_475
LBB2_369:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_372 Depth 3
	mov	x1, #0                          ; =0x0
	mov	x23, x9
	b	LBB2_372
LBB2_370:                               ;   in Loop: Header=BB2_372 Depth=3
	mov	x10, #0                         ; =0x0
LBB2_371:                               ;   in Loop: Header=BB2_372 Depth=3
	add	x9, x9, #1
	dup.2d	v19, x9
	dup.2d	v20, x10
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v19, v20, v19
	bit.16b	v17, v18, v19
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x25, x1, lsl #3]
	add	x1, x1, #1
	cmp	x1, #9
	b.eq	LBB2_368
LBB2_372:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_369 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w1, #6
	mov	w10, #50973                     ; =0xc71d
	movk	w10, #7281, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	add	w10, w10, w10, lsl #3
	mov	w12, #9                         ; =0x9
	subs	w9, w9, w10
	sub	w9, w12, w9
	csel	w10, wzr, w9, eq
	mov	w9, #54                         ; =0x36
	sub	x9, x9, x10
	mov	x12, #7282                      ; =0x1c72
	movk	x12, #29127, lsl #16
	movk	x12, #50972, lsl #32
	movk	x12, #7281, lsl #48
	umulh	x9, x9, x12
	add	w12, w9, #3
	dup.2d	v19, x10
	ldr	d18, [x25, x1, lsl #3]
	and	x10, x12, #0xe
Lloh54:
	adrp	x12, lCPI2_35@PAGE
Lloh55:
	ldr	q17, [x12, lCPI2_35@PAGEOFF]
	ushl.2d	v17, v17, v19
	orr.16b	v17, v17, v18
	cmp	x10, #2
	b.eq	LBB2_370
; %bb.373:                              ;   in Loop: Header=BB2_372 Depth=3
Lloh56:
	adrp	x12, lCPI2_36@PAGE
Lloh57:
	ldr	q20, [x12, lCPI2_36@PAGEOFF]
	ushl.2d	v20, v20, v19
	orr.16b	v20, v20, v18
	cmp	x10, #4
	b.ne	LBB2_375
; %bb.374:                              ;   in Loop: Header=BB2_372 Depth=3
	mov	w10, #2                         ; =0x2
	mov.16b	v18, v17
	mov.16b	v17, v20
	b	LBB2_371
LBB2_375:                               ;   in Loop: Header=BB2_372 Depth=3
Lloh58:
	adrp	x12, lCPI2_37@PAGE
Lloh59:
	ldr	q17, [x12, lCPI2_37@PAGEOFF]
	ushl.2d	v17, v17, v19
	orr.16b	v17, v17, v18
	cmp	x10, #6
	b.ne	LBB2_377
; %bb.376:                              ;   in Loop: Header=BB2_372 Depth=3
	mov	w10, #4                         ; =0x4
	mov.16b	v18, v20
	b	LBB2_371
LBB2_377:                               ;   in Loop: Header=BB2_372 Depth=3
Lloh60:
	adrp	x10, lCPI2_38@PAGE
Lloh61:
	ldr	q20, [x10, lCPI2_38@PAGEOFF]
	ushl.2d	v19, v20, v19
	orr.16b	v19, v19, v18
	mov	w10, #6                         ; =0x6
	mov.16b	v18, v17
	mov.16b	v17, v19
	b	LBB2_371
LBB2_378:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #7
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.379:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x19, x23, lsl #3
	add	x9, x9, #32
	mov	x10, x23
LBB2_380:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
Lloh62:
	adrp	x12, lCPI2_39@PAGE
Lloh63:
	ldr	q17, [x12, lCPI2_39@PAGEOFF]
	ldp	q18, q19, [x9, #-32]
	orr.16b	v17, v18, v17
Lloh64:
	adrp	x12, lCPI2_40@PAGE
Lloh65:
	ldr	q18, [x12, lCPI2_40@PAGEOFF]
	orr.16b	v18, v19, v18
	stp	q17, q18, [x9, #-32]
	ldr	q17, [x9]
Lloh66:
	adrp	x12, lCPI2_41@PAGE
Lloh67:
	ldr	q18, [x12, lCPI2_41@PAGEOFF]
	orr.16b	v17, v17, v18
	str	q17, [x9]
	ldr	x12, [x9, #16]
	mov	x13, #33026                     ; =0x8102
	movk	x13, #8256, lsl #16
	movk	x13, #2064, lsl #32
	movk	x13, #516, lsl #48
	orr	x12, x12, x13
	str	x12, [x9, #16]
	add	x9, x9, #56
	add	x23, x10, #7
	add	x12, x10, #14
	mov	x10, x23
	cmp	x22, x12
	b.ge	LBB2_380
	b	LBB2_475
LBB2_381:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #11
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.382:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
	b	LBB2_384
LBB2_383:                               ;   in Loop: Header=BB2_384 Depth=2
	add	x9, x23, #11
	add	x1, x1, #88
	cmp	x22, x9
	b.lt	LBB2_475
LBB2_384:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_387 Depth 3
	mov	x17, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_387
LBB2_385:                               ;   in Loop: Header=BB2_387 Depth=3
	mov	x10, #0                         ; =0x0
LBB2_386:                               ;   in Loop: Header=BB2_387 Depth=3
	add	x9, x9, #1
	dup.2d	v19, x9
	dup.2d	v20, x10
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v19, v20, v19
	bif.16b	v17, v18, v19
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x17, lsl #3]
	add	x17, x17, #1
	cmp	x17, #11
	b.eq	LBB2_383
LBB2_387:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_384 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w17, #6
	mov	w10, #53621                     ; =0xd175
	movk	w10, #5957, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	mov	w12, #11                        ; =0xb
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	cmp	w9, #0
	csel	w10, wzr, w10, eq
	mov	w9, #52                         ; =0x34
	sub	x9, x9, x10
	mov	x12, #17874                     ; =0x45d2
	movk	x12, #23831, lsl #16
	movk	x12, #53620, lsl #32
	movk	x12, #5957, lsl #48
	umulh	x9, x9, x12
	add	w12, w9, #3
	dup.2d	v19, x10
	ldr	d17, [x1, x17, lsl #3]
	and	x10, x12, #0xe
Lloh68:
	adrp	x12, lCPI2_32@PAGE
Lloh69:
	ldr	q18, [x12, lCPI2_32@PAGEOFF]
	ushl.2d	v18, v18, v19
	orr.16b	v18, v18, v17
	cmp	x10, #2
	b.eq	LBB2_385
; %bb.388:                              ;   in Loop: Header=BB2_387 Depth=3
Lloh70:
	adrp	x12, lCPI2_33@PAGE
Lloh71:
	ldr	q20, [x12, lCPI2_33@PAGEOFF]
	ushl.2d	v20, v20, v19
	orr.16b	v20, v20, v17
	cmp	x10, #4
	b.ne	LBB2_390
; %bb.389:                              ;   in Loop: Header=BB2_387 Depth=3
	mov	w10, #2                         ; =0x2
	mov.16b	v17, v18
	mov.16b	v18, v20
	b	LBB2_386
LBB2_390:                               ;   in Loop: Header=BB2_387 Depth=3
Lloh72:
	adrp	x10, lCPI2_34@PAGE
Lloh73:
	ldr	q18, [x10, lCPI2_34@PAGEOFF]
	ushl.2d	v18, v18, v19
	orr.16b	v18, v18, v17
	mov	w10, #4                         ; =0x4
	mov.16b	v17, v20
	b	LBB2_386
LBB2_391:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #15
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.392:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
	b	LBB2_394
LBB2_393:                               ;   in Loop: Header=BB2_394 Depth=2
	add	x9, x23, #15
	add	x1, x1, #120
	cmp	x22, x9
	b.lt	LBB2_475
LBB2_394:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_397 Depth 3
	mov	x17, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_397
LBB2_395:                               ;   in Loop: Header=BB2_397 Depth=3
	mov	x10, #0                         ; =0x0
LBB2_396:                               ;   in Loop: Header=BB2_397 Depth=3
	add	x9, x9, #1
	dup.2d	v19, x9
	dup.2d	v20, x10
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v19, v20, v19
	bif.16b	v17, v18, v19
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x17, lsl #3]
	add	x17, x17, #1
	cmp	x17, #15
	b.eq	LBB2_393
LBB2_397:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_394 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w17, #6
	mov	w10, #4370                      ; =0x1112
	movk	w10, #4369, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	sub	w10, w10, w10, lsl #4
	adds	w9, w9, w10
	eor	w9, w9, #0xf
	csel	w10, wzr, w9, eq
	mov	w9, #48                         ; =0x30
	sub	x9, x9, x10
	mov	x12, #1229782938247303441       ; =0x1111111111111111
	movk	x12, #4370
	umulh	x9, x9, x12
	add	w12, w9, #3
	dup.2d	v19, x10
	ldr	d17, [x1, x17, lsl #3]
	and	x10, x12, #0xe
Lloh74:
	adrp	x12, lCPI2_28@PAGE
Lloh75:
	ldr	q18, [x12, lCPI2_28@PAGEOFF]
	ushl.2d	v18, v18, v19
	orr.16b	v18, v18, v17
	cmp	x10, #2
	b.eq	LBB2_395
; %bb.398:                              ;   in Loop: Header=BB2_397 Depth=3
Lloh76:
	adrp	x12, lCPI2_29@PAGE
Lloh77:
	ldr	q20, [x12, lCPI2_29@PAGEOFF]
	ushl.2d	v20, v20, v19
	orr.16b	v20, v20, v17
	cmp	x10, #4
	b.ne	LBB2_400
; %bb.399:                              ;   in Loop: Header=BB2_397 Depth=3
	mov	w10, #2                         ; =0x2
	mov.16b	v17, v18
	mov.16b	v18, v20
	b	LBB2_396
LBB2_400:                               ;   in Loop: Header=BB2_397 Depth=3
	mov	x10, #1                         ; =0x1
	movk	x10, #16384, lsl #16
	movk	x10, #4096, lsl #48
	fmov	d18, x10
	ushl.2d	v18, v18, v19
	orr.16b	v18, v18, v17
	mov	w10, #4                         ; =0x4
	mov.16b	v17, v20
	b	LBB2_396
LBB2_401:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #13
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.402:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
	b	LBB2_404
LBB2_403:                               ;   in Loop: Header=BB2_404 Depth=2
	add	x9, x23, #13
	add	x1, x1, #104
	cmp	x22, x9
	b.lt	LBB2_475
LBB2_404:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_407 Depth 3
	mov	x17, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_407
LBB2_405:                               ;   in Loop: Header=BB2_407 Depth=3
	mov	x10, #0                         ; =0x0
LBB2_406:                               ;   in Loop: Header=BB2_407 Depth=3
	add	x9, x9, #1
	dup.2d	v19, x9
	dup.2d	v20, x10
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v19, v20, v19
	bif.16b	v17, v18, v19
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x17, lsl #3]
	add	x17, x17, #1
	cmp	x17, #13
	b.eq	LBB2_403
LBB2_407:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_404 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w17, #6
	mov	w10, #15124                     ; =0x3b14
	movk	w10, #5041, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	mov	w12, #13                        ; =0xd
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	cmp	w9, #0
	csel	w10, wzr, w10, eq
	mov	w9, #50                         ; =0x32
	sub	x9, x9, x10
	mov	x12, #5042                      ; =0x13b2
	movk	x12, #45371, lsl #16
	movk	x12, #15123, lsl #32
	movk	x12, #5041, lsl #48
	umulh	x9, x9, x12
	add	w12, w9, #3
	dup.2d	v19, x10
	ldr	d17, [x1, x17, lsl #3]
	and	x10, x12, #0xe
Lloh78:
	adrp	x12, lCPI2_30@PAGE
Lloh79:
	ldr	q18, [x12, lCPI2_30@PAGEOFF]
	ushl.2d	v18, v18, v19
	orr.16b	v18, v18, v17
	cmp	x10, #2
	b.eq	LBB2_405
; %bb.408:                              ;   in Loop: Header=BB2_407 Depth=3
Lloh80:
	adrp	x12, lCPI2_31@PAGE
Lloh81:
	ldr	q20, [x12, lCPI2_31@PAGEOFF]
	ushl.2d	v20, v20, v19
	orr.16b	v20, v20, v17
	cmp	x10, #4
	b.ne	LBB2_410
; %bb.409:                              ;   in Loop: Header=BB2_407 Depth=3
	mov	w10, #2                         ; =0x2
	mov.16b	v17, v18
	mov.16b	v18, v20
	b	LBB2_406
LBB2_410:                               ;   in Loop: Header=BB2_407 Depth=3
	mov	x10, #1                         ; =0x1
	movk	x10, #1024, lsl #16
	movk	x10, #16, lsl #48
	fmov	d18, x10
	ushl.2d	v18, v18, v19
	orr.16b	v18, v18, v17
	mov	w10, #4                         ; =0x4
	mov.16b	v17, v20
	b	LBB2_406
LBB2_411:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #55
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.412:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_413:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_414 Depth 3
                                        ;         Child Loop BB2_415 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_414:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_413 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_415 Depth 4
	add	x17, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #10725                     ; =0x29e5
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #5
	mov	w12, #55                        ; =0x37
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #9
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #9                          ; =0x9
	cmp	x13, #9
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #58387                     ; =0xe413
	movk	x10, #16681, lsl #16
	movk	x10, #4766, lsl #32
	movk	x10, #10724, lsl #48
	umulh	x10, x9, x10
	sub	x9, x9, x10
	add	x9, x10, x9, lsr #1
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x17, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh82:
	adrp	x10, lCPI2_5@PAGE
Lloh83:
	ldr	q20, [x10, lCPI2_5@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_415:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_413 Depth=2
                                        ;       Parent Loop BB2_414 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #110                       ; =0x6e
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_415
; %bb.416:                              ;   in Loop: Header=BB2_414 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x17, lsl #3]
	cmp	x2, #55
	b.ne	LBB2_414
; %bb.417:                              ;   in Loop: Header=BB2_413 Depth=2
	add	x9, x23, #55
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_413
	b	LBB2_475
LBB2_418:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #27
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.419:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
LBB2_420:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_421 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
LBB2_421:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_420 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w14, #6
	mov	w10, #16991                     ; =0x425f
	movk	w10, #2427, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	mov	w12, #27                        ; =0x1b
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	cmp	w9, #0
	csel	w9, wzr, w10, eq
	mov	w10, #36                        ; =0x24
	sub	x10, x10, x9
	mov	x12, #46118                     ; =0xb426
	movk	x12, #53399, lsl #16
	movk	x12, #16990, lsl #32
	movk	x12, #2427, lsl #48
	umulh	x10, x10, x12
	add	x12, x10, #1
	dup.2d	v17, x12
	dup.2d	v18, x9
	ldr	d19, [x1, x14, lsl #3]
	add	w9, w10, #3
	and	x9, x9, #0x6
Lloh84:
	adrp	x10, lCPI2_19@PAGE
Lloh85:
	ldr	q20, [x10, lCPI2_19@PAGEOFF]
	ushl.2d	v20, v20, v18
	orr.16b	v20, v20, v19
	fmov	d21, x9
	mov	w10, #2                         ; =0x2
	cmp	x9, #2
	csel	x9, xzr, x10, eq
	fmov	d22, x10
	cmeq.2d	v21, v21, v22
	dup.2d	v21, v21[0]
	mov	x10, #1                         ; =0x1
	movk	x10, #64, lsl #48
	fmov	d22, x10
	ushl.2d	v18, v22, v18
	orr.16b	v18, v18, v19
	bit.16b	v18, v20, v21
	dup.2d	v22, x9
	bif.16b	v19, v20, v21
	ldr	q20, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v22, v20
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x14, lsl #3]
	add	x14, x14, #1
	cmp	x14, #27
	b.ne	LBB2_421
; %bb.422:                              ;   in Loop: Header=BB2_420 Depth=2
	add	x9, x23, #27
	add	x1, x1, #216
	cmp	x22, x9
	b.ge	LBB2_420
	b	LBB2_475
LBB2_423:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #59
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.424:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_425:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_426 Depth 3
                                        ;         Child Loop BB2_427 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_426:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_425 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_427 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #35545                     ; =0x8ad9
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #59                        ; =0x3b
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #5
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #5                          ; =0x5
	cmp	x13, #5
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #26659                     ; =0x6823
	movk	x10, #43320, lsl #16
	movk	x10, #62203, lsl #32
	movk	x10, #35544, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh86:
	adrp	x10, lCPI2_3@PAGE
Lloh87:
	ldr	q20, [x10, lCPI2_3@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_427:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_425 Depth=2
                                        ;       Parent Loop BB2_426 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #118                       ; =0x76
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_427
; %bb.428:                              ;   in Loop: Header=BB2_426 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #59
	b.ne	LBB2_426
; %bb.429:                              ;   in Loop: Header=BB2_425 Depth=2
	add	x9, x23, #59
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_425
	b	LBB2_475
LBB2_430:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #31
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.431:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x1, x19, x23, lsl #3
LBB2_432:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_433 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
LBB2_433:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_432 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	lsl	w9, w14, #6
	mov	w10, #4229                      ; =0x1085
	movk	w10, #2114, lsl #16
	umull	x10, w9, w10
	lsr	x10, x10, #32
	sub	w10, w10, w10, lsl #5
	adds	w9, w9, w10
	eor	w9, w9, #0x1f
	csel	w9, wzr, w9, eq
	mov	w10, #32                        ; =0x20
	sub	x10, x10, x9
	mov	x12, #16913                     ; =0x4211
	movk	x12, #8456, lsl #16
	movk	x12, #4228, lsl #32
	movk	x12, #2114, lsl #48
	umulh	x10, x10, x12
	add	x12, x10, #1
	dup.2d	v17, x12
	dup.2d	v18, x9
	ldr	d19, [x1, x14, lsl #3]
	add	w9, w10, #3
	and	x9, x9, #0x6
Lloh88:
	adrp	x10, lCPI2_17@PAGE
Lloh89:
	ldr	q20, [x10, lCPI2_17@PAGEOFF]
	ushl.2d	v20, v20, v18
	orr.16b	v20, v20, v19
	fmov	d21, x9
	mov	w10, #2                         ; =0x2
	cmp	x9, #2
	csel	x9, xzr, x10, eq
	fmov	d22, x10
	cmeq.2d	v21, v21, v22
	dup.2d	v21, v21[0]
	mov	x10, #1                         ; =0x1
	movk	x10, #16384, lsl #48
	fmov	d22, x10
	ushl.2d	v18, v22, v18
	orr.16b	v18, v18, v19
	bit.16b	v18, v20, v21
	dup.2d	v22, x9
	bif.16b	v19, v20, v21
	ldr	q20, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v22, v20
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	str	d17, [x1, x14, lsl #3]
	add	x14, x14, #1
	cmp	x14, #31
	b.ne	LBB2_433
; %bb.434:                              ;   in Loop: Header=BB2_432 Depth=2
	add	x9, x23, #31
	add	x1, x1, #248
	cmp	x22, x9
	b.ge	LBB2_432
	b	LBB2_475
LBB2_435:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #45
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.436:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_437:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_438 Depth 3
                                        ;         Child Loop BB2_439 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_438:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_437 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_439 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #11651                     ; =0x2d83
	mul	w10, w10, w12
	lsr	w10, w10, #19
	mov	w12, #45                        ; =0x2d
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #19
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #19                         ; =0x13
	cmp	x13, #19
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #11651                     ; =0x2d83
	movk	x10, #33496, lsl #16
	movk	x10, #55341, lsl #32
	movk	x10, #11650, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #3
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh90:
	adrp	x10, lCPI2_10@PAGE
Lloh91:
	ldr	q20, [x10, lCPI2_10@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_439:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_437 Depth=2
                                        ;       Parent Loop BB2_438 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #90                        ; =0x5a
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_439
; %bb.440:                              ;   in Loop: Header=BB2_438 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #45
	b.ne	LBB2_438
; %bb.441:                              ;   in Loop: Header=BB2_437 Depth=2
	add	x9, x23, #45
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_437
	b	LBB2_475
LBB2_442:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #61
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.443:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_444:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_445 Depth 3
                                        ;         Child Loop BB2_446 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_445:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_444 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_446 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #8595                      ; =0x2193
	mul	w10, w10, w12
	lsr	w10, w10, #19
	mov	w12, #61                        ; =0x3d
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #3
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	tst	x9, #0xfffc
	mov	w9, #3                          ; =0x3
	csel	x9, x13, x9, ne
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #44049                     ; =0xac11
	movk	x10, #52643, lsl #16
	movk	x10, #5371, lsl #32
	movk	x10, #3223, lsl #48
	umulh	x10, x9, x10
	sub	x9, x9, x10
	add	x9, x10, x9, lsr #1
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh92:
	adrp	x10, lCPI2_1@PAGE
Lloh93:
	ldr	q20, [x10, lCPI2_1@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_446:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_444 Depth=2
                                        ;       Parent Loop BB2_445 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #122                       ; =0x7a
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_446
; %bb.447:                              ;   in Loop: Header=BB2_445 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #61
	b.ne	LBB2_445
; %bb.448:                              ;   in Loop: Header=BB2_444 Depth=2
	add	x9, x23, #61
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_444
	b	LBB2_475
LBB2_449:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #53
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.450:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_451:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_452 Depth 3
                                        ;         Child Loop BB2_453 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_452:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_451 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_453 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #39569                     ; =0x9a91
	mul	w10, w10, w12
	lsr	w10, w10, #21
	mov	w12, #53                        ; =0x35
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #11
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #11                         ; =0xb
	cmp	x13, #11
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #4947                      ; =0x1353
	movk	x10, #46988, lsl #16
	movk	x10, #53170, lsl #32
	movk	x10, #13601, lsl #48
	umulh	x10, x9, x10
	sub	x9, x9, x10
	add	x9, x10, x9, lsr #1
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh94:
	adrp	x10, lCPI2_6@PAGE
Lloh95:
	ldr	q20, [x10, lCPI2_6@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_453:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_451 Depth=2
                                        ;       Parent Loop BB2_452 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #106                       ; =0x6a
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_453
; %bb.454:                              ;   in Loop: Header=BB2_452 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #53
	b.ne	LBB2_452
; %bb.455:                              ;   in Loop: Header=BB2_451 Depth=2
	add	x9, x23, #53
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_451
	b	LBB2_475
LBB2_456:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #47
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.457:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_458:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_459 Depth 3
                                        ;         Child Loop BB2_460 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_459:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_458 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_460 Depth 4
	add	x17, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #23705                     ; =0x5c99
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #5
	mov	w12, #47                        ; =0x2f
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #17
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	mov	w9, #17                         ; =0x11
	cmp	x13, #17
	csel	x9, x13, x9, hi
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #29283                     ; =0x7263
	movk	x10, #12549, lsl #16
	movk	x10, #33465, lsl #32
	movk	x10, #23704, lsl #48
	umulh	x10, x9, x10
	sub	x9, x9, x10
	add	x9, x10, x9, lsr #1
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x17, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh96:
	adrp	x10, lCPI2_9@PAGE
Lloh97:
	ldr	q20, [x10, lCPI2_9@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_460:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_458 Depth=2
                                        ;       Parent Loop BB2_459 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #94                        ; =0x5e
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_460
; %bb.461:                              ;   in Loop: Header=BB2_459 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x17, lsl #3]
	cmp	x2, #47
	b.ne	LBB2_459
; %bb.462:                              ;   in Loop: Header=BB2_458 Depth=2
	add	x9, x23, #47
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_458
	b	LBB2_475
LBB2_463:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x9, x23, #57
	cmp	x22, x9
	b.lt	LBB2_475
; %bb.464:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	x1, x23
LBB2_465:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_466 Depth 3
                                        ;         Child Loop BB2_467 Depth 4
	mov	x2, #0                          ; =0x0
	mov	x23, x9
LBB2_466:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_465 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_467 Depth 4
	add	x15, x2, x1
	lsl	w9, w2, #6
	and	w10, w9, #0xffc0
	mov	w12, #8049                      ; =0x1f71
	mul	w10, w10, w12
	lsr	w10, w10, #16
	sub	w12, w9, w10
	and	w12, w12, #0xfffe
	add	w10, w10, w12, lsr #1
	lsr	w10, w10, #5
	mov	w12, #57                        ; =0x39
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	cmp	w10, #7
	cset	w10, lo
	mov	w12, #1                         ; =0x1
	cinc	x12, x12, lo
	and	x13, x9, #0xffff
	tst	x9, #0xfff8
	mov	w9, #7                          ; =0x7
	csel	x9, x13, x9, ne
	sub	x9, x9, x10
	sub	x9, x9, x13
	mov	x10, #33343                     ; =0x823f
	movk	x10, #2299, lsl #16
	movk	x10, #9198, lsl #32
	movk	x10, #36792, lsl #48
	umulh	x9, x9, x10
	add	x10, x12, x9, lsr #5
	add	x9, x10, #1
	and	x9, x9, #0x1ffffffffffffffe
	sub	x10, x10, #1
	ldr	d18, [x19, x15, lsl #3]
	dup.2d	v17, x10
	dup.2d	v19, x13
Lloh98:
	adrp	x10, lCPI2_4@PAGE
Lloh99:
	ldr	q20, [x10, lCPI2_4@PAGEOFF]
	add.2d	v20, v19, v20
	mov	w10, #2                         ; =0x2
LBB2_467:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_465 Depth=2
                                        ;       Parent Loop BB2_466 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.16b	v19, v18
	mov	w12, #1                         ; =0x1
	dup.2d	v18, x12
	ushl.2d	v18, v18, v20
	orr.16b	v18, v19, v18
	mov	w12, #114                       ; =0x72
	dup.2d	v21, x12
	add.2d	v20, v20, v21
	sub	x10, x10, #2
	add	x12, x9, x10
	cmp	x12, #2
	b.ne	LBB2_467
; %bb.468:                              ;   in Loop: Header=BB2_466 Depth=3
	neg	x9, x10
	dup.2d	v20, x9
	ldr	q21, [x24, lCPI2_2@PAGEOFF]
	orr.16b	v20, v20, v21
	cmhi.2d	v17, v20, v17
	bsl.16b	v17, v19, v18
	ext.16b	v18, v17, v17, #8
	orr.8b	v17, v17, v18
	add	x2, x2, #1
	str	d17, [x19, x15, lsl #3]
	cmp	x2, #57
	b.ne	LBB2_466
; %bb.469:                              ;   in Loop: Header=BB2_465 Depth=2
	add	x9, x23, #57
	mov	x1, x23
	cmp	x22, x9
	b.ge	LBB2_465
	b	LBB2_475
LBB2_470:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x13, x23, #63
	cmp	x22, x13
	b.lt	LBB2_475
; %bb.471:                              ;   in Loop: Header=BB2_3 Depth=1
	add	x14, x19, #496
	add	x9, x19, x23, lsl #3
	mov	x10, x23
LBB2_472:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_473 Depth 3
	mov	x12, #0                         ; =0x0
	mov	x23, x13
Lloh100:
	adrp	x13, lCPI2_0@PAGE
Lloh101:
	ldr	d17, [x13, lCPI2_0@PAGEOFF]
LBB2_473:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_472 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	shl.2s	v18, v17, #6
	movi	d19, #0x00ffff0000ffff
	and.8b	v18, v18, v19
	mov	w13, #16645                     ; =0x4105
	movk	w13, #1040, lsl #16
	dup.2s	v19, w13
	umull.2d	v19, v18, v19
	shrn.2s	v19, v19, #32
	movi.2s	v20, #63
	mls.2s	v18, v19, v20
	eor.8b	v19, v18, v20
	cmeq.2s	v18, v18, #0
	bic.8b	v18, v19, v18
	ushll.2d	v18, v18, #0
	ldr	q19, [x9, x12]
	mov	w13, #1                         ; =0x1
	dup.2d	v20, x13
	ushl.2d	v20, v20, v18
	orr.16b	v19, v20, v19
	cmeq.2d	v18, v18, #0
	movi.2d	v20, #0000000000000000
	fneg.2d	v20, v20
	orr.16b	v20, v19, v20
	bsl.16b	v18, v20, v19
	str	q18, [x9, x12]
	movi.2s	v18, #2
	add.2s	v17, v17, v18
	add	x12, x12, #16
	cmp	x12, #496
	b.ne	LBB2_473
; %bb.474:                              ;   in Loop: Header=BB2_472 Depth=2
	ldr	x12, [x14, x10, lsl #3]
	orr	x12, x12, #0x2
	str	x12, [x14, x10, lsl #3]
	add	x13, x23, #63
	add	x9, x9, #504
	mov	x10, x23
	cmp	x22, x13
	b.ge	LBB2_472
LBB2_475:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x9, x23, #6
	cmp	x9, x21
	b.ge	LBB2_478
LBB2_476:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x10, x9, #0x7
	mov	w12, #1                         ; =0x1
	lsl	w10, w12, w10
	asr	x12, x9, #3
	ldrb	w13, [x19, x12]
	orr	w10, w10, w13
	strb	w10, [x19, x12]
	adds	x10, x9, x11
	b.vs	LBB2_502
; %bb.477:                              ;   in Loop: Header=BB2_476 Depth=2
	add	x9, x9, x11
	cmp	x10, x21
	b.lt	LBB2_476
LBB2_478:                               ;   in Loop: Header=BB2_3 Depth=1
	adds	x11, x11, #2
	b.vc	LBB2_2
	b	LBB2_505
LBB2_479:                               ;   in Loop: Header=BB2_3 Depth=1
	add	x15, x19, x23, lsl #4
	b	LBB2_481
LBB2_480:                               ;   in Loop: Header=BB2_481 Depth=2
	add	x9, x23, #111
	add	x15, x15, #1776
	cmp	x22, x9
	b.lt	LBB2_275
LBB2_481:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_483 Depth 3
	mov	x14, #0                         ; =0x0
	mov	x23, x9
	b	LBB2_483
LBB2_482:                               ;   in Loop: Header=BB2_483 Depth=3
	str	q17, [x15, x14, lsl #4]
	add	x14, x14, #1
	cmp	x14, #111
	b.eq	LBB2_480
LBB2_483:                               ;   Parent Loop BB2_3 Depth=1
                                        ;     Parent Loop BB2_481 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	q17, [x15, x14, lsl #4]
	lsl	w9, w14, #7
	and	w10, w9, #0xff80
	mov	w12, #37787                     ; =0x939b
	mul	w10, w10, w12
	lsr	w10, w10, #22
	mov	w12, #111                       ; =0x6f
	msub	w9, w10, w12, w9
	sub	w10, w12, w9
	tst	w9, #0xffff
	csel	w9, wzr, w10, eq
	and	w10, w9, #0xffff
	lsr	w12, w9, #3
	mov	w13, #1                         ; =0x1
	lsl	x13, x13, x9
	ubfx	x16, x9, #6, #10
	add	x17, sp, #800
	and	x12, x12, #0x8
	orr	x12, x17, x12
	bfi	x17, x16, #3, #1
	str	q17, [sp, #800]
	ldr	x12, [x12]
	orr	x12, x12, x13
	str	x12, [x17]
	ldr	q17, [sp, #800]
	cmp	w10, #16
	b.hi	LBB2_482
; %bb.484:                              ;   in Loop: Header=BB2_483 Depth=3
	and	x9, x9, #0xffff
	add	x9, x9, #111
	mov	w10, #1                         ; =0x1
	lsl	x10, x10, x9
	lsr	x12, x9, #6
	add	x13, sp, #784
	lsr	x9, x9, #3
	and	x9, x9, #0x8
	orr	x9, x13, x9
	bfi	x13, x12, #3, #1
	str	q17, [sp, #784]
	ldr	x9, [x9]
	orr	x9, x9, x10
	str	x9, [x13]
	ldr	q17, [sp, #784]
	b	LBB2_482
LBB2_485:                               ;   in Loop: Header=BB2_3 Depth=1
	lsr	x15, x21, #3
	cmp	x15, #8
	mov	w9, #8                          ; =0x8
	csel	x9, x15, x9, gt
	cmp	x21, #71
	cset	w10, hi
	cinc	x12, x6, hi
	sub	x9, x9, x10
	sub	x9, x9, #8
	mov	x10, #-6148914691236517206      ; =0xaaaaaaaaaaaaaaaa
	movk	x10, #43691
	umulh	x9, x9, x10
	add	x9, x12, x9, lsr #1
	cmp	x9, #16
	b.hs	LBB2_487
; %bb.486:                              ;   in Loop: Header=BB2_3 Depth=1
	mov	w14, #3                         ; =0x3
	b	LBB2_490
LBB2_487:                               ;   in Loop: Header=BB2_3 Depth=1
	and	x10, x9, #0x7ffffffffffffff0
	add	x12, x10, x10, lsl #1
	orr	x14, x12, #0x3
	add	x12, x19, #3
	mov	x13, x10
LBB2_488:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldp	q18, q20, [x12, #16]
	ldr	q17, [x12]
	tbl.16b	v19, { v17, v18 }, v0
	tbl.16b	v21, { v19, v20 }, v1
	tbl.16b	v19, { v17, v18 }, v2
	tbl.16b	v22, { v19, v20 }, v3
	orr.16b	v23, v22, v4
	orr.16b	v22, v21, v5
	tbl.16b	v19, { v17, v18 }, v6
	tbl.16b	v17, { v19, v20 }, v7
	orr.16b	v24, v17, v16
	st3.16b	{ v22, v23, v24 }, [x12], #48
	subs	x13, x13, #16
	b.ne	LBB2_488
; %bb.489:                              ;   in Loop: Header=BB2_3 Depth=1
	cmp	x9, x10
	b.eq	LBB2_492
LBB2_490:                               ;   in Loop: Header=BB2_3 Depth=1
	sub	x9, x15, #3
LBB2_491:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	x10, x19, x14
	ldrb	w12, [x10]
	orr	w12, w12, w7
	strb	w12, [x10]
	ldrb	w12, [x10, #1]
	orr	w12, w12, w4
	strb	w12, [x10, #1]
	ldrb	w12, [x10, #2]
	orr	w12, w12, w5
	strb	w12, [x10, #2]
	add	x14, x14, #3
	cmp	x9, x14
	b.ge	LBB2_491
LBB2_492:                               ;   in Loop: Header=BB2_3 Depth=1
	lsl	x9, x14, #3
LBB2_493:                               ;   in Loop: Header=BB2_3 Depth=1
	cmp	x9, x21
	b.hs	LBB2_478
LBB2_494:                               ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x10, x9, #0x7
	lsl	w10, w6, w10
	asr	x12, x9, #3
	ldrb	w13, [x19, x12]
	orr	w10, w10, w13
	strb	w10, [x19, x12]
	adds	x10, x9, #3
	b.vs	LBB2_551
; %bb.495:                              ;   in Loop: Header=BB2_494 Depth=2
	add	x9, x9, #3
	cmp	x10, x21
	b.lt	LBB2_494
	b	LBB2_478
LBB2_496:
	add	sp, sp, #816
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB2_497:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_498:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_499:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_500:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_501:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_502:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_503:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_504:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_505:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_506:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_507:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_508:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_509:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_510:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_511:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_512:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_513:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_514:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_515:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_516:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_517:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_518:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_519:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_520:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_521:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_522:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_523:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_524:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_525:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_526:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_527:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_528:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_529:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_530:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_531:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_532:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_533:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_534:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_535:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_536:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_537:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_538:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_539:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_540:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_541:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_542:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_543:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_544:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_545:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_546:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_547:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_548:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_549:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_550:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_551:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_552:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB2_553:
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
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh14, Lloh15
	.loh AdrpLdr	Lloh18, Lloh19
	.loh AdrpAdrp	Lloh16, Lloh18
	.loh AdrpLdr	Lloh16, Lloh17
	.loh AdrpLdr	Lloh20, Lloh21
	.loh AdrpLdr	Lloh22, Lloh23
	.loh AdrpLdr	Lloh24, Lloh25
	.loh AdrpLdr	Lloh26, Lloh27
	.loh AdrpLdr	Lloh28, Lloh29
	.loh AdrpLdr	Lloh30, Lloh31
	.loh AdrpLdr	Lloh32, Lloh33
	.loh AdrpLdr	Lloh36, Lloh37
	.loh AdrpLdr	Lloh34, Lloh35
	.loh AdrpLdr	Lloh38, Lloh39
	.loh AdrpLdr	Lloh42, Lloh43
	.loh AdrpLdr	Lloh40, Lloh41
	.loh AdrpLdr	Lloh44, Lloh45
	.loh AdrpLdr	Lloh46, Lloh47
	.loh AdrpLdr	Lloh48, Lloh49
	.loh AdrpLdr	Lloh52, Lloh53
	.loh AdrpLdr	Lloh50, Lloh51
	.loh AdrpLdr	Lloh54, Lloh55
	.loh AdrpLdr	Lloh56, Lloh57
	.loh AdrpLdr	Lloh58, Lloh59
	.loh AdrpLdr	Lloh60, Lloh61
	.loh AdrpLdr	Lloh66, Lloh67
	.loh AdrpAdrp	Lloh64, Lloh66
	.loh AdrpLdr	Lloh64, Lloh65
	.loh AdrpAdrp	Lloh62, Lloh64
	.loh AdrpLdr	Lloh62, Lloh63
	.loh AdrpLdr	Lloh68, Lloh69
	.loh AdrpLdr	Lloh70, Lloh71
	.loh AdrpLdr	Lloh72, Lloh73
	.loh AdrpLdr	Lloh74, Lloh75
	.loh AdrpLdr	Lloh76, Lloh77
	.loh AdrpLdr	Lloh78, Lloh79
	.loh AdrpLdr	Lloh80, Lloh81
	.loh AdrpLdr	Lloh82, Lloh83
	.loh AdrpLdr	Lloh84, Lloh85
	.loh AdrpLdr	Lloh86, Lloh87
	.loh AdrpLdr	Lloh88, Lloh89
	.loh AdrpLdr	Lloh90, Lloh91
	.loh AdrpLdr	Lloh92, Lloh93
	.loh AdrpLdr	Lloh94, Lloh95
	.loh AdrpLdr	Lloh96, Lloh97
	.loh AdrpLdr	Lloh98, Lloh99
	.loh AdrpLdr	Lloh100, Lloh101
	.cfi_endproc
	.p2align	2
lJTI2_0:
	.long	LBB2_55-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_218-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_204-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_246-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_239-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_176-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_211-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_232-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_183-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_225-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_141-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_253-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_162-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_120-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_134-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_190-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_148-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_197-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_127-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_155-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_260-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_267-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_169-Ltmp0
	.long	LBB2_552-Ltmp0
	.long	LBB2_274-Ltmp0
	.p2align	2
lJTI2_1:
	.long	LBB2_59-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_378-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_366-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_381-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_401-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_391-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_337-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_361-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_325-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_356-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_294-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_418-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_313-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_430-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_299-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_342-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_306-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_349-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_287-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_318-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_435-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_456-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_330-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_280-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_449-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_411-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_463-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_423-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_442-Ltmp1
	.long	LBB2_553-Ltmp1
	.long	LBB2_470-Ltmp1
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function $s10PrimeSwift0A5SieveC6primesSaySiGyF
lCPI3_0:
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
	b.lt	LBB3_14
; %bb.1:
Lloh102:
	adrp	x0, _$ss23_ContiguousArrayStorageCySiGMd@PAGE
Lloh103:
	add	x0, x0, _$ss23_ContiguousArrayStorageCySiGMd@PAGEOFF
Lloh104:
	adrp	x1, _$ss23_ContiguousArrayStorageCySiGMR@PAGE
Lloh105:
	add	x1, x1, _$ss23_ContiguousArrayStorageCySiGMR@PAGEOFF
	bl	___swift_instantiateConcreteTypeFromMangledNameV2
	mov	w1, #40                         ; =0x28
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
Lloh106:
	adrp	x8, lCPI3_0@PAGE
Lloh107:
	ldr	q0, [x8, lCPI3_0@PAGEOFF]
	str	q0, [x0, #16]
	mov	w8, #2                          ; =0x2
	str	x8, [x0, #32]
	ldr	x21, [x20, #32]
	tbnz	x21, #63, LBB3_19
; %bb.2:
	mov	x3, x0
	cbz	x21, LBB3_15
; %bb.3:
	mov	x22, #0                         ; =0x0
	ldr	x23, [x20, #40]
	sub	x24, x21, #1
	mov	w10, #-1                        ; =0xffffffff
	mov	x11, #-1152921504606846976      ; =0xf000000000000000
	mov	x12, #4611686018427387904       ; =0x4000000000000000
	b	LBB3_5
LBB3_4:                                 ;   in Loop: Header=BB3_5 Depth=1
	add	x22, x22, #1
	cmp	x22, x21
	b.eq	LBB3_15
LBB3_5:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_10 Depth 2
	ldrb	w8, [x23, x22]
	mvn	w28, w8
	cmp	x22, x24
	b.ne	LBB3_7
; %bb.6:                                ;   in Loop: Header=BB3_5 Depth=1
	ldr	x9, [x20, #24]
	ands	x9, x9, #0x7
	lsl	w9, w10, w9
	bic	w9, w28, w9
	csinv	w28, w9, w8, ne
LBB3_7:                                 ;   in Loop: Header=BB3_5 Depth=1
	tst	w28, #0xff
	b.eq	LBB3_4
; %bb.8:                                ;   in Loop: Header=BB3_5 Depth=1
	add	x8, x22, x11
	lsr	x8, x8, #61
	cmp	x8, #7
	b.lo	LBB3_17
; %bb.9:                                ;   in Loop: Header=BB3_5 Depth=1
	lsl	x25, x22, #3
	cmn	x25, x12
	b.mi	LBB3_18
LBB3_10:                                ;   Parent Loop BB3_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	rbit	w8, w28
	clz	w8, w8
	orr	x8, x25, x8
	lsl	x8, x8, #1
	adds	x26, x8, #3
	b.vs	LBB3_16
; %bb.11:                               ;   in Loop: Header=BB3_10 Depth=2
	ldp	x27, x8, [x3, #16]
	add	x19, x27, #1
	cmp	x27, x8, lsr #1
	b.hs	LBB3_13
LBB3_12:                                ;   in Loop: Header=BB3_10 Depth=2
	str	x19, [x3, #16]
	add	x8, x3, x27, lsl #3
	str	x26, [x8, #32]
	sub	w8, w28, #1
	and	w28, w8, w28
	tst	w28, #0xff
	b.ne	LBB3_10
	b	LBB3_4
LBB3_13:                                ;   in Loop: Header=BB3_10 Depth=2
	cmp	x8, #1
	cset	w0, hi
	mov	x1, x19
	mov	w2, #1                          ; =0x1
	bl	_$ss12_ArrayBufferV20_consumeAndCreateNew14bufferIsUnique15minimumCapacity13growForAppendAByxGSb_SiSbtFSi_Tg5
	mov	x12, #4611686018427387904       ; =0x4000000000000000
	mov	x11, #-1152921504606846976      ; =0xf000000000000000
	mov	w10, #-1                        ; =0xffffffff
	mov	x3, x0
	b	LBB3_12
LBB3_14:
Lloh108:
	adrp	x3, __swiftEmptyArrayStorage@GOTPAGE
Lloh109:
	ldr	x3, [x3, __swiftEmptyArrayStorage@GOTPAGEOFF]
LBB3_15:
	mov	x0, x3
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB3_16:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB3_17:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB3_18:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB3_19:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.loh AdrpLdr	Lloh106, Lloh107
	.loh AdrpAdd	Lloh104, Lloh105
	.loh AdrpAdd	Lloh102, Lloh103
	.loh AdrpLdrGot	Lloh108, Lloh109
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
	cbz	x8, LBB4_2
; %bb.1:
	ldr	x0, [x20, #40]
	b	LBB4_3
LBB4_2:
	mov	x0, #0                          ; =0x0
LBB4_3:
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
Lloh110:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh111:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh112:
	ldr	x8, [x8]
	stur	x8, [x29, #-96]
	stp	x0, x1, [sp, #64]
	stp	x0, x1, [sp, #48]
	mov	x0, x1
	bl	_swift_bridgeObjectRetain
Lloh113:
	adrp	x0, _$s10Foundation15ContiguousBytes_pMd@PAGE
Lloh114:
	add	x0, x0, _$s10Foundation15ContiguousBytes_pMd@PAGEOFF
Lloh115:
	adrp	x1, _$s10Foundation15ContiguousBytes_pMR@PAGE
Lloh116:
	add	x1, x1, _$s10Foundation15ContiguousBytes_pMR@PAGEOFF
	bl	___swift_instantiateConcreteTypeFromMangledNameV2
	mov	x3, x0
Lloh117:
	adrp	x2, _$sSS8UTF8ViewVN@GOTPAGE
Lloh118:
	ldr	x2, [x2, _$sSS8UTF8ViewVN@GOTPAGEOFF]
	add	x0, sp, #80
	add	x1, sp, #48
	mov	w4, #6                          ; =0x6
	bl	_swift_dynamicCast
	cbz	w0, LBB5_2
; %bb.1:
	add	x0, sp, #80
	add	x1, sp, #128
	bl	_$s10Foundation15ContiguousBytes_pWOb
	ldp	x22, x23, [sp, #152]
	add	x0, sp, #128
	mov	x1, x22
	bl	___swift_project_boxed_opaque_existential_1
	mov	x20, x0
Lloh119:
	adrp	x0, _$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_@PAGE
Lloh120:
	add	x0, x0, _$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_@PAGEOFF
Lloh121:
	adrp	x2, _$s10Foundation4DataV15_RepresentationON@GOTPAGE
Lloh122:
	ldr	x2, [x2, _$s10Foundation4DataV15_RepresentationON@GOTPAGEOFF]
	add	x8, sp, #80
	mov	x1, #0                          ; =0x0
	mov	x21, #0                         ; =0x0
	mov	x3, x22
	mov	x4, x23
	bl	_$s10Foundation15ContiguousBytesP010withUnsafeC0yqd__qd__SWKXEKlFTj
	add	x0, sp, #128
	bl	___swift_destroy_boxed_opaque_existential_1
	b	LBB5_54
LBB5_2:
	str	xzr, [sp, #112]
	movi.2d	v0, #0000000000000000
	stp	q0, q0, [sp, #80]
	add	x0, sp, #80
	bl	_$s10Foundation15ContiguousBytes_pSgWOh
	tbnz	x19, #60, LBB5_59
; %bb.3:
	tbnz	x19, #61, LBB5_7
; %bb.4:
	tbz	x20, #60, LBB5_60
; %bb.5:
	and	x8, x19, #0xfffffffffffffff
	add	x0, x8, #32
	and	x1, x20, #0xffffffffffff
LBB5_6:
	add	x8, x1, x0
	cmp	x0, #0
	csel	x1, xzr, x8, eq
	bl	_$s10Foundation4DataV15_RepresentationOyAESWcfCTf4nd_n
	mov	x22, x0
	mov	x23, x1
	b	LBB5_9
LBB5_7:
	ubfx	x1, x19, #56, #4
	and	x8, x19, #0xffffffffffffff
	stp	x20, x8, [sp, #80]
	add	x8, sp, #128
	add	x0, sp, #80
	mov	x21, #0                         ; =0x0
	bl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSRyAEGXEfU0_
	cbnz	x21, LBB5_65
; %bb.8:
	ldp	x22, x23, [sp, #128]
LBB5_9:
	lsr	x8, x23, #60
	cmp	x8, #14
	b.ls	LBB5_14
; %bb.10:
	and	x8, x20, #0xffffffffffff
	ubfx	x9, x19, #56, #4
	tst	x19, #0x2000000000000000
	csel	x0, x8, x9, eq
LBB5_11:
	bl	_$s10Foundation4DataV15_RepresentationO5countAESi_tcfCTf4nd_n
	stp	x0, x1, [sp, #80]
	add	x8, sp, #64
	str	x8, [sp, #144]
Lloh123:
	adrp	x0, _$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufc8IteratorQz_SitSwXEfU1_SS8UTF8ViewV_TG5TA@PAGE
Lloh124:
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
	b.gt	LBB5_15
; %bb.12:
	cbnz	w10, LBB5_18
; %bb.13:
	ubfx	x11, x9, #48, #8
	cmp	x3, x11
	b.ne	LBB5_20
	b	LBB5_25
LBB5_14:
	stp	x22, x23, [sp, #80]
	b	LBB5_54
LBB5_15:
	cmp	w10, #2
	b.ne	LBB5_23
; %bb.16:
	ldp	x12, x11, [x8, #16]
	subs	x11, x11, x12
	b.vs	LBB5_62
; %bb.17:
	cmp	x3, x11
	b.ne	LBB5_20
	b	LBB5_25
LBB5_18:
	lsr	x11, x8, #32
	subs	w11, w11, w8
	b.vs	LBB5_63
; %bb.19:
	sxtw	x11, w11
	cmp	x3, x11
	b.eq	LBB5_25
LBB5_20:
	cmp	w10, #2
	b.eq	LBB5_49
; %bb.21:
	cmp	w10, #1
	b.ne	LBB5_50
; %bb.22:
	asr	x1, x8, #32
	b	LBB5_51
LBB5_23:
	cbz	x3, LBB5_25
; %bb.24:
	mov	x1, #0                          ; =0x0
	b	LBB5_51
LBB5_25:
	str	x23, [sp, #16]                  ; 8-byte Folded Spill
	and	x8, x24, #0xffffffffffff
	ubfx	x9, x21, #56, #4
	tst	x21, #0x2000000000000000
	csel	x26, x8, x9, eq
	lsl	x27, x26, #2
	stur	xzr, [sp, #54]
	str	xzr, [sp, #48]
	cmp	x27, x25, lsr #14
	b.eq	LBB5_48
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
	b	LBB5_28
LBB5_27:                                ;   in Loop: Header=BB5_28 Depth=1
	cmp	x27, x25, lsr #14
	b.eq	LBB5_46
LBB5_28:                                ; =>This Inner Loop Header: Depth=1
	and	x23, x25, #0xc
	mov	x0, x25
	cmp	x23, x22
	b.eq	LBB5_37
LBB5_29:                                ;   in Loop: Header=BB5_28 Depth=1
	lsr	x20, x0, #16
	cmp	x20, x26
	b.hs	LBB5_56
; %bb.30:                               ;   in Loop: Header=BB5_28 Depth=1
	tbnz	x21, #60, LBB5_38
; %bb.31:                               ;   in Loop: Header=BB5_28 Depth=1
	tbnz	x21, #61, LBB5_34
; %bb.32:                               ;   in Loop: Header=BB5_28 Depth=1
	ldr	x0, [sp, #24]                   ; 8-byte Folded Reload
	tbz	x24, #60, LBB5_45
LBB5_33:                                ;   in Loop: Header=BB5_28 Depth=1
	ldrb	w20, [x0, x20]
	cmp	x23, x22
	b.ne	LBB5_35
	b	LBB5_39
LBB5_34:                                ;   in Loop: Header=BB5_28 Depth=1
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	stp	x24, x8, [sp, #128]
	add	x8, sp, #128
	ldrb	w20, [x8, x20]
	cmp	x23, x22
	b.eq	LBB5_39
LBB5_35:                                ;   in Loop: Header=BB5_28 Depth=1
	tbnz	x21, #60, LBB5_40
LBB5_36:                                ;   in Loop: Header=BB5_28 Depth=1
	and	x8, x25, #0xffffffffffff0000
	mov	w9, #4                          ; =0x4
	movk	w9, #1, lsl #16
	add	x25, x8, x9
	b	LBB5_42
LBB5_37:                                ;   in Loop: Header=BB5_28 Depth=1
	mov	x0, x25
	mov	x1, x24
	mov	x2, x21
	bl	_$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF
	b	LBB5_29
LBB5_38:                                ;   in Loop: Header=BB5_28 Depth=1
	mov	x1, x24
	mov	x2, x21
	bl	_$sSS8UTF8ViewV17_foreignSubscript8positions5UInt8VSS5IndexV_tF
	mov	x20, x0
	cmp	x23, x22
	b.ne	LBB5_35
LBB5_39:                                ;   in Loop: Header=BB5_28 Depth=1
	mov	x0, x25
	mov	x1, x24
	mov	x2, x21
	bl	_$ss11_StringGutsV27_slowEnsureMatchingEncodingySS5IndexVAEF
	mov	x25, x0
	tbz	x21, #60, LBB5_36
LBB5_40:                                ;   in Loop: Header=BB5_28 Depth=1
	cmp	x26, x25, lsr #16
	b.ls	LBB5_58
; %bb.41:                               ;   in Loop: Header=BB5_28 Depth=1
	mov	x0, x25
	mov	x1, x24
	mov	x2, x21
	bl	_$sSS8UTF8ViewV13_foreignIndex5afterSS0D0VAF_tF
	mov	x25, x0
LBB5_42:                                ;   in Loop: Header=BB5_28 Depth=1
	and	x8, x28, #0xff
	and	w9, w28, #0xff
	add	x10, sp, #48
	strb	w20, [x10, x8]
	add	w28, w9, #1
	lsr	w8, w28, #8
	tbnz	w8, #0, LBB5_57
; %bb.43:                               ;   in Loop: Header=BB5_28 Depth=1
	and	w8, w28, #0xff
	cmp	w8, #14
	b.ne	LBB5_27
; %bb.44:                               ;   in Loop: Header=BB5_28 Depth=1
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
	b	LBB5_27
LBB5_45:                                ;   in Loop: Header=BB5_28 Depth=1
	mov	x0, x24
	mov	x1, x21
	bl	_$ss13_StringObjectV10sharedUTF8SRys5UInt8VGvg
	b	LBB5_33
LBB5_46:
	tst	w28, #0xff
	ldr	x22, [sp, #8]                   ; 8-byte Folded Reload
	b.eq	LBB5_48
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
	b	LBB5_53
LBB5_48:
	mov	x0, x21
	bl	_swift_bridgeObjectRelease
	mov	x0, x22
	ldr	x1, [sp, #16]                   ; 8-byte Folded Reload
	bl	_$s10Foundation4DataV15_RepresentationOSgWOe
	b	LBB5_54
LBB5_49:
	ldr	x1, [x8, #24]
	b	LBB5_51
LBB5_50:
	ubfx	x1, x9, #48, #8
LBB5_51:
	cmp	x1, x3
	b.lt	LBB5_61
; %bb.52:
	add	x20, sp, #80
	mov	x0, x3
	mov	x2, #0                          ; =0x0
	mov	x3, #0                          ; =0x0
	bl	_$s10Foundation4DataV15_RepresentationO15replaceSubrange_4with5countySnySiG_SVSgSitF
LBB5_53:
	mov	x0, x21
	bl	_swift_bridgeObjectRelease
LBB5_54:
	ldp	x20, x21, [sp, #80]
	mov	x0, x20
	mov	x1, x21
	bl	_$s10Foundation4DataV15_RepresentationOWOy
	mov	x0, x19
	bl	_swift_bridgeObjectRelease
	ldp	x0, x1, [sp, #80]
	bl	_$s10Foundation4DataV15_RepresentationOWOe
	ldur	x8, [x29, #-96]
Lloh125:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh126:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh127:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB5_64
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
LBB5_56:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB5_57:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB5_58:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB5_59:
	mov	x0, x20
	mov	x1, x19
	bl	_$sSS8UTF8ViewV13_foreignCountSiyF
	mov	x22, #0                         ; =0x0
	mov	x23, #-1152921504606846976      ; =0xf000000000000000
	b	LBB5_11
LBB5_60:
	mov	x0, x20
	mov	x1, x19
	bl	_$ss13_StringObjectV10sharedUTF8SRys5UInt8VGvg
	b	LBB5_6
LBB5_61:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB5_62:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB5_63:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB5_64:
	bl	___stack_chk_fail
LBB5_65:
	mov	x0, x21
	bl	_swift_errorRelease
	brk	#0x1
	.loh AdrpLdrGot	Lloh117, Lloh118
	.loh AdrpAdd	Lloh115, Lloh116
	.loh AdrpAdd	Lloh113, Lloh114
	.loh AdrpLdrGotLdr	Lloh110, Lloh111, Lloh112
	.loh AdrpLdrGot	Lloh121, Lloh122
	.loh AdrpAdd	Lloh119, Lloh120
	.loh AdrpAdd	Lloh123, Lloh124
	.loh AdrpLdrGotLdr	Lloh125, Lloh126, Lloh127
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
	tbz	w2, #0, LBB7_4
; %bb.1:
	ldr	x9, [x19, #24]
	lsr	x8, x9, #1
	cmp	x8, x1
	b.ge	LBB7_5
; %bb.2:
	mov	x10, #4611686018427387904       ; =0x4000000000000000
	cmn	x8, x10
	b.mi	LBB7_14
; %bb.3:
	and	x8, x9, #0xfffffffffffffffe
	cmp	x8, x1
	csel	x8, x8, x1, gt
	b	LBB7_5
LBB7_4:
	mov	x8, x1
LBB7_5:
	ldr	x22, [x19, #16]
	cmp	x8, x22
	csel	x21, x8, x22, gt
	cbz	x21, LBB7_7
; %bb.6:
Lloh128:
	adrp	x0, _$ss23_ContiguousArrayStorageCySiGMd@PAGE
Lloh129:
	add	x0, x0, _$ss23_ContiguousArrayStorageCySiGMd@PAGEOFF
Lloh130:
	adrp	x1, _$ss23_ContiguousArrayStorageCySiGMR@PAGE
Lloh131:
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
	b	LBB7_8
LBB7_7:
Lloh132:
	adrp	x21, __swiftEmptyArrayStorage@GOTPAGE
Lloh133:
	ldr	x21, [x21, __swiftEmptyArrayStorage@GOTPAGEOFF]
LBB7_8:
	add	x0, x21, #32
	add	x1, x19, #32
	tbz	w20, #0, LBB7_12
; %bb.9:
	add	x8, x1, x22, lsl #3
	cmp	x21, x19
	ccmp	x0, x8, #2, eq
	b.lo	LBB7_11
; %bb.10:
	lsl	x2, x22, #3
	bl	_memmove
LBB7_11:
	str	xzr, [x19, #16]
	b	LBB7_13
LBB7_12:
	lsl	x2, x22, #3
	bl	_memcpy
LBB7_13:
	mov	x0, x19
	bl	_swift_bridgeObjectRelease
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB7_14:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.loh AdrpAdd	Lloh130, Lloh131
	.loh AdrpAdd	Lloh128, Lloh129
	.loh AdrpLdrGot	Lloh132, Lloh133
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
	cbz	x0, LBB8_5
; %bb.1:
	mov	x22, x1
	cbz	x1, LBB8_4
; %bb.2:
	mov	x23, x21
	cmp	x22, #15
	b.hs	LBB8_7
; %bb.3:
	add	x1, x22, x0
	bl	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	and	x8, x1, #0xffffffffffffff
	mov	x21, x23
	b	LBB8_6
LBB8_4:
	mov	x0, #0                          ; =0x0
LBB8_5:
	mov	x8, #-4611686018427387904       ; =0xc000000000000000
LBB8_6:
	stp	x0, x8, [x19]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x23, x22, [sp], #48             ; 16-byte Folded Reload
	ret
LBB8_7:
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
	b.hi	LBB8_9
; %bb.8:
	lsl	x0, x22, #32
	orr	x8, x20, #0x4000000000000000
	mov	x21, x23
	b	LBB8_6
LBB8_9:
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation4DataV14RangeReferenceCMa
	mov	w1, #32                         ; =0x20
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
	stp	xzr, x22, [x0, #16]
	orr	x8, x20, #0x8000000000000000
	mov	x21, x23
	b	LBB8_6
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function $s10Foundation4DataV15_RepresentationO22withUnsafeMutableBytesyxxSwKXEKlFs16IndexingIteratorVySS8UTF8ViewVG_Sit_Tg5
lCPI9_0:
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
Lloh134:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh135:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh136:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	ldp	x25, x20, [x20]
	lsr	x8, x20, #62
	cmp	w8, #1
	b.gt	LBB9_4
; %bb.1:
	str	x26, [sp, #80]                  ; 8-byte Folded Spill
	cbnz	w8, LBB9_7
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
	cbz	x21, LBB9_14
; %bb.3:
	ldur	x8, [x29, #-104]
	ldurb	w9, [x29, #-90]
	ldurh	w10, [x29, #-92]
	orr	w9, w10, w9, lsl #16
	ldur	w10, [x29, #-96]
	orr	x9, x10, x9, lsl #32
	stp	x8, x9, [x19]
	b	LBB9_22
LBB9_4:
	cmp	w8, #2
	b.ne	LBB9_12
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
Lloh137:
	adrp	x8, lCPI9_0@PAGE
Lloh138:
	ldr	q0, [x8, lCPI9_0@PAGEOFF]
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
	cbz	x21, LBB9_15
; %bb.6:
	str	x22, [x19]
	b	LBB9_21
LBB9_7:
	and	x26, x20, #0x3fffffffffffffff
	mov	x0, x26
	bl	_swift_retain
	mov	x0, x25
	mov	x1, x20
	bl	_$s10Foundation4DataV15_RepresentationOWOe
Lloh139:
	adrp	x8, lCPI9_0@PAGE
Lloh140:
	ldr	q0, [x8, lCPI9_0@PAGEOFF]
	str	q0, [x19]
	mov	x0, #0                          ; =0x0
	mov	x1, #-4611686018427387904       ; =0xc000000000000000
	bl	_$s10Foundation4DataV15_RepresentationOWOe
	mov	x0, x26
	bl	_swift_isUniquelyReferenced_nonNull_native
	sxtw	x27, w25
	asr	x28, x25, #32
	tbnz	w0, #0, LBB9_18
; %bb.8:
	subs	x8, x28, x27
	str	x8, [sp, #72]                   ; 8-byte Folded Spill
	b.lt	LBB9_27
; %bb.9:
	mov	x0, x26
	bl	_swift_retain
	mov	x20, x26
	bl	_$s10Foundation13__DataStorageC6_bytesSvSgvg
	cbz	x0, LBB9_16
; %bb.10:
	mov	x22, x0
	mov	x20, x26
	bl	_$s10Foundation13__DataStorageC7_offsetSivg
	subs	x8, x27, x0
	b.vs	LBB9_28
; %bb.11:
	add	x20, x8, x22
	b	LBB9_17
LBB9_12:
	stur	xzr, [x29, #-98]
	stur	xzr, [x29, #-104]
	add	x8, sp, #88
	sub	x0, x29, #104
	sub	x1, x29, #104
	mov	x20, x26
	mov	x21, x23
	blr	x24
	cbnz	x21, LBB9_22
; %bb.13:
	ldp	x0, x1, [sp, #88]
	ldp	x2, x3, [sp, #104]
	b	LBB9_23
LBB9_14:
	ldp	x0, x1, [sp, #88]
	ldp	x2, x3, [sp, #104]
	ldur	x8, [x29, #-104]
	ldurb	w9, [x29, #-90]
	ldurh	w10, [x29, #-92]
	orr	w9, w10, w9, lsl #16
	ldur	w10, [x29, #-96]
	orr	x9, x10, x9, lsl #32
	stp	x8, x9, [x19]
	b	LBB9_23
LBB9_15:
	stp	x22, x8, [x19]
	b	LBB9_23
LBB9_16:
	mov	x20, #0                         ; =0x0
LBB9_17:
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
LBB9_18:
	cmp	x28, x27
	b.lt	LBB9_26
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
	cbz	x27, LBB9_25
; %bb.20:
	str	x25, [x19]
LBB9_21:
	str	x8, [x19, #8]
LBB9_22:
                                        ; implicit-def: $x0
                                        ; implicit-def: $x1
                                        ; implicit-def: $x2
                                        ; implicit-def: $x3
LBB9_23:
	ldur	x8, [x29, #-88]
Lloh141:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh142:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh143:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB9_29
; %bb.24:
	ldp	x29, x30, [sp, #224]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #208]            ; 16-byte Folded Reload
	ldp	x23, x22, [sp, #192]            ; 16-byte Folded Reload
	ldp	x25, x24, [sp, #176]            ; 16-byte Folded Reload
	ldp	x27, x26, [sp, #160]            ; 16-byte Folded Reload
	ldr	x28, [sp, #144]                 ; 8-byte Folded Reload
	add	sp, sp, #240
	ret
LBB9_25:
	stp	x25, x8, [x19]
	mov	x0, x20
	mov	x1, x22
	mov	x2, x23
	mov	x3, x24
	b	LBB9_23
LBB9_26:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB9_27:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB9_28:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB9_29:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh134, Lloh135, Lloh136
	.loh AdrpLdr	Lloh137, Lloh138
	.loh AdrpLdr	Lloh139, Lloh140
	.loh AdrpLdrGotLdr	Lloh141, Lloh142, Lloh143
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_ ; -- Begin function $s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_
	.globl	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_
	.weak_definition	_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_
	.p2align	2
_$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_: ; @"$s10Foundation4DataVyACxcSTRzs5UInt8V7ElementRtzlufcAC15_RepresentationOSWXEfU_"
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB10_3
; %bb.1:
	subs	x9, x1, x0
	b.ne	LBB10_4
; %bb.2:
	mov	x0, #0                          ; =0x0
LBB10_3:
	mov	x9, #-4611686018427387904       ; =0xc000000000000000
	stp	x0, x9, [x8]
	ret
LBB10_4:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	cmp	x9, #15
	b.hs	LBB10_6
; %bb.5:
	mov	x19, x21
	mov	x20, x8
	bl	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	mov	x8, x20
	mov	x21, x19
	and	x9, x1, #0xffffffffffffff
	b	LBB10_10
LBB10_6:
	mov	x19, x8
	mov	x20, x21
	mov	w8, #2147483646                 ; =0x7ffffffe
	cmp	x9, x8
	b.hi	LBB10_8
; %bb.7:
	bl	_$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n
	orr	x9, x1, #0x4000000000000000
	b	LBB10_9
LBB10_8:
	bl	_$s10Foundation4DataV10LargeSliceVyAESWcfCTf4nd_n
	orr	x9, x1, #0x8000000000000000
LBB10_9:
	mov	x21, x20
	mov	x8, x19
LBB10_10:
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
	cbz	x0, LBB11_9
; %bb.1:
	mov	x24, x0
	bl	_$s10Foundation13__DataStorageC7_offsetSivg
	subs	x27, x26, x0
	b.vs	LBB11_7
; %bb.2:
	subs	x25, x25, x26
	b.vs	LBB11_8
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
	cbz	x21, LBB11_5
; %bb.4:
                                        ; implicit-def: $x0
                                        ; implicit-def: $x1
                                        ; implicit-def: $x2
                                        ; implicit-def: $x3
	b	LBB11_6
LBB11_5:
	ldp	x0, x1, [sp]
	ldp	x2, x3, [sp, #16]
LBB11_6:
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x23, x22, [sp, #64]             ; 16-byte Folded Reload
	ldp	x25, x24, [sp, #48]             ; 16-byte Folded Reload
	ldp	x27, x26, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB11_7:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB11_8:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB11_9:
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
	tbz	x3, #60, LBB12_3
; %bb.1:
	tbnz	x2, #59, LBB12_3
; %bb.2:
	mov	w0, #15                         ; =0xf
	bl	_$sSS8UTF8ViewV13_foreignIndex_8offsetBySS0D0VAF_SitF
	add	x8, x0, x20, lsl #16
	and	x8, x8, #0xffffffffffff0000
	bfxil	x0, x19, #0, #2
	cmp	x20, #0
	csel	x8, x8, x0, ne
	orr	x0, x8, #0x8
	b	LBB12_4
LBB12_3:
	mov	w0, #15                         ; =0xf
	bl	_$sSS9UTF16ViewV5index_8offsetBySS5IndexVAF_SitF
	add	x8, x0, x20, lsl #16
	and	x8, x8, #0xffffffffffff0000
	bfxil	x0, x19, #0, #2
	cmp	x20, #0
	csel	x8, x8, x0, ne
	orr	x0, x8, #0x4
LBB12_4:
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
	cbz	x0, LBB13_3
; %bb.1:
	mov	x19, x21
	mov	x20, x8
	ldp	x2, x3, [x2]
	sub	x1, x1, x0
	bl	_$ss11_StringGutsV8copyUTF84intoSiSgSrys5UInt8VG_tF
	and	w8, w1, #0xff
	cmp	w8, #1
	b.eq	LBB13_4
; %bb.2:
	mov	x8, #-2305843009213693952       ; =0xe000000000000000
	stp	xzr, x8, [x20]
	mov	w8, #15                         ; =0xf
	stp	x8, x0, [x20, #16]
	mov	x21, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB13_3:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB13_4:
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
Lloh144:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh145:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh146:
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	sub	x2, x1, x0
	cmp	x0, #0
	csel	x9, xzr, x2, eq
	tbnz	x9, #63, LBB14_8
; %bb.1:
	cmp	x9, #255
	b.hi	LBB14_9
; %bb.2:
	str	xzr, [sp, #8]
	lsl	x8, x9, #48
	strb	w9, [sp, #22]
	strh	wzr, [sp, #20]
	str	w8, [sp, #16]
	cbz	x0, LBB14_6
; %bb.3:
	cmp	x1, x0
	b.ne	LBB14_5
; %bb.4:
	mov	x0, #0                          ; =0x0
	b	LBB14_6
LBB14_5:
	mov	x1, x0
	add	x0, sp, #8
	bl	_memcpy
	ldr	x0, [sp, #8]
	ldrb	w8, [sp, #22]
	ldrh	w9, [sp, #20]
	orr	w8, w9, w8, lsl #16
	ldr	w9, [sp, #16]
	orr	x8, x9, x8, lsl #32
LBB14_6:
	ldur	x9, [x29, #-8]
Lloh147:
	adrp	x10, ___stack_chk_guard@GOTPAGE
Lloh148:
	ldr	x10, [x10, ___stack_chk_guard@GOTPAGEOFF]
Lloh149:
	ldr	x10, [x10]
	cmp	x10, x9
	b.ne	LBB14_10
; %bb.7:
	and	x1, x8, #0xffffffffffffff
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB14_8:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB14_9:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB14_10:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh144, Lloh145, Lloh146
	.loh AdrpLdrGotLdr	Lloh147, Lloh148, Lloh149
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
	cbnz	x8, LBB16_2
; %bb.1:
	mov	x1, x0
	lsl	x0, x19, #32
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB16_2:
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
	cbz	x0, LBB17_3
; %bb.1:
	subs	x8, x1, x0
	b.ne	LBB17_4
; %bb.2:
	mov	x0, #0                          ; =0x0
LBB17_3:
	mov	x1, #-4611686018427387904       ; =0xc000000000000000
	ret
LBB17_4:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	cmp	x8, #15
	b.hs	LBB17_6
; %bb.5:
	bl	_$s10Foundation4DataV06InlineB0VyAESWcfCTf4nd_n
	and	x1, x1, #0xffffffffffffff
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB17_6:
	mov	w9, #2147483647                 ; =0x7fffffff
	cmp	x8, x9
	b.hs	LBB17_8
; %bb.7:
	bl	_$s10Foundation4DataV11InlineSliceVyAESWcfCTf4nd_n
	orr	x1, x1, #0x4000000000000000
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB17_8:
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
	cbz	x0, LBB18_4
; %bb.1:
	mov	x19, x0
	cmp	x0, #15
	b.ge	LBB18_5
; %bb.2:
	tbnz	x19, #63, LBB18_9
; %bb.3:
	mov	x0, #0                          ; =0x0
	lsl	x1, x19, #48
	b	LBB18_8
LBB18_4:
	mov	x1, #-4611686018427387904       ; =0xc000000000000000
	b	LBB18_8
LBB18_5:
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
	b.hs	LBB18_7
; %bb.6:
	lsl	x0, x19, #32
	orr	x1, x20, #0x4000000000000000
	b	LBB18_8
LBB18_7:
	mov	x0, #0                          ; =0x0
	bl	_$s10Foundation4DataV14RangeReferenceCMa
	mov	w1, #32                         ; =0x20
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
	stp	xzr, x19, [x0, #16]
	orr	x1, x20, #0x8000000000000000
LBB18_8:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB18_9:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function $s10PrimeSwift9BenchmarkV4mainyyFZTf4d_n
lCPI19_0:
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
Lloh150:
	adrp	x16, ___chkstk_darwin@GOTPAGE
Lloh151:
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
	b.ne	LBB19_8
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
LBB19_2:                                ; =>This Inner Loop Header: Depth=1
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
	b.vs	LBB19_6
; %bb.3:                                ;   in Loop: Header=BB19_2 Depth=1
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
	b.lo	LBB19_7
; %bb.4:                                ;   in Loop: Header=BB19_2 Depth=1
	add	x25, x24, x25
	add	x28, x28, #1
	cmp	x8, x19
	b.lo	LBB19_2
; %bb.5:
	ucvtf	d0, x8
	mov	x8, #225833675390976            ; =0xcd6500000000
	movk	x8, #16845, lsl #48
	fmov	d1, x8
	fdiv	d8, d0, d1
Lloh152:
	adrp	x0, _$ss23_ContiguousArrayStorageCyypGMd@PAGE
Lloh153:
	add	x0, x0, _$ss23_ContiguousArrayStorageCyypGMd@PAGEOFF
Lloh154:
	adrp	x1, _$ss23_ContiguousArrayStorageCyypGMR@PAGE
Lloh155:
	add	x1, x1, _$ss23_ContiguousArrayStorageCyypGMR@PAGEOFF
	bl	___swift_instantiateConcreteTypeFromMangledNameV2
	mov	w1, #64                         ; =0x40
	mov	w2, #7                          ; =0x7
	bl	_swift_allocObject
	mov	x21, x0
Lloh156:
	adrp	x8, lCPI19_0@PAGE
Lloh157:
	ldr	q0, [x8, lCPI19_0@PAGEOFF]
	str	q0, [x0, #16]
	mov	x23, #-2305843009213693952      ; =0xe000000000000000
	stp	xzr, x23, [x29, #-160]
	sub	x20, x29, #160
	mov	w0, #73                         ; =0x49
	bl	_$ss11_StringGutsV4growyySiF
	ldp	x8, x9, [x29, #-160]
	stp	x8, x9, [x29, #-160]
Lloh158:
	adrp	x8, "l_.str.31.fahlman_swift_striped_unrolled;"@PAGE
Lloh159:
	add	x8, x8, "l_.str.31.fahlman_swift_striped_unrolled;"@PAGEOFF
	sub	x8, x8, #32
	mov	x24, #31                        ; =0x1f
	movk	x24, #53248, lsl #48
	orr	x1, x8, #0x8000000000000000
	mov	x0, #31                         ; =0x1f
	movk	x0, #53248, lsl #48
	bl	_$sSS6appendyySSF
	stur	x26, [x29, #-168]
Lloh160:
	adrp	x0, _$sSiN@GOTPAGE
Lloh161:
	ldr	x0, [x0, _$sSiN@GOTPAGEOFF]
Lloh162:
	adrp	x1, _$sSis23CustomStringConvertiblesWP@GOTPAGE
Lloh163:
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
Lloh164:
	adrp	x1, _$ss26DefaultStringInterpolationVN@GOTPAGE
Lloh165:
	ldr	x1, [x1, _$ss26DefaultStringInterpolationVN@GOTPAGEOFF]
Lloh166:
	adrp	x2, _$ss26DefaultStringInterpolationVs16TextOutputStreamsWP@GOTPAGE
Lloh167:
	ldr	x2, [x2, _$ss26DefaultStringInterpolationVs16TextOutputStreamsWP@GOTPAGEOFF]
	sub	x0, x29, #160
	mov.16b	v0, v8
	bl	_$sSd5write2toyxz_ts16TextOutputStreamRzlF
Lloh168:
	adrp	x8, "l_.str.37.;1;algorithm=base,faithful=yes,bits=1"@PAGE
Lloh169:
	add	x8, x8, "l_.str.37.;1;algorithm=base,faithful=yes,bits=1"@PAGEOFF
	sub	x8, x8, #32
	add	x0, x24, #6
	orr	x1, x8, #0x8000000000000000
	bl	_$sSS6appendyySSF
	ldp	x8, x9, [x29, #-160]
Lloh170:
	adrp	x10, _$sSSN@GOTPAGE
Lloh171:
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
Lloh172:
	adrp	x8, l_OBJC_CLASS_REF_$_NSFileHandle@PAGE
Lloh173:
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
Lloh174:
	adrp	x8, "l_.str.35.Validated: 78498 primes; checksum: "@PAGE
Lloh175:
	add	x8, x8, "l_.str.35.Validated: 78498 primes; checksum: "@PAGEOFF
	sub	x8, x8, #32
	orr	x8, x8, #0x8000000000000000
	add	x9, x24, #4
	stp	x9, x8, [x29, #-160]
	stur	x25, [x29, #-168]
Lloh176:
	adrp	x0, _$ss6UInt64VN@GOTPAGE
Lloh177:
	ldr	x0, [x0, _$ss6UInt64VN@GOTPAGEOFF]
Lloh178:
	adrp	x1, _$ss6UInt64Vs23CustomStringConvertiblesWP@GOTPAGE
Lloh179:
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
LBB19_6:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB19_7:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
LBB19_8:
	; InlineAsm Start
	; InlineAsm End
	brk	#0x1
	.loh AdrpLdrGot	Lloh178, Lloh179
	.loh AdrpLdrGot	Lloh176, Lloh177
	.loh AdrpAdd	Lloh174, Lloh175
	.loh AdrpLdr	Lloh172, Lloh173
	.loh AdrpLdrGot	Lloh170, Lloh171
	.loh AdrpAdd	Lloh168, Lloh169
	.loh AdrpLdrGot	Lloh166, Lloh167
	.loh AdrpLdrGot	Lloh164, Lloh165
	.loh AdrpLdrGot	Lloh162, Lloh163
	.loh AdrpLdrGot	Lloh160, Lloh161
	.loh AdrpAdd	Lloh158, Lloh159
	.loh AdrpLdr	Lloh156, Lloh157
	.loh AdrpAdd	Lloh154, Lloh155
	.loh AdrpAdd	Lloh152, Lloh153
	.loh AdrpLdrGot	Lloh150, Lloh151
	.cfi_endproc
                                        ; -- End function
	.private_extern	_$s10PrimeSwift0A5SieveCMa ; -- Begin function $s10PrimeSwift0A5SieveCMa
	.globl	_$s10PrimeSwift0A5SieveCMa
	.p2align	2
_$s10PrimeSwift0A5SieveCMa:             ; @"$s10PrimeSwift0A5SieveCMa"
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh180:
	adrp	x0, _$s10PrimeSwift0A5SieveCMf@PAGE+24
Lloh181:
	add	x0, x0, _$s10PrimeSwift0A5SieveCMf@PAGEOFF+24
	bl	_objc_opt_self
	mov	x1, #0                          ; =0x0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh180, Lloh181
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
	b.eq	LBB21_2
; %bb.1:
	ldr	x9, [x1]
	asr	x8, x9, #32
	add	x0, x1, w9, sxtw
	mov	x1, x8
	mov	x2, #0                          ; =0x0
	mov	x3, #0                          ; =0x0
	bl	_swift_getTypeByMangledNameInContext2
	str	x0, [x19]
LBB21_2:
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
	b.eq	LBB22_3
; %bb.1:
	cmp	w8, #2
	b.ne	LBB22_4
; %bb.2:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	bl	_swift_release
	mov	x1, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
LBB22_3:
	and	x0, x1, #0x3fffffffffffffff
	b	_swift_release
LBB22_4:
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
Lloh182:
	adrp	x0, _$s10Foundation15ContiguousBytes_pSgMd@PAGE
Lloh183:
	add	x0, x0, _$s10Foundation15ContiguousBytes_pSgMd@PAGEOFF
Lloh184:
	adrp	x1, _$s10Foundation15ContiguousBytes_pSgMR@PAGE
Lloh185:
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
	.loh AdrpAdd	Lloh184, Lloh185
	.loh AdrpAdd	Lloh182, Lloh183
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
	b.eq	LBB25_3
; %bb.1:
	cmp	w8, #2
	b.ne	LBB25_4
; %bb.2:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	bl	_swift_retain
	mov	x1, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
LBB25_3:
	and	x0, x1, #0x3fffffffffffffff
	b	_swift_retain
LBB25_4:
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
	b.ls	LBB26_2
; %bb.1:
	ret
LBB26_2:
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
	tbz	w8, #17, LBB28_2
; %bb.1:
	ldr	x9, [x0]
	and	x8, x8, #0xff
	add	x10, x8, #16
	bic	x8, x10, x8
	add	x0, x9, x8
LBB28_2:
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
	tbnz	w9, #1, LBB29_2
; %bb.1:
	ldr	x2, [x8, #8]
	br	x2
LBB29_2:
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
Ltmp2:
	.long	_$ss5UInt8VMn@GOT-Ltmp2
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
Ltmp3:
	.long	_$ss23_ContiguousArrayStorageCMn@GOT-Ltmp3
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
Ltmp4:
	.long	_$s10Foundation15ContiguousBytesMp@GOT-Ltmp4
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
Ltmp5:
	.long	_$s10Foundation15ContiguousBytesMp@GOT-Ltmp5
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
Ltmp6:
	.long	_$ss23_ContiguousArrayStorageCMn@GOT-Ltmp6
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
