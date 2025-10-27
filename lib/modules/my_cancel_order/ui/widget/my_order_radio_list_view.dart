import '../../../../utils/exports.dart';

/// Widget that displays a list of radio buttons for order cancellation reasons.
class MyOrderRadioListView extends StatelessWidget {
  /// Creates a my order radio list view.
  const MyOrderRadioListView({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MyOrderCancelCubit, MyOrderCancelState>(
        builder: (BuildContext context, MyOrderCancelState state) =>
            ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            String listItem = state.cancelReasongList[index];
            return Padding(
              padding: const EdgeInsets.only(
                bottom: Dimens.space10,
              ),
              child: CustomRadioButtonWidget(
                device: device,
                value: index,
                groupValue: state.selectedIndex,
                onChange: (dynamic value) {
                  context
                      .read<MyOrderCancelCubit>()
                      .radioButtonSelection(index);
                },
                label: listItem,
              ),
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.cancelReasongList.length,
        ),
      );
}
