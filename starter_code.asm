;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3000

LD R4 baseptr
LD R5 maxptr
LD R6 topptr

;this stack lab computes the polish notation of a set of calls
;push_val(4) pushes the value 4 onto the stack [4]
;push_val(3) pushes the value 3 onto the stack [4,3]
;push_val(2) pushes the value 2 onto the stack [4,3,2]
;add_val() pop 3,2 and push the result of 3+2 onto the stack [4,5]
;add_val() pop 4,5 and push the result of 4+5 onto the stack[9]
;----------push 
GETC
OUT

LD R3 ascii
ADD R0, R0, R3

LD R1 subpushptr
JSRR R1

;----------push
GETC
OUT

ADD R0 R0 R3

LD R1 subpushptr
JSRR R1

LD R4 baseptr
LD R5 maxptr

LD R1 subaddptr
JSRR R1

;----------add 
GETC
OUT

ADD R0 R0 R3

LD R1 subpushptr
JSRR R1

LD R4 baseptr
LD R5 maxptr

LD R1 subaddptr
JSRR R1
;move the top value of the stack into r4
;----------pop
LD R1 subpopptr
JSRR R1

AND R4 R4 #0
ADD R4 R4 R0

halt
;------------------------------------------------------------------------------------------
baseptr     .fill xA000
maxptr      .fill xA005
topptr      .fill xA000

subpushptr  .fill x3400
subpopptr   .fill x3800
subaddptr   .FILL x4200

ascii       .fill #-48

.end
;------------------------------------------------------------------------------------------
.orig x3400 ;;push_val(int val)implement your push function that will push a value onto the stack

ST R1 r1push
ST R2 r2push
ST R3 r3push
ST R4 r4push
ST R5 r5push
ST R7 r7push

;LD R4 baseptr
;LD R5 maxptr
;LD R6 TOSptr

ADD R6 R6 #1
NOT R5 R5
ADD R5 R5 #1
ADD R5 R5 R6  
;check TOS with MAX
STR R0 R6 #0

LD R1 r1push
LD R2 r2push
LD R3 r3push
LD R4 r4push
LD R5 r5push
LD R7 r7push

ret
;------------------------------------------------------------------------------------------
r1push  .blkw #1
r2push  .blkw #1
r3push  .blkw #1
r4push  .blkw #1
r5push  .blkw #1
r7push  .blkw #1
.end
;------------------------------------------------------------------------------------------
.orig x3800 ;; add_val() pops two values from the top of the stack and pushes the result of adding the poppped value into the stack

ST R1 r1pop
ST R2 r2pop
ST R3 r3pop
ST R4 r4pop
ST R5 r5pop
ST R7 r7pop

;LD R4, baseptr
;LD R5, maxptr
;LD R6, TOSptr

NOT R4 R4
ADD R4 R4 #1
ADD R4 R4 R6 
;check TOS with BASE
LDR R0 R6 #0
ADD R6 R6 #-1
;decreament of stackpointer

LD R1 r1pop
LD R2 r2pop
LD R3 r3pop
LD R4 r4pop
LD R5 r5pop
LD R7 r7pop				 

ret

;------------------------------------------------------------------------------------------
r1pop   .blkw #1
r2pop   .blkw #1
r3pop   .blkw #1
r4pop   .blkw #1
r5pop   .blkw #1
r7pop   .blkw #1
;------------------------------------------------------------------------------------------
.end
;------------------------------------------------------------------------------------------
.orig x4200 ;;data you might need

ST R1 r1add
ST R2 r2add
ST R3 r3add
ST R4 r4add
ST R5 r5add
ST R7 r7add

LD R1 popptr
JSRR R1

ADD R2 R0 #0

LD R1 popptr
JSRR R1

ADD R3 R0 #0

ADD R0 R3 R2

LD R1 pushptr
JSRR R1

LD R1 r1add
LD R2 r2add
LD R3 r3add
LD R4 r4add
LD R5 r5add
LD R7 r7add	
ret
;------------------------------------------------------------------------------------------
popptr  .FILL x3800
pushptr .FILL x3400
r1add   .blkw #1
r2add   .blkw #1
r3add   .blkw #1
r4add   .blkw #1
r5add   .blkw #1
r7add   .blkw #1
;------------------------------------------------------------------------------------------
.end


