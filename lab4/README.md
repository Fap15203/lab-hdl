# Những việc cần làm đối với lab 4
Ngoại trừ Single Port RAM, tất cả cách module ALU, Register File, Data Memory đều sẽ được tái sử dụng trong lab 5, Datapath của bộ xử lý MIPS.
## 1. Thực hiện bộ ALU 
Đối với ALU trong lab 4, module đọc giá trị f (function) và thực hiện các phép tính với ngõ vào 32 bit a và b.

Nên sửa lại các câu lệnh if else thành case, thêm trường hợp default hoặc else để hạn chế phần tử nhớ dư thừa xuất hiện trong mạch.

Có thể thêm các parameter cho code "sạch" hơn.
```v
parameter comp = 3'b000;
parameter and  = 3'b001;
para...
```
## 2. Thực hiện các module nhớ
Về cơ bản các module nhớ khá tương đồng về mặt thiết kế và hành vi, lấy ví dụ hành vi của module Data memory.
```v
always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i=0;i<64;i=i+1) begin
                mem[i] = 32'b0;
            end
        end
        else begin
            if (MemRW) mem[address] <= DataW;
        end
    end
    assign DataR = mem[address];
```
Chức năng:
* Reset: tính cực mức thấp, dùng vòng for để gán toàn bộ giá trị trong bộ nhớ về 0.
* Lưu (Store Word): khi có clk cạnh lên và rst mức cao, hệ thống kiểm tra nếu cho phép ghi (MemRW == 1) thì lưu dữ liệu vào vị trí trong bộ nhớ dựa vào địa chỉ
* Đọc (Load Word): dữ liệu luôn luôn được đọc dựa vào địa chỉ input, không có kiểm tra điều kiện cho phép đọc

Ngoài ra, do bài tập 4 Single Port RAM yêu cầu data read và write qua một cổng inout, cần tạo thanh ghi temporary data trước khi xuất giá trị qua cổng inout.

Tham khảo Single Port RAM tại: https://www.chipverify.com/verilog/verilog-single-port-ram

Cách sử dụng cổng inout: https://electronics.stackexchange.com/questions/556859/verilog-testbench-for-inout
## 3. Chỉnh sửa lại testbench
### Đối với testbench cho ALU: 
Đừng sử dụng lại testbench trong git này, testbench trong này sử dụng test vector và chỉ có giá trị tham khảo nếu muốn tìm hiểu thêm.

Xem testbench chuẩn ở đây và sửa số: https://codereview.stackexchange.com/questions/157383/32-bit-alu-design-implementation-and-testbench

Nếu muốn báo cáo testbench theo kiểu testvector như code mẫu, cần thêm một file alu_tv.mem có nội dung như ví dụ:
```mem
2_00000000_00000000_00000000
2_00000000_FFFFFFFF_FFFFFFFF
2_00000001_FFFFFFFF_00000000
2_000000FF_00000001_00000100
6_00000000_00000000_00000000
6_00000000_FFFFFFFF_00000001
6_00000001_00000001_00000000
6_00000100_00000001_000000FF
//mã function - Toán hạng A 32 bit - Toán hạng B 32 bit - Kết quả trả về kỳ vọng
```


### Đối với testbench cho module nhớ
Testbench của ba module nhớ gần như giống hệt nhau

Cách hoạt động của testbench:

    1. Tạo clock, khối always
    2. Khởi tạo các giá trị ban đầu, khối initial 
    3. Dòng for đầu tiên nạp các giá trị random vào bộ nhớ từ địa chỉ 0 đến 9; dòng for thứ hai đọc giá trị được lưu trong các ô nhớ từ 0 đến 9 có giống với những gì được nạp.
 
**Thay đổi for (i = 0; i < 10; i++) thành repeat (10); tìm hiểu thêm về lệnh repeat, nếu chưa hiểu code đủ để làm điều này thì đừng báo cáo.**

+ Testbench self-checking:

  Sửa lại như sau đối với ví dụ là reg_file.v
```v
for (i = 0; i < 10; i= i+1) begin
      @(posedge clk) write_address <= i; write_en <= 1; write_data <= i;
end
for (i = 0; i < 10; i= i+1) begin
      @(posedge clk) read_address1 <= i; read_address2 <= 10-i; write_en <= 0;
        if(read_data1 != i)  $display("error")
        else        $display("success")
end
```
