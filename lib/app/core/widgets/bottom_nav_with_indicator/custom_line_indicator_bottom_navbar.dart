


import '../../../../utils/exports.dart';
/// Documentation
///
/// [CustomLineIndicatorBottomNavbar] is a custom widget for a bottom navigation bar
/// with a line indicator. It provides a flexible way to customize the appearance
/// and behavior of the bottom navigation bar, including the indicator line, colors,
/// font sizes, icon sizes, and more.
class CustomLineIndicatorBottomNavbar extends StatelessWidget {
  /// [backgroundColor] is the background color of the navigation bar.
  final Color? backgroundColor;

  /// [customBottomBarItems] is a list of [CustomBottomBarItems] that represent
  /// the items in the navigation bar.
  final List<CustomBottomBarItems<dynamic>> customBottomBarItems;

  /// [selectedColor] is the color of the selected item's icon and label.
  final Color selectedColor;

  /// [unSelectedColor] is the color of the unselected items' icons and labels.
  final Color unSelectedColor;

  /// [unselectedFontSize] is the font size of the unselected item labels.
  final double unselectedFontSize;

  /// [splashColor] is the splash color when an item is tapped.
  final Color? splashColor;

  /// [currentIndex] is the index of the currently selected item.
  final int currentIndex;

  /// [enableLineIndicator] determines whether the line indicator is enabled.
  final bool enableLineIndicator;

  /// [lineIndicatorWidth] is the width of the line indicator.
  final double lineIndicatorWidth;

  /// [indicatorType] specifies the position of the line indicator (top or bottom).
  final IndicatorType indicatorType;

  /// [onTap] is a callback function that is called when an item is tapped,
  /// passing the index of the tapped item.
  final Function(int) onTap;

  /// [selectedFontSize] is the font size of the selected item's label.
  final double selectedFontSize;

  /// [selectedIconSize] is the size of the selected item's icon.
  ///
  /// The [CustomLineIndicatorBottomNavbar] widget is a customizable bottom navigation bar
  /// that includes a line indicator to show the currently selected item. It supports
  /// various customizations for the appearance and behavior of the navigation bar, including:
  ///
  /// - **Background Color**: Customize the background color of the entire navigation bar.
  /// - **Items**: Add a list of [CustomBottomBarItems] to populate the navigation bar.
  /// - **Selected/Unselected Colors**: Control the colors of the icons and labels for the selected
  ///   and unselected items.
  /// - **Font Sizes**: Set the font sizes for both selected and unselected item labels.
  /// - **Icon Sizes**: Adjust the size of the selected and unselected item icons.
  /// - **Splash Color**: Customize the splash color when an item is tapped.
  /// - **Line Indicator**: Enable/disable the line indicator, adjust its width, and determine
  ///   its position (top or bottom).
  /// - **Gradient**: Apply a gradient to the background of the navigation bar.
  /// - **Custom Label Styles**: Define custom styles for the labels of selected and unselected items.
  ///
  /// **Example Usage:**
  ///
  final double selectedIconSize;

  /// [unselectedIconSize] is the size of the unselected items' icons.
  final double unselectedIconSize;

  /// [gradient] is an optional gradient to apply to the background of the navigation bar.
  final LinearGradient? gradient;

  /// [selectedLabelStyle] is an optional custom style for the selected item's label.
  final TextStyle? selectedLabelStyle;

  /// [unselectedLabelStyle] is an optional custom style for the unselected items' labels.
  final TextStyle? unselectedLabelStyle;


  ///CustomLineIndicatorBottomNavbar
  const CustomLineIndicatorBottomNavbar({
    super.key,
    this.backgroundColor,
  required  this.selectedColor,
    required this.customBottomBarItems,
    required this.unSelectedColor,
    this.unselectedFontSize = 0,
    this.selectedFontSize = 0,
    this.selectedIconSize = 24,
    this.unselectedIconSize = 24,
    this.splashColor,
    this.currentIndex = 0,
    required this.onTap,
    this.enableLineIndicator = true,
    this.lineIndicatorWidth = 3,
    this.indicatorType = IndicatorType.top,
    this.gradient,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
  });

  /// body of nav bar.
  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData bottomTheme =
        BottomNavigationBarTheme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? bottomTheme.backgroundColor,
        gradient: gradient,
      ),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (int i = 0; i < customBottomBarItems.length; i++) ...<Widget>[
              Expanded(
                child: CustomLineIndicatorBottomNavbarItems(
                activeIcon: customBottomBarItems[i].activeIcon,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                  icon: customBottomBarItems[i].icon,
                  label: customBottomBarItems[i].label,
                  unSelectedFontSize: unselectedFontSize,
                  selectedFontSize: selectedFontSize,
                  unselectedIconSize: unselectedIconSize,
                  selectedLabelStyle: selectedLabelStyle,
                  unselectedLabelStyle: unselectedLabelStyle,
                  selectedIconSize: selectedIconSize,
                  splashColor: splashColor,
                  currentIndex: currentIndex,
                  enableLineIndicator: enableLineIndicator,
                  lineIndicatorWidth: lineIndicatorWidth,
                  indicatorType: indicatorType,
                  index: i,
                  onTap: onTap,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

/// Documentation
///
/// [CustomBottomBarItems] is a model class for the items in the custom bottom
/// navigation bar. It holds the data for each item, including the icon, label,
/// and active icon.
class CustomBottomBarItems<T> {
  /// [icon] is the icon for the item. It can be an [IconData] or a [Widget].
  final T icon;

  /// [label] is the label text for the item.
  final String label;

  /// [activeIcon] is the icon for the item when it is selected.
  final T activeIcon;

  ///CustomBottomBarItems
  CustomBottomBarItems({
    /// [icon] icon is the icon for the item.
    /// [activeIcon] is the icon for the item when it is selected.
    required this.icon,
    required this.label,
    required this.activeIcon,
  }) : assert(icon is IconData || icon is Widget || activeIcon is IconData || activeIcon is Widget  ,
            'CustomBottomBarItems only support IconData and Widget');
}

/// Documentation
///
/// [CustomLineIndicatorBottomNavbarItems] is a stateless widget that represents
/// an individual item in the custom line indicator bottom navigation bar. It
/// handles the display and behavior of each item, including the icon, label,
/// and indicator line.
class CustomLineIndicatorBottomNavbarItems extends StatelessWidget {
  /// [icon] is the icon for the item. It can be an [IconData] or a [Widget].
  final dynamic icon;

  /// [activeIcon] is the icon for the item when it is selected.
  final dynamic activeIcon;

  /// [label] is the label text for the item.
  final String? label;

  /// [selectedColor] is the color of the item's icon and label when it is selected.
  final Color selectedColor;

  /// [unSelectedColor] is the color of the item's icon and label when it is not selected.
  final Color unSelectedColor;

  /// [unSelectedFontSize] is the font size of the item's label when it is not selected.
  final double unSelectedFontSize;

  /// [selectedIconSize] is the size of the item's icon when it is selected.
  final double selectedIconSize;

  /// [unselectedIconSize] is the size of the item's icon when it is not selected.
  final double unselectedIconSize;

  /// [selectedFontSize] is the font size of the item's label when it is selected.
  final double selectedFontSize;

  /// [splashColor] is the splash color when the item is tapped.
  final Color? splashColor;

  /// [currentIndex] is the index of the currently selected item.
  final int? currentIndex;

  /// [index] is the index of this item in the navigation bar.
  final int index;

  /// [onTap] is a callback function that is called when the item is tapped.
  final Function(int) onTap;

  /// [enableLineIndicator] determines whether the line indicator is enabled for this item.
  final bool enableLineIndicator;

  /// [lineIndicatorWidth] is the width of the line indicator.
  final double lineIndicatorWidth;

  /// [indicatorType] specifies the position of the line indicator (top or bottom).
  final IndicatorType indicatorType;
  /// Optional custom style for the selected item's label.
  final TextStyle? selectedLabelStyle;
  /// Optional custom style for the unselected item's label.
  final TextStyle? unselectedLabelStyle;


  ///CustomLineIndicatorBottomNavbarItems
  const CustomLineIndicatorBottomNavbarItems({
    super.key,
    required this.icon,
    required this.activeIcon,
    this.label,
   required this.selectedColor,
   required this.unSelectedColor,
    this.unSelectedFontSize = 11,
    this.selectedFontSize = 12,
    this.selectedIconSize = 20,
    this.unselectedIconSize = 15,
    this.splashColor,
    this.currentIndex,
    required this.onTap,
    required this.index,
    this.enableLineIndicator = true,
    this.lineIndicatorWidth = 3,
    this.indicatorType = IndicatorType.top,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
  });

  TextStyle _getLabelStyle(BuildContext context) {

    if (currentIndex == index) {
      return selectedLabelStyle ??
          TextStyle(
            fontSize: selectedFontSize,
            color: selectedColor,
          );
    } else {
      return unselectedLabelStyle ??
          TextStyle(
            fontSize: unSelectedFontSize,
            color: unSelectedColor,
          );
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 7),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: splashColor ?? Theme.of(context).splashColor,
            onTap: () {
              onTap(index);
            },
            child: Column(

              children: <Widget>[
                Container(
                  width: Dimens.size24, // Set the width
                  height: lineIndicatorWidth, // Set the height
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? selectedColor
                        : Colors.transparent, // Background color
                    borderRadius: Dimens.radius8.borderRadius , // Rounded corners

                  )),
                const SizedBox(height: Dimens.size6,),

                currentIndex == index ?  activeIcon :icon
                   ,
                // const SizedBox(
                //   height: 5.0,
                // ),
                Text(
                  '$label',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: _getLabelStyle(context),
                ),
                const SizedBox(height: Dimens.size5,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}