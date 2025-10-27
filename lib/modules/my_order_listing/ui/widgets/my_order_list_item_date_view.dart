
import '../../../../utils/exports.dart';
/// This widget displays the date and status of an order in a list item.
class MyOrderListItemDateView extends StatelessWidget {



  ///
  const MyOrderListItemDateView({
    super.key,
    required this.date,
    required this.status,
    required this.statusColorCode,
    this.device=ScreenType.mobile
  });
  /// [date] is the order date to be displayed.
  final String date;
  /// [status] is the order status to be displayed.
  final String status;
  /// [statusColorCode] is the color code for the status text.
  final String statusColorCode;
  /// [device] is the screen type (mobile or tablet). It defaults to [ScreenType.mobile]
  final ScreenType device;
  @override
  Widget build(BuildContext context) {

    double statusFontSize=Dimens.fontSize14;
    double width=Dimens.size20;
    switch(device){

      case ScreenType.tablet:
         statusFontSize=Dimens.fontSize18;
         width=Dimens.size30;

      default:
        break;
    }

    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: CustomTextLabelWidget(
            label: date,
            maxLines: Dimens.maxLines01,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,

          ),
        ),
        width.widthBox,
        Expanded(
          child: CustomTextLabelWidget(
            label: status,
            textAlign: TextAlign.start,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Color(int.parse(statusColorCode.substring(Dimens.digit1, Dimens.digit7),
                  radix: Dimens.digit16) + Colors.black.toARGB32()),
              fontSize: statusFontSize,
            ),
          ),
        ),
      ],
    );
  }
}
