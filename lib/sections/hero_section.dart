// lib/sections/hero_section.dart
import 'package:flutter/material.dart';
import '../data.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: isWide ? 80 : 40, horizontal: 24),
      color: const Color(0xFF120521),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 1100 : size.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left column
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, I'm ${PortfolioData.name}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isWide ? 42 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      PortfolioData.role,
                      style: TextStyle(
                        color: Colors.purpleAccent.shade100,
                        fontSize: isWide ? 20 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      PortfolioData.heroSubtitle,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isWide ? 18 : 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // open contact or mail
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text("Hire me"),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () {
                            // open resume or projects
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white24),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text("View projects", style: TextStyle(color: Colors.white70)),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // right image / avatar
              if (isWide)
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: [Colors.purple.shade800, Colors.purpleAccent.shade100]),
                        boxShadow: [BoxShadow(blurRadius: 40, color: Colors.purple.shade900.withOpacity(0.4))],
                      ),
                      child: const Center(child: Text("Your Photo", style: TextStyle(color: Colors.white70))),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
