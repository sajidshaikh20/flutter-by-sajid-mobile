import '../../../utils/exports.dart';

/// State representing force update and under maintenance status.
///
/// This state holds information about the current maintenance status,
/// including whether a force update is required and the configuration for
/// the update process. It also tracks the visibility of alert dialogs
/// related to the maintenance state.
class ForceUpdateUnderMaintenanceState extends BaseState {
  /// State representing force update and under maintenance status.

  const ForceUpdateUnderMaintenanceState({
    required super.status,
    this.underMaintenanceType,
    this.updateMaintenanceType,
    this.forceUpdateConfigModel,
    this.isAlertDialogVisible,
    super.msg = '',
    super.redirectRoute,
  });

  /// The configuration model for the force update, if available.
  final ForceUpdateConfigModel? forceUpdateConfigModel;

  /// The type of under maintenance state, if applicable.
  final UnderMaintenanceType? underMaintenanceType;

  /// The update maintenance type, if applicable.
  final UpdateMaintenanceType? updateMaintenanceType;

  /// Indicates if the alert dialog for maintenance is visible.
  final bool? isAlertDialogVisible;

  /// Creates a new state by copying the current one with the given overrides.
  ///
  /// This method allows for creating a new state based on the current state
  /// with optional updates to certain properties.
  ForceUpdateUnderMaintenanceState copyWith({
    required BaseStateStatus status,
    ForceUpdateConfigModel? forceUpdateConfigModel,
    UnderMaintenanceType? underMaintenanceType,
    UpdateMaintenanceType? updateMaintenanceType,
    bool? isAlertDialogVisible,
    PageRouteInfo? redirectRoute,
    String? msg,
  }) =>
      ForceUpdateUnderMaintenanceState(
        forceUpdateConfigModel:
            forceUpdateConfigModel ?? this.forceUpdateConfigModel,
        isAlertDialogVisible: isAlertDialogVisible ?? this.isAlertDialogVisible,
        underMaintenanceType: underMaintenanceType ?? this.underMaintenanceType,
        updateMaintenanceType:
            updateMaintenanceType ?? this.updateMaintenanceType,
        status: status,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        msg: msg ?? this.msg,
      );

  /// List of properties for equality comparison.
  ///
  /// This list contains all the properties that should be used to compare
  /// instances of this state for equality.
  @override
  List<Object?> get props => <Object?>[
        status,
        forceUpdateConfigModel,
        underMaintenanceType,
        updateMaintenanceType,
        isAlertDialogVisible,
        msg,
        redirectRoute,
      ];
}
