import '../../../utils/exports.dart';

/// UI-only ChatSupportCubit.
class ChatSupportCubit extends BaseCubit<ChatSupportState> {
  ChatSupportCubit() : super(ChatSupportState.initial());

  @override
  ChatSupportState getResetErrorState() => state.copyWith(msg: '');

  @override
  ChatSupportState getResetRedirectionState() => state.copyWith();
}
