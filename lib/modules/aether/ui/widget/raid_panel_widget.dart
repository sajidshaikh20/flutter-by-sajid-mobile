import '../../../../utils/exports.dart';

/// Raid panel — slot pips + sign-up CTA + live roster counter.
///
/// Uses a [BlocSelector] so it only rebuilds when the slot count or the
/// in-flight flag changes, not when chat messages arrive.
class RaidPanelWidget extends StatelessWidget {
  /// Creates the raid panel.
  const RaidPanelWidget({super.key});

  static const Color _accent = Color(0xFF7C4DFF);
  static const Color _surface = Color(0xFF15121F);
  static const Color _surfaceBorder = Color(0xFF2A2440);
  static const Color _pipEmpty = Color(0xFF3A3357);
  static const Color _success = Color(0xFF22C55E);
  static const Color _danger = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: BlocSelector<AetherCubit, AetherState, _RaidVm>(
        selector: (AetherState s) => _RaidVm(
          slotsFilled: s.raid?.slotsFilled ?? 0,
          maxSlots: s.raid?.maxSlots ?? 15,
          isFull: s.raid?.isFull ?? false,
          isJoining: s.isJoining,
          lastResult: s.lastJoinSucceeded,
        ),
        builder: (BuildContext context, _RaidVm vm) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _surfaceBorder),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _accent.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: _accent.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.shield_moon,
                            color: _accent,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Geo-Raid · Dragon',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Atomic 15-slot roster',
                              style: TextStyle(
                                color: Colors.white60,
                                fontFamily: 'inter',
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _SlotChip(
                        slotsFilled: vm.slotsFilled,
                        maxSlots: vm.maxSlots,
                        isFull: vm.isFull,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _SlotPipsRow(
                    slotsFilled: vm.slotsFilled,
                    maxSlots: vm.maxSlots,
                  ),
                  const SizedBox(height: 16),
                  _JoinButton(vm: vm),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: vm.lastResult == null
                        ? const SizedBox(width: double.infinity)
                        : Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  vm.lastResult!
                                      ? Icons.check_circle
                                      : Icons.error,
                                  size: 16,
                                  color: vm.lastResult! ? _success : _danger,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    vm.lastResult!
                                        ? 'You are in. See you at the gate.'
                                        : 'Raid is full — try the next pulse.',
                                    style: TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: vm.lastResult!
                                          ? _success
                                          : _danger,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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

class _JoinButton extends StatelessWidget {
  const _JoinButton({required this.vm});

  final _RaidVm vm;

  @override
  Widget build(BuildContext context) {
    final bool disabled = vm.isFull || vm.isJoining;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: disabled
              ? const LinearGradient(
                  colors: <Color>[
                    Color(0xFF2A2440),
                    Color(0xFF2A2440),
                  ],
                )
              : const LinearGradient(
                  colors: <Color>[
                    Color(0xFF9F7BFF),
                    Color(0xFF5E36F0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: disabled
                ? null
                : () => unawaited(
                      context.read<AetherCubit>().joinRaid(),
                    ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (vm.isJoining)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else
                    Icon(
                      vm.isFull ? Icons.lock : Icons.flash_on,
                      color: disabled ? Colors.white54 : Colors.white,
                      size: 18,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    vm.isFull
                        ? 'Raid Full'
                        : (vm.isJoining ? 'Joining…' : 'Join Raid'),
                    style: TextStyle(
                      color: disabled ? Colors.white54 : Colors.white,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({
    required this.slotsFilled,
    required this.maxSlots,
    required this.isFull,
  });

  final int slotsFilled;
  final int maxSlots;
  final bool isFull;

  @override
  Widget build(BuildContext context) {
    final Color color = isFull
        ? const Color(0xFFEF4444)
        : RaidPanelWidget._accent;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          '$slotsFilled / $maxSlots',
          style: TextStyle(
            color: color,
            fontFamily: 'inter',
            fontWeight: FontWeight.w800,
            fontSize: 12,
            fontFeatures: const <FontFeature>[
              FontFeature.tabularFigures(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlotPipsRow extends StatelessWidget {
  const _SlotPipsRow({required this.slotsFilled, required this.maxSlots});

  final int slotsFilled;
  final int maxSlots;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        const double spacing = 6;
        final int count = maxSlots <= 0 ? 0 : maxSlots;
        final double size = count == 0
            ? 0.0
            : ((c.maxWidth - spacing * (count - 1)) / count)
                .clamp(8.0, 22.0);
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: <Widget>[
            for (int i = 0; i < count; i++)
              _Pip(filled: i < slotsFilled, size: size),
          ],
        );
      },
    );
  }
}

class _Pip extends StatelessWidget {
  const _Pip({required this.filled, required this.size});

  final bool filled;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: filled
            ? const LinearGradient(
                colors: <Color>[
                  Color(0xFF9F7BFF),
                  Color(0xFF5E36F0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: filled ? null : RaidPanelWidget._pipEmpty,
        shape: BoxShape.circle,
        boxShadow: filled
            ? <BoxShadow>[
                BoxShadow(
                  color: RaidPanelWidget._accent.withValues(alpha: 0.45),
                  blurRadius: 6,
                ),
              ]
            : null,
      ),
    );
  }
}

class _RaidVm extends Equatable {
  const _RaidVm({
    required this.slotsFilled,
    required this.maxSlots,
    required this.isFull,
    required this.isJoining,
    required this.lastResult,
  });

  final int slotsFilled;
  final int maxSlots;
  final bool isFull;
  final bool isJoining;
  final bool? lastResult;

  @override
  List<Object?> get props => <Object?>[
        slotsFilled,
        maxSlots,
        isFull,
        isJoining,
        lastResult,
      ];
}
