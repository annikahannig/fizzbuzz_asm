
;
; FizzBuzz
;
; Write a program that prints the numbers from 1 to 100. But
; for multiples of three print "Fizz" instead of the number
; and for the multiples of five print "Buzz". For numbers which
; are multiples of both three and five print "FizzBuzz".
;

section .data

  txt_num      db "%d", 0xa, 0
  txt_fizz     db "fizz", 0xa, 0
  txt_buzz     db "buzz", 0xa, 0
  txt_fizzbuzz db "fizzbuzz", 0xa, 0


section .text
  extern printf

  global main


;
; FizzBuzz main
;
main:
  ; setup stack
  push rbp
  mov  rbp, rsp

  mov rcx, 1 ; count from 1
  
counter:
  push rcx ; save counter in case it will
           ; be modified in the subsequent functions

  ; is divisible by 3 or 5 (or 3*5)
  xor rdx, rdx ; clear remainder
  mov rax, rcx ; divide current counter
  mov rbx, 15  ; by 3 or 5
  div rbx
  cmp rdx, 0   ; true
  jz  print_fizzbuzz
       
  ; is divisible by 5
  xor rdx, rdx ; clear remainder
  mov rax, rcx ; divide current counter
  mov rbx, 5   ; by 5
  div rbx
  cmp rdx, 0   ; true
  jz  print_buzz

  ; is divisible by 3
  xor rdx, rdx ; clear remainder
  mov rax, rcx ; divide current counter
  mov rbx, 3   ; by 3
  div rbx
  cmp rdx, 0   ; true
  jz  print_fizz

  ; otherwise
  jmp print_n


print_fizz:
  xor  rax, rax ; clear register

  mov  rdi, txt_fizz  
  call printf         ; printf(rdi,  rsi, rdx, rcx, r8, r9)
  jmp  next


print_buzz:
  xor  rax, rax 

  mov  rdi, txt_buzz
  call printf
  jmp  next


print_fizzbuzz:
  xor  rax, rax

  mov  rdi, txt_fizzbuzz
  call printf
  jmp  next


print_n:
  xor  rax, rax

  mov  rsi, rcx ; arg0 = fmt_string, arg1 = counter
  mov  rdi, txt_num
  call printf


next:
  pop rcx ; restore counter
  inc rcx ; += 1

  cmp rcx, 100 ; loop from 1 .. 100
  jle counter

  ; restore stack
  pop rbp

  ; and return 0
  xor eax, eax 
  ret

