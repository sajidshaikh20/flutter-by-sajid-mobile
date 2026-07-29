
import '../../../utils/exports.dart';


@RoutePage()
class MyClientsPage extends BaseResponsiveView {
  const MyClientsPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<MyClientsCubit>(
      create: (BuildContext context) => MyClientsCubit(
        repository: MyClientsRepositoryImpl(),
      ),
      child: const MyClientsView(),
    );
  }
}

class MyClientsView extends StatefulWidget {
  const MyClientsView({super.key});

  @override
  State<MyClientsView> createState() => _MyClientsViewState();
}

class _MyClientsViewState extends State<MyClientsView> {
  // Set to store expanded trade public IDs
  final Set<String> _expandedTrades = <String>{};

  void _toggleExpand(String tradeId) {
    setState(() {
      if (_expandedTrades.contains(tradeId)) {
        _expandedTrades.remove(tradeId);
      } else {
        _expandedTrades.add(tradeId);
      }
    });
  }

  String _formatCreatedDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '—';
    try {
      final DateTime parsed = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsed.toLocal());
    } on Object catch (_) {
      return dateStr;
    }
  }

  Color _getStatusColor(String status, Color themeGreen) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return AppColors.primaryPurple;
      case 'CLOSED':
        return themeGreen;
      case 'PENDING':
        return AppColors.infoColor;
      case 'CANCEL':
      case 'CANCELLED':
        return AppColors.errorColor;
      default:
        return AppColors.greyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color cardBorderColor = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;

    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);

    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.space16,
                vertical: Dimens.space12,
              ),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => context.router.back(),
                    child: Container(
                      padding: const EdgeInsets.all(Dimens.space8),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: borderCol),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: textColor,
                        size: Dimens.size16,
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimens.space16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: 'My Clients',
                          style: TextStyle(
                            fontSize: Dimens.fontSize20,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: Dimens.space2),
                        CustomTextLabelWidget(
                          label: 'See who copied your premium trade signals',
                          style: TextStyle(
                            fontSize: Dimens.fontSize11,
                            color: subtextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<MyClientsCubit, MyClientsState>(
                listener: (BuildContext context, MyClientsState state) {
                  if (state.status == BaseStateStatus.failure && state.msg != null && state.msg!.isNotEmpty) {
                    displaySnackBar(state.msg!, context);
                    context.read<MyClientsCubit>().resetError();
                  }
                },
                builder: (BuildContext context, MyClientsState state) {
                  if (state.isInitialLoading) {
                    return _buildShimmerList(isDark);
                  }

                  if (state.trades.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.space24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.people_outline_rounded,
                              size: Dimens.size64,
                              color: subtextColor,
                            ),
                            const SizedBox(height: Dimens.space16),
                            CustomTextLabelWidget(
                              label: 'No Clients Yet',
                              style: TextStyle(
                                color: textColor,
                                fontSize: Dimens.fontSize18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Dimens.space8),
                            CustomTextLabelWidget(
                              label: 'No clients have copied your premium trade signals yet.',
                              style: TextStyle(
                                color: subtextColor,
                                fontSize: Dimens.fontSize13,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final int listLength = state.isLoadingMore ? state.trades.length + 1 : state.trades.length;

                  return RefreshIndicator(
                    onRefresh: () => context.read<MyClientsCubit>().loadMyClients(),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (notification is ScrollEndNotification ||
                            notification is ScrollUpdateNotification) {
                          final ScrollMetrics metrics = notification.metrics;
                          if (metrics.pixels >= metrics.maxScrollExtent * 0.9) {
                            unawaited(context.read<MyClientsCubit>().loadMore());
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space16,
                          vertical: Dimens.space12,
                        ),
                        itemCount: listLength,
                        itemBuilder: (BuildContext context, int index) {
                          if (index >= state.trades.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: Dimens.space16),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryPurple),
                                  ),
                                ),
                              ),
                            );
                          }

                          final TradeWithClientsModel trade = state.trades[index];
                          final bool isExpanded = _expandedTrades.contains(trade.tradePublicId);
                          final Color statusColor = _getStatusColor(trade.status, themeGreen);

                          return Container(
                            margin: const EdgeInsets.only(bottom: Dimens.space12),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(Dimens.radius12),
                              border: Border.all(color: cardBorderColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Trade Card Header click to expand
                              InkWell(
                                onTap: () => _toggleExpand(trade.tradePublicId),
                                borderRadius: BorderRadius.circular(Dimens.radius12),
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimens.space16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              CustomTextLabelWidget(
                                                label: trade.currencyPairSymbol.isNotEmpty
                                                    ? trade.currencyPairSymbol
                                                    : '--',
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: Dimens.fontSize16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: Dimens.space8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: Dimens.space6,
                                                  vertical: Dimens.space2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
                                                  borderRadius: BorderRadius.circular(Dimens.radius4),
                                                ),
                                                child: CustomTextLabelWidget(
                                                  label: trade.market.isNotEmpty ? trade.market : '--',
                                                  style: TextStyle(
                                                    color: subtextColor,
                                                    fontSize: Dimens.fontSize10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: Dimens.space8,
                                              vertical: Dimens.space2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: statusColor.withValues(alpha: 0.15),
                                              borderRadius: BorderRadius.circular(Dimens.radius6),
                                            ),
                                            child: CustomTextLabelWidget(
                                              label: trade.status.isNotEmpty ? trade.status : '--',
                                              style: TextStyle(
                                                color: statusColor,
                                                fontSize: Dimens.fontSize10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: Dimens.space8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          CustomTextLabelWidget(
                                            label: '${trade.clients.length} Clients Copied',
                                            style: const TextStyle(
                                              color: AppColors.primaryPurple,
                                              fontSize: Dimens.fontSize12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              CustomTextLabelWidget(
                                                label: _formatCreatedDate(trade.createdAt),
                                                style: TextStyle(
                                                  color: subtextColor,
                                                  fontSize: Dimens.fontSize11,
                                                ),
                                              ),
                                              const SizedBox(width: Dimens.space4),
                                              Icon(
                                                isExpanded
                                                    ? Icons.keyboard_arrow_up_rounded
                                                    : Icons.keyboard_arrow_down_rounded,
                                                color: subtextColor,
                                                size: Dimens.size16,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (trade.note.isNotEmpty) ...<Widget>[
                                        const SizedBox(height: Dimens.space10),
                                        Text(
                                          trade.note,
                                          style: TextStyle(
                                            color: subtextColor,
                                            fontSize: Dimens.fontSize12,
                                            fontStyle: FontStyle.italic,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              // Expanded Clients List
                              if (isExpanded) ...<Widget>[
                                Divider(height: 1, thickness: 0.5, color: cardBorderColor),
                                if (trade.clients.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(Dimens.space16),
                                    child: Center(
                                      child: CustomTextLabelWidget(
                                        label: 'No details available for clients of this trade.',
                                        style: TextStyle(
                                          color: subtextColor,
                                          fontSize: Dimens.fontSize12,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.space12,
                                      vertical: Dimens.space8,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: trade.clients.length,
                                      itemBuilder: (BuildContext context, int cIndex) {
                                        final ClientSummaryModel client = trade.clients[cIndex];
                                        final String initial = client.name.isNotEmpty
                                            ? client.name[0].toUpperCase()
                                            : (client.username.isNotEmpty ? client.username[0].toUpperCase() : 'U');

                                        return ListTile(
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: Dimens.space8,
                                            vertical: Dimens.space2,
                                          ),
                                          leading: ClipOval(
                                            child: client.profilePictureUrl.isNotEmpty
                                                ? FastCachedImage(
                                                    url: client.profilePictureUrl,
                                                    width: Dimens.size36,
                                                    height: Dimens.size36,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stacktrace) {
                                                      return Container(
                                                        width: Dimens.size36,
                                                        height: Dimens.size36,
                                                        color: AppColors.primaryPurple.withValues(alpha: 0.15),
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          initial,
                                                          style: const TextStyle(
                                                            color: AppColors.primaryPurple,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    width: Dimens.size36,
                                                    height: Dimens.size36,
                                                    color: AppColors.primaryPurple.withValues(alpha: 0.15),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      initial,
                                                      style: const TextStyle(
                                                        color: AppColors.primaryPurple,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          title: Text(
                                            client.name.isNotEmpty ? client.name : 'Unknown User',
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: Dimens.fontSize13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Text(
                                            client.username.isNotEmpty ? '@${client.username}' : '--',
                                            style: TextStyle(
                                              color: subtextColor,
                                              fontSize: Dimens.fontSize11,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList(bool isDark) {
    final Color baseCol = isDark ? const Color(0xFF1B162E) : Colors.grey.shade300;
    final Color highCol = isDark ? const Color(0xFF2E274C) : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseCol,
      highlightColor: highCol,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space16,
          vertical: Dimens.space12,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 90,
            margin: const EdgeInsets.only(bottom: Dimens.space12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.radius12),
            ),
          );
        },
      ),
    );
  }
}
