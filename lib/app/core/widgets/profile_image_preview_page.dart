import '../../../utils/exports.dart';

/// Full-screen image preview page with pinch-to-zoom (InteractiveViewer)
class ProfileImagePreviewPage extends StatelessWidget {
  const ProfileImagePreviewPage({
    super.key,
    required this.name,
    required this.initial,
    this.imageUrl,
    this.localImageBytes,
  });

  final String name;
  final String initial;
  final String? imageUrl;
  final Uint8List? localImageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Hero(
            tag: 'profile_avatar_hero',
            child: localImageBytes != null
                ? Image.memory(
                    localImageBytes!,
                    fit: BoxFit.contain,
                  )
                : (imageUrl != null && imageUrl!.isNotEmpty)
                    ? FastCachedImage(
                        url: imageUrl!,
                        fit: BoxFit.contain,
                        loadingBuilder: (BuildContext context, FastCachedProgressData progress) => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryPurple,
                          ),
                        ),
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stacktrace) => _buildFallback(),
                      )
                    : _buildFallback(),
          ),
        ),
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      width: 250,
      height: 250,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryButtonGradient,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w800,
          fontSize: 100,
        ),
      ),
    );
  }
}
