import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data.dart';

class CTASection extends StatefulWidget {
  const CTASection({super.key});

  @override
  State<CTASection> createState() => _CTASectionState();
}

class _CTASectionState extends State<CTASection> {
  bool _isHovering = false;

  Future<void> _launchEmail() async {
    final uri = Uri.parse('mailto:${PortfolioData.email}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;

    final containerPadding = isMobile ? 24.0 : (isTablet ? 40.0 : 60.0);
    final titleFontSize = isMobile ? 22.0 : (isTablet ? 28.0 : 32.0);
    final textFontSize = isMobile ? 14.0 : (isTablet ? 15.0 : 16.0);
    final buttonPaddingH = isMobile ? 20.0 : 32.0;
    final buttonPaddingV = isMobile ? 12.0 : 16.0;

    return Center(
      child: Container(
        // width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : 40.0,
          vertical: containerPadding,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 37, 15, 68),
              const Color.fromARGB(255, 50, 20, 80),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(255, 150, 100, 200).withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 150, 100, 200).withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              'Ready to Start Your Project?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
      
            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 30),
              child: Text(
                "Let's discuss your ideas and create something amazing together. I'm here to help bring your vision to life.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textFontSize,
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),
            ),
            SizedBox(height: isMobile ? 24 : 32),
      
            // Button
            MouseRegion(
              onEnter: (_) => setState(() => _isHovering = true),
              onExit: (_) => setState(() => _isHovering = false),
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: _isHovering
                    ? Matrix4.translationValues(0, -3, 0)
                    : Matrix4.translationValues(0, 0, 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isHovering
                        ? const [
                            Color.fromARGB(255, 180, 50, 200),
                            Color.fromARGB(255, 150, 100, 200),
                          ]
                        : const [
                            Color.fromARGB(255, 150, 100, 200),
                            Color.fromARGB(255, 120, 80, 180),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 150, 100, 200)
                          .withValues(alpha: _isHovering ? 0.6 : 0.3),
                      blurRadius: _isHovering ? 20 : 10,
                      spreadRadius: _isHovering ? 2 : 0,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _launchEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      horizontal: buttonPaddingH,
                      vertical: buttonPaddingV,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: isMobile ? 14.0 : 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
