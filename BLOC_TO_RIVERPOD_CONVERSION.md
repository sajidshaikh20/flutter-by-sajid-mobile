# BLoC to Riverpod Conversion Guide

## Conversion Pattern

### 1. Replace BlocProvider with Riverpod Provider
**Before:**
```dart
BlocProvider<LoginCubit>(
  create: (context) => LoginCubit(...),
  child: Widget(),
)
```

**After:**
```dart
// Provider is already available globally, no need to wrap
Widget()
// Access via: ref.watch(loginNotifierProvider)
```

### 2. Replace BlocBuilder with Consumer
**Before:**
```dart
BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) => Widget(),
)
```

**After:**
```dart
Consumer(
  builder: (context, ref, child) {
    final state = ref.watch(loginNotifierProvider);
    return Widget();
  },
)
```

### 3. Replace BlocListener with ref.listen
**Before:**
```dart
BlocListener<LoginCubit, LoginState>(
  listener: (context, state) => {},
  child: Widget(),
)
```

**After:**
```dart
// In ConsumerStatefulWidget's initState or build:
ref.listen<LoginState>(loginNotifierProvider, (previous, next) {
  // Handle state changes
});
```

### 4. Replace context.read/watch with ref.read/watch
**Before:**
```dart
context.read<LoginCubit>().login();
context.watch<LoginCubit>();
```

**After:**
```dart
ref.read(loginNotifierProvider.notifier).login();
ref.watch(loginNotifierProvider);
```

### 5. Convert StatelessWidget to ConsumerWidget
**Before:**
```dart
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) => Widget();
}
```

**After:**
```dart
class MyWidget extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) => Widget();
}
```

### 6. Convert StatefulWidget to ConsumerStatefulWidget
**Before:**
```dart
class MyWidget extends StatefulWidget {
  State<MyWidget> createState() => _MyWidgetState();
}
class _MyWidgetState extends State<MyWidget> {}
```

**After:**
```dart
class MyWidget extends ConsumerStatefulWidget {
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}
class _MyWidgetState extends ConsumerState<MyWidget> {}
```

## Available Providers

- `localeNotifierProvider` - Locale management
- `internetNotifierProvider` - Internet connectivity
- `cartCountProvider` - Cart count state
- `globalWishlistProvider` - Global wishlist/cart
- `splashNotifierProvider` - Splash screen
- `loginNotifierProvider` - Login
- `socialLoginNotifierProvider` - Social login
- `homeNotifierProvider` - Home screen
- `notificationNotifierProvider` - Notifications
- `myAccountNotifierProvider` - My account
- `wishListNotifierProvider` - Wishlist
- `forgotPasswordNotifierProvider` - Forgot password

## Files Still Needing Conversion

See grep results for all files using BlocProvider, BlocBuilder, BlocConsumer, or context.read/watch with Cubit.

