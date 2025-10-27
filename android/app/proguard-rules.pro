 ## Flutter wrapper
 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.** { *; }
 -keep class io.flutter.util.** { *; }
 -keep class io.flutter.view.** { *; }
 -keep class io.flutter.** { *; }
 -keep class io.flutter.plugins.** { *; }
 -keep class com.google.firebase.** { *; }
 -dontwarn io.flutter.embedding.**
 -ignorewarnings
 -keepattributes *Annotation*
 -keepclassmembers class ** {
     @com.google.firebase.messaging.FirebaseMessagingService <methods>;
 }
 -keep public class com.google.android.gms.** { *; }


