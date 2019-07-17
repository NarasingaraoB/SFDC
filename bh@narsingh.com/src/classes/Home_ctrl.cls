public class Home_ctrl {

    public PageReference GoHome() {
    PageReference pg=new PageReference('/apex/welcome');
        return pg;
    }

}