import 'package:flutter/material.dart';
import '../data.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;

    final spacing = isMobile ? 8.0 : 10.0;
    final runSpacing = isMobile ? 6.0 : 8.0;
    final sectionSpacing = isMobile ? 24.0 : 30.0;
    final titleSpacing = isMobile ? 10.0 : 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================== Skills Section ==================
        const GradientTitle("Skills"),
        SizedBox(height: titleSpacing),
        Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: PortfolioData.skills.map((s) {
            return constGradientChip(s);
          }).toList(),
        ),
        SizedBox(height: sectionSpacing),

        // ================== Soft Skills Section ==================
        const GradientTitle("Soft Skills"),
        SizedBox(height: titleSpacing),
        Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: PortfolioData.softSkills.map((s) {
            return constGradientChip(s);
          }).toList(),
        ),
        SizedBox(height: sectionSpacing),

        // ================== Languages Section ==================
        const GradientTitle("Languages"),
        SizedBox(height: titleSpacing + 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: PortfolioData.languages.map((lang) {
            return Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 14.0 : 18.0),
              child: LanguageBar(
                language: lang['name']!,
                level: lang['level']!,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// ------------------ Gradient Title ------------------
class GradientTitle extends StatelessWidget {
  final String text;
  const GradientTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;
    
    final fontSize = isMobile ? 18.0 : (isTablet ? 20.0 : 22.0);

    final gradient = const LinearGradient(
      colors: [
        Color.fromARGB(255, 99, 69, 217),
        Color.fromARGB(255, 99, 69, 217),
        Color.fromARGB(255, 180, 5, 211),
        Color(0xFFA7D8F2),
      ],
    );

    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// ------------------ Gradient Chip ------------------
Widget constGradientChip(String label) {
  return GradientChip(label: label);
}

class GradientChip extends StatefulWidget {
  final String label;

  const GradientChip({required this.label, super.key});

  @override
  State<GradientChip> createState() => _GradientChipState();
}

class _GradientChipState extends State<GradientChip> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    
    final baseFontSize = isMobile ? 12.0 : 14.0;
    final hoverFontSize = isMobile ? 13.0 : 15.0;
    final horizontalPadding = isMobile ? 12.0 : 14.0;
    final verticalPadding = isMobile ? 6.0 : 8.0;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isHovered
                ? const [
                    Color.fromARGB(255, 180, 5, 211),
                    Color.fromARGB(255, 150, 50, 220),
                    Color.fromARGB(255, 99, 69, 217),
                    Color(0xFF89CFF0),
                  ]
                : const [
                    Color.fromARGB(255, 13, 4, 48),
                    Color.fromARGB(255, 99, 69, 217),
                    Color.fromARGB(255, 123, 2, 145),
                    Color(0xFFA7D8F2),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? const Color.fromARGB(255, 180, 5, 211).withOpacity(0.6)
                  : Colors.black.withOpacity(0.15),
              blurRadius: isHovered ? 15 : 5,
              offset: isHovered ? const Offset(0, 4) : const Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
              fontSize: isHovered ? hoverFontSize : baseFontSize,
            ),
          ),
        ),
      ),
    );
  }
}

/// ------------------ Language Progress Bar ------------------
class LanguageBar extends StatelessWidget {
  final String language;
  final double level;

  const LanguageBar({super.key, required this.language, required this.level});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    
    final textFontSize = isMobile ? 14.0 : 16.0;
    final barHeight = isMobile ? 6.0 : 8.0;
    final spacing = isMobile ? 4.0 : 6.0;

    const gradientColors = [
      Color.fromARGB(255, 37, 11, 142),
      Color.fromARGB(255, 99, 69, 217),
      Color.fromARGB(255, 123, 2, 145),
      Color(0xFFA7D8F2),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language,
          style: TextStyle(
            fontSize: textFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: spacing),
        Container(
          height: barHeight,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                Container(
                  width: constraints.maxWidth * level,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
