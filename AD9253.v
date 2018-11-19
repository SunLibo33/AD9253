module AD9253Driver(

		 input wire Data_A_L,
		 input wire Data_A_H,
		 input wire Data_B_L,
		 input wire Data_B_H,
		 input wire Data_C_L,
		 input wire Data_C_H,
		 input wire Data_D_L,
		 input wire Data_D_H,

     input wire DCO,
     input wire FCO,
		 
		 output reg       Data_VLD,
		 output reg[13:0] Data_CH0,
		 output reg[13:0] Data_CH1,
		 output reg[13:0] Data_CH2,
		 output reg[13:0] Data_CH3

);

reg [1:0]FCO_COUNT_H_Rise;
reg [1:0]FCO_COUNT_H_Down;
reg [1:0]FCO_COUNT_L_Rise;
reg [1:0]FCO_COUNT_L_Down;

reg [7:0]REG_DATA_H_H_CH0;
reg [7:0]REG_DATA_H_L_CH0;
reg [7:0]REG_DATA_L_H_CH0;
reg [7:0]REG_DATA_L_L_CH0;

reg [7:0]REG_DATA_H_H_CH1;
reg [7:0]REG_DATA_H_L_CH1;
reg [7:0]REG_DATA_L_H_CH1;
reg [7:0]REG_DATA_L_L_CH1;

reg [7:0]REG_DATA_H_H_CH2;
reg [7:0]REG_DATA_H_L_CH2;
reg [7:0]REG_DATA_L_H_CH2;
reg [7:0]REG_DATA_L_L_CH2;

reg [7:0]REG_DATA_H_H_CH3;
reg [7:0]REG_DATA_H_L_CH3;
reg [7:0]REG_DATA_L_H_CH3;
reg [7:0]REG_DATA_L_L_CH3;

reg Data_VLD_GEN_1D,Data_VLD_GEN_2D,Data_VLD_GEN_3D,Data_VLD_GEN;

always @(posedge DCO)
begin
  Data_VLD_GEN_1D<=FCO;
  Data_VLD_GEN_2D<=Data_VLD_GEN_1D;
  Data_VLD_GEN_3D<=Data_VLD_GEN_2D;
  Data_VLD_GEN<=Data_VLD_GEN_2D^Data_VLD_GEN_3D;
  Data_VLD<=Data_VLD_GEN;
end

always @(posedge DCO)
begin
 if(Data_VLD_GEN==1'b1)
   begin
	  if(FCO==1'b1)
	    begin
	      Data_CH0<={REG_DATA_L_H_CH0,REG_DATA_L_L_CH0[7:2]}; 
		   Data_CH1<={REG_DATA_L_H_CH1,REG_DATA_L_L_CH1[7:2]}; 
		   Data_CH2<={REG_DATA_L_H_CH2,REG_DATA_L_L_CH2[7:2]}; 
		   Data_CH3<={REG_DATA_L_H_CH3,REG_DATA_L_L_CH3[7:2]}; 	
		 end
	  else
	    begin
	      Data_CH0<={REG_DATA_H_H_CH0,REG_DATA_H_L_CH0[7:2]}; 
		   Data_CH1<={REG_DATA_H_H_CH1,REG_DATA_H_L_CH1[7:2]}; 
		   Data_CH2<={REG_DATA_H_H_CH2,REG_DATA_H_L_CH2[7:2]}; 
		   Data_CH3<={REG_DATA_H_H_CH3,REG_DATA_H_L_CH3[7:2]}; 	
		 end	  
	end
end

always @(posedge DCO)
begin
	if(FCO==1'b1)
	  begin
	    case(FCO_COUNT_H_Rise)
		   2'b00:
			      begin
					 REG_DATA_H_H_CH0[7]<=Data_A_H;
					 REG_DATA_H_L_CH0[7]<=Data_A_L;
					 REG_DATA_H_H_CH1[7]<=Data_B_H;
					 REG_DATA_H_L_CH1[7]<=Data_B_L;
					 REG_DATA_H_H_CH2[7]<=Data_C_H;
					 REG_DATA_H_L_CH2[7]<=Data_C_L;
					 REG_DATA_H_H_CH3[7]<=Data_D_H;
					 REG_DATA_H_L_CH3[7]<=Data_D_L;					 
					end
			2'b01:
			      begin
					 REG_DATA_H_H_CH0[5]<=Data_A_H;
					 REG_DATA_H_L_CH0[5]<=Data_A_L;
					 REG_DATA_H_H_CH1[5]<=Data_B_H;
					 REG_DATA_H_L_CH1[5]<=Data_B_L;
					 REG_DATA_H_H_CH2[5]<=Data_C_H;
					 REG_DATA_H_L_CH2[5]<=Data_C_L;
					 REG_DATA_H_H_CH3[5]<=Data_D_H;
					 REG_DATA_H_L_CH3[5]<=Data_D_L;					 
					end			
			2'b10:
			      begin
					 REG_DATA_H_H_CH0[3]<=Data_A_H;
					 REG_DATA_H_L_CH0[3]<=Data_A_L;
					 REG_DATA_H_H_CH1[3]<=Data_B_H;
					 REG_DATA_H_L_CH1[3]<=Data_B_L;
					 REG_DATA_H_H_CH2[3]<=Data_C_H;
					 REG_DATA_H_L_CH2[3]<=Data_C_L;
					 REG_DATA_H_H_CH3[3]<=Data_D_H;
					 REG_DATA_H_L_CH3[3]<=Data_D_L;					 
					end				
			2'b11:
			      begin
					 REG_DATA_H_H_CH0[1]<=Data_A_H;
					 REG_DATA_H_L_CH0[1]<=Data_A_L;
					 REG_DATA_H_H_CH1[1]<=Data_B_H;
					 REG_DATA_H_L_CH1[1]<=Data_B_L;
					 REG_DATA_H_H_CH2[1]<=Data_C_H;
					 REG_DATA_H_L_CH2[1]<=Data_C_L;
					 REG_DATA_H_H_CH3[1]<=Data_D_H;
					 REG_DATA_H_L_CH3[1]<=Data_D_L;					 
					end				
       endcase
	  end 
end

always @(negedge DCO)
begin
	if(FCO==1'b1)
	  begin
	    case(FCO_COUNT_H_Down)
		   2'b00:
			      begin
					 REG_DATA_H_H_CH0[6]<=Data_A_H;
					 REG_DATA_H_L_CH0[6]<=Data_A_L;
					 REG_DATA_H_H_CH1[6]<=Data_B_H;
					 REG_DATA_H_L_CH1[6]<=Data_B_L;
					 REG_DATA_H_H_CH2[6]<=Data_C_H;
					 REG_DATA_H_L_CH2[6]<=Data_C_L;
					 REG_DATA_H_H_CH3[6]<=Data_D_H;
					 REG_DATA_H_L_CH3[6]<=Data_D_L;					 
					end
			2'b01:
			      begin
					 REG_DATA_H_H_CH0[4]<=Data_A_H;
					 REG_DATA_H_L_CH0[4]<=Data_A_L;
					 REG_DATA_H_H_CH1[4]<=Data_B_H;
					 REG_DATA_H_L_CH1[4]<=Data_B_L;
					 REG_DATA_H_H_CH2[4]<=Data_C_H;
					 REG_DATA_H_L_CH2[4]<=Data_C_L;
					 REG_DATA_H_H_CH3[4]<=Data_D_H;
					 REG_DATA_H_L_CH3[4]<=Data_D_L;					 
					end			
			2'b10:
			      begin
					 REG_DATA_H_H_CH0[2]<=Data_A_H;
					 REG_DATA_H_L_CH0[2]<=Data_A_L;
					 REG_DATA_H_H_CH1[2]<=Data_B_H;
					 REG_DATA_H_L_CH1[2]<=Data_B_L;
					 REG_DATA_H_H_CH2[2]<=Data_C_H;
					 REG_DATA_H_L_CH2[2]<=Data_C_L;
					 REG_DATA_H_H_CH3[2]<=Data_D_H;
					 REG_DATA_H_L_CH3[2]<=Data_D_L;					 
					end				
			2'b11:
			      begin
					 REG_DATA_H_H_CH0[0]<=Data_A_H;
					 REG_DATA_H_L_CH0[0]<=Data_A_L;
					 REG_DATA_H_H_CH1[0]<=Data_B_H;
					 REG_DATA_H_L_CH1[0]<=Data_B_L;
					 REG_DATA_H_H_CH2[0]<=Data_C_H;
					 REG_DATA_H_L_CH2[0]<=Data_C_L;
					 REG_DATA_H_H_CH3[0]<=Data_D_H;
					 REG_DATA_H_L_CH3[0]<=Data_D_L;					 
					end				
       endcase
	  end 
end

always @(posedge DCO)
begin
	if(FCO==1'b0)
	  begin
	    case(FCO_COUNT_L_Rise)
		   2'b00:
			      begin
					 REG_DATA_L_H_CH0[7]<=Data_A_H;
					 REG_DATA_L_L_CH0[7]<=Data_A_L;
					 REG_DATA_L_H_CH1[7]<=Data_B_H;
					 REG_DATA_L_L_CH1[7]<=Data_B_L;
					 REG_DATA_L_H_CH2[7]<=Data_C_H;
					 REG_DATA_L_L_CH2[7]<=Data_C_L;
					 REG_DATA_L_H_CH3[7]<=Data_D_H;
					 REG_DATA_L_L_CH3[7]<=Data_D_L;					 
					end
			2'b01:
			      begin
					 REG_DATA_L_H_CH0[5]<=Data_A_H;
					 REG_DATA_L_L_CH0[5]<=Data_A_L;
					 REG_DATA_L_H_CH1[5]<=Data_B_H;
					 REG_DATA_L_L_CH1[5]<=Data_B_L;
					 REG_DATA_L_H_CH2[5]<=Data_C_H;
					 REG_DATA_L_L_CH2[5]<=Data_C_L;
					 REG_DATA_L_H_CH3[5]<=Data_D_H;
					 REG_DATA_L_L_CH3[5]<=Data_D_L;					 
					end			
			2'b10:
			      begin
					 REG_DATA_L_H_CH0[3]<=Data_A_H;
					 REG_DATA_L_L_CH0[3]<=Data_A_L;
					 REG_DATA_L_H_CH1[3]<=Data_B_H;
					 REG_DATA_L_L_CH1[3]<=Data_B_L;
					 REG_DATA_L_H_CH2[3]<=Data_C_H;
					 REG_DATA_L_L_CH2[3]<=Data_C_L;
					 REG_DATA_L_H_CH3[3]<=Data_D_H;
					 REG_DATA_L_L_CH3[3]<=Data_D_L;					 
					end				
			2'b11:
			      begin
					 REG_DATA_L_H_CH0[1]<=Data_A_H;
					 REG_DATA_L_L_CH0[1]<=Data_A_L;
					 REG_DATA_L_H_CH1[1]<=Data_B_H;
					 REG_DATA_L_L_CH1[1]<=Data_B_L;
					 REG_DATA_L_H_CH2[1]<=Data_C_H;
					 REG_DATA_L_L_CH2[1]<=Data_C_L;
					 REG_DATA_L_H_CH3[1]<=Data_D_H;
					 REG_DATA_L_L_CH3[1]<=Data_D_L;					 
					end				
       endcase
	  end 
end

always @(negedge DCO)
begin
	if(FCO==1'b0)
	  begin
	    case(FCO_COUNT_L_Down)
		   2'b00:
			      begin
					 REG_DATA_L_H_CH0[6]<=Data_A_H;
					 REG_DATA_L_L_CH0[6]<=Data_A_L;
					 REG_DATA_L_H_CH1[6]<=Data_B_H;
					 REG_DATA_L_L_CH1[6]<=Data_B_L;
					 REG_DATA_L_H_CH2[6]<=Data_C_H;
					 REG_DATA_L_L_CH2[6]<=Data_C_L;
					 REG_DATA_L_H_CH3[6]<=Data_D_H;
					 REG_DATA_L_L_CH3[6]<=Data_D_L;					 
					end
			2'b01:
			      begin
					 REG_DATA_L_H_CH0[4]<=Data_A_H;
					 REG_DATA_L_L_CH0[4]<=Data_A_L;
					 REG_DATA_L_H_CH1[4]<=Data_B_H;
					 REG_DATA_L_L_CH1[4]<=Data_B_L;
					 REG_DATA_L_H_CH2[4]<=Data_C_H;
					 REG_DATA_L_L_CH2[4]<=Data_C_L;
					 REG_DATA_L_H_CH3[4]<=Data_D_H;
					 REG_DATA_L_L_CH3[4]<=Data_D_L;					 
					end			
			2'b10:
			      begin
					 REG_DATA_L_H_CH0[2]<=Data_A_H;
					 REG_DATA_L_L_CH0[2]<=Data_A_L;
					 REG_DATA_L_H_CH1[2]<=Data_B_H;
					 REG_DATA_L_L_CH1[2]<=Data_B_L;
					 REG_DATA_L_H_CH2[2]<=Data_C_H;
					 REG_DATA_L_L_CH2[2]<=Data_C_L;
					 REG_DATA_L_H_CH3[2]<=Data_D_H;
					 REG_DATA_L_L_CH3[2]<=Data_D_L;					 
					end				
			2'b11:
			      begin
					 REG_DATA_L_H_CH0[0]<=Data_A_H;
					 REG_DATA_L_L_CH0[0]<=Data_A_L;
					 REG_DATA_L_H_CH1[0]<=Data_B_H;
					 REG_DATA_L_L_CH1[0]<=Data_B_L;
					 REG_DATA_L_H_CH2[0]<=Data_C_H;
					 REG_DATA_L_L_CH2[0]<=Data_C_L;
					 REG_DATA_L_H_CH3[0]<=Data_D_H;
					 REG_DATA_L_L_CH3[0]<=Data_D_L;					 
					end				
       endcase
	  end 
end

always @(posedge DCO)
begin
	if(FCO==1'b1)
	  FCO_COUNT_L_Rise <= 2'b00;
	else 
	  FCO_COUNT_L_Rise <= FCO_COUNT_L_Rise + 2'b01;
end

always @(negedge DCO)
begin
	if(FCO==1'b1)
	  FCO_COUNT_L_Down <= 2'b00;
	else 
	  FCO_COUNT_L_Down <= FCO_COUNT_L_Down + 2'b01;
end

always @(posedge DCO)
begin
	if(FCO==1'b0)
	  FCO_COUNT_H_Rise <= 2'b00;
	else 
	  FCO_COUNT_H_Rise <= FCO_COUNT_H_Rise + 2'b01;
end

always @(negedge DCO)
begin
	if(FCO==1'b0)
	  FCO_COUNT_H_Down <= 2'b00;
	else 
	  FCO_COUNT_H_Down <= FCO_COUNT_H_Down + 2'b01;
end

endmodule 