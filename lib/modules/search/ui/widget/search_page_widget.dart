import '../../../../utils/exports.dart';

/// Widget that displays the search page with results and filters.
class SearchPageWidget extends StatelessWidget {
  /// Creates a search page widget.
  SearchPageWidget({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  /// Scroll controller for the search results list.
  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listener: (BuildContext context, SearchState state) async {
        if (state.redirectRoute != null) {
          await context.router.push(state.redirectRoute!);
        } else if (state.msg?.isNotEmpty ?? false) {
          displaySnackBar(state.msg!, context);
        } else if (state.showDefaultErrMsg ?? false) {
          displaySnackBar(
              MainConfig.dynamicString(JsonServiceString.keySomethingWentWrong),
              context);
        }
      },
      listenWhen: (SearchState previous, SearchState current) =>
      previous.redirectRoute != current.redirectRoute,
      child:
      Scaffold(
        resizeToAvoidBottomInset: true, // Prevent background shifting
        backgroundColor: AppColors.whiteColor,
        appBar:  SearchBarWidget(
          device: device,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            // Dismiss keyboard immediately on any drag
            FocusManager.instance.primaryFocus?.unfocus();
            unawaited(SystemChannels.textInput.invokeMethod('TextInput.hide'));
          },
          onTap: () {
            // Hide keyboard when tapping outside (global)
            FocusManager.instance.primaryFocus?.unfocus();
            unawaited(SystemChannels.textInput.invokeMethod('TextInput.hide'));
          },
          child: Stack(
            children: <Widget>[
              // Background image that fills the entire screen
              Positioned.fill(
                child: Assets.svgs.bgFullscreenCommon.svg(
                  fit: BoxFit.cover,
                ),
              ),
              // Content that handles keyboard properly
              Column(
                children: <Widget>[
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        // Hide keyboard on any scroll event (global)
                        FocusManager.instance.primaryFocus?.unfocus();
                        unawaited(SystemChannels.textInput.invokeMethod('TextInput.hide'));
                        return false;
                      },
                      child: SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        primary: true,
                        child: BlocBuilder<SearchCubit, SearchState>(
                          builder: (BuildContext context, SearchState state) {
                            return Column(
                              children: <Widget>[
                                ProductListWidget(
                                  device: device,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
