module uart_tx_top (busy,
    clk,
    rst_n,
    tx,
    valid_in,
    data_in);
 output busy;
 input clk;
 input rst_n;
 output tx;
 input valid_in;
 input [7:0] data_in;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire shift_bit0;
 wire shift_bit1;
 wire \u_baud_counter.baud_count[0] ;
 wire \u_baud_counter.baud_count[1] ;
 wire \u_baud_counter.baud_count[2] ;
 wire \u_baud_counter.baud_count[3] ;
 wire \u_bit_counter.bit_index[0] ;
 wire \u_bit_counter.bit_index[1] ;
 wire \u_bit_counter.bit_index[2] ;
 wire \u_bit_counter.bit_index[3] ;
 wire \u_tx_controller.state[0] ;
 wire \u_tx_controller.state[1] ;
 wire \u_tx_controller.state[2] ;
 wire \u_tx_controller.state[3] ;
 wire \u_tx_shift_register.shift_reg[2] ;
 wire \u_tx_shift_register.shift_reg[3] ;
 wire \u_tx_shift_register.shift_reg[4] ;
 wire \u_tx_shift_register.shift_reg[5] ;
 wire \u_tx_shift_register.shift_reg[6] ;
 wire \u_tx_shift_register.shift_reg[7] ;

 sky130_fd_sc_hd__inv_2 _077_ (.A(tx),
    .Y(_042_));
 sky130_fd_sc_hd__inv_2 _078_ (.A(rst_n),
    .Y(_043_));
 sky130_fd_sc_hd__inv_2 _079_ (.A(\u_tx_controller.state[1] ),
    .Y(_044_));
 sky130_fd_sc_hd__inv_2 _080_ (.A(valid_in),
    .Y(_045_));
 sky130_fd_sc_hd__and3_2 _081_ (.A(\u_baud_counter.baud_count[0] ),
    .B(\u_baud_counter.baud_count[1] ),
    .C(\u_baud_counter.baud_count[2] ),
    .X(_046_));
 sky130_fd_sc_hd__and4_2 _082_ (.A(\u_baud_counter.baud_count[0] ),
    .B(\u_baud_counter.baud_count[1] ),
    .C(\u_baud_counter.baud_count[2] ),
    .D(\u_baud_counter.baud_count[3] ),
    .X(_047_));
 sky130_fd_sc_hd__nor2_2 _083_ (.A(_043_),
    .B(_047_),
    .Y(_048_));
 sky130_fd_sc_hd__and2_2 _084_ (.A(rst_n),
    .B(_047_),
    .X(_049_));
 sky130_fd_sc_hd__nand2_2 _085_ (.A(\u_bit_counter.bit_index[1] ),
    .B(\u_bit_counter.bit_index[0] ),
    .Y(_050_));
 sky130_fd_sc_hd__and4b_2 _086_ (.A_N(\u_bit_counter.bit_index[3] ),
    .B(\u_bit_counter.bit_index[2] ),
    .C(\u_bit_counter.bit_index[1] ),
    .D(\u_bit_counter.bit_index[0] ),
    .X(_051_));
 sky130_fd_sc_hd__a32o_2 _087_ (.A1(\u_tx_controller.state[1] ),
    .A2(_049_),
    .A3(_051_),
    .B1(\u_tx_controller.state[3] ),
    .B2(_048_),
    .X(_003_));
 sky130_fd_sc_hd__a32o_2 _088_ (.A1(rst_n),
    .A2(\u_tx_controller.state[0] ),
    .A3(valid_in),
    .B1(_048_),
    .B2(\u_tx_controller.state[2] ),
    .X(_002_));
 sky130_fd_sc_hd__o21bai_2 _089_ (.A1(_044_),
    .A2(_051_),
    .B1_N(\u_tx_controller.state[2] ),
    .Y(_052_));
 sky130_fd_sc_hd__a22o_2 _090_ (.A1(\u_tx_controller.state[1] ),
    .A2(_048_),
    .B1(_049_),
    .B2(_052_),
    .X(_001_));
 sky130_fd_sc_hd__a221o_2 _091_ (.A1(\u_tx_controller.state[0] ),
    .A2(_045_),
    .B1(_047_),
    .B2(\u_tx_controller.state[3] ),
    .C1(_043_),
    .X(_000_));
 sky130_fd_sc_hd__or2_2 _092_ (.A(\u_tx_controller.state[3] ),
    .B(\u_tx_controller.state[2] ),
    .X(_053_));
 sky130_fd_sc_hd__nor4b_2 _093_ (.A(\u_tx_controller.state[0] ),
    .B(_051_),
    .C(_053_),
    .D_N(_047_),
    .Y(_054_));
 sky130_fd_sc_hd__or4b_2 _094_ (.A(\u_tx_controller.state[0] ),
    .B(_051_),
    .C(_053_),
    .D_N(_047_),
    .X(_055_));
 sky130_fd_sc_hd__or2_2 _095_ (.A(\u_bit_counter.bit_index[0] ),
    .B(_054_),
    .X(_056_));
 sky130_fd_sc_hd__nor3_2 _096_ (.A(\u_tx_controller.state[1] ),
    .B(\u_tx_controller.state[3] ),
    .C(\u_tx_controller.state[2] ),
    .Y(_057_));
 sky130_fd_sc_hd__or3_2 _097_ (.A(\u_tx_controller.state[1] ),
    .B(\u_tx_controller.state[3] ),
    .C(\u_tx_controller.state[2] ),
    .X(_058_));
 sky130_fd_sc_hd__nand2_2 _098_ (.A(rst_n),
    .B(_058_),
    .Y(_059_));
 sky130_fd_sc_hd__a21oi_2 _099_ (.A1(\u_tx_controller.state[2] ),
    .A2(_047_),
    .B1(_059_),
    .Y(_060_));
 sky130_fd_sc_hd__nand2_2 _100_ (.A(\u_bit_counter.bit_index[0] ),
    .B(_054_),
    .Y(_061_));
 sky130_fd_sc_hd__and3_2 _101_ (.A(_056_),
    .B(_060_),
    .C(_061_),
    .X(_004_));
 sky130_fd_sc_hd__a21o_2 _102_ (.A1(\u_bit_counter.bit_index[0] ),
    .A2(_054_),
    .B1(\u_bit_counter.bit_index[1] ),
    .X(_062_));
 sky130_fd_sc_hd__o211a_2 _103_ (.A1(_050_),
    .A2(_055_),
    .B1(_060_),
    .C1(_062_),
    .X(_005_));
 sky130_fd_sc_hd__nand4_2 _104_ (.A(\u_bit_counter.bit_index[2] ),
    .B(\u_bit_counter.bit_index[1] ),
    .C(\u_bit_counter.bit_index[0] ),
    .D(_054_),
    .Y(_063_));
 sky130_fd_sc_hd__a31o_2 _105_ (.A1(\u_bit_counter.bit_index[1] ),
    .A2(\u_bit_counter.bit_index[0] ),
    .A3(_054_),
    .B1(\u_bit_counter.bit_index[2] ),
    .X(_064_));
 sky130_fd_sc_hd__and3_2 _106_ (.A(_060_),
    .B(_063_),
    .C(_064_),
    .X(_006_));
 sky130_fd_sc_hd__and3_2 _107_ (.A(\u_bit_counter.bit_index[3] ),
    .B(_060_),
    .C(_063_),
    .X(_007_));
 sky130_fd_sc_hd__nor4b_2 _108_ (.A(\u_tx_controller.state[1] ),
    .B(\u_tx_controller.state[3] ),
    .C(\u_tx_controller.state[2] ),
    .D_N(valid_in),
    .Y(_065_));
 sky130_fd_sc_hd__nand2_2 _109_ (.A(valid_in),
    .B(_057_),
    .Y(_066_));
 sky130_fd_sc_hd__and3_2 _110_ (.A(shift_bit0),
    .B(_055_),
    .C(_066_),
    .X(_067_));
 sky130_fd_sc_hd__and3_2 _111_ (.A(shift_bit1),
    .B(_054_),
    .C(_066_),
    .X(_068_));
 sky130_fd_sc_hd__and2_2 _112_ (.A(data_in[0]),
    .B(_065_),
    .X(_069_));
 sky130_fd_sc_hd__o31a_2 _113_ (.A1(_067_),
    .A2(_068_),
    .A3(_069_),
    .B1(rst_n),
    .X(_008_));
 sky130_fd_sc_hd__and3_2 _114_ (.A(\u_tx_shift_register.shift_reg[2] ),
    .B(_054_),
    .C(_066_),
    .X(_070_));
 sky130_fd_sc_hd__and3_2 _115_ (.A(shift_bit1),
    .B(_055_),
    .C(_066_),
    .X(_071_));
 sky130_fd_sc_hd__and2_2 _116_ (.A(data_in[1]),
    .B(_065_),
    .X(_072_));
 sky130_fd_sc_hd__o31a_2 _117_ (.A1(_070_),
    .A2(_071_),
    .A3(_072_),
    .B1(rst_n),
    .X(_009_));
 sky130_fd_sc_hd__and3_2 _118_ (.A(\u_tx_shift_register.shift_reg[2] ),
    .B(_055_),
    .C(_066_),
    .X(_073_));
 sky130_fd_sc_hd__and3_2 _119_ (.A(\u_tx_shift_register.shift_reg[3] ),
    .B(_054_),
    .C(_066_),
    .X(_074_));
 sky130_fd_sc_hd__and2_2 _120_ (.A(data_in[2]),
    .B(_065_),
    .X(_075_));
 sky130_fd_sc_hd__o31a_2 _121_ (.A1(_073_),
    .A2(_074_),
    .A3(_075_),
    .B1(rst_n),
    .X(_010_));
 sky130_fd_sc_hd__and3_2 _122_ (.A(\u_tx_shift_register.shift_reg[4] ),
    .B(_054_),
    .C(_066_),
    .X(_076_));
 sky130_fd_sc_hd__and3_2 _123_ (.A(\u_tx_shift_register.shift_reg[3] ),
    .B(_055_),
    .C(_066_),
    .X(_022_));
 sky130_fd_sc_hd__and2_2 _124_ (.A(data_in[3]),
    .B(_065_),
    .X(_023_));
 sky130_fd_sc_hd__o31a_2 _125_ (.A1(_076_),
    .A2(_022_),
    .A3(_023_),
    .B1(rst_n),
    .X(_011_));
 sky130_fd_sc_hd__and3_2 _126_ (.A(\u_tx_shift_register.shift_reg[5] ),
    .B(_054_),
    .C(_066_),
    .X(_024_));
 sky130_fd_sc_hd__and3_2 _127_ (.A(\u_tx_shift_register.shift_reg[4] ),
    .B(_055_),
    .C(_066_),
    .X(_025_));
 sky130_fd_sc_hd__and2_2 _128_ (.A(data_in[4]),
    .B(_065_),
    .X(_026_));
 sky130_fd_sc_hd__o31a_2 _129_ (.A1(_024_),
    .A2(_025_),
    .A3(_026_),
    .B1(rst_n),
    .X(_012_));
 sky130_fd_sc_hd__and3_2 _130_ (.A(\u_tx_shift_register.shift_reg[5] ),
    .B(_055_),
    .C(_066_),
    .X(_027_));
 sky130_fd_sc_hd__and3_2 _131_ (.A(\u_tx_shift_register.shift_reg[6] ),
    .B(_054_),
    .C(_066_),
    .X(_028_));
 sky130_fd_sc_hd__and2_2 _132_ (.A(data_in[5]),
    .B(_065_),
    .X(_029_));
 sky130_fd_sc_hd__o31a_2 _133_ (.A1(_027_),
    .A2(_028_),
    .A3(_029_),
    .B1(rst_n),
    .X(_013_));
 sky130_fd_sc_hd__and3_2 _134_ (.A(\u_tx_shift_register.shift_reg[6] ),
    .B(_055_),
    .C(_066_),
    .X(_030_));
 sky130_fd_sc_hd__and2_2 _135_ (.A(data_in[6]),
    .B(_065_),
    .X(_031_));
 sky130_fd_sc_hd__a31o_2 _136_ (.A1(\u_tx_shift_register.shift_reg[7] ),
    .A2(_054_),
    .A3(_066_),
    .B1(_031_),
    .X(_032_));
 sky130_fd_sc_hd__o21a_2 _137_ (.A1(_030_),
    .A2(_032_),
    .B1(rst_n),
    .X(_014_));
 sky130_fd_sc_hd__and3_2 _138_ (.A(rst_n),
    .B(data_in[7]),
    .C(_065_),
    .X(_033_));
 sky130_fd_sc_hd__a41o_2 _139_ (.A1(\u_tx_shift_register.shift_reg[7] ),
    .A2(rst_n),
    .A3(_055_),
    .A4(_066_),
    .B1(_033_),
    .X(_015_));
 sky130_fd_sc_hd__nor2_2 _140_ (.A(\u_baud_counter.baud_count[0] ),
    .B(_059_),
    .Y(_016_));
 sky130_fd_sc_hd__o211ai_2 _141_ (.A1(\u_baud_counter.baud_count[0] ),
    .A2(\u_baud_counter.baud_count[1] ),
    .B1(_058_),
    .C1(rst_n),
    .Y(_034_));
 sky130_fd_sc_hd__a21oi_2 _142_ (.A1(\u_baud_counter.baud_count[0] ),
    .A2(\u_baud_counter.baud_count[1] ),
    .B1(_034_),
    .Y(_017_));
 sky130_fd_sc_hd__a21oi_2 _143_ (.A1(\u_baud_counter.baud_count[0] ),
    .A2(\u_baud_counter.baud_count[1] ),
    .B1(\u_baud_counter.baud_count[2] ),
    .Y(_035_));
 sky130_fd_sc_hd__nor3_2 _144_ (.A(_046_),
    .B(_059_),
    .C(_035_),
    .Y(_018_));
 sky130_fd_sc_hd__o211a_2 _145_ (.A1(\u_baud_counter.baud_count[3] ),
    .A2(_046_),
    .B1(_048_),
    .C1(_058_),
    .X(_019_));
 sky130_fd_sc_hd__or2_2 _146_ (.A(shift_bit0),
    .B(\u_tx_controller.state[1] ),
    .X(_036_));
 sky130_fd_sc_hd__o31a_2 _147_ (.A1(shift_bit1),
    .A2(_044_),
    .A3(_051_),
    .B1(_036_),
    .X(_037_));
 sky130_fd_sc_hd__mux2_1 _148_ (.A0(\u_tx_controller.state[0] ),
    .A1(_047_),
    .S(_058_),
    .X(_038_));
 sky130_fd_sc_hd__o311a_2 _149_ (.A1(\u_tx_controller.state[3] ),
    .A2(_057_),
    .A3(_037_),
    .B1(_038_),
    .C1(_066_),
    .X(_039_));
 sky130_fd_sc_hd__nor2_2 _150_ (.A(_042_),
    .B(_038_),
    .Y(_040_));
 sky130_fd_sc_hd__or3_2 _151_ (.A(_043_),
    .B(_039_),
    .C(_040_),
    .X(_020_));
 sky130_fd_sc_hd__a211o_2 _152_ (.A1(\u_tx_controller.state[3] ),
    .A2(_047_),
    .B1(_057_),
    .C1(_043_),
    .X(_041_));
 sky130_fd_sc_hd__o21ai_2 _153_ (.A1(_043_),
    .A2(_066_),
    .B1(_041_),
    .Y(_021_));
 sky130_fd_sc_hd__dfxtp_2 _154_ (.CLK(clk),
    .D(_004_),
    .Q(\u_bit_counter.bit_index[0] ));
 sky130_fd_sc_hd__dfxtp_2 _155_ (.CLK(clk),
    .D(_005_),
    .Q(\u_bit_counter.bit_index[1] ));
 sky130_fd_sc_hd__dfxtp_2 _156_ (.CLK(clk),
    .D(_006_),
    .Q(\u_bit_counter.bit_index[2] ));
 sky130_fd_sc_hd__dfxtp_2 _157_ (.CLK(clk),
    .D(_007_),
    .Q(\u_bit_counter.bit_index[3] ));
 sky130_fd_sc_hd__dfxtp_2 _158_ (.CLK(clk),
    .D(_008_),
    .Q(shift_bit0));
 sky130_fd_sc_hd__dfxtp_2 _159_ (.CLK(clk),
    .D(_009_),
    .Q(shift_bit1));
 sky130_fd_sc_hd__dfxtp_2 _160_ (.CLK(clk),
    .D(_010_),
    .Q(\u_tx_shift_register.shift_reg[2] ));
 sky130_fd_sc_hd__dfxtp_2 _161_ (.CLK(clk),
    .D(_011_),
    .Q(\u_tx_shift_register.shift_reg[3] ));
 sky130_fd_sc_hd__dfxtp_2 _162_ (.CLK(clk),
    .D(_012_),
    .Q(\u_tx_shift_register.shift_reg[4] ));
 sky130_fd_sc_hd__dfxtp_2 _163_ (.CLK(clk),
    .D(_013_),
    .Q(\u_tx_shift_register.shift_reg[5] ));
 sky130_fd_sc_hd__dfxtp_2 _164_ (.CLK(clk),
    .D(_014_),
    .Q(\u_tx_shift_register.shift_reg[6] ));
 sky130_fd_sc_hd__dfxtp_2 _165_ (.CLK(clk),
    .D(_015_),
    .Q(\u_tx_shift_register.shift_reg[7] ));
 sky130_fd_sc_hd__dfxtp_2 _166_ (.CLK(clk),
    .D(_000_),
    .Q(\u_tx_controller.state[0] ));
 sky130_fd_sc_hd__dfxtp_2 _167_ (.CLK(clk),
    .D(_001_),
    .Q(\u_tx_controller.state[1] ));
 sky130_fd_sc_hd__dfxtp_2 _168_ (.CLK(clk),
    .D(_002_),
    .Q(\u_tx_controller.state[2] ));
 sky130_fd_sc_hd__dfxtp_2 _169_ (.CLK(clk),
    .D(_003_),
    .Q(\u_tx_controller.state[3] ));
 sky130_fd_sc_hd__dfxtp_2 _170_ (.CLK(clk),
    .D(_016_),
    .Q(\u_baud_counter.baud_count[0] ));
 sky130_fd_sc_hd__dfxtp_2 _171_ (.CLK(clk),
    .D(_017_),
    .Q(\u_baud_counter.baud_count[1] ));
 sky130_fd_sc_hd__dfxtp_2 _172_ (.CLK(clk),
    .D(_018_),
    .Q(\u_baud_counter.baud_count[2] ));
 sky130_fd_sc_hd__dfxtp_2 _173_ (.CLK(clk),
    .D(_019_),
    .Q(\u_baud_counter.baud_count[3] ));
 sky130_fd_sc_hd__dfxtp_2 _174_ (.CLK(clk),
    .D(_020_),
    .Q(tx));
 sky130_fd_sc_hd__dfxtp_2 _175_ (.CLK(clk),
    .D(_021_),
    .Q(busy));
endmodule
