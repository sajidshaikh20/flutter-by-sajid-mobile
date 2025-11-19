# FlutterBySajid Mobile Application

A modern Flutter application built with Clean Architecture principles, supporting Android, iOS, and Web platforms. The app features an in-app browser with tab management, file handling, authentication, and multi-language support.

## 📋 Project Overview

FlutterBySajid is a cross-platform mobile application developed using Flutter framework. The application provides:

- **In-App Browser**: Multi-tab browser with navigation controls (Back/Forward/Refresh)
- **File Management**: Document viewer and file picker for PDF, DOCX, PPTX, XLSX
- **Authentication**: Social login (Google, Facebook, Apple) and email/password
- **Multi-language Support**: English and Arabic with RTL support
- **State Management**: BLoC pattern with Cubit for reactive state management
- **Local Storage**: Hive for complex data, GetStorage for key-value pairs
- **Firebase Integration**: Analytics, Crashlytics, Remote Config, and Push Notifications

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns across multiple layers:

```
┌─────────────────────────────────────────────────────────────┐
│                        Presentation Layer                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │    UI/Pages  │  │   Widgets    │  │   Cubits     │      │
│  │              │  │              │  │  (State Mgmt)│      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                        Domain Layer                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Models      │  │ Repositories  │  │   Use Cases  │      │
│  │  (Entities)  │  │  (Interfaces) │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                        Data Layer                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Repository   │  │   API Client │  │   Storage    │      │
│  │ Implementations│ │   (Dio)     │  │  (Hive/SP)   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                        Core/Infrastructure                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Services    │  │  Navigation  │  │   Utils      │      │
│  │  (Firebase,  │  │  (auto_route)│  │  (Helpers)   │      │
│  │  Network,    │  │              │  │              │      │
│  │  Storage)    │  │              │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### Directory Structure

```
lib/
├── app/                    # App-level configuration
│   ├── core/              # Core widgets, themes, configs
│   ├── initializer/       # App initialization logic
│   └── translations/      # Localization & i18n
├── base/                  # Base classes (Cubit, State, Config)
├── modules/               # Feature modules (Clean Architecture)
│   ├── tabs/             # Browser tabs feature
│   ├── login/            # Authentication
│   ├── home/             # Home/Dashboard
│   └── ...               # Other features
├── service/               # Infrastructure services
│   ├── network/          # API client, repositories
│   ├── storage/          # Local storage (Hive)
│   ├── firebase/         # Firebase services
│   └── navigation/        # Routing
└── utils/                 # Utility functions & extensions
```

## 🚀 Setup & Run Instructions

### Prerequisites

- Flutter SDK: `>=3.5.3 <4.0.0`
- Dart SDK: Compatible with Flutter SDK
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development)
- Chrome (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter-by-sajid-mobile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (for freezed, json_serializable, auto_route)**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Generate assets**
   ```bash
   flutter pub run flutter_gen_runner
   ```

### Running the Application

#### Android

**Debug Mode:**
```bash
flutter run --flavor stage --dart-define-from-file=stage_env.json
```

**Release Mode:**
```bash
flutter build apk --release --flavor prod --dart-define-from-file=prod_env.json
```

**Stage Build:**
```bash
flutter build apk --release --flavor stage --dart-define-from-file=stage_env.json
```

#### iOS

**Debug Mode:**
```bash
flutter run --flavor stage --dart-define-from-file=stage_env.json
```

**Release Mode:**
```bash
flutter build ios --release --flavor prod --dart-define-from-file=prod_env.json
```

**Stage Build:**
```bash
flutter build ios --release --flavor stage --dart-define-from-file=stage_env.json
```

#### Web

**Run on Chrome:**
```bash
flutter run -d chrome
```

**Note:** Flavors are not supported on web. Run without `--flavor` flag.

**Build for Web:**
```bash
flutter build web
```

### Environment Configuration

Create environment configuration files:

**`stage_env.json`:**
```json
{
  "base_url": "https://api-stage.example.com",
  "envKey": "stage"
}
```

**`prod_env.json`:**
```json
{
  "base_url": "https://api.example.com",
  "envKey": "prod"
}
```

## 📦 Package List & Versioning

### Core Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^9.0.0 | State management (BLoC pattern) |
| `get_it` | ^8.2.0 | Dependency injection |
| `auto_route` | ^9.2.2 | Declarative routing |
| `dio` | ^5.7.0 | HTTP client for API calls |
| `hive` | ^2.2.3 | Local NoSQL database |
| `hive_flutter` | ^1.1.0 | Hive Flutter integration |
| `get_storage` | ^2.1.1 | Key-value storage (SharedPreferences) |
| `freezed` | ^2.5.2 | Immutable data classes |
| `equatable` | ^2.0.5 | Value equality for objects |

### UI & UX

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_easyloading` | ^3.0.5 | Loading indicators |
| `cached_network_image` | ^3.4.1 | Image caching |
| `fast_cached_network_image` | ^1.3.3+5 | Fast image caching |
| `flutter_svg` | ^2.0.10+1 | SVG support |
| `lottie` | ^3.3.1 | Lottie animations |
| `shimmer` | ^3.0.0 | Shimmer loading effects |
| `photo_view` | ^0.15.0 | Image viewer |

### Platform Features

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_inappwebview` | ^6.1.5 | In-app browser (Android/iOS) |
| `webview_flutter` | ^4.9.0 | WebView for Flutter |
| `permission_handler` | ^12.0.1 | Runtime permissions |
| `device_info_plus` | ^11.5.0 | Device information |
| `package_info_plus` | ^8.0.2 | App package info |
| `url_launcher` | ^6.3.1 | Launch URLs/external apps |
| `file_picker` | ^8.1.2 | File picker |
| `open_filex` | ^4.3.3 | Open files |

### Firebase

| Package | Version | Purpose |
|---------|---------|---------|
| `firebase_core` | ^4.0.0 | Firebase core |
| `firebase_messaging` | ^16.0.0 | Push notifications |
| `firebase_crashlytics` | ^5.0.0 | Crash reporting |
| `firebase_analytics` | ^12.0.0 | Analytics |
| `firebase_remote_config` | ^6.0.0 | Remote configuration |

### Authentication

| Package | Version | Purpose |
|---------|---------|---------|
| `google_sign_in` | ^6.1.6 | Google Sign-In |
| `flutter_facebook_auth` | ^7.1.2 | Facebook Sign-In |
| `sign_in_with_apple` | ^7.0.1 | Apple Sign-In |

### Development Tools

| Package | Version | Purpose |
|---------|---------|---------|
| `build_runner` | ^2.4.9 | Code generation |
| `json_serializable` | ^6.7.1 | JSON serialization |
| `auto_route_generator` | ^9.0.0 | Route generation |
| `flutter_gen_runner` | ^5.11.0 | Asset generation |
| `flutter_lints` | ^6.0.0 | Linting rules |

## 🧩 State Management

The application uses **BLoC (Business Logic Component) pattern** with **Cubit** for state management, powered by `flutter_bloc` package.

### Why BLoC/Cubit?

1. **Separation of Concerns**: Business logic is separated from UI
2. **Testability**: Easy to unit test business logic
3. **Reactive**: UI automatically updates when state changes
4. **Predictable**: Unidirectional data flow
5. **Scalable**: Easy to add new features without affecting existing code

### Architecture

```
┌─────────────┐
│    UI       │  ← Listens to state changes
│  (Widget)   │
└──────┬──────┘
       │
       │ Events/Actions
       ↓
┌─────────────┐
│   Cubit     │  ← Business logic & state management
│  (State)    │
└──────┬──────┘
       │
       │ Emits new state
       ↓
┌─────────────┐
│  Repository │  ← Data layer (API/Storage)
└─────────────┘
```

### Example Implementation

```dart
// State
class TabsState extends BaseState {
  final List<BrowserTabModel> tabs;
  final String? activeTabId;
  
  TabsState copyWith({...}) { ... }
}

// Cubit
class TabsCubit extends BaseCubit<TabsState> {
  Future<void> createNewTab(String url) async {
    // Business logic
    final newTab = BrowserTabModel(...);
    final updatedTabs = [...state.tabs, newTab];
    
    // Emit new state
    emit(state.copyWith(tabs: updatedTabs));
  }
}

// UI
BlocBuilder<TabsCubit, TabsState>(
  builder: (context, state) {
    return ListView.builder(
      itemCount: state.tabs.length,
      ...
    );
  },
)
```

### Base Classes

- **`BaseCubit<T>`**: Abstract base class for all Cubits
  - Provides `resetError()` and `resetRedirection()` methods
  - Ensures consistent error handling across features

- **`BaseState`**: Base state class
  - Contains common state properties (status, error, redirectRoute)
  - Uses `Equatable` for efficient state comparison

## 💾 Storage Logic

The application uses a **hybrid storage approach** combining multiple storage solutions based on data type and requirements.

### Storage Strategy

```
┌─────────────────────────────────────────┐
│         Storage Layer                   │
├─────────────────────────────────────────┤
│                                         │
│  ┌──────────────┐  ┌──────────────┐   │
│  │     Hive     │  │ GetStorage   │   │
│  │  (Complex)   │  │  (Key-Value) │   │
│  └──────────────┘  └──────────────┘   │
│         │                  │           │
│         └────────┬─────────┘           │
│                  │                     │
│         ┌────────▼─────────┐           │
│         │  StorageService  │           │
│         │  (Abstraction)   │           │
│         └──────────────────┘           │
└─────────────────────────────────────────┘
```

### 1. Hive (Complex Data Storage)

**Purpose**: Store structured data, lists, and complex objects

**Used For**:
- Browser tabs data
- File metadata
- Cached pages
- Summaries

**Implementation**:
```dart
// StorageService using Hive
class StorageService {
  Future<void> saveTabs(List<Map<String, dynamic>> tabs) async {
    await _tabsBoxInstance?.put('tabs_list', {'tabs': tabs});
  }
  
  List<Map<String, dynamic>>? getSavedTabs() {
    return _tabsBoxInstance?.get('tabs_list')?['tabs'];
  }
}
```

**Why Hive?**
- Fast NoSQL database
- Type-safe
- Works offline
- Efficient for complex data structures

### 2. GetStorage / SharedPreferences (Key-Value Storage)

**Purpose**: Store simple key-value pairs, user preferences, and settings

**Used For**:
- User authentication tokens
- Language preferences
- App settings
- Feature flags

**Implementation**:
```dart
// SharedPref wrapper
class SharedPref {
  Future<void> setValue(String key, dynamic value) async {
    await _storage.write(key, value);
  }
  
  T? getValue<T>(String key) {
    return _storage.read<T>(key);
  }
}
```

**Why GetStorage?**
- Simple API
- Fast for key-value operations
- Cross-platform (works on web)
- Lightweight

### Storage Decision Matrix

| Data Type | Storage Solution | Reason |
|-----------|-----------------|--------|
| Browser Tabs | Hive | Complex list of objects |
| File Metadata | Hive | Structured data |
| User Token | GetStorage | Simple key-value |
| Language Preference | GetStorage | Simple setting |
| Cached Pages | Hive | Complex nested data |
| App Settings | GetStorage | Key-value pairs |

### Web Platform Considerations

On web platform:
- **Hive**: Not fully supported (uses IndexedDB fallback)
- **GetStorage**: Works seamlessly (uses localStorage)
- **File System**: Not accessible (uses browser download)

The app includes platform-specific checks (`kIsWeb`) to handle web limitations gracefully.

## 🔧 Build Commands

### Code Generation
```bash
# Generate freezed, json_serializable, auto_route files
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on file changes)
dart run build_runner watch --delete-conflicting-outputs

# Generate assets
dart run flutter_gen_runner
```

### Android Builds
```bash
# Production APK
flutter build apk --release --flavor prod --dart-define-from-file=prod_env.json

# Stage APK
flutter build apk --release --flavor stage --dart-define-from-file=stage_env.json

# Debug APK
flutter build apk --debug --flavor stage --dart-define-from-file=stage_env.json
```

### iOS Builds
```bash
# Production
flutter build ios --release --flavor prod --dart-define-from-file=prod_env.json

# Stage
flutter build ios --release --flavor stage --dart-define-from-file=stage_env.json

# Debug
flutter build ios --debug --flavor stage --dart-define-from-file=stage_env.json
```

### Web Build
```bash
# Build for web (no flavor support)
flutter build web
```

## 📝 Additional Notes

- **Flavors**: Used for different environments (prod/stage). Not supported on web.
- **Platform Support**: Android, iOS, and Web (with platform-specific implementations)
- **Localization**: English and Arabic with RTL support
- **Error Handling**: Centralized error handling with user-friendly messages
- **Logging**: Custom debug logger with file and console output (file logging disabled on web)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

[Add your license information here]

---

**Developed by Sajid** 🚀
