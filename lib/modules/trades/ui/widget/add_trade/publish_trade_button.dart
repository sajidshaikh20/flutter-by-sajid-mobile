import '../../../../../utils/exports.dart';

class PublishTradeButton extends StatelessWidget {
  const PublishTradeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      buildWhen: (AddTradeState prev, AddTradeState curr) =>
          prev.isSubmitting != curr.isSubmitting ||
          prev.selectedPair != curr.selectedPair ||
          prev.liveSocketPrice != curr.liveSocketPrice,
      builder: (BuildContext context, AddTradeState state) {
        final bool hasPair = state.selectedPair != null;
        final bool hasLivePrice = state.liveSocketPrice != null && state.liveSocketPrice! > 0;
        final bool isButtonEnabled = !state.isSubmitting && hasPair && hasLivePrice;

        String buttonText = 'Publish Trade';
        if (!hasPair) {
          buttonText = 'Select Currency Pair';
        } else if (!hasLivePrice) {
          buttonText = 'Waiting for Live Price...';
        }

        return SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: isButtonEnabled ? cubit.submitTrade : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              disabledBackgroundColor: isDark ? Colors.white10 : Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: isButtonEnabled ? 2 : 0,
            ),
            child: state.isSubmitting
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    buttonText,
                    style: TextStyle(
                      color: isButtonEnabled
                          ? Colors.white
                          : (isDark ? Colors.white38 : Colors.black38),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
