import '../../../../utils/exports.dart';

/// A widget that displays address input fields.
///
/// This widget can be used in forms for adding or editing an address.
/// It adapts its layout based on the [device] type.
class AddressFieldsWidget extends StatelessWidget {
  /// Creates an [AddressFieldsWidget].
  ///
  /// The [device] parameter allows customizing the layout for different
  /// screen types (mobile, tablet, web).
  const AddressFieldsWidget({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device to adjust the layout or styling of the address fields.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double heightMobTab15_25= Dimens.size15;
    switch(device){

      case ScreenType.tablet:
        heightMobTab15_25= Dimens.size25;

      default:
        break;
    }
    return Column(
      children: <Widget>[
        ///country
         CountryWidget(device: device,),
        heightMobTab15_25.heightBox,

        ///state
         StateWidget(device: device,),
        heightMobTab15_25.heightBox,

        ///city
         CityWidget(device: device,),
        heightMobTab15_25.heightBox,

        ///postal code
         PostalCode(device: device,),
        heightMobTab15_25.heightBox,
      ],
    );
  }
}