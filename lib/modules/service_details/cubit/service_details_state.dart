import '../../../../utils/exports.dart';

/// State for the service details screen (e.g. AEPS, DMT).
class ServiceDetailsState extends BaseState {
  const ServiceDetailsState({
    required this.serviceType,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  factory ServiceDetailsState.initial(ServiceDetailType serviceType) =>
      ServiceDetailsState(serviceType: serviceType);

  /// Which service flow is being shown.
  final ServiceDetailType serviceType;

  ServiceDetailsState copyWith({
    ServiceDetailType? serviceType,
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
  }) =>
      ServiceDetailsState(
        serviceType: serviceType ?? this.serviceType,
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
      );

  @override
  List<Object?> get props => <Object?>[serviceType, status, msg, redirectRoute];
}
