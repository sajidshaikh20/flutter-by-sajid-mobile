import '../../../utils/exports.dart';

/// A page that displays loyalty points information, including points earned, points burned,
/// and a transaction history list. This page adapts to different screen sizes using responsive layouts.
///
/// It inherits from [BaseResponsiveView] to handle layout changes based on screen width.
@RoutePage()
class LoyaltyPointsPage extends StatelessWidget {
  /// Creates an instance of [LoyaltyPointsPage].
  ///
  /// This page does not require any additional parameters. It simply displays the loyalty
  /// points information based on the user's data.

  const LoyaltyPointsPage({super.key});




  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoyaltyPointsCubit>(
        create: (BuildContext c) => LoyaltyPointsCubit(),
        child: const LoyaltyPointsPageWidget());

  }
}
