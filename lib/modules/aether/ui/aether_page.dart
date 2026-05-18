import '../../../utils/exports.dart';
import '../service/world_pulse_service.dart';
import 'widget/widget.dart';

/// Single-screen Aether experience: World Pulse + Geo-Raid + Engagement Chat.
///
/// Visit via [AetherRoute]. The `MaintenanceMiddleware` guard already
/// gates this route, so when Firebase Remote Config flips the app into
/// force-update or under-maintenance, the user gets the
/// `ForceUpdateUnderMaintenancePage` instead of a half-broken raid.
@RoutePage()
class AetherPage extends BaseResponsiveView {
  /// Builds the Aether page. [channelId] picks the chat room — the
  /// route param so deep links can land on any guild's chat.
  const AetherPage({
    super.key,
    this.channelId = 'global',
  });

  /// Chat channel this page is bound to.
  final String channelId;

  Widget _build(BuildContext context) {
    // @AETHER: Construct services inside the BlocProvider closure so
    // they live with the cubit, not with the widget. This means
    // navigating away from the screen tears down the 100 ms timer and
    // the Firestore listeners — no orphan subscriptions, no battery
    // burn.
    return BlocProvider<AetherCubit>(
      create: (BuildContext _) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final RaidService raid = RaidService(firestore: firestore);
        final ChatService chat = ChatService(firestore: firestore);
        final AetherCubit cubit = AetherCubit(
          raidService: raid,
          chatService: chat,
          channelId: channelId,
          localUserId: _generateUserId(),
        );
        unawaited(cubit.bind());
        return cubit;
      },
      child: _AetherScaffold(channelId: channelId),
    );
  }

  static String _generateUserId() {
    final int rnd = Random().nextInt(0xFFFFFF);
    return 'guest_${rnd.toRadixString(16).padLeft(6, '0')}';
  }

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
}

/// Internal scaffold — kept private so external screens can only enter
/// Aether through the route, never by importing the inner widget.
class _AetherScaffold extends StatefulWidget {
  const _AetherScaffold({required this.channelId});

  final String channelId;

  @override
  State<_AetherScaffold> createState() => _AetherScaffoldState();
}

class _AetherScaffoldState extends State<_AetherScaffold> {
  late final WorldPulseService _pulse;

  @override
  void initState() {
    super.initState();
    // @AETHER: The boss spawn is hard-coded to 10 min ahead for the demo;
    // production reads this from Firebase Remote Config so live ops can
    // re-target the herd without shipping a new build.
    _pulse = WorldPulseService(
      bossSpawnAt: DateTime.now().add(const Duration(minutes: 10)),
    )..start();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0817),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0817),

        elevation: 0,
        centerTitle: false,
        titleSpacing: 16,
        title: Row(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xFF9F7BFF),
                    Color(0xFF5E36F0),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF7C4DFF).withValues(alpha: 0.45),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.bolt,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Aether',
              style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(width: 8),
            DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.45),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  'NERVOUS SYSTEM',
                  style: TextStyle(
                    color: Color(0xFF22C55E),
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w800,
                    fontSize: 9,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 1.1,
            center: Alignment.topCenter,
            colors: <Color>[
              Color(0xFF1B132E),
              Color(0xFF0B0817),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: <Widget>[
                WorldPulseWidget(service: _pulse),
                const SizedBox(height: 14),
                const RaidPanelWidget(),
                const SizedBox(height: 14),
                const Expanded(child: ChatPanelWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
