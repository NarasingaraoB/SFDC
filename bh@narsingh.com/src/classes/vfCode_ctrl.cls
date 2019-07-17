public class vfCode_ctrl {
public String randomCode;
public vfCode_ctrl()
{
  characters = new List<String>{'a','b','c','d','e','f','g','h',
            'i','j','k','l','m','n','o','p','q','r','s','t','u','v','w',
            'x','y','z','1','2','3','4','5','6','7','8','9','0'
        };
    
}
public String getGetVfCode() {
    String code='';
    code+=(getChar1()+getChar2()+getChar3()+getChar4()+getChar5()+getChar1());
    randomCode=code;
        return code;
    }
    List<String> characters;   
 public Integer randomNumber(){
        Integer random = Math.Round(Math.Random() * characters.Size());
        if(random == characters.size()){
            random--;
        }
        return random;
    }
    public String getChar1(){
        
        return characters[randomNumber()];
    }
    public String getChar2(){
        return characters[randomNumber()];
    }
    public String getChar3(){
        return characters[randomNumber()];
    }
    public String getChar4(){
        return characters[randomNumber()];
    }
    public String getChar5(){
        return characters[randomNumber()];
    }
    public String getChar6(){
        return characters[randomNumber()];
    }
}