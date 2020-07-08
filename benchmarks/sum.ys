    irmovq $4,%rsi
    irmovq $0,%rdi
    irmovq $8,%r8
    irmovq $1,%r9
    xorq %rax,%rax
    andq %rsi,%rsi
    jmp test
loop:
    mrmovq (%rdi),%r10
    addq %r10,%rax
    addq %r8,%rdi
    subq %r9,%rsi
test:
    jne loop
    ret
