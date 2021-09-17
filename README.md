```
flutter build web --web-renderer html --release
firebase deploy --only hosting
```


### signing app
 - change icon with the help of flutter_icons:
 - change app name from AndroidManifest.xml > android:label=<name>
 - copy keystore command to generate keyfile.jks from <a href="https://flutter.dev/docs/deployment/android">here</a> or use this command ```  keytool -genkey -v -keystore ~/<appname>-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload```
 - store the passwords you enter, you will need it later.
 - now get the SHA keys if you've added Authentication, ```keytool -list -v -keystore ~/<appname>-key.jks -alias {alias_name i.e. upload}``` and for password enter keyPassword.
 - Add this SHA keys in your firebase
 - create a file, android/key.properties and these lines
 ```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload // notice from step 3 keyalias is "upload"
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
```
 - In android/app/build.gradle, change your applicationId if you havent already, and for version number change it from .yaml
 - Add the keystore information from your properties file before the android {} block:
 ```
 def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
        ...
}
```
 - Replace buildTypes block with 
 ```
    signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```
 - run ```flutter build appbundle```

