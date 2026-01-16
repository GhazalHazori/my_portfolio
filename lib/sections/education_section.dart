import 'package:flutter/material.dart';

class AnimatedHoverEducationCard extends StatefulWidget {
  final Widget child;

  const AnimatedHoverEducationCard({required this.child, super.key});

  @override
  State<AnimatedHoverEducationCard> createState() =>
      _AnimatedHoverEducationCardState();
}

class _AnimatedHoverEducationCardState extends State<AnimatedHoverEducationCard>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;
  late AnimationController _floatingController;
  late Animation<double> _floatingOffset;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingOffset = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatingOffset,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingOffset.value),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovering = true),
            onExit: (_) => setState(() => _hovering = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
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
                        ? const Color.fromARGB(
                            255,
                            150,
                            100,
                            200,
                          ).withOpacity(0.4)
                        : Colors.black.withOpacity(0.3),
                    blurRadius: _hovering ? 20 : 8,
                    spreadRadius: _hovering ? 2 : 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;

    final titleFontSize = isMobile ? 20.0 : (isTablet ? 23.0 : 26.0);
    final cardWidth = isMobile ? double.infinity : (isTablet ? 450.0 : 500.0);
    final cardPadding = isMobile ? 20.0 : 28.0;
    final iconSize = isMobile ? 48.0 : 60.0;
    final iconIconSize = isMobile ? 24.0 : 32.0;
    final univNameSize = isMobile ? 18.0 : 22.0;
    final degreeSize = isMobile ? 13.0 : 15.0;
    final specSize = isMobile ? 12.0 : 13.0;
    final spacing1 = isMobile ? 16.0 : 20.0;
    final spacing2 = isMobile ? 10.0 : 12.0;
    final spacing3 = isMobile ? 12.0 : 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Education",
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: isMobile ? 16 : 24),
        Center(
          child: SizedBox(
            width: cardWidth,
            child: AnimatedHoverEducationCard(
              child: Container(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // University Icon
                    Container(
                      width: iconSize,
                      height: iconSize,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 150, 100, 200),
                            Color.fromARGB(255, 100, 150, 200),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.school,
                          color: Colors.white,
                          size: iconIconSize,
                        ),
                      ),
                    ),
                    SizedBox(height: spacing1),

                    // University Name
                    Text(
                      "Homs University",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: univNameSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spacing2),

                    // Degree
                    Text(
                      "Information Technology Engineering",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 150, 100, 200),
                        fontSize: degreeSize,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isMobile ? 6.0 : 8.0),

                    // Specialization
                    Text(
                      "Software Engineering & Information Systems",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: specSize,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spacing3),

                    // Divider
                    Container(
                      height: 1,
                      color: const Color.fromARGB(100, 150, 100, 200),
                    ),
                    SizedBox(height: spacing3),

                    // Graduation Year
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: const Color.fromARGB(255, 150, 100, 200),
                          size: isMobile ? 16 : 18,
                        ),
                        SizedBox(width: isMobile ? 6 : 8),
                        Text(
                          "Graduated: 2025",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: isMobile ? 12.0 : 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 16 : 24),
      ],
    );
  }
}
