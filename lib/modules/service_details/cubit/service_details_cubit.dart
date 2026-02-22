import '../../../../utils/exports.dart';

/// Cubit for the service details screen (AEPS, DMT, etc.).
class ServiceDetailsCubit extends BaseCubit<ServiceDetailsState> {
  ServiceDetailsCubit(ServiceDetailType serviceType)
      : super(ServiceDetailsState.initial(serviceType));

  @override
  ServiceDetailsState getResetErrorState() => state.copyWith(msg: '');

  @override
  ServiceDetailsState getResetRedirectionState() => state.copyWith();
}
