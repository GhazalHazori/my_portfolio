// lib/sections/about_section.dart
import 'package:flutter/material.dart';
import '../data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;
    
    final titleFontSize = isMobile ? 18.0 : (isTablet ? 20.0 : 22.0);
    final textFontSize = isMobile ? 14.0 : (isTablet ? 15.0 : 16.0);
    final titleSpacing = isMobile ? 6.0 : 8.0;

    return Container(
      color: const Color.fromARGB(255, 37, 15, 68),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About",
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: titleSpacing),
          Text(
            PortfolioData.about,
            style: TextStyle(
              fontSize: textFontSize,
              height: 1.6,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
