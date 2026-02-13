import '../../../utils/exports.dart';

/// State for the main screen (first screen after splash).
class MainState extends BaseState {
  /// Creates a [MainState].
  const MainState({
    required super.status,
    this.model = const MainScreenModel(),
    super.msg,
    super.redirectRoute,
  });

  /// Main screen data.
  final MainScreenModel model;

  /// Returns a copy with updated fields.
  /// Pass [clearRedirect] true to set [redirectRoute] to null.
  /// Pass [clearMessage] true to set [msg] to null.
  MainState copyWith({
    BaseStateStatus? status,
    MainScreenModel? model,
    String? msg,
    PageRouteInfo? redirectRoute,
    bool clearRedirect = false,
    bool clearMessage = false,
  }) {
    return MainState(
      status: status ?? this.status,
      model: model ?? this.model,
      msg: clearMessage ? null : (msg ?? this.msg),
      redirectRoute: clearRedirect ? null : (redirectRoute ?? this.redirectRoute),
    );
  }

  @override
  List<Object?> get props => <Object?>[...super.props, model];
}
