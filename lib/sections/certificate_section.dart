import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/animated_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data.dart';

class AnimatedHoverCertificateCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const AnimatedHoverCertificateCard({
    required this.child,
    required this.onTap,
    super.key,
  });

  @override
  State<AnimatedHoverCertificateCard> createState() =>
      _AnimatedHoverCertificateCardState();
}

class _AnimatedHoverCertificateCardState
    extends State<AnimatedHoverCertificateCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovering
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.translationValues(0, 0, 0),
        decoration: BoxDecoration(
          color:  Color.fromARGB(255, 37, 15, 68),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovering
                ? const Color.fromARGB(255, 150, 100, 200)
                : const Color.fromARGB(100, 150, 100, 200),
            width: _hovering ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovering
                  ? const Color.fromARGB(255, 150, 100, 200).withOpacity(0.4)
                  : Colors.black.withOpacity(0.3),
              blurRadius: _hovering ? 20 : 8,
              spreadRadius: _hovering ? 2 : 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(14),
          child: widget.child,
        ),
      ),
    );
  }
}

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final list = PortfolioData.certificates;
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;

    final titleFontSize = isMobile ? 20.0 : (isTablet ? 23.0 : 26.0);
    final crossAxisCount = isMobile ? 1 : 2;
    final mainAxisExtent = isMobile ? 280.0 : (isTablet ? 290.0 : 300.0);
    final spacing = isMobile ? 10.0 : (isTablet ? 12.0 : 14.0);
    final titleSpacing = isMobile ? 12.0 : 16.0;
    final cardPadding = isMobile ? 10.0 : 12.0;
    final certTitleSize = isMobile ? 12.0 : 14.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Certificates",
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: titleSpacing),

        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisExtent: mainAxisExtent,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemBuilder: (context, i) {
            final cert = list[i];

            return ScrollAnimatedCard(
              delay: i * 120,
              child: AnimatedHoverCertificateCard(
                onTap: () {
                  _launchURL(cert.url);
                },
                child: Container(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildImage(cert.image),
                        ),
                      ),
                      Divider(
                        color: const Color.fromARGB(255, 80, 80, 80),
                        thickness: 1,
                        height: isMobile ? 12 : 16,
                      ),
                      Text(
                        cert.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: certTitleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              color: Colors.blue[300],
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[800],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.insert_drive_file_outlined,
                    size: 48,
                    color: Colors.blue[300],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Certificate',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[800],
            child: const Center(
              child: Icon(Icons.image_not_supported, color: Colors.white),
            ),
          );
        },
      );
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
