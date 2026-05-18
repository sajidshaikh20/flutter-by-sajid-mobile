import '../../../../utils/exports.dart';

/// Chat panel — bubble list + rounded composer.
///
/// Uses a [BlocSelector] keyed only on the message list so typing in
/// the composer does not rebuild the list, and incoming chat does not
/// rebuild the composer.
class ChatPanelWidget extends StatefulWidget {
  /// Creates the chat panel.
  const ChatPanelWidget({super.key});

  @override
  State<ChatPanelWidget> createState() => _ChatPanelWidgetState();
}

class _ChatPanelWidgetState extends State<ChatPanelWidget> {
  late final TextEditingController _controller;

  static const Color _surface = Color(0xFF15121F);
  static const Color _surfaceBorder = Color(0xFF2A2440);
  static const Color _selfBubble = Color(0xFF5E36F0);
  static const Color _otherBubble = Color(0xFF231C36);
  static const Color _accent = Color(0xFF7C4DFF);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AetherCubit>().state.composer,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String selfId = context.read<AetherCubit>().localUserId;
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _surfaceBorder),
        ),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.forum, color: _accent, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Engagement Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  _LiveDot(),
                  SizedBox(width: 4),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      color: Color(0xFF22C55E),
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: _surfaceBorder),
            Expanded(
              child: BlocSelector<AetherCubit, AetherState, List<ChatMessage>>(
                selector: (AetherState s) => s.messages,
                builder:
                    (BuildContext context, List<ChatMessage> messages) {
                  if (messages.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Be the first to say hi.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontFamily: 'inter',
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int i) {
                      final ChatMessage m = messages[i];
                      final bool isSelf = m.author == selfId;
                      return _Bubble(message: m, isSelf: isSelf);
                    },
                  );
                },
              ),
            ),
            const Divider(height: 1, color: _surfaceBorder),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D182C),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: _surfaceBorder),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                        // @AETHER: Override the project's global TextField
                        // theme. `border: InputBorder.none` alone leaves
                        // the enabled/focused/error variants in place, so
                        // an underline bleeds through the rounded pill.
                        // We disable all of them and use a collapsed
                        // decoration to make the field paint nothing but
                        // text + cursor.
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'inter',
                            fontSize: 13,
                            height: 1.2,
                          ),
                          cursorColor: _accent,
                          cursorWidth: 1.5,
                          textInputAction: TextInputAction.send,
                          minLines: 1,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            hintText: 'Say something to the herd…',
                            hintStyle: TextStyle(
                              color: Colors.white38,
                              fontFamily: 'inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                          onChanged: (String v) =>
                              context.read<AetherCubit>().onComposerChanged(v),
                          onSubmitted: (_) => _send(context),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => _send(context),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF9F7BFF),
                              Color(0xFF5E36F0),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _send(BuildContext context) {
    final AetherCubit cubit = context.read<AetherCubit>();
    unawaited(cubit.sendMessage());
    _controller.clear();
  }
}

class _LiveDot extends StatelessWidget {
  const _LiveDot();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF22C55E),
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF22C55E).withValues(alpha: 0.6),
            blurRadius: 6,
          ),
        ],
      ),
      child: const SizedBox(width: 8, height: 8),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message, required this.isSelf});

  final ChatMessage message;
  final bool isSelf;

  @override
  Widget build(BuildContext context) {
    final String stripped = message.author.replaceFirst('guest_', '');
    final String initial =
        stripped.isEmpty ? '?' : stripped[0].toUpperCase();
    final Color bubbleColor = isSelf
        ? _ChatPanelWidgetState._selfBubble
        : _ChatPanelWidgetState._otherBubble;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isSelf) ...<Widget>[
            _Avatar(initial: initial, seed: message.author),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isSelf ? 'You' : message.author,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontFamily: 'inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(isSelf ? 14 : 4),
                      bottomRight: Radius.circular(isSelf ? 4 : 14),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      message.body,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'inter',
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isSelf) ...<Widget>[
            const SizedBox(width: 8),
            _Avatar(initial: initial, seed: message.author, isSelf: true),
          ],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.initial,
    required this.seed,
    this.isSelf = false,
  });

  final String initial;
  final String seed;
  final bool isSelf;

  @override
  Widget build(BuildContext context) {
    final int hash = seed.hashCode & 0x7fffffff;
    final List<Color> palette = <Color>[
      const Color(0xFF7C4DFF),
      const Color(0xFFFF6A00),
      const Color(0xFF22C55E),
      const Color(0xFFEF4444),
      const Color(0xFF38BDF8),
      const Color(0xFFEAB308),
    ];
    final Color tint = isSelf
        ? const Color(0xFF9F7BFF)
        : palette[hash % palette.length];
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[tint.withValues(alpha: 0.95), tint.withValues(alpha: 0.55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        width: 28,
        height: 28,
        child: Center(
          child: Text(
            initial,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'inter',
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
