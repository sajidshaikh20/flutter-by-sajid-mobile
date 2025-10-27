import '../../../../utils/exports.dart';

/// Widget that displays the track order page with order details and timeline.
class TrackOrderPageWidget extends StatelessWidget {
  /// Creates a track order page widget.
  const TrackOrderPageWidget({
    required this.orderDetailsResponse,
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The order details response model containing order information.
  final MyOrderDetailResponseModel orderDetailsResponse;

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    // Create timeline steps from the actual orderStatuses data
    List<TimelineStep> timelineSteps = _createTimelineStepsFromOrderStatuses(context);
    
    // Calculate current step index based on completed statuses in timeline steps
    int currentStepIndex = _calculateCurrentStepIndexFromTimelineSteps(timelineSteps);

    return Scaffold(
      backgroundColor: MainConfig.appColors.backgroundPinkColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          ProductDetailsAppBar(
            titleText: context.appString.trackOrderKey,
            isLastWidgetDisplay: false,
            prefixIcon: Assets.svgs.icBack.svg(),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: isRtl ? 0 : Dimens.size16,
              right: isRtl ? Dimens.size16 : 0,
            ),
            child: timelineSteps.isEmpty 
                ? _buildNoStatusAvailable(context)
                : SizedBox(
                    child: Column(
                      children: List<Widget>.generate(timelineSteps.length, (int index) {
                        final TimelineStep step = timelineSteps[index];
                        return MyTimelineTile(
                          isFirst: index == 0,
                          isLast: index == timelineSteps.length - 1,
                          isAfterLinePast: index < currentStepIndex + 1,
                          isBeforeLinePast: index <= currentStepIndex + 1,
                          isTopCirclePast: index <= currentStepIndex,
                          child: EachTimeLine(
                            status: step.statusKey,
                            device: device,
                            statusTime: step.statusDetailsTime,
                            statusDate: utcToDateFormate( step.statusDetailsDate , DateConstants.dateMonthYearOnlyFormat),
                            statusDetails: step.statusDetailsKey,
                          ),
                        );
                      }),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// Create timeline steps from the orderStatuses data
  List<TimelineStep> _createTimelineStepsFromOrderStatuses(BuildContext context) {
    final List<OrderStatusModel>? orderStatuses = orderDetailsResponse.orderStatuses;
    final String? orderType = orderDetailsResponse.orderType;
    
    // Define all possible statuses based on order type
    final List<String> allStatuses = _getAllStatusesForOrderType(orderType);
    
    // Create a map of API statuses for quick lookup
    final Map<String, OrderStatusModel> apiStatusMap = <String, OrderStatusModel>{};
    if (orderStatuses != null) {
      for (final OrderStatusModel status in orderStatuses) {
        if (status.status != null) {
          apiStatusMap[status.status!.toLowerCase().trim()] = status;
        }
      }
    }
    
    List<TimelineStep> timelineSteps = <TimelineStep>[];
    
    // Create timeline steps for all statuses
    for (final String status in allStatuses) {
      final String lowerStatus = status.toLowerCase().trim();
      OrderStatusModel? apiStatus = apiStatusMap[lowerStatus];
      
      // Special handling for "Order Placed" - always show proper description and use orderDate
      if (lowerStatus == TrackOrderStatus.orderPlaced.value.toLowerCase()) {
        final String mappedStatus = _mapStatusToLocalized(status, context);
        final String mappedDescription = _mapDescriptionToLocalized(status, context);
        
        // Parse orderDate to get time and date
        final String orderTime = _extractTimeFromOrderDate(orderDetailsResponse.orderDate);
        final String orderDate = _extractDateFromOrderDate(orderDetailsResponse.orderDate);
        
        timelineSteps.add(TimelineStep(
          statusKey: mappedStatus,
          statusDetailsKey: mappedDescription, // Always "Your order has been placed."
          statusDetailsTime: orderTime,
          statusDetailsDate: orderDate,
          // isDone defaults to true for Order Placed since order exists
        ));
      } else if (apiStatus != null) {
        // Status found in API - mark as done
        final String mappedStatus = _mapStatusToLocalized(status, context);
        final String mappedDescription = _mapDescriptionToLocalized(status, context);
        
        timelineSteps.add(TimelineStep(
          statusKey: mappedStatus,
          statusDetailsKey: mappedDescription,
          statusDetailsTime: apiStatus.time ?? '',
          statusDetailsDate: apiStatus.date ?? '',
          // isDone defaults to true for statuses found in API
        ));
      } else {
        // Status not found in API - mark as not done (no right mark)
        final String mappedStatus = _mapStatusToLocalized(status, context);
        
        timelineSteps.add(TimelineStep(
          statusKey: mappedStatus,
          statusDetailsKey: context.appString.waitingDescKey,
          statusDetailsTime: '',
          statusDetailsDate: '',
          isDone: false, // No right mark for statuses not in API
        ));
      }
    }
    
    DebugLog.instance.i('TrackOrderPage: Created ${timelineSteps.length} timeline steps for orderType: $orderType');
    return timelineSteps;
  }

  /// Get all statuses for a given order type
  List<String> _getAllStatusesForOrderType(String? orderType) {
    final String? lowerOrderType = orderType?.toLowerCase().trim();
    
    // Common statuses for all order types
    final List<String> commonStatuses = <String>[
      TrackOrderStatus.orderPlaced.value,
      TrackOrderStatus.confirmed.value,
      TrackOrderStatus.assigned.value,
    ];
    
    // Add order type specific statuses
    if (lowerOrderType == AppConstant.delivery) {
      return <String>[
        ...commonStatuses,
        TrackOrderStatus.inDelivery.value,
        TrackOrderStatus.delivered.value,
      ];
    } else if (lowerOrderType == AppConstant.pickup || lowerOrderType == AppConstant.pickup1) {
      return <String>[
        ...commonStatuses,
        TrackOrderStatus.pickupStarted.value,
        TrackOrderStatus.pickedUp.value,
      ];
    } else {
      // Default to delivery statuses for unknown order types
      return <String>[
        ...commonStatuses,
        TrackOrderStatus.inDelivery.value,
        TrackOrderStatus.delivered.value,
      ];
    }
  }

  /// Map API status to localized status
  String _mapStatusToLocalized(String originalStatus, BuildContext context) {
    final TrackOrderStatus? status = TrackOrderStatus.fromValue(originalStatus);
    
    switch (status) {
      case TrackOrderStatus.orderPlaced:
        return context.appString.orderPlacedKey;
      case TrackOrderStatus.confirmed:
        return context.appString.acceptedKey;
      case TrackOrderStatus.assigned:
        return context.appString.processingKey;
      case TrackOrderStatus.inDelivery:
        return context.appString.outForDeliveryKey;
      case TrackOrderStatus.delivered:
        return context.appString.deliveredKey;
      case TrackOrderStatus.pickupStarted:
        return context.appString.readyToPickupKey;
      case TrackOrderStatus.pickedUp:
        return context.appString.pickedUpKey;
      case null:
        return originalStatus; // Return original if no mapping found
    }
  }

  /// Map API description to localized description
  String _mapDescriptionToLocalized(String originalStatus, BuildContext context) {
    final TrackOrderStatus? status = TrackOrderStatus.fromValue(originalStatus);
    
    switch (status) {
      case TrackOrderStatus.orderPlaced:
        return context.appString.orderPlacedDescKey;
      case TrackOrderStatus.confirmed:
        return context.appString.orderAcceptedDescKey;
      case TrackOrderStatus.assigned:
        return context.appString.orderProcessingDescKey;
      case TrackOrderStatus.inDelivery:
        return context.appString.orderOutForDeliveryDescKey;
      case TrackOrderStatus.delivered:
        return context.appString.orderDeliveredDescKey;
      case TrackOrderStatus.pickupStarted:
        return context.appString.orderReadyToPickupDescKey;
      case TrackOrderStatus.pickedUp:
        return context.appString.orderPickedUpDescKey;
      case null:
        return context.appString.waitingDescKey; // Default to waiting
    }
  }

  /// Calculate the current step index based on completed statuses in timeline steps
  int _calculateCurrentStepIndexFromTimelineSteps(List<TimelineStep> timelineSteps) {
    if (timelineSteps.isEmpty) {
      return 0;
    }

    // Find the last completed status (isDone = true)
    int lastCompletedIndex = -1;
    for (int i = 0; i < timelineSteps.length; i++) {
      if (timelineSteps[i].isDone) {
        lastCompletedIndex = i;
      }
    }
    
    // Return the index of the last completed status, or 0 if none completed
    int currentIndex = lastCompletedIndex >= 0 ? lastCompletedIndex : 0;
    DebugLog.instance.i('TrackOrderPage: Current step index: $currentIndex (last completed: $lastCompletedIndex)');
    return currentIndex;
  }

  /// Extract time from orderDate string
  String _extractTimeFromOrderDate(String? orderDate) {
    if (orderDate == null || orderDate.isEmpty) {
      return '';
    }
    
    try {
      // Handle format: "2025-09-24 12:54 PM"
      if (orderDate.contains(' ')) {
        final List<String> parts = orderDate.split(' ');
        if (parts.length >= 3) {
          // Extract time part (e.g., "12:54 PM")
          final String timePart = '${parts[1]} ${parts[2]}';
          return timePart;
        }
      }
      
      // Fallback: Try to parse as ISO format
      final DateTime dateTime = DateTime.parse(orderDate);
      
      // Convert to 12-hour format
      final int hour = dateTime.hour;
      final int minute = dateTime.minute;
      final String period = hour >= 12 ? 'PM' : 'AM';
      final int displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    } on FormatException {
      DebugLog.instance.w('TrackOrderPage: Failed to parse orderDate: $orderDate');
      return '';
    }
  }

  /// Extract date from orderDate string
  String _extractDateFromOrderDate(String? orderDate) {
    if (orderDate == null || orderDate.isEmpty) {
      return '';
    }
    
    try {
      // Handle format: "2025-09-24 12:54 PM"
      if (orderDate.contains(' ')) {
        final List<String> parts = orderDate.split(' ');
        if (parts.isNotEmpty) {
          // Extract date part (e.g., "2025-09-24")
          return parts[0];
        }
      }
      
      // Fallback: Try to parse as ISO format
      final DateTime dateTime = DateTime.parse(orderDate);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    } on FormatException {
      DebugLog.instance.w('TrackOrderPage: Failed to parse orderDate: $orderDate');
      return '';
    }
  }

  /// Build widget when no order statuses are available
  Widget _buildNoStatusAvailable(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.size20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Assets.svgs.icPlaceHolderDukkan.svg(
            width: Dimens.size80,
            height: Dimens.size80,
          ),
          const SizedBox(height: Dimens.size16),
          CustomTextLabelWidget(
            label: context.appString.noOrderStatusAvailableKey,
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.w600,
              color: MainConfig.appColors.backgroundBlackColor,
            ),
          ),
          const SizedBox(height: Dimens.size8),
          CustomTextLabelWidget(
            label: context.appString.orderTrackingNotAvailableDescKey,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: Dimens.fontSize14,
              fontWeight: FontWeight.w400,
              color: MainConfig.appColors.creyColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Returns device-specific dimensions based on the screen type.
  DeviceDimens getDeviceDimens(ScreenType device) {
    switch (device) {
      case ScreenType.tablet:
        return const DeviceDimens(
          spaceMobTab20_30: Dimens.space30,
          spaceMobTab_17_25: Dimens.space25,
          sizeMobTab45_50: Dimens.size50,
          sizeMobTab_50_55: Dimens.size55,
          sizeMobTab34_40: Dimens.size40,
        );
      default:
        return const DeviceDimens(
          spaceMobTab20_30: Dimens.space20,
          spaceMobTab_17_25: Dimens.space17,
          sizeMobTab45_50: Dimens.size45,
          sizeMobTab_50_55: Dimens.size50,
          sizeMobTab34_40: Dimens.size34,
        );
    }
  }
}

/// Device-specific dimensions for responsive design.
class DeviceDimens {
  /// Creates a DeviceDimens instance with the specified dimensions.
  const DeviceDimens({
    required this.spaceMobTab20_30,
    required this.spaceMobTab_17_25,
    required this.sizeMobTab45_50,
    required this.sizeMobTab_50_55,
    required this.sizeMobTab34_40,
  });

  /// Space dimension that varies between mobile/tablet (20/30).
  final double spaceMobTab20_30;

  /// Space dimension that varies between mobile/tablet (17/25).
  final double spaceMobTab_17_25;

  /// Size dimension that varies between mobile/tablet (45/50).
  final double sizeMobTab45_50;

  /// Size dimension that varies between mobile/tablet (50/55).
  final double sizeMobTab_50_55;

  /// Size dimension that varies between mobile/tablet (34/40).
  final double sizeMobTab34_40;
}
