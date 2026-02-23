# Android release build & install

## Build a release APK

This project uses **product flavors** (`stage`, `prod`). Always pass a flavor.

**Stage (with env config from `stage_env.json`):**

```bash
# From project root
flutter build apk --release --flavor stage --dart-define-from-file=stage_env.json
```

**Prod (no env file; add `prod_env.json` and use it if you need defines):**

```bash
flutter build apk --flavor prod
# or with env file:
# flutter build apk --release --flavor prod --dart-define-from-file=prod_env.json
```

APK path: `build/app/outputs/flutter-apk/app-stage-release.apk` or `app-prod-release.apk`.

## If you see "App not installed" or "Package appears to be invalid"

1. **Uninstall the existing app** on the device (Settings → Apps → your app → Uninstall).  
   Installing a release build over a debug build (or over an app signed with another key) fails; Android requires the same signature for updates.

2. **Install the new APK** again after uninstall.

3. If it still fails, ensure you built with a flavor:  
   `flutter build apk --flavor prod`

## Optional: release keystore (for Play Store)

For production, use your own keystore. Create `android/keystore.properties` (do not commit it):

```properties
storeFile=path/to/your/upload-keystore.jks
storePassword=***
keyPassword=***
keyAlias=upload
```

Use a path relative to the project root or an absolute path. Without this file, release builds are signed with the **debug** key so the APK is still installable for testing.
