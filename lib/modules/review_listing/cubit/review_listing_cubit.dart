import '../../../utils/exports.dart';

/// Manages the state of review listings.
/// Handles fetching, updating, and emitting review states.
class ReviewListingCubit extends Cubit<ReviewListingState> {
  /// Manages review listing and uses the passed review data.
  ReviewListingCubit()
      : super(const ReviewListingState(status: BaseStateStatus.success));

// No longer need repository or API calls since data is passed directly
}
