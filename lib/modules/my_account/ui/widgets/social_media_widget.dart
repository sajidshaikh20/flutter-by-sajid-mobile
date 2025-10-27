
import '../../../../utils/exports.dart';

/// Widget that displays social media icons and links.
class SocialMediaWidget extends StatelessWidget {
  /// Creates a social media widget.
  const SocialMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Read social media URLs as individual strings from SharedPref
    final String facebookUrl = SharedPref.instance.getString(PrefsKey.facebookUrlKey, '');
    final String instagramUrl = SharedPref.instance.getString(PrefsKey.instagramUrlKey, '');
    
    DebugLog.instance.i('SocialMediaWidget: Facebook URL from SharedPref: "$facebookUrl"');
    DebugLog.instance.i('SocialMediaWidget: Instagram URL from SharedPref: "$instagramUrl"');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            DebugLog.instance.i('Facebook icon tapped, URL: $facebookUrl');
            if (facebookUrl.isNotEmpty) {
              await _openExternalUrl(facebookUrl, context);
            } else {
              DebugLog.instance.w('Facebook URL is empty');
            }
          },
          child: Assets.svgs.icRoundFacebook.svg(),
        ),
        const SizedBox(width: Dimens.space15,),
        GestureDetector(
          onTap: () async {
            DebugLog.instance.i('Instagram icon tapped, URL: $instagramUrl');
            if (instagramUrl.isNotEmpty) {
              await _openExternalUrl(instagramUrl, context);
            } else {
              DebugLog.instance.w('Instagram URL is empty');
            }
          },
          child: Assets.svgs.icInstagram.svg(),
        ),
        //# TODO in first phase we don't give this things but in future its required
        // const SizedBox(width: Dimens.space15,),
        // Assets.svgs.icYoutube.svg(),
      ],
    );
  }
}

Future<void> _openExternalUrl(String url, BuildContext context) async {
  try {
    DebugLog.instance.i('_openExternalUrl called with: $url');
    String urlToOpen = url;
    if (!urlToOpen.startsWith('http://') && !urlToOpen.startsWith('https://')) {
      urlToOpen = 'https://$urlToOpen';
    }
    DebugLog.instance.i('URL to open: $urlToOpen');
    final Uri uri = Uri.parse(urlToOpen);
    DebugLog.instance.i('Parsed URI: $uri');
    
    final bool canLaunch = await canLaunchUrl(uri);
    DebugLog.instance.i('Can launch URL: $canLaunch');
    
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      DebugLog.instance.i('URL launched successfully');
    } else {
      DebugLog.instance.w('Cannot launch URL: $urlToOpen');
      if (context.mounted) displaySnackBar('Could not open URL', context);
    }
  } on Exception catch (e) {
    DebugLog.instance.e('Error opening URL: $e');
    if (context.mounted) displaySnackBar('Could not open URL', context);
  }
}
