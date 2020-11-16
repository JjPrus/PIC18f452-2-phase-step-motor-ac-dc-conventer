list p=18f452
    #include <p18f452.inc>
    
    
; PIC18F452 Configuration Bit Settings
 
; Assembly source line config statements
 
; CONFIG1H
  CONFIG  OSC = RCIO            ; Oscillator Selection bits (RC oscillator w/ OSC2 configured as RA6)
  CONFIG  OSCS = OFF            ; Oscillator System Clock Switch Enable bit (Oscillator system clock switch option is disabled (main oscillator is source))
 
; CONFIG2L
  CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOR = ON              ; Brown-out Reset Enable bit (Brown-out Reset enabled)
  CONFIG  BORV = 20             ; Brown-out Reset Voltage bits (VBOR set to 2.0V)
 
; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 128           ; Watchdog Timer Postscale Select bits (1:128)
 
; CONFIG3H
  CONFIG  CCP2MUX = ON          ; CCP2 Mux bit (CCP2 input/output is multiplexed with RC1)
 
; CONFIG4L
  CONFIG  STVR = ON             ; Stack Full/Underflow Reset Enable bit (Stack Full/Underflow will cause RESET)
  CONFIG  LVP = ON              ; Low Voltage ICSP Enable bit (Low Voltage ICSP enabled)
 
; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000200-001FFFh) not code protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) not code protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) not code protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) not code protected)
 
; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot Block (000000-0001FFh) not code protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM not code protected)
 
; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000200-001FFFh) not write protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) not write protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) not write protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) not write protected)
 
; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) not write protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot Block (000000-0001FFh) not write protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM not write protected)
 
; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000200-001FFFh) not protected from Table Reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) not protected from Table Reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) not protected from Table Reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) not protected from Table Reads executed in other blocks)
 
; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot Block (000000-0001FFh) not protected from Table Reads executed in other blocks)

  
RES_VECT CODE 0x0000
 
goto START
         
MAIN_PROG CODE   
 


    ; Delay = 0.5 seconds
   ; Clock frequency = 4 MHz

   ; Actual delay = 0.5 seconds = 500000 cycles
   ; Error = 0 %
;   DELAY
;	   cblock
;	   d1
;	   d2
;	   d3
;	   endc
;
;			   ;499994 cycles
;	   movlw	0x03
;	   movwf	d1
;	   movlw	0x18
;	   movwf	d2
;	   movlw	0x02
;	   movwf	d3
;   Delay_0
;	   decfsz	d1, f
;	   goto	$+2
;	   decfsz	d2, f
;	   goto	$+2
;	   decfsz	d3, f
;	   goto	Delay_0
;
;			   ;6 cycles
;	   goto	$+2
;	   goto	$+2
;	   goto	$+2
   
;   RETURN

;subwf 0x82,1 
;       btfsc STATUS, C
   
       CZEKAJ
       
       movlw 0xFF
       movwf 0x80
       movwf 0x81
       CZEKAJ1
       subwf 0x80, 1
       btfsc STATUS,C
       return
       CZEKAJ2
       subwf 0x81, 1
       btfsc STATUS,C
       goto CZEKAJ1
       goto CZEKAJ2
       return


     POLP
       movlw 0xCC
       movwf 0x86
      KROKP
       clrf TRISB
       movlw b'00000001'
       movwf PORTB
       goto CZEKAJ
       movlw b'00000010'
       movwf PORTB
       goto CZEKAJ 
       movlw b'00001000'
       movwf PORTB
       goto CZEKAJ
       movlw b'00001000'
       movwf PORTB 
       goto CZEKAJ 
       subwf 0x86,1 
       btfsc STATUS, C
       return
      goto KROKP


     POLL
       movlw 0xCC
       movwf 0x87

       KROKL
       clrf TRISB
       movlw b'00001000'
       movwf PORTB
       movlw b'00000100'
       movwf PORTB
       movlw b'00000010'
       movwf PORTB
       movlw b'00000001'
       movwf PORTB
       subwf 0x87,1 
       btfsc STATUS, C
       return
       goto KROKL
       return

      STOP
       clrf TRISB
       movlw b'00000000'
       movwf PORTB

       movlw b'00000000'
       movwf PORTB

       movlw b'00000000'
       movwf PORTB

       movlw b'00000000'
       movwf PORTB
       return
       

    START

       movlw 0x03 ;3 obroty 
       movwf 0x82

       movlw 0x04 ;4 obroty
       movwf 0x83



    LOOP

     P1
     

      P11
       goto POLP
       subwf 0x82,1 
       btfsc STATUS, C
       goto P2
       goto P11

     P2
       goto STOP
       goto CZEKAJ
      P21
       goto POLL

       subwf 0x83,1 

       btfsc STATUS, C
       goto LOOP
       goto P21

       END
-
