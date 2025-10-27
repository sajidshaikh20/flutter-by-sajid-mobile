import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

/// Base request class for all API requests.
///
/// This class is used as a structure for all requests
/// that include a `head` and `body`.
/// It simplifies the process of generating API requests
///  by handling the common structure,
/// so only the body needs to be provided when creating a request.
///
/// Example structure:
/// ```dart
/// {
///   head: {...},
///   body: {...}
/// }
/// ```
///
/// The `T` represents the type of the body, which can be customized
///  based on the request.
@JsonSerializable(ignoreUnannotated: true, genericArgumentFactories: true)
class BaseRequest<T> {
  /// Creates a new instance of `BaseRequest`.
  ///
  /// [head] is the header of the request that contains metadata
  /// like authorization tokens and request info.
  /// [body] is the main content of the request, representing the payload.
  BaseRequest({this.head, this.body});

  /// Converts a JSON object into a `BaseRequest` instance,
  /// using the provided [jsonFrom] function
  /// to deserialize the body.
  factory BaseRequest.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) jsonFrom,
  ) =>
      _$BaseRequestFromJson<T>(json, jsonFrom);

  /// Represents the header of the request, which includes
  ///  metadata about the request.
  @JsonKey(name: 'Head')
  HeadRequest? head;

  /// The body of the request, which can be of any type [T],
  /// representing the data being sent.
  @JsonKey(name: 'Body')
  T? body;

  /// Converts the `BaseRequest` instance into a JSON object,
  ///  using the provided [toJson] function
  /// to serialize the body.
  Map<String, dynamic> toJson(Object? Function(T) toJson) =>
      _$BaseRequestToJson(this, toJson);
}

/// Class representing the header of the API request, containing
///  metadata for the request.
///
/// This includes information like the app version, device details,
/// request codes, and authentication tokens.
@JsonSerializable(ignoreUnannotated: true)
class HeadRequest {
  /// Creates a new instance of `HeadRequest`.
  ///
  /// This constructor is used to set values for the metadata fields
  ///  that are part of the request header.
  HeadRequest({
    this.code,
    this.key,
    this.requestCode,
    this.token,
    this.appName,
    this.deviceMake,
    this.deviceModel,
    this.deviceType,
    this.appVersion,
  });

  /// Factory method to create a `HeadRequest` instance from a JSON object.
  factory HeadRequest.fromJson(Map<String, dynamic> json) =>
      _$HeadRequestFromJson(json);

  /// Code representing the request type or status.
  @JsonKey(name: 'Code')
  String? code;

  /// Key for identifying the request or user.
  @JsonKey(name: 'Key')
  String? key;

  /// Version of the app sending the request.
  @JsonKey(name: 'AppVer')
  String? appVersion;

  /// Name of the app sending the request.
  @JsonKey(name: 'AppName')
  String? appName;

  /// Name of the operating system (e.g., Android or iOS).
  @JsonKey(name: 'OSName')
  String? osName;

  /// Manufacturer or brand of the device (e.g., Samsung, Apple).
  @JsonKey(name: 'device_make')
  String? deviceMake;

  /// Model of the device.
  @JsonKey(name: 'device_model')
  String? deviceModel;

  /// Version of the operating system on the device.
  @JsonKey(name: 'os_version')
  String? osVersion;

  /// Type of the device (e.g., Mobile, Tablet).
  @JsonKey(name: 'device_type')
  String? deviceType;

  /// Code that identifies the request.
  @JsonKey(name: 'RequestCode')
  String? requestCode;

  /// Token for authentication or identification.
  @JsonKey(name: 'Token')
  String? token;

  /// Converts the `HeadRequest` instance into a JSON object.
  Map<String, dynamic> toJson() => _$HeadRequestToJson(this);
}
