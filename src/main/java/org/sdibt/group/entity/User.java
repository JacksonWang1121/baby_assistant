package org.sdibt.group.entity;

import java.io.Serializable;
/**
 * 
 * Title:User
 * @author hanfangfang
 * date:2018年8月28日 上午11:16:06
 * package:org.sdibt.group.entity
 * version 1.0
 */
public class User implements Serializable {
    private Long id;
    private String username;
    private String password;
    //用于用户密码加密的随机数
    private String salt;
    //标识该用户是否被锁
    private Boolean locked = Boolean.FALSE;
    //用户姓名
    private String realName;
    //用户昵称
    private String nickName;
    //用户头像
    private String userIcon;
    //个性签名
    private String personalitySignature;
    //家庭住址
    private String address;
    //首次登录状态
    private int firstLoginStatus;
    
    public User() {
    }
    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getCredentialsSalt() {
        return username + salt;
    }

    public Boolean getLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }
    
    public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getUserIcon() {
		return userIcon;
	}
	public void setUserIcon(String userIcon) {
		this.userIcon = userIcon;
	}
	public String getPersonalitySignature() {
		return personalitySignature;
	}
	public void setPersonalitySignature(String personalitySignature) {
		this.personalitySignature = personalitySignature;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getFirstLoginStatus() {
		return firstLoginStatus;
	}
	public void setFirstLoginStatus(int firstLoginStatus) {
		this.firstLoginStatus = firstLoginStatus;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", salt=" + salt + ", locked="
				+ locked + ", realName=" + realName + ", nickName=" + nickName + ", userIcon=" + userIcon
				+ ", personalitySignature=" + personalitySignature + ", address=" + address + ", firstLoginStatus="
				+ firstLoginStatus + "]";
	}

}
