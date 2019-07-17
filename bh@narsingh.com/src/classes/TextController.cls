global class TextController {

    global static String fromText ;
    public TextController()
    {
   
    }
    @RemoteAction
    global static void getText(String fromT)
    {
     System.debug('......fromText............'+fromT);
    fromText=fromT;
    }
}