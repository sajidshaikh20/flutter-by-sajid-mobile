import '../../../../../utils/exports.dart';

/// Widget that displays the main screen UI (first screen after splash).
class MainViewWidget extends StatelessWidget {
  /// Creates a main view widget.
  const MainViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextLabelWidget(
          label: 'Main',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: Dimens.fontSize18,
          ),
        ),
        backgroundColor: MainConfig.appColors.mainColor,
        foregroundColor: AppColors.whiteColor,
      ),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (BuildContext context, MainState state) {
          if (state.status == BaseStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Dimens.size24.heightBox,
                  CustomTextLabelWidget(
                    label: state.model.title,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: Dimens.fontSize22,
                    ),
                  ),
                  Dimens.size12.heightBox,
                  CustomTextLabelWidget(
                    label: state.model.description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: Dimens.fontSize14,
                      color: AppColors.blackColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
