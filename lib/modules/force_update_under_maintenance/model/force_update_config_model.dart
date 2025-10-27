/// Represents the configuration model for force update and maintenance settings.
class ForceUpdateConfigModel {
  /// Force update configuration details.
  ForceUpdate? forceUpdate;

  /// Under maintenance configuration details.
  UnderMaintainance? underMaintenance;

  /// Creates a [ForceUpdateConfigModel] instance.
  ForceUpdateConfigModel({this.forceUpdate, this.underMaintenance});

  /// Creates a [ForceUpdateConfigModel] from a JSON map.
  ForceUpdateConfigModel.fromJson(Map<String, dynamic> json) {
    forceUpdate = json['force_update'] != null
        ? ForceUpdate.fromJson(json['force_update'])
        : null;
    underMaintenance = json['under_maintainance'] != null
        ? UnderMaintainance.fromJson(json['under_maintainance'])
        : null;
  }

  /// Converts the [ForceUpdateConfigModel] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forceUpdate != null) {
      data['force_update'] = forceUpdate!.toJson();
    }
    if (underMaintenance != null) {
      data['under_maintainance'] = underMaintenance!.toJson();
    }
    return data;
  }
}

/// Represents the configuration details for a forced app update.
class ForceUpdate {
  /// The maximum supported Android version.
  String? androidMaxVersion;

  /// The minimum required Android version.
  String? androidMinVersion;

  /// The maximum supported iOS version.
  String? iosMaxVersion;

  /// The minimum required iOS version.
  String? iosMinVersion;

  /// The message displayed to the user when a force update is required.
  String? forceUpdateMsg;

  /// The title displayed in the force update dialog.
  String? forceUpdateTitle;

  /// Creates a [ForceUpdate] instance.
  ForceUpdate({
    this.androidMaxVersion,
    this.androidMinVersion,
    this.iosMaxVersion,
    this.iosMinVersion,
    this.forceUpdateMsg,
    this.forceUpdateTitle,
  });

  /// Creates a [ForceUpdate] instance from a JSON map.
  ForceUpdate.fromJson(Map<String, dynamic> json) {
    androidMaxVersion = json['android_max_version'];
    androidMinVersion = json['android_min_version'];
    iosMaxVersion = json['ios_max_version'];
    iosMinVersion = json['ios_min_version'];
    forceUpdateMsg = json['force_update_msg'];
    forceUpdateTitle = json['force_update_title'];
  }

  /// Converts the [ForceUpdate] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['android_max_version'] = androidMaxVersion;
    data['android_min_version'] = androidMinVersion;
    data['ios_max_version'] = iosMaxVersion;
    data['ios_min_version'] = iosMinVersion;
    data['force_update_msg'] = forceUpdateMsg;
    data['force_update_title'] = forceUpdateTitle;
    return data;
  }
}

/// Represents the configuration details for maintenance mode.
class UnderMaintainance {
  /// Indicates whether maintenance mode is enabled.
  bool? isMaintainanceModeEnable;

  /// The title shown during maintenance.
  String? maintainanceTitle;

  /// The description displayed during maintenance.
  String? maintainanceDescription;

  /// The image URL shown during maintenance.
  String? maintainanceImage;

  /// The priority level for maintenance mode.
  int? maintainancePriority;

  /// Creates an [UnderMaintainance] instance.
  UnderMaintainance({
    this.isMaintainanceModeEnable,
    this.maintainanceTitle,
    this.maintainanceDescription,
    this.maintainanceImage,
    this.maintainancePriority,
  });

  /// Creates an [UnderMaintainance] instance from a JSON map.
  UnderMaintainance.fromJson(Map<String, dynamic> json) {
    isMaintainanceModeEnable = json['is_maintainance_mode_enable'];
    maintainanceTitle = json['maintainance_title'];
    maintainanceDescription = json['maintainance_description'];
    maintainanceImage = json['maintainance_image'];
    maintainancePriority = json['maintainance_priority'];
  }

  /// Converts the [UnderMaintainance] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_maintainance_mode_enable'] = isMaintainanceModeEnable;
    data['maintainance_title'] = maintainanceTitle;
    data['maintainance_description'] = maintainanceDescription;
    data['maintainance_image'] = maintainanceImage;
    data['maintainance_priority'] = maintainancePriority;
    return data;
  }
}
