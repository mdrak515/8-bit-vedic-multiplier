@@ -0,0 +1,119 @@
`timescale 1ns / 1ps

module ha(a,b,s,c);
input a,b;
output s,c;
xor x1(s,a,b);
and a1(c,a,b);

endmodule

module add4bitadder(a,b,c);
input [3:0] a,b;
output [3:0] c;
assign c=a+b;
endmodule 

module add6bitadder(a,b,c);
input [5:0] a,b;
output [5:0] c;
assign c=a+b;
endmodule 

module add8bitadder(a,b,c);
input [7:0] a,b;
output [7:0]c;
assign c=a+b;
endmodule

module add12bitadder(a,b,c);
input [11:0] a,b;
output [11:0]c;
assign c=a+b;
endmodule 

module multiplier2bit(a,b,mul
    );
input [1:0] a,b;
output [3:0] mul;

wire [3:0] mul,temp;
assign mul[0]=a[0]&b[0];
assign temp[0]=a[0]&b[1];
assign temp[1]=a[1]&b[0];
assign temp[2]=a[1]&b[1];

ha ha1(temp[0],temp[1],mul[1],temp[3]);
ha ha2(temp[3],temp[2],mul[2],mul[3]);
endmodule

module multiplier4bit(a,b, mul);
input [3:0] a,b;
output [7:0] mul;

wire [7:0]mul;
wire [3:0]q0;
wire [3:0]q1;
wire [3:0]q2;
wire [3:0]q3;
wire [3:0]temp1;
wire [5:0]temp2;
wire [5:0]temp3;
wire [3:0]q4;
wire [5:0]q5;
wire [5:0]temp5;
wire [5:0]q6;
wire [5:0]temp4;

multiplier2bit z1(a[1:0],b[1:0],q0[3:0]);
multiplier2bit z2(a[1:0],b[3:2],q1[3:0]);
multiplier2bit z3(a[3:2],b[1:0],q2[3:0]);
multiplier2bit z4(a[3:2],b[3:2],q3[3:0]);

assign temp1={2'b0,q0[3:2]};
assign temp2={2'b0,q2[3:0]};
assign temp3={q3[3:0],2'b0};

add4bitadder add1(temp1[3:0],q1[3:0],q4[3:0]);
add6bitadder add2(temp2[5:0],temp3[5:0],q5[5:0]);
assign temp5={2'b0,q4[3:0]};
add6bitadder add3(q5[5:0],temp5[5:0],q6[5:0]);

assign mul={q6[5:0],q0[1:0]};

endmodule

module multiplier8bit(a,b,mul);
input [7:0] a,b;
output [15:0]mul;

wire [15:0] mul;
wire [7:0]q0;
wire [7:0]q1;
wire [7:0]q2;
wire [7:0]q3;
wire [7:0] temp;
wire [11:0] temp2;
wire [11:0] temp3;
wire [11:0] q5;
wire [7:0] q4;
wire [11:0]temp4;
wire [11:0]q6;

multiplier4bit z1(a[3:0],b[3:0],q0[7:0]);
multiplier4bit z2(a[3:0],b[7:4],q1[7:0]);
multiplier4bit z3(a[7:4],b[3:0],q2[7:0]);
multiplier4bit z4(a[7:4],b[7:4],q3[7:0]);

assign temp={4'b0,q0[7:4]};
assign temp2={4'b0,q2[7:0]};
assign temp3={q3[7:0],4'b0};

add8bitadder add1(temp[7:0],q1[7:0],q4[7:0]);
add12bitadder add2(temp2[11:0],temp3[11:0],q5[11:0]);
assign temp4={4'b0,q4[7:0]};

add12bitadder add3(temp4[11:0],q5[11:0],q6[11:0]);

assign mul={q6[11:0],q0[3:0]};
endmodule 
