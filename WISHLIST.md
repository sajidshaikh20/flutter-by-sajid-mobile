# Wishlist Feature Coding Style Overview

This document defines the coding style and implementation standards for the Wishlist/Watchlist feature in this project.

## 1) Architecture Rules

- Follow existing module structure under `lib/modules/`.
- Use existing BLoC style used in this codebase: `Cubit` + `BaseState`.
- Keep page files thin:
  - Route annotation
  - `BlocProvider`
  - Root screen widget
- Keep UI layout inside reusable widget files (example: `ui/widget/`).

## 2) Folder and File Pattern

Use this structure for feature modules:

- `cubit/`
  - `feature_cubit.dart`
  - `feature_state.dart`
  - `cubit.dart` (barrel export)
- `model/`
  - `feature_model.dart`
  - `model.dart` (barrel export)
- `ui/`
  - `feature_page.dart`
  - `ui.dart` (barrel export)
  - `widget/`
    - reusable UI widgets
    - `widget.dart` (barrel export)
- `feature.dart` (module barrel export)

## 3) Naming Conventions

- Page: `*Page` (`WatchlistPage`)
- Cubit: `*Cubit` (`WatchlistCubit`)
- State: `*State` (`WatchlistState`)
- Model: clear entity name (`WatchlistStockModel`)
- UI widgets: `*Widget` suffix (`WatchlistStockTileWidget`)

## 4) State Management Style

- State class extends `BaseState`.
- Keep state immutable:
  - `const` constructor where possible
  - `copyWith(...)` for updates
  - new list instances when modifying collections
- Handle list reorder through Cubit action method (event-style method):
  - `onStocksReordered(int oldIndex, int newIndex)`
- Always emit a fresh state object.

## 5) UI and Theme Consistency

- Reuse project theme and tokens:
  - `Dimens` for spacing, radius, and sizes
  - `MainConfig.appColors` / `AppColors` for colors
  - `context.textTheme` for typography
- Prefer reusable widgets over large inline UI blocks.
- Use `ReorderableListView` for drag-and-drop ordering.
- Provide stable keys for reorderable items (`ValueKey(stock.id)`).

## 6) Code Quality Guidelines

- Keep code simple and production-ready.
- Use strong typing; avoid `dynamic` unless unavoidable.
- Add short comments only for important logic (example: reorder index correction).
- Prefer `const` constructors/widgets where applicable.
- Keep imports consistent with project style:
  - `import '../../../utils/exports.dart';` (depth adjusted by file location)

## 7) Performance and UX

- Use `BlocBuilder` with `buildWhen` to reduce unnecessary rebuilds.
- Keep item widgets lightweight and reusable.
- Avoid expensive work in `build()` methods.
- Keep touch targets and spacing clear for responsive layouts.

## 8) Navigation Integration

- Register route in `AppPaths`.
- Add route in `AppRouter`.
- Update module export file `lib/modules/modules.dart`.
- Keep navigation behavior aligned with existing dashboard/tab flow.

## 9) Developer Checklist

- [ ] Uses existing `Cubit` architecture
- [ ] State is immutable
- [ ] Uses reusable widgets
- [ ] Uses existing theme/colors/tokens
- [ ] Route + exports are wired correctly
- [ ] Lint check passes for changed files

