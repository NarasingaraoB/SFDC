public class pnrStatus_ctrl {

    public PageReference GetPnrStatus() {
    PageReference tb=new PageReference('/apex/payment');
    tb.getParameters().put('pnrNo',pnrNo);
        return tb;
    }


    public String pnrNo { get; set; }
}