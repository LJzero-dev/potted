package vo;

import java.io.Serializable;

import lombok.Getter;

@Getter
public class SessionMember implements Serializable {

    private String name;
    private String email;
    private String picture;


    public SessionMember(MemberInfo mi){
    	
    }
}
