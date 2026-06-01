import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../service_details/service_details.dart';

/// Model representing a single service item in the All Services grid.
class ServiceItemModel {
  /// Creates a [ServiceItemModel] with the given label, icon and optional [serviceDetailType].
  const ServiceItemModel({
    required this.label,
    this.icon,
    this.serviceDetailType,
  });

  /// Display label for the service.
  final String label;

  /// Icon for the service.
  final Widget? icon;

  /// When non-null, the item is clickable and navigates to service details for this type.
  final ServiceDetailType? serviceDetailType;

  /// Banking services list. Only AEPS Aadhaar Pay and DMT are clickable ([serviceDetailType] set).
  static List<ServiceItemModel> bankingServices = <ServiceItemModel>[
    ServiceItemModel(
      label: 'AEPS Aadhaar Pay',
      icon: Assets.svgs.icStreamlineColorFingerprint2.svg(),
      serviceDetailType: ServiceDetailType.aepsAadhaarPay,
    ),
    ServiceItemModel(label: 'MATM', icon: Assets.svgs.icMatm.svg()),
    ServiceItemModel(
      label: 'DMT',
      icon: Assets.svgs.icDmt.svg(),
      serviceDetailType: ServiceDetailType.dmt,
    ),
    ServiceItemModel(label: 'Credit Card', icon: Assets.svgs.icAdd.svg()),
    ServiceItemModel(label: 'Account Open', icon: Assets.svgs.icAccountOpen.svg()),
    ServiceItemModel(label: 'Loan', icon: Assets.svgs.icLoan.svg()),
  ];

  /// Recharge and bill pay services list.
  static  List<ServiceItemModel> rechargeAndBillPay =
      <ServiceItemModel>[
    ServiceItemModel(label: 'Mobile', icon: Assets.svgs.icMobile.svg()),
    ServiceItemModel(label: 'DTH', icon: Assets.svgs.icDth.svg()),
    ServiceItemModel(label: 'Postpaid', icon: Assets.svgs.icPostpaid.svg()),
    ServiceItemModel(label: 'Broadband', icon: Assets.svgs.icBroadband.svg()),
     ServiceItemModel(label: 'UPI/QR Payment',icon: Assets.svgs.icBroadband.svg(
       height: 0,
       width: 0
     ) ),
    const ServiceItemModel(label: 'View More',  ),
  ];

  /// Tour and travel services list.
  static  List<ServiceItemModel> tourAndTravel = <ServiceItemModel>[
    ServiceItemModel(label: 'Train', icon: Assets.svgs.icTrain.svg()),
    ServiceItemModel(label: 'Flight', icon: Assets.svgs.icFlight.svg()),
    ServiceItemModel(label: 'Bus', icon: Assets.svgs.icBus.svg()),
    ServiceItemModel(label: 'Hotel', icon: Assets.svgs.icHotel.svg()),
  ];
}
