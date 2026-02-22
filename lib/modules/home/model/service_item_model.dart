import 'package:flutter/material.dart';

/// Model representing a single service item in the All Services grid.
class ServiceItemModel {
  /// Creates a [ServiceItemModel] with the given label and icon.
  const ServiceItemModel({
    required this.label,
    required this.icon,
  });

  /// Display label for the service.
  final String label;

  /// Icon for the service.
  final IconData icon;

  /// Default banking services list.
  static const List<ServiceItemModel> bankingServices = <ServiceItemModel>[
    ServiceItemModel(label: 'AEPS Aadhaar Pay', icon: Icons.fingerprint),
    ServiceItemModel(label: 'MATM', icon: Icons.atm),
    ServiceItemModel(label: 'DMT', icon: Icons.swap_horiz),
    ServiceItemModel(label: 'Credit Card', icon: Icons.credit_card),
    ServiceItemModel(label: 'Account Open', icon: Icons.person_outline),
    ServiceItemModel(label: 'Loan', icon: Icons.account_balance_wallet),
  ];
}
