import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;

    final titleFontSize = isMobile ? 20.0 : (mq.width > 600 && mq.width <= 1200 ? 23.0 : 26.0);
    final cardSpacing = isMobile ? 10.0 : 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: isMobile ? 16 : 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: isMobile ? 160.0 : 200.0,
              width: isMobile ? 160.0 : 200.0,
              child: _ExperienceCard(
                label: 'Years',
                value: '+4',
                delay: 0,
                isMobile: isMobile,
              ),
            ),
            SizedBox(width: isMobile ? 10 : 20),
            SizedBox(
              height: isMobile ? 160.0 : 200.0,
              width: isMobile ? 160.0 : 200.0,
              child: _ExperienceCard(
                label: 'Technology',
                value: '+15',
                delay: 150,
                isMobile: isMobile,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatefulWidget {
   final String label;
   final String value;
   final int delay;
   final bool isMobile;

   const _ExperienceCard({
     required this.label,
     required this.value,
     required this.delay,
     required this.isMobile,
   });

   @override
   State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
   bool _isVisible = false;
   bool _hovering = false;

   @override
   void initState() {
     super.initState();
     final actualDelay = kIsWeb ? 0 : widget.delay;
     
     Future.delayed(Duration(milliseconds: actualDelay), () {
       if (mounted) {
         setState(() => _isVisible = true);
       }
     });
   }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedScale(
        scale: _isVisible ? 1.0 : 0.8,
        duration: const Duration(milliseconds: 600),
        child: SizedBox.expand(
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovering = true),
            onExit: (_) => setState(() => _hovering = false),
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              transform: _hovering
                  ? Matrix4.translationValues(0, -5, 0)
                  : Matrix4.translationValues(0, 0, 0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 37, 15, 68),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: widget.isMobile ? 12 : 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: widget.isMobile ? 12 : 16),
                  Text(
                    widget.value,
                    style: TextStyle(
                      fontSize: widget.isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
