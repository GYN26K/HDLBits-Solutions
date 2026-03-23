module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,   // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); 
    // You may use these parameters to access state bits using e.g., state[B2] instead of state[6].
    parameter s0=0, s1=1, s2=2, s3=3, s4=4, s5=5, s6=6, s7=7, s8=8, s9=9;

    // assign B3_next = ...;
    // assign S_next = ...;
    // etc.
    assign B3_next = state[s6];
    assign S_next = (state[s0] & (~d)) | (state[s1] & (~d)) | (state[s3] & (~d)) | (state[s9] & ack);
    assign S1_next = state[s0] & d;
    assign Count_next = state[s7] | (state[s8] & (~done_counting));
    assign Wait_next = (state[s8] & (done_counting)) | (state[s9] & (~ack));
    assign done = state[s9];
    assign counting = state[s8];
    assign shift_ena = state[s4] | state[s5] | state[s6] | state[s7];

endmodule