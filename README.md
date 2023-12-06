# lab-hdl
Sử dụng sơ đồ dưới đây để tham khảo kiến trúc MIPS processor trong bài này
![image](https://github.com/Fap15203/lab-hdl/assets/42090475/3ed2573f-de28-48a1-9884-c163e17b4bc8)

Những file pc.v, pc_adder.v, imem.v và instr_file.mem dùng để nạp sẵn một số lệnh dưới dạng mã hex

File instr_file.mem:
```mem
2109000A
210A0012
210B000A
210C0014
210D001E
01494820
8D4C0008
AD4B000A
8D4D000A
```
Tương ứng với:
```asm
addi t1 , t0,   0x000a 
addi t2 , t0,   0x0012
addi t3 , t0,   0x000a 
addi t4 , t0,   0x0014 
addi t5 , t0,   0x001e 
    
add t1, t2, t1
lw t4, 0x8(t2)
sw t3, 0xa(t2)
lw t5, 0xa(t2) 
```

Sử dụng tool sau để đổi từ Assembly sang mã hex cho MIPS: https://www.eg.bucknell.edu/~csci320/mips_web/

