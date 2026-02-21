import '../../../utils/exports.dart';

/// State for the chat support screen.
class ChatSupportState extends BaseState {
  const ChatSupportState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
  });

  ChatSupportState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
  }) =>
      ChatSupportState(
        status: status ?? this.status,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        msg: msg ?? this.msg,
      );

  @override
  List<Object?> get props => <Object?>[...super.props];

  factory ChatSupportState.initial() {
    return const ChatSupportState(
      status: BaseStateStatus.initial,
    );
  }
}
