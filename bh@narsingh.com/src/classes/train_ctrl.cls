public class train_ctrl {

    public String jrdat { get; set; }

    public String selClass { get; set; }

    public String destCode { get; set; }

    public String srcCode { get; set; }
    Public List<String> links {get;set;}
    List<String> states;
    List<String> connections;
    public train_ctrl()
    {
    states=new List<String>{'Andhra Pradesh','Bihar','Chennai','Gujrat','Haryana','JK','Karnataka','Kolkata','Kerala','Maharashtra','Madhya Pradesh','North East','Orissa','Punjab','Rajasthan','Tamil Nadu','Uttar Pradesh (E)','Uttar Pradesh (W)','West Bengal'};
    connections=new List<String>{'Vodafone','Tata Docomo','Idea','Airtel','BSNL','Uninor','Reliance CDMA','Reliance GSM'};
    links=new List<String>();
    for(integer i=0;i<3;i++)
    {
    links.add('/apex/TelicomDetails?conType='+(connections[randomNumber(connections)])+'&circle='+(states[randomNumber(states)]));
    }
    }

    public PageReference getReset() {
        return null;
    }

     public Integer randomNumber(List<String> lst){
        Integer random = Math.Round(Math.Random() * lst.Size());
        if(random == lst.size()){
            random--;
        }
        return random;
    }
    public PageReference getSeatAvailability() {
        return null;
    }

}