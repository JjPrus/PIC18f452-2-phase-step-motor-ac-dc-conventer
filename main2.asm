RES_VECT CODE 0x0000
 
goto START
         
MAIN_PROG CODE 

CZEKAJ
       return
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

       movlw b'00000010'
       movwf PORTB

       movlw b'00001000'
       movwf PORTB

       movlw b'00001000'
       movwf PORTB 

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
      goto CZEKAJ

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
