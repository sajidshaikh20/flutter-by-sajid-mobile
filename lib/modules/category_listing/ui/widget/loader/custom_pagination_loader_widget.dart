import '../../../../../utils/exports.dart';

/// A widget that displays a loading indicator for pagination.
///
/// This widget is typically used when fetching more data for pagination,
/// and it shows a circular progress indicator to inform the user that
/// new data is being loaded.
class CustomPaginationLoaderWidget extends StatelessWidget {

  /// Constructs a [CustomPaginationLoaderWidget].
  ///
  /// The widget is stateless and only shows a progress indicator. It takes
  /// an optional [key] for identifying the widget in the widget tree.
  const CustomPaginationLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns a container that centers the circular progress indicator vertically and horizontally.
    return Container(
      height: Dimens.size50,  // Set the height of the container (specified in Dimens.size50)
      alignment: Alignment.center,  // Align the circular progress indicator in the center of the container
      child: const CircularProgressIndicator(),  // Show a circular progress indicator
    );
  }
}
