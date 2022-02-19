;******************************************************************************** 
;* Program Name: InfixToPostfix.pep
;* Programmer: Jacob Manis, Matthew Beeler, Thomas Justice, and Gabriel Vieira Ramos 
;* Class: CSCI 2160-001 
;* Project: CSCI 2160 - Project 1 - Infix to Postfix Calculator 
;* Date: 2/18/2022 
;* Purpose: <write a few descriptive sentences here - answer what, how, why>
;******************************************************************************** 
BR                           main



int1:           .BLOCK    2    ;global variable #2d  
operator:       .BLOCK    1    ;global variable #1c 
int2:           .BLOCK    2    ;global variable #2d 
answer:         .BLOCK    2    ;global variable #2d 




main:            STRO        request,d        ;output request message to get user input            
                 DECI        int1,d           ;sets int1 to the user input
                
                 LDBA        charIn,d         ;loads operand 
                 STBA        operator,d       ;stores operand to operator
                 
                 DECI        int2,d           ;sets int2 to the user input
                 
                 LDBA        operator,d       ;loads operand 
                 CPBA        '+',i            ;checks if operand is a plus sign
                 BREQ        addBR            ;breaks to add statements if equal 
                 
                 LDBA        operator,d       ;loads operand 
                 CPBA        '-',i            ;checks if operand is a minus sign
                 BREQ        subBR            ;breaks to subtract statements if equal 




addBR:           LDWA        int1,d           ;loads first int
                 ADDA        int2,d           ;adds second int
                 STWA        answer,d         ;stores to answer

                 

                 BR          output           ;breaks to output

subBR:           LDWA        int1,d           ;loads first int
                 SUBA        int2,d           ;subtracts second int
                 STWA        answer,d         ;stores to answer






                 ;OUTPUT 
output:          STRO        newline,d
                 STRO        infix,d
                 DECO        int1,d 
                 STRO        space,d 
                 STRO        operator,d 
                 STRO        space,d 
                 DECO        int2,d
                 STRO        eq,d
                 DECO        answer,d

                 STRO        newline,d
                 STRO        postfix,d
                 DECO        int1,d
                 STRO        space,d  
                 DECO        int2,d
                 STRO        space,d 
                 STRO        operator,d 
                 STRO        eq,d
                 DECO        answer,d

                 BR          stop             ;breaks to stop





stop:            STOP             

request:         .ASCII      "Please enter a mathmatical expression that contains only one operator and single-digit, non-negative integers. \x00"
newline:         .ASCII      "\n\x00"
space:           .ASCII      " \x00"
eq:              .ASCII      " = \x00"
infix:           .ASCII      "INFIX NOTATION:\t \x00"
postfix:         .ASCII      "POSTFIX NOTATION:\t \x00"
.end