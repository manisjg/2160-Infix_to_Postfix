;******************************************************************************** 
;* Program Name: InfixToPostfix.pep
;* Programmer: Jacob Manis, Matthew Beeler, Thomas Justice, and Gabriel Vieira Ramos 
;* Class: CSCI 2160-001 
;* Project: CSCI 2160 - Project 1 - Infix to Postfix Calculator 
;* Date: 2/18/2022 
;* Purpose: <write a few descriptive sentences here - answer what, how, why>
;******************************************************************************** 
BR                           main


input:          .BLOCK    5    ;global variable #5c
int1:           .BLOCK    2    ;global variable #2d  
operator:       .BLOCK    1    ;global variable #1c 
int2:           .BLOCK    2    ;global variable #2d 
answer:         .BLOCK    2    ;global variable #2d 
scratch:        .BLOCK    2    ;global variable #2d 
rem:            .BLOCK    2    ;global variable #2d 


main:            STRO        request,d        ;output request message to get user input     
                 
                 LDBA        0,i
                 STWA        rem,d


                 LDBA        charIn,x         ;grabs first input character
                 STWA        input,x          ;stores this byte to input
                 ADDX        2,i              ;adds 2 to the index
                
                 LDBA        charIn,d         ;grabs the operator from input
                 STBA        input,x          ;stores operand to input
                 ADDX        1,i              ;adds 1 to the index
                 
                 LDBA        charIn,d         ;grabs the last input character
                 STBA        input,x          ;stores this to the input
                 BR          fillvars

fillvars:        LDWX        0,i              ;resets the index back to zero to parse through the input variable
                 LDWA        input,x          ;loads the first number into the accumulator

                 SUBA        48,i             ;NOTE: in order to get the values of the numbers that were input, I had to subtract the numbers by 48. For example, if you had a 7, it would load into the accumulator 0x0037. To get to 7 you would have to subtract the value by 48 to get to 0x0007. Also, when looking at the pep/9 reference table, 7 has a hex value 37. There may be an issue on my part causing this, but it does work.

                                              ;NOTE: this also only works on single digits.
                 STWA        int1,d           ;store the first number from input to int1
                 ADDX        2,i              ;add two to the index
                 LDBA        input,x          ;loads the operator to the accumulator
                 STBA        operator,d       ;stores the operator to its variable
                 ADDX        1,i              ;add 1 to the index
                 LDBA        input,x          ;loads last number to accumulator
                 SUBA        48,i             ;subtract 48 to get number value.
                 STWA        int2,d           ;store last number to the int2 variable

                 
                 LDBA        operator,d       ;loads operand 
                 CPBA        '+',i            ;checks if operand is a plus sign
                 BREQ        addBR            ;breaks to add statements if equal 
                 
                 LDBA        operator,d       ;loads operand 
                 CPBA        '-',i            ;checks if operand is a minus sign
                 BREQ        subBR            ;breaks to subtract statements if equal 

                 LDBA        operator,d       ;loads operand 
                 CPBA        '*',i            ;checks if operand is multiplication
                 BREQ        multBR            ;breaks to multiply statements if equal 
                 
                 LDBA        operator,d       ;loads operand 
                 CPBA        '/',i            ;checks if operand is division
                 BREQ        divBR            ;breaks to divide statements if equal 


addBR:           LDWA        int1,d           ;loads first int
                 ADDA        int2,d           ;adds second int
                 STWA        answer,d         ;stores to answer

                 

                 BR          output           ;breaks to output

subBR:           LDWA        int1,d           ;loads first int
                 SUBA        int2,d           ;subtracts second int
                 STWA        answer,d         ;stores to answer


                 BR          output           ;breaks to output

multBR:          LDWX        0,i              ;initialize counter
                 LDWA        int1,d           ;loads first int
reMult:          ADDX        1,i              ;update counter
                 CPWX        int2,d           ;compare counter to second int
                 BREQ        endMult          ;breaks out of loop if counter = int2
                 ADDA        int1,d           ;adds int 1
                 BR          reMult           ;loops if counter =/= int2

endMult:         STWA        answer,d         ;stores to answer
                 

                 BR          output           ;breaks to output


divBR:           LDWX        0,i              ;initialize counter
                 LDWA        int1,d           ;loads first int
                 STWA        scratch,d        ;copies first int
reDiv:           LDWA        scratch,d        ;reloads scratch for comparison    
                 CPWA        0,i              ;compare counter to second int 
                 
                 BREQ        endDiv           ;breaks out of loop if scratch = 0
                 BRLT        endRem           ;breaks out of loop if scratch < 0
                 ADDX        1,i              ;update counter
                 LDWA        scratch,d        ;reloads scratch for subtraction
                 SUBA        int2,d           ;subtracts int2
                 STWA        scratch,d        ;saves new value to scratch
                 BR          reDiv            ;loops if counter =/= int2

endDiv:          STWX        answer,d         ;stores to answer
                 

                 BR          output           ;breaks to output



endRem:          ADDA        int2,d 
                 STWA        rem,d            ;stores remainder if there is one
                 SUBX        1,i
                 STWX        answer,d         ;stores to answer
                 

                 BR          outputR          ;breaks to output

                 ;OUTPUT WITH A REMAINDER
outputR:         STRO        newline,d        ;outputs newline
                 STRO        infix,d          ;outputs infix message
                 DECO        int1,d           ;out first number
                 STRO        space,d          ;space out
                 STRO        operator,d       ;out operator
                 STRO        space,d          ;space out
                 DECO        int2,d           ;out second num
                 STRO        eq,d             ;out equals
                 DECO        answer,d         ;out answer
                 STRO        remain,d         ;out remainder message
                 DECO        rem,d            ;out remainder

                 STRO        newline,d        ;outputs newline
                 STRO        postfix,d        ;outputs postfix message
                 DECO        int1,d           ;out first number
                 STRO        space,d          ;space out
                 DECO        int2,d           ;out second num
                 STRO        space,d          ;space out
                 STRO        operator,d       ;out operator
                 STRO        eq,d             ;out equals
                 DECO        answer,d         ;out answer
                 STRO        remain,d         ;out remainder message
                 DECO        rem,d            ;out remainder

                 BR          stop             ;breaks to stop











                 ;OUTPUT 
output:          STRO        newline,d        ;outputs newline
                 STRO        infix,d          ;outputs infix message 
                 DECO        int1,d           ;out first number
                 STRO        space,d          ;space out
                 STRO        operator,d       ;out operator
                 STRO        space,d          ;space out
                 DECO        int2,d           ;out second num
                 STRO        eq,d             ;out equals
                 DECO        answer,d         ;out answer
                 

                 STRO        newline,d        ;outputs newline
                 STRO        postfix,d        ;outputs postfix message
                 DECO        int1,d           ;out first number
                 STRO        space,d          ;space out
                 DECO        int2,d           ;out second num
                 STRO        space,d          ;space out
                 STRO        operator,d       ;out operator
                 STRO        eq,d             ;out equals
                 DECO        answer,d         ;out answer
                 

                 BR          stop             ;breaks to stop





stop:            STOP             

request:         .ASCII      "Please enter a mathmatical expression that contains only one operator and single-digit, non-negative integers. \x00"
newline:         .ASCII      "\n\x00"
space:           .ASCII      " \x00"
eq:              .ASCII      " = \x00"
infix:           .ASCII      "INFIX NOTATION:\t \x00"
postfix:         .ASCII      "POSTFIX NOTATION:\t \x00"
remain:         .ASCII       " R\x00"
.end