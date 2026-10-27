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
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net19;

 sky130_fd_sc_hd__inv_2 _077_ (.A(net12),
    .Y(_042_));
 sky130_fd_sc_hd__inv_2 _078_ (.A(net19),
    .Y(_043_));
 sky130_fd_sc_hd__inv_2 _079_ (.A(\u_tx_controller.state[1] ),
    .Y(_044_));
 sky130_fd_sc_hd__inv_2 _080_ (.A(net10),
    .Y(_045_));
 sky130_fd_sc_hd__and3_1 _081_ (.A(\u_baud_counter.baud_count[0] ),
    .B(\u_baud_counter.baud_count[1] ),
    .C(\u_baud_counter.baud_count[2] ),
    .X(_046_));
 sky130_fd_sc_hd__and4_2 _082_ (.A(\u_baud_counter.baud_count[0] ),
    .B(\u_baud_counter.baud_count[1] ),
    .C(\u_baud_counter.baud_count[2] ),
    .D(\u_baud_counter.baud_count[3] ),
    .X(_047_));
 sky130_fd_sc_hd__nor2_1 _083_ (.A(_043_),
    .B(_047_),
    .Y(_048_));
 sky130_fd_sc_hd__and2_1 _084_ (.A(net19),
    .B(_047_),
    .X(_049_));
 sky130_fd_sc_hd__nand2_1 _085_ (.A(\u_bit_counter.bit_index[1] ),
    .B(\u_bit_counter.bit_index[0] ),
    .Y(_050_));
 sky130_fd_sc_hd__and4b_1 _086_ (.A_N(\u_bit_counter.bit_index[3] ),
    .B(\u_bit_counter.bit_index[2] ),
    .C(\u_bit_counter.bit_index[1] ),
    .D(\u_bit_counter.bit_index[0] ),
    .X(_051_));
 sky130_fd_sc_hd__a32o_1 _087_ (.A1(\u_tx_controller.state[1] ),
    .A2(_049_),
    .A3(_051_),
    .B1(\u_tx_controller.state[3] ),
    .B2(_048_),
    .X(_003_));
 sky130_fd_sc_hd__a32o_1 _088_ (.A1(net19),
    .A2(\u_tx_controller.state[0] ),
    .A3(net10),
    .B1(_048_),
    .B2(\u_tx_controller.state[2] ),
    .X(_002_));
 sky130_fd_sc_hd__o21bai_1 _089_ (.A1(_044_),
    .A2(_051_),
    .B1_N(\u_tx_controller.state[2] ),
    .Y(_052_));
 sky130_fd_sc_hd__a22o_1 _090_ (.A1(\u_tx_controller.state[1] ),
    .A2(_048_),
    .B1(_049_),
    .B2(_052_),
    .X(_001_));
 sky130_fd_sc_hd__a221o_1 _091_ (.A1(\u_tx_controller.state[0] ),
    .A2(_045_),
    .B1(_047_),
    .B2(\u_tx_controller.state[3] ),
    .C1(_043_),
    .X(_000_));
 sky130_fd_sc_hd__or2_1 _092_ (.A(\u_tx_controller.state[3] ),
    .B(\u_tx_controller.state[2] ),
    .X(_053_));
 sky130_fd_sc_hd__nor4b_1 _093_ (.A(\u_tx_controller.state[0] ),
    .B(_051_),
    .C(_053_),
    .D_N(_047_),
    .Y(_054_));
 sky130_fd_sc_hd__or4b_4 _094_ (.A(\u_tx_controller.state[0] ),
    .B(_051_),
    .C(_053_),
    .D_N(_047_),
    .X(_055_));
 sky130_fd_sc_hd__or2_1 _095_ (.A(\u_bit_counter.bit_index[0] ),
    .B(net15),
    .X(_056_));
 sky130_fd_sc_hd__nor3_1 _096_ (.A(\u_tx_controller.state[1] ),
    .B(\u_tx_controller.state[3] ),
    .C(\u_tx_controller.state[2] ),
    .Y(_057_));
 sky130_fd_sc_hd__or3_2 _097_ (.A(\u_tx_controller.state[1] ),
    .B(\u_tx_controller.state[3] ),
    .C(\u_tx_controller.state[2] ),
    .X(_058_));
 sky130_fd_sc_hd__nand2_1 _098_ (.A(net19),
    .B(_058_),
    .Y(_059_));
 sky130_fd_sc_hd__a21oi_1 _099_ (.A1(\u_tx_controller.state[2] ),
    .A2(_047_),
    .B1(_059_),
    .Y(_060_));
 sky130_fd_sc_hd__nand2_1 _100_ (.A(\u_bit_counter.bit_index[0] ),
    .B(net15),
    .Y(_061_));
 sky130_fd_sc_hd__and3_1 _101_ (.A(_056_),
    .B(_060_),
    .C(_061_),
    .X(_004_));
 sky130_fd_sc_hd__a21o_1 _102_ (.A1(\u_bit_counter.bit_index[0] ),
    .A2(net15),
    .B1(\u_bit_counter.bit_index[1] ),
    .X(_062_));
 sky130_fd_sc_hd__o211a_1 _103_ (.A1(_050_),
    .A2(_055_),
    .B1(_060_),
    .C1(_062_),
    .X(_005_));
 sky130_fd_sc_hd__nand4_1 _104_ (.A(\u_bit_counter.bit_index[2] ),
    .B(\u_bit_counter.bit_index[1] ),
    .C(\u_bit_counter.bit_index[0] ),
    .D(net15),
    .Y(_063_));
 sky130_fd_sc_hd__a31o_1 _105_ (.A1(\u_bit_counter.bit_index[1] ),
    .A2(\u_bit_counter.bit_index[0] ),
    .A3(net15),
    .B1(\u_bit_counter.bit_index[2] ),
    .X(_064_));
 sky130_fd_sc_hd__and3_1 _106_ (.A(_060_),
    .B(_063_),
    .C(_064_),
    .X(_006_));
 sky130_fd_sc_hd__and3_1 _107_ (.A(\u_bit_counter.bit_index[3] ),
    .B(_060_),
    .C(_063_),
    .X(_007_));
 sky130_fd_sc_hd__nor4b_1 _108_ (.A(\u_tx_controller.state[1] ),
    .B(\u_tx_controller.state[3] ),
    .C(\u_tx_controller.state[2] ),
    .D_N(net10),
    .Y(_065_));
 sky130_fd_sc_hd__nand2_1 _109_ (.A(net10),
    .B(_057_),
    .Y(_066_));
 sky130_fd_sc_hd__and3_1 _110_ (.A(shift_bit0),
    .B(_055_),
    .C(net14),
    .X(_067_));
 sky130_fd_sc_hd__and3_1 _111_ (.A(shift_bit1),
    .B(net16),
    .C(net14),
    .X(_068_));
 sky130_fd_sc_hd__and2_1 _112_ (.A(net1),
    .B(net18),
    .X(_069_));
 sky130_fd_sc_hd__o31a_1 _113_ (.A1(_067_),
    .A2(_068_),
    .A3(_069_),
    .B1(net9),
    .X(_008_));
 sky130_fd_sc_hd__and3_1 _114_ (.A(\u_tx_shift_register.shift_reg[2] ),
    .B(net16),
    .C(net14),
    .X(_070_));
 sky130_fd_sc_hd__and3_1 _115_ (.A(shift_bit1),
    .B(_055_),
    .C(net14),
    .X(_071_));
 sky130_fd_sc_hd__and2_1 _116_ (.A(net2),
    .B(net18),
    .X(_072_));
 sky130_fd_sc_hd__o31a_1 _117_ (.A1(_070_),
    .A2(_071_),
    .A3(_072_),
    .B1(net9),
    .X(_009_));
 sky130_fd_sc_hd__and3_1 _118_ (.A(\u_tx_shift_register.shift_reg[2] ),
    .B(_055_),
    .C(net14),
    .X(_073_));
 sky130_fd_sc_hd__and3_1 _119_ (.A(\u_tx_shift_register.shift_reg[3] ),
    .B(net15),
    .C(net13),
    .X(_074_));
 sky130_fd_sc_hd__and2_1 _120_ (.A(net3),
    .B(net18),
    .X(_075_));
 sky130_fd_sc_hd__o31a_1 _121_ (.A1(_073_),
    .A2(_074_),
    .A3(_075_),
    .B1(net9),
    .X(_010_));
 sky130_fd_sc_hd__and3_1 _122_ (.A(\u_tx_shift_register.shift_reg[4] ),
    .B(net15),
    .C(net13),
    .X(_076_));
 sky130_fd_sc_hd__and3_1 _123_ (.A(\u_tx_shift_register.shift_reg[3] ),
    .B(_055_),
    .C(net13),
    .X(_022_));
 sky130_fd_sc_hd__and2_1 _124_ (.A(net4),
    .B(net18),
    .X(_023_));
 sky130_fd_sc_hd__o31a_1 _125_ (.A1(_076_),
    .A2(_022_),
    .A3(_023_),
    .B1(net19),
    .X(_011_));
 sky130_fd_sc_hd__and3_1 _126_ (.A(\u_tx_shift_register.shift_reg[5] ),
    .B(net15),
    .C(net13),
    .X(_024_));
 sky130_fd_sc_hd__and3_1 _127_ (.A(\u_tx_shift_register.shift_reg[4] ),
    .B(_055_),
    .C(net13),
    .X(_025_));
 sky130_fd_sc_hd__and2_1 _128_ (.A(net5),
    .B(net18),
    .X(_026_));
 sky130_fd_sc_hd__o31a_1 _129_ (.A1(_024_),
    .A2(_025_),
    .A3(_026_),
    .B1(net19),
    .X(_012_));
 sky130_fd_sc_hd__and3_1 _130_ (.A(\u_tx_shift_register.shift_reg[5] ),
    .B(_055_),
    .C(net13),
    .X(_027_));
 sky130_fd_sc_hd__and3_1 _131_ (.A(\u_tx_shift_register.shift_reg[6] ),
    .B(net15),
    .C(net13),
    .X(_028_));
 sky130_fd_sc_hd__and2_1 _132_ (.A(net6),
    .B(_065_),
    .X(_029_));
 sky130_fd_sc_hd__o31a_1 _133_ (.A1(_027_),
    .A2(_028_),
    .A3(_029_),
    .B1(net19),
    .X(_013_));
 sky130_fd_sc_hd__and3_1 _134_ (.A(\u_tx_shift_register.shift_reg[6] ),
    .B(_055_),
    .C(net13),
    .X(_030_));
 sky130_fd_sc_hd__and2_1 _135_ (.A(net7),
    .B(_065_),
    .X(_031_));
 sky130_fd_sc_hd__a31o_1 _136_ (.A1(\u_tx_shift_register.shift_reg[7] ),
    .A2(net15),
    .A3(net13),
    .B1(_031_),
    .X(_032_));
 sky130_fd_sc_hd__o21a_1 _137_ (.A1(_030_),
    .A2(_032_),
    .B1(net19),
    .X(_014_));
 sky130_fd_sc_hd__and3_1 _138_ (.A(net19),
    .B(net8),
    .C(_065_),
    .X(_033_));
 sky130_fd_sc_hd__a41o_1 _139_ (.A1(\u_tx_shift_register.shift_reg[7] ),
    .A2(net19),
    .A3(_055_),
    .A4(net13),
    .B1(_033_),
    .X(_015_));
 sky130_fd_sc_hd__nor2_1 _140_ (.A(\u_baud_counter.baud_count[0] ),
    .B(_059_),
    .Y(_016_));
 sky130_fd_sc_hd__o211ai_1 _141_ (.A1(\u_baud_counter.baud_count[0] ),
    .A2(\u_baud_counter.baud_count[1] ),
    .B1(_058_),
    .C1(net9),
    .Y(_034_));
 sky130_fd_sc_hd__a21oi_1 _142_ (.A1(\u_baud_counter.baud_count[0] ),
    .A2(\u_baud_counter.baud_count[1] ),
    .B1(_034_),
    .Y(_017_));
 sky130_fd_sc_hd__a21oi_1 _143_ (.A1(\u_baud_counter.baud_count[0] ),
    .A2(\u_baud_counter.baud_count[1] ),
    .B1(\u_baud_counter.baud_count[2] ),
    .Y(_035_));
 sky130_fd_sc_hd__nor3_1 _144_ (.A(_046_),
    .B(_059_),
    .C(_035_),
    .Y(_018_));
 sky130_fd_sc_hd__o211a_1 _145_ (.A1(\u_baud_counter.baud_count[3] ),
    .A2(_046_),
    .B1(_048_),
    .C1(_058_),
    .X(_019_));
 sky130_fd_sc_hd__or2_1 _146_ (.A(shift_bit0),
    .B(\u_tx_controller.state[1] ),
    .X(_036_));
 sky130_fd_sc_hd__o31a_1 _147_ (.A1(shift_bit1),
    .A2(_044_),
    .A3(_051_),
    .B1(_036_),
    .X(_037_));
 sky130_fd_sc_hd__mux2_1 _148_ (.A0(\u_tx_controller.state[0] ),
    .A1(_047_),
    .S(_058_),
    .X(_038_));
 sky130_fd_sc_hd__o311a_1 _149_ (.A1(\u_tx_controller.state[3] ),
    .A2(_057_),
    .A3(_037_),
    .B1(_038_),
    .C1(net14),
    .X(_039_));
 sky130_fd_sc_hd__nor2_1 _150_ (.A(_042_),
    .B(_038_),
    .Y(_040_));
 sky130_fd_sc_hd__or3_1 _151_ (.A(_043_),
    .B(_039_),
    .C(_040_),
    .X(_020_));
 sky130_fd_sc_hd__a211o_1 _152_ (.A1(\u_tx_controller.state[3] ),
    .A2(_047_),
    .B1(_057_),
    .C1(_043_),
    .X(_041_));
 sky130_fd_sc_hd__o21ai_1 _153_ (.A1(_043_),
    .A2(net14),
    .B1(_041_),
    .Y(_021_));
 sky130_fd_sc_hd__dfxtp_1 _154_ (.CLK(clk),
    .D(_004_),
    .Q(\u_bit_counter.bit_index[0] ));
 sky130_fd_sc_hd__dfxtp_1 _155_ (.CLK(clk),
    .D(_005_),
    .Q(\u_bit_counter.bit_index[1] ));
 sky130_fd_sc_hd__dfxtp_1 _156_ (.CLK(clk),
    .D(_006_),
    .Q(\u_bit_counter.bit_index[2] ));
 sky130_fd_sc_hd__dfxtp_1 _157_ (.CLK(clk),
    .D(_007_),
    .Q(\u_bit_counter.bit_index[3] ));
 sky130_fd_sc_hd__dfxtp_1 _158_ (.CLK(clk),
    .D(_008_),
    .Q(shift_bit0));
 sky130_fd_sc_hd__dfxtp_1 _159_ (.CLK(clk),
    .D(_009_),
    .Q(shift_bit1));
 sky130_fd_sc_hd__dfxtp_1 _160_ (.CLK(clk),
    .D(_010_),
    .Q(\u_tx_shift_register.shift_reg[2] ));
 sky130_fd_sc_hd__dfxtp_1 _161_ (.CLK(clk),
    .D(_011_),
    .Q(\u_tx_shift_register.shift_reg[3] ));
 sky130_fd_sc_hd__dfxtp_1 _162_ (.CLK(clk),
    .D(_012_),
    .Q(\u_tx_shift_register.shift_reg[4] ));
 sky130_fd_sc_hd__dfxtp_1 _163_ (.CLK(clk),
    .D(_013_),
    .Q(\u_tx_shift_register.shift_reg[5] ));
 sky130_fd_sc_hd__dfxtp_1 _164_ (.CLK(clk),
    .D(_014_),
    .Q(\u_tx_shift_register.shift_reg[6] ));
 sky130_fd_sc_hd__dfxtp_1 _165_ (.CLK(clk),
    .D(_015_),
    .Q(\u_tx_shift_register.shift_reg[7] ));
 sky130_fd_sc_hd__dfxtp_1 _166_ (.CLK(clk),
    .D(_000_),
    .Q(\u_tx_controller.state[0] ));
 sky130_fd_sc_hd__dfxtp_1 _167_ (.CLK(clk),
    .D(_001_),
    .Q(\u_tx_controller.state[1] ));
 sky130_fd_sc_hd__dfxtp_1 _168_ (.CLK(clk),
    .D(_002_),
    .Q(\u_tx_controller.state[2] ));
 sky130_fd_sc_hd__dfxtp_1 _169_ (.CLK(clk),
    .D(_003_),
    .Q(\u_tx_controller.state[3] ));
 sky130_fd_sc_hd__dfxtp_1 _170_ (.CLK(clk),
    .D(_016_),
    .Q(\u_baud_counter.baud_count[0] ));
 sky130_fd_sc_hd__dfxtp_1 _171_ (.CLK(clk),
    .D(_017_),
    .Q(\u_baud_counter.baud_count[1] ));
 sky130_fd_sc_hd__dfxtp_1 _172_ (.CLK(clk),
    .D(_018_),
    .Q(\u_baud_counter.baud_count[2] ));
 sky130_fd_sc_hd__dfxtp_1 _173_ (.CLK(clk),
    .D(_019_),
    .Q(\u_baud_counter.baud_count[3] ));
 sky130_fd_sc_hd__dfxtp_1 _174_ (.CLK(clk),
    .D(_020_),
    .Q(net12));
 sky130_fd_sc_hd__dfxtp_1 _175_ (.CLK(clk),
    .D(_021_),
    .Q(net11));
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Right_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_33 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_34 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_35 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_36 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_38 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_61 ();
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(data_in[0]),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(data_in[1]),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(data_in[2]),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(data_in[3]),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(data_in[4]),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_1 input6 (.A(data_in[5]),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_1 input7 (.A(data_in[6]),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(data_in[7]),
    .X(net8));
 sky130_fd_sc_hd__clkbuf_2 input9 (.A(rst_n),
    .X(net9));
 sky130_fd_sc_hd__buf_1 input10 (.A(valid_in),
    .X(net10));
 sky130_fd_sc_hd__buf_2 output11 (.A(net11),
    .X(busy));
 sky130_fd_sc_hd__buf_2 output12 (.A(net12),
    .X(tx));
 sky130_fd_sc_hd__clkbuf_2 fanout13 (.A(_066_),
    .X(net13));
 sky130_fd_sc_hd__dlymetal6s2s_1 fanout14 (.A(_066_),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_2 fanout15 (.A(net17),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_1 wire16 (.A(_054_),
    .X(net16));
 sky130_fd_sc_hd__clkbuf_1 max_cap17 (.A(_054_),
    .X(net17));
 sky130_fd_sc_hd__buf_1 wire18 (.A(_065_),
    .X(net18));
 sky130_fd_sc_hd__buf_2 fanout19 (.A(net9),
    .X(net19));
endmodule
