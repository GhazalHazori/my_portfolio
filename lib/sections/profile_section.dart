import 'package:flutter/material.dart';
import 'dart:math';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Rotation animation للخطوط المنقطة
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    // Slide animation للصورة
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    _slideController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;

    final profileSize = isMobile ? 200.0 : 280.0;
    final borderWidth = isMobile ? 2.0 : 3.0;

    return Center(
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            SizedBox(
              width: profileSize + 40,
              height: profileSize + 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating dashed border
                  AnimatedBuilder(
                    animation: _rotationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationController.value * 2 * pi,
                        child: CustomPaint(
                          painter: DashedCirclePainter(
                            strokeWidth: borderWidth,
                          ),
                          size: Size(profileSize + 40, profileSize + 40),
                        ),
                      );
                    },
                  ),

                  // Profile image
                  Container(
                    width: profileSize,
                    height: profileSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 150, 100, 200),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 150, 100, 200)
                              .withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/me.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final double strokeWidth;

  DashedCirclePainter({required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 150, 100, 200)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // رسم دائرة منقطة
    _drawDashedCircle(canvas, center, radius, paint);
  }

  void _drawDashedCircle(Canvas canvas, Offset center, double radius, Paint paint) {
    const int dashCount = 30;
    const double dashLength = 0.3;

    for (int i = 0; i < dashCount; i++) {
      final angle = (i / dashCount) * 2 * pi;

      // رسم الخط المنقط
      if (i % 2 == 0) {
        final startAngle = angle;
        final endAngle = angle + (dashLength * 2 * pi);

        final p1 = Offset(
          center.dx + radius * cos(pi / 2 - startAngle),
          center.dy + radius * sin(pi / 2 - startAngle),
        );

        final p2 = Offset(
          center.dx + radius * cos(pi / 2 - endAngle),
          center.dy + radius * sin(pi / 2 - endAngle),
        );

        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
