import 'package:flutter/material.dart';

class DevelopmentProcessSection extends StatelessWidget {
  const DevelopmentProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;

    final processes = [
      {
        'title': 'Planning',
        'items': [
          'Define project requirements',
          'Research and analysis',
          'Create project timeline',
          'Set goals and objectives',
        ],
      },
      {
        'title': 'Design',
        'items': [
          'UI/UX wireframes',
          'Create mockups',
          'Design system setup',
          'Prototype creation',
        ],
      },
      {
        'title': 'Development',
        'items': [
          'Frontend implementation',
          'Backend setup',
          'Database design',
          'API integration',
        ],
      },
      {
        'title': 'Testing',
        'items': [
          'Unit testing',
          'Integration testing',
          'User acceptance testing',
          'Bug fixes and deployment',
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Development Process',
          style: TextStyle(
            fontSize: isMobile ? 20.0 : 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: isMobile ? 24 : 40),
        if (isMobile)
          _MobileTimeline(processes: processes)
        else
          _DesktopTimeline(processes: processes),
      ],
    );
  }
}

class _MobileTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> processes;

  const _MobileTimeline({required this.processes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        processes.length,
        (index) {
          final process = processes[index];
          return Column(
            children: [
              _ProcessCard(
                title: process['title'] as String,
                items: List<String>.from(process['items'] as List),
                isMobile: true,
              ),
              if (index < processes.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    height: 2,
                    width: 40,
                    color: const Color.fromARGB(255, 150, 100, 200),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _DesktopTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> processes;

  const _DesktopTimeline({required this.processes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Timeline line
        SizedBox(
          height: 600,
          child: CustomPaint(
            painter: TimelinePainter(),
            child: Stack(
              children: List.generate(
                processes.length,
                (index) {
                  final process = processes[index];
                  final isRight = index % 2 == 0;

                  return Positioned(
                    left: isRight ? 0 : null,
                    right: isRight ? null : 0,
                    top: (index * 120).toDouble(),
                    child: Column(
                      crossAxisAlignment: isRight
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        _ProcessCard(
                          title: process['title'] as String,
                          items: List<String>.from(process['items'] as List),
                          isMobile: false,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProcessCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool isMobile;

  const _ProcessCard({
    required this.title,
    required this.items,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : 280,
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 37, 15, 68),
            const Color.fromARGB(255, 50, 20, 80),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(255, 150, 100, 200).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 150, 100, 200).withValues(alpha: 0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 7, right: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 150, 100, 200),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 13,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class TimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 150, 100, 200).withValues(alpha: 0.3)
      ..strokeWidth = 2;

    // رسم الخط الرئيسي
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // رسم الدوائر والخطوط الجانبية
    for (int i = 0; i < 4; i++) {
      final yPos = (i * 120).toDouble() + 40;
      final isRight = i % 2 == 0;

      // الدائرة في الوسط
      canvas.drawCircle(
        Offset(size.width / 2, yPos),
        8,
        Paint()
          ..color = const Color.fromARGB(255, 150, 100, 200)
          ..style = PaintingStyle.fill,
      );

      // الخط الجانبي
      final startX = isRight ? size.width / 2 : size.width / 2;
      final endX = isRight ? size.width * 0.05 : size.width * 0.95;

      canvas.drawLine(
        Offset(startX, yPos),
        Offset(endX, yPos),
        Paint()
          ..color = const Color.fromARGB(255, 150, 100, 200).withValues(alpha: 0.3)
          ..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
