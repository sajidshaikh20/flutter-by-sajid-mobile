import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays product listing with filter and sorting options.
class ProductListingWithFilterPage extends BaseResponsiveView {
  /// The type ID for filtering products.
  final int? typeId;

  /// The type name for filtering products.
  final String? type;

  /// The label for the current product listing.
  final String? label;

  /// The list of tab labels for different categories.
  final List<dynamic>? tabLabels;

  /// The product SKU for filtering.
  final String? productSku;

  /// Creates a product listing with filter page.
  const ProductListingWithFilterPage(
      {super.key,
      this.typeId,
      this.type,
      this.label,
      this.tabLabels = const <dynamic>[],
      this.productSku});

  /// Builds the product listing page with BlocProvider for the specified context.
  Widget buildMethod(BuildContext context) {
    return BlocProvider<ProductListingWithFilterCubit>(
      create: (BuildContext context) => ProductListingWithFilterCubit(
        typeId: typeId,
        type: type,
        label: label,
        tabLabels: tabLabels,
        productSku: productSku
      ),
      child: const ProductListingWithFilterWidget(),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildMethod(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildMethod(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildMethod(context);
  }
}
