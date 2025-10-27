import '../../../utils/exports.dart';

/// `SocialLoginState` class represents the state of the social login screen.
///
/// It extends `BaseState` and contains properties related to the social login process.
class SocialLoginState extends BaseState {
  ///
  const SocialLoginState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
  });

  @override
  List<Object?> get props => <Object?>[
    ...super.props,
  ];

  /// Creates a copy of this state with the given fields replaced by new values.
  SocialLoginState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
  }) {
    return SocialLoginState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute,
    );
  }
}
