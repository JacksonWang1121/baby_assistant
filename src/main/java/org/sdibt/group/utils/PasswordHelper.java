package org.sdibt.group.utils;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.sdibt.group.entity.User;

/**
 * 
 * Title:PasswordHelper
 * @author hanfangfang
 * date:2018年8月28日 上午11:16:51
 * package:org.sdibt.group.utils
 * version 1.0
 */
public class PasswordHelper {

    private RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
    private String algorithmName = "md5";
    private int hashIterations = 2;

    public void setRandomNumberGenerator(RandomNumberGenerator randomNumberGenerator) {
        this.randomNumberGenerator = randomNumberGenerator;
    }

    public void setAlgorithmName(String algorithmName) {
        this.algorithmName = algorithmName;
    }

    public void setHashIterations(int hashIterations) {
        this.hashIterations = hashIterations;
    }

    public void encryptPassword(User user) {

        user.setSalt(randomNumberGenerator.nextBytes().toHex());
        /**
         * 根据md5，原始密码，佐料生成新的密码
         */
        String newPassword = new SimpleHash(
                algorithmName,
                user.getPassword(),
                ByteSource.Util.bytes(user.getCredentialsSalt()),
                hashIterations).toHex();

        user.setPassword(newPassword);
    }
    public User secretPassword(User user) {

        user.setSalt(randomNumberGenerator.nextBytes().toHex());
        /**
         * 根据md5，原始密码，佐料生成新的密码
         */
        String newPassword = new SimpleHash(
                algorithmName,
                user.getPassword(),
                ByteSource.Util.bytes(user.getCredentialsSalt()),
                hashIterations).toHex();

        user.setPassword(newPassword);
        return user;
    }
    
    public static void main(String[] args) {
    	   User u1 = new User("zhang", "ok");
	       User u2 = new User("li", "ok");
	       User u3 = new User("13468749480", "ok");
	       User u4 = new User("13772373425", "ok");
	       User u5 = new User("17865572663", "ok");
	       User u6 = new User("15653541150", "ok");
	       PasswordHelper ph=new PasswordHelper();
	       ph.encryptPassword(u1);
	       ph.encryptPassword(u2);
	       ph.encryptPassword(u3);
	       ph.encryptPassword(u4);
	       ph.encryptPassword(u5);
	       ph.encryptPassword(u6);
	       System.out.println(u1.getSalt()+":"+u1.getPassword());
	       System.out.println(u2.getSalt()+":"+u2.getPassword());
	       System.out.println(u3.getSalt()+":"+u3.getPassword());
	       System.out.println(u4.getSalt()+":"+u4.getPassword());
	       System.out.println(u5.getSalt()+":"+u5.getPassword());
	       System.out.println(u6.getSalt()+":"+u6.getPassword());
	}
}
