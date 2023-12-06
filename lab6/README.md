# Lưu ý
1. Chưa có testbench riêng cho lab 5 nên cần xem xét và sửa chữa dựa vào bài tổng hợp lab5 + lab6 đã có
2. Tham khảo sơ đồ khối sau (đối với lab 6 không cần thiết lắm):
![image](https://github.com/Fap15203/lab-hdl/assets/42090475/3ed2573f-de28-48a1-9884-c163e17b4bc8)
3.
                RegDst      =   thanh ghi đích;
                RegWrite    =   cho phép ghi vào thanh ghi;
                ALUsrc      =   phép tính đối với thanh ghi khác/ đối với số tức thời;
                alu_control =   lệnh cho bộ alu;
                MemWrite    =   cho phép ghi vào bộ nhớ;
                MemRead     =   cho phép đọc từ bộ nhớ; // không dùng, lúc nào cũng đọc từ bộ nhớ
                MemToReg    =   lấy kết quả cuối cùng từ bộ nhớ/ alu;
