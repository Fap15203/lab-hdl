# Sơ đồ khối DATAPATH và CONTROLLER tổng hợp:
Sử dụng sơ đồ dưới đây để tham khảo kiến trúc MIPS processor trong bài này
![image](https://github.com/Fap15203/lab-hdl/assets/42090475/3ed2573f-de28-48a1-9884-c163e17b4bc8)

# Testbench:
Sử dụng tool sau để đổi từ Assembly sang mã hex cho MIPS: https://www.eg.bucknell.edu/~csci320/mips_web/

### 1. Testbench và top module sử dụng instruction memory và thanh ghi PC
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
### 2. Testbench và top module KHÔNG sử dụng instruction memory và thanh ghi PC

Đây là phiên bản đơn giản hoá vừa đạt đúng yêu cầu cho lab 5 6.

Đối với top module: hoàn toàn giống sơ đồ ở trên.

Đối với testbench: Gồm 3 khối initial với 3 chức năng như sau
- Tạo clock chu kỳ 2ns
- Tạo reset trong 4ns đầu
- Sau 4ns reset thì bắt đầu nạp các lệnh cho top module



