module chi_monitor(
    input TX_REQFLITPEND,
    input TX_REQFLITV,
    input [153:0] TX_REQFLIT,
    input TX_RSPFLITPEND,
    input TX_RSPFLITV,
    input [72:0] TX_RSPFLIT,
    input TX_DATFLITPEND,
    input TX_DATFLITV,
    input [385:0] TX_DATFLIT,
    
    input RX_REQFLITPEND,
    input RX_REQFLITV,
    input [10:0] RX_REQFLIT,
    input RX_RSPFLITPEND,
    input RX_RSPFLITV,
    input [72:0] RX_RSPFLIT,
    input RX_DATFLITPEND,
    input RX_DATFLITV,
    input [385:0] RX_DATFLIT,
    input RX_SNPFLITPEND,
    input RX_SNPFLITV,
    input [110:0] RX_SNPFLIT,

    input clk,
    input [153:0] TXREQFLIT,
    input [72:0] TXRSPFLIT,
    input [385:0] TXDATFLIT,
    input [153:0] RXREQFLIT,
    input [72:0] RXRSPFLIT,
    input [385:0] RXDATFLIT,
    input [110:0] RXSNPFLIT
);

logic [42:0] txreqflit_addr;
logic [1:0] txreqflit_groupidtext;
logic [3:0] txreqflit_lpid;
logic [9:0] txreqflit_mpam;
logic [2:0] txreqflit_memattr;
logic [5:0] txreqflit_opcode;
logic [1:0] txreqflit_order;
logic [2:0] txreqflit_pcrdtype;
logic [3:0] txreqflit_qos;
logic [9:0] txreqflit_returnnid;
logic [10:0] txreqflit_returntxnid;
logic [1:0] txreqflit_size;
logic [9:0] txreqflit_srcid;
logic [1:0] txreqflit_tagop;
logic [9:0] txreqflit_tgtid;
logic [10:0] txreqflit_txnid;

logic [1:0] txrspflit_cbusy;
logic [10:0] txrspflit_dbid;
logic [1:0] txrspflit_fwdstate;
logic [3:0] txrspflit_opcode;
logic [2:0] txrspflit_pcrdtype;
logic [3:0] txrspflit_qos;
logic [1:0] txrspflit_resp;
logic [1:0] txrspflit_resperr;
logic [9:0] txrspflit_srcid;
logic [1:0] txrspflit_tagop;
logic [9:0] txrspflit_tgtid;
logic [10:0] txrspflit_txnid;

logic [2:0] txdatflit_poison;

logic [1:0] rxrspflit_cbusy;
logic [10:0] rxrspflit_dbid;
logic [1:0] rxrspflit_fwdstate;
logic [3:0] rxrspflit_opcode;
logic [2:0] rxrspflit_pcrdtype;
logic [3:0] rxrspflit_qos;
logic [1:0] rxrspflit_resp;
logic [1:0] rxrspflit_resperr;
logic [9:0] rxrspflit_srcid;
logic [1:0] rxrspflit_tagop;
logic [9:0] rxrspflit_tgtid;
logic [10:0] rxrspflit_txnid;

logic [2:0] trxdatflit_poison;

logic [1:0] rxsnpflit_addr;
logic [1:0] rxsnpflit_donotgotosd;
logic [1:0] rxsnpflit_fwdnid;
logic [1:0] rxsnpflit_fwdtxnnid;
logic [2:0] rxsnpflit_mpam;
logic [3:0] rxsnpflit_ns;
logic [1:0] rxsnpflit_opcode;
logic [1:0] rxsnpflit_qos;
logic [9:0] rxsnpflit_rettosrc;
logic [1:0] rxsnpflit_srcid;
logic [9:0] rxsnpflit_tracetag;
logic [10:0] rxsnpflit_pend;

assign txreqflit_addr = TXREQFLIT[115:72];
assign txreqflit_allowretry = TXREQFLIT[118:118];
assign txreqflit_excl = TXREQFLIT[138:138];
assign txreqflit_expcompack = TXREQFLIT[139:139];
assign txreqflit_groupidext = TXREQFLIT[137:135];
assign txreqflit_lpid = TXREQFLIT[134:130];
assign txreqflit_likelyshared = TXREQFLIT[117:117];
assign txreqflit_mpam = TXREQFLIT[153:143];
assign txreqflit_memattr = TXREQFLIT[128:125];
assign txreqflit_ns = TXREQFLIT[116:116];
assign txreqflit_opcode = TXREQFLIT[68:62];
assign txreqflit_order = TXREQFLIT[120:119];
assign txreqflit_pcrdtype = TXREQFLIT[124:121];
assign txreqflit_qos = TXREQFLIT[3:0];
assign txreqflit_returnnid = TXREQFLIT[48:38];
assign txreqflit_returntxnid = TXREQFLIT[61:50];
assign txreqflit_size = TXREQFLIT[71:69];
assign txreqflit_snpattr = TXREQFLIT[129:129];
assign txreqflit_srcid = TXREQFLIT[25:15];
assign txreqflit_stashnidvalid = TXREQFLIT[49:49];
assign txreqflit_tagop = TXREQFLIT[141:140];
assign txreqflit_tgtid = TXREQFLIT[14:4];
assign txreqflit_tracetag = TXREQFLIT[142:142];
assign txreqflit_txnid = TXREQFLIT[37:26];
assign txreqflit_pend = TXREQFLIT[0:0];
assign txreqflit_v = TXREQFLIT[0:0];
assign txreqflit_lcrdv = TXREQFLIT[0:0];

assign txrspflit_cbusy = TXRSPFLIT[53:51];
assign txrspflit_dbid = TXRSPFLIT[65:54];
assign txrspflit_fwdstate = TXRSPFLIT[50:48];
assign txrspflit_opcode = TXRSPFLIT[42:38];
assign txrspflit_pcrdtype = TXRSPFLIT[69:66];
assign txrspflit_qos = TXRSPFLIT[3:0];
assign txrspflit_resp = TXRSPFLIT[47:45];
assign txrspflit_resperr = TXRSPFLIT[44:43];
assign txrspflit_srcid = TXRSPFLIT[25:15];
assign txrspflit_tagop = TXRSPFLIT[71:70];
assign txrspflit_tgtid = TXRSPFLIT[14:4];
assign txrspflit_tracetag = TXRSPFLIT[72:72];
assign txrspflit_txnid = TXRSPFLIT[37:26];
assign txrspflit_pend = TXRSPFLIT[0:0];
assign txrspflit_v = TXRSPFLIT[0:0];
assign txrspflit_lcrdv = TXRSPFLIT[0:0];

assign txdatflit_poison = TXDATFLIT[385:382];

assign rxrspflit_cbusy = RXRSPFLIT[53:51];
assign rxrspflit_dbid = RXRSPFLIT[65:54];
assign rxrspflit_fwdstate = RXRSPFLIT[50:48];
assign rxrspflit_opcode = RXRSPFLIT[42:38];
assign rxrspflit_pcrdtype = RXRSPFLIT[69:66];
assign rxrspflit_qos = RXRSPFLIT[3:0];
assign rxrspflit_resp = RXRSPFLIT[47:45];
assign rxrspflit_resperr = RXRSPFLIT[44:43];
assign rxrspflit_srcid = RXRSPFLIT[25:15];
assign rxrspflit_tagop = RXRSPFLIT[71:70];
assign rxrspflit_tgtid = RXRSPFLIT[14:4];
assign rxrspflit_tracetag = RXRSPFLIT[72:72];
assign rxrspflit_txnid = RXRSPFLIT[37:26];
assign rxrspflit_pend = RXRSPFLIT[0:0];
assign rxrspflit_v = RXRSPFLIT[0:0];
assign rxrspflit_lcrdv = RXRSPFLIT[0:0];

assign rxdatflit_poison = TXDATFLIT[385:382];

assign rxsnpflit_addr = RXSNPFLIT[53:51];
assign rxsnpflit_donotgotosd = RXSNPFLIT[65:54];
assign rxsnpflit_fwdnid = RXSNPFLIT[50:48];
assign rxsnpflit_fwdtxnnid = RXSNPFLIT[42:38];
assign rxsnpflit_mpam = RXSNPFLIT[69:66];
assign rxsnpflit_ns = RXSNPFLIT[3:0];
assign rxsnpflit_opcode = RXSNPFLIT[47:45];
assign rxsnpflit_qos = RXSNPFLIT[44:43];
assign rxsnpflit_rettosrc = RXSNPFLIT[25:15];
assign rxsnpflit_srcid = RXSNPFLIT[71:70];
assign rxsnpflit_tracetag = RXSNPFLIT[14:4];
assign rxsnpflit_txnid = RXSNPFLIT[72:72];
assign rxsnpflit_pend = RXSNPFLIT[37:26];
assign rxsnpflit_v = RXSNPFLIT[0:0];
assign rxsnpflit_lcrdv = RXSNPFLIT[0:0];


initial begin
repeat(2) @(posedge clk);
  $display("chi:TX_REQFLITPEND=%0d", TX_REQFLITPEND);
repeat(2) @(posedge clk);
  $display("chi:TX_REQFLITV=%0d", TX_REQFLITV);
repeat(2) @(posedge clk);
  $display("chi:TX_REQFLIT=%0d", TX_REQFLIT);
repeat(2) @(posedge clk);
  $display("chi:TX_RSPFLITPEND=%0d", TX_RSPFLITPEND);
repeat(2) @(posedge clk);
  $display("chi:TX_RSPFLITV=%0d", TX_RSPFLITV);
repeat(2) @(posedge clk);
  $display("chi:TX_RSPFLIT=%0d", TX_RSPFLIT);
repeat(2) @(posedge clk);
  $display("chi:TX_DATFLITPEND=%0d", TX_DATFLITPEND);
repeat(2) @(posedge clk);
  $display("chi:TX_DATFLITV=%0d", TX_DATFLITV);
repeat(2) @(posedge clk);
  $display("chi:TX_DATFLIT=%0d", TX_DATFLIT);
repeat(2) @(posedge clk);

repeat(2) @(posedge clk);
  $display("chi:RX_REQFLITPEND=%0d", RX_REQFLITPEND);
repeat(2) @(posedge clk);
  $display("chi:RX_REQFLITV=%0d", RX_REQFLITV);
repeat(2) @(posedge clk);
  $display("chi:TX_REQFLIT=%0d", RX_REQFLIT);
repeat(2) @(posedge clk);
  $display("chi:RX_RSPFLITPEND=%0d", RX_RSPFLITPEND);
repeat(2) @(posedge clk);
  $display("chi:RX_RSPFLITV=%0d", RX_RSPFLITV);
repeat(2) @(posedge clk);
  $display("chi:RX_RSPFLIT=%0d", RX_RSPFLIT);
repeat(2) @(posedge clk);
  $display("chi:RX_DATFLITPEND=%0d", RX_DATFLITPEND);
repeat(2) @(posedge clk);
  $display("chi:RX_DATFLITV=%0d", RX_DATFLITV);
repeat(2) @(posedge clk);
  $display("chi:RX_DATFLIT=%0d", RX_DATFLIT);
repeat(2) @(posedge clk);
  $display("chi:RX_SNPFLITPEND=%0d", RX_SNPFLITPEND);
repeat(2) @(posedge clk);
  $display("chi:RX_SNPFLITV=%0d", RX_SNPFLITV);
repeat(2) @(posedge clk);
  $display("chi:RX_SNPFLIT=%0d", RX_SNPFLIT);
$display(" ");
 end

initial begin
repeat(2)@ (posedge clk);
$display("txreqflit_addr=%0d",txreqflit_addr);
$display("txreqflit_allowretry=%0d",txreqflit_allowretry);
$display("txreqflit_excl=%0d",txreqflit_excl);
$display("txreqflit_expcompack=%0d",txreqflit_expcompack);
$display("txreqflit_groupidext=%0d",txreqflit_groupidext);
$display("txreqflit_lpid=%0d",txreqflit_lpid);
$display("txreqflit_likelyshared=%0d",txreqflit_likelyshared);
$display("txreqflit_mpam=%0d",txreqflit_mpam);
$display("txreqflit_memattr=%0d",txreqflit_memattr);
$display("txreqflit_ns=%0d",txreqflit_ns);
$display("txreqflit_opcode=%0d",txreqflit_opcode);
$display("txreqflit_order=%0d",txreqflit_order);
$display("txreqflit_pcrdtype=%0d",txreqflit_pcrdtype);
$display("txreqflit_qos=%0d",txreqflit_qos);
$display("txreqflit_returnnid=%0d",txreqflit_returnnid);
$display("txreqflit_returntxnid=%0d",txreqflit_returntxnid);
$display("txreqflit_size=%0d",txreqflit_size);
$display("txreqflit_snpattr=%0d",txreqflit_snpattr);
$display("txreqflit_srcid=%0d",txreqflit_srcid);
$display("txreqflit_stashnidvalid=%0d",txreqflit_stashnidvalid);
$display("txreqflit_tagop=%0d",txreqflit_tagop);
$display("txreqflit_tgtid=%0d",txreqflit_tgtid);
$display("txreqflit_tracetag=%0d",txreqflit_tracetag);
$display("txreqflit_txnid=%0d",txreqflit_txnid);
$display("txreqflit_pend=%0d",txreqflit_pend);
$display("txreqflit_v=%0d",txreqflit_v);
$display("txreqflit_lcrdv=%0d", txreqflit_lcrdv);

$display("txrspflit_cbusy=%0d",txrspflit_cbusy);
$display("txrspflit_dbid=%0d",txrspflit_dbid);
$display("txrspflit_fwdstate=%0d",txrspflit_fwdstate);
$display("txrspflit_opcode=%0d",txrspflit_opcode);
$display("txrspflit_pcrdtype=%0d",txrspflit_pcrdtype);
$display("txrspflit_qos=%0d",txrspflit_qos);
$display("txrspflit_resp=%0d",txrspflit_resp);
$display("txrspflit_resperr=%0d",txrspflit_resperr);
$display("txrspflit_srcid=%0d",txrspflit_srcid);
$display("txrspflit_tagop=%0d",txrspflit_tagop);
$display("txrspflit_tgtid=%0d",txrspflit_tgtid);
$display("txrspflit_tracetag=%0d",txrspflit_tracetag);
$display("txrspflit_txnid=%0d",txrspflit_txnid);
$display("txrspflit_pend=%0d",txrspflit_pend);
$display("txrspflit_v=%0d",txrspflit_v);
$display("txrspflit_lcrdv=%0d",txrspflit_lcrdv);

$display("txdatflit_poison=%0d",txdatflit_poison);

$display("rxrspflit_cbusy=%0d",rxrspflit_cbusy);
$display("rxrspflit_dbid=%0d",rxrspflit_dbid);
$display("rxrspflit_fwdstate=%0d",rxrspflit_fwdstate);
$display("rxrspflit_opcode=%0d",rxrspflit_opcode);
$display("rxrspflit_pcrdtype=%0d",rxrspflit_pcrdtype);
$display("rxrspflit_qos=%0d",rxrspflit_qos);
$display("rxrspflit_resp=%0d",rxrspflit_resp);
$display("rxrspflit_resperr=%0d",rxrspflit_resperr);
$display("rxrspflit_srcid=%0d",rxrspflit_srcid);
$display("rxrspflit_tagop=%0d",rxrspflit_tagop);
$display("rxrspflit_tgtid=%0d",rxrspflit_tgtid);
$display("rxrspflit_tracetag=%0d",rxrspflit_tracetag);
$display("rxrspflit_txnid=%0d",rxrspflit_txnid);
$display("rxrspflit_pend=%0d",rxrspflit_pend);
$display("rxrspflit_v=%0d",rxrspflit_v);
$display("rxrspflit_lcrdv=%0d",rxrspflit_lcrdv);

$display("rxdatflit_poison=%0d",rxdatflit_poison);

$display("rxsnpflit_addr=%0d",rxsnpflit_addr);
$display("rxsnpflit_donotgotosd=%0d", rxsnpflit_donotgotosd);
$display("rxsnpflit_fwdnid=%0d", rxsnpflit_fwdnid);
$display("rxsnpflit_fwdtxnnid=%0d", rxsnpflit_fwdtxnnid);
$display("rxsnpflit_mpam=%0d", rxsnpflit_mpam);
$display("rxsnpflit_ns=%0d", rxsnpflit_ns);
$display("rxsnpflit_opcode=%0d", rxsnpflit_opcode);
$display("rxsnpflit_qos=%0d", rxsnpflit_qos);
$display("rxsnpflit_rettosrc=%0d", rxsnpflit_rettosrc);
$display("rxsnpflit_srcid=%0d", rxsnpflit_srcid);
$display("rxsnpflit_tracetag=%0d", rxsnpflit_tracetag);
$display("rxsnpflit_txnid=%0d", rxsnpflit_txnid);
$display("rxsnpflit_pend=%0d", rxsnpflit_pend);
$display("rxsnpflit_v=%0d", rxsnpflit_v);
$display("rxsnpflit_lcrdv=%0d", rxsnpflit_lcrdv);
$display(" ");
end


bit [153:0] TXREQ_q[$];
function void compare(bit [153:0] TXREQ_q[$], bit [72:0]RXRSPFLIT);
  for(int i=0; i<$size(TXREQ_q); i++) begin
    if(TXREQ_q[i][48:38]==RXRSPFLIT[25:15] && TXREQ_q[i][61:50]==RXRSPFLIT[37:26]) begin
      $display("Deleting element from queue - found a match! %0h", TXREQ_q[i]);
      TXREQ_q.delete(i);
      $display("Exiting loop as corresponding REQ for RSP is found");
      break;
    end
  end
endfunction

always @(posedge clk) begin
  if(TX_REQFLITV==1) begin
   $display("Pushing TX_REQFLIT into the queue");
    TXREQ_q.push_back(TX_REQFLIT);
    end
  if(RX_RSPFLITV==1) begin
    $display("Go to compare function");
    compare(TXREQ_q,RXRSPFLIT);
    end
end

initial begin
 $display("Display queue items: %p",TXREQ_q);
$display(" ");
end

endmodule