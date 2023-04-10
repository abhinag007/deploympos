package com.tech.mpos;

import android.app.Application;
import android.content.ContextWrapper;
import android.os.Environment;
import android.util.Log;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SealedObject;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.xml.transform.stream.StreamResult;

public class Encrypt {
/*
    private static Serializable details;

    public Encrypt(Details details) {
        this.details = details;
    }*/


    static int amount;
    static String type,exp_month,exp_year,acc_number,cvv;

    public Encrypt(String cvv, int amount, String type, String exp_month, String exp_year, String acc_number) {
        Encrypt.amount = amount;
        Encrypt.type = type;
        Encrypt.exp_month = exp_month;
        Encrypt.exp_year = exp_year;
        Encrypt.acc_number = acc_number;
        Encrypt.cvv = cvv;
    }

    public void encrypt() throws IOException, ClassNotFoundException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {

        Details details = new Details(cvv,amount,type,exp_month, exp_year,acc_number);

        KeyGenerator generator = KeyGenerator.getInstance( "AES" );
        SecretKey key = generator.generateKey();
        
        Log.d("check", String.valueOf(key));

        SecureRandom random = new SecureRandom();
        byte [] iv = new byte [16];
        random.nextBytes( iv );
     /*   for (byte a :
                iv) {
            Log.d("bytes", String.valueOf(a));
        }*/
        // create cipher
        Cipher cipher = Cipher.getInstance( key.getAlgorithm() + "/CBC/PKCS5Padding" );
        cipher.init( Cipher.ENCRYPT_MODE, key, new IvParameterSpec( iv ) );
        String path = android.os.Environment.getExternalStorageDirectory().toString().replaceAll(":",".")+"/"+"out.aes";

//        ContextWrapper contextWrapper = new ContextWrapper(getApplicationContext());
//        File directory = contextWrapper.getExternalFilesDir(Environment.DIRECTORY_DCIM);
//        File file = new File(directory,"out"+".aes");
        Log.d("path", path);
        // create sealed object
        SealedObject sealedEm1 = new SealedObject(details , cipher);

        // Create stream
        FileOutputStream fos = new FileOutputStream(path);

//        FileOutputStream fos = new FileOutputStream("out.aes");
        BufferedOutputStream bos = new BufferedOutputStream(fos);
        CipherOutputStream cos = new CipherOutputStream(bos, cipher);
        ObjectOutputStream oos = new ObjectOutputStream(cos);
        oos.writeObject( sealedEm1 );
        oos.close();

        Log.d("encrypt", String.valueOf(sealedEm1));

        // read an encrypted java object from a file and decrypt it


        // turn the mode of cipher to decryption
        cipher.init( Cipher.DECRYPT_MODE, key, new IvParameterSpec( iv ) ); // reuse the key and iv generated before

        // create stream
        CipherInputStream cipherInputStream = new CipherInputStream( new BufferedInputStream( new FileInputStream( path ) ), cipher );
        ObjectInputStream inputStream = new ObjectInputStream( cipherInputStream );
        SealedObject sealedObject = (SealedObject) inputStream.readObject();
        Details dt = (Details) sealedObject.getObject(cipher);
        Log.d("encrypt", dt.type);


    }
}
