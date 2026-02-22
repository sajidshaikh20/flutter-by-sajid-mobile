import '../../../../utils/exports.dart';

/// Avatar subwidget for user greeting.
class UserGreetingAvatarWidget extends StatelessWidget {
  const UserGreetingAvatarWidget({super.key, this.profileImagePath});

  final String? profileImagePath;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Assets.png.icUserImage.image(),
    );
  }
}
