import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatefulWidget {
  final String activeButton;
  final Function(String) onButtonPressed;

  const HomeSection({
    super.key,
    required this.activeButton,
    required this.onButtonPressed,
  });

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;
  final String _fullText =
      "Software Engineer / Mobile App Developer / Flutter Developer";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _characterCount = IntTween(begin: 0, end: _fullText.length).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchURL() async {
    const url = 'https://1drv.ms/b/c/91ad386e7cfd5cff/ESDkmdb7hOZDiyjaXyypKQkBFtCP-ZC4O1FHvSK5H2A4DQ';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Color getButtonColor(String buttonName) {
    return widget.activeButton == buttonName
        ? Colors.deepPurpleAccent
        : Colors.transparent;
  }

  Color getTextColor(String buttonName) {
    return widget.activeButton == buttonName ? Colors.white : Colors.white70;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;

    final verticalPadding = isMobile ? 60.0 : (isTablet ? 80.0 : 120.0);
    final horizontalPadding = isMobile ? 20.0 : (isTablet ? 40.0 : 40.0);
    final titleFontSize = isMobile ? 28.0 : (isTablet ? 36.0 : 48.0);
    final subtitleFontSize = isMobile ? 16.0 : (isTablet ? 22.0 : 28.0);
    final descriptionFontSize = isMobile ? 14.0 : (isTablet ? 15.0 : 16.0);
    final buttonSpacing = isMobile ? 12.0 : 20.0;
    final buttonRunSpacing = isMobile ? 8.0 : 10.0;
    final buttonPaddingH = isMobile ? 16.0 : 24.0;
    final buttonPaddingV = isMobile ? 12.0 : 16.0;
    final buttonIconSize = isMobile ? 18.0 : 20.0;
    final titleSpacing = isMobile ? 12.0 : 16.0;
    final subtitleSpacing = isMobile ? 16.0 : 24.0;
    final buttonsSpacing = isMobile ? 24.0 : 40.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(17, 7, 31, 1),
            Color.fromARGB(255, 89, 53, 139),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.orangeAccent,
                Colors.cyanAccent,
                Colors.orangeAccent,
              ],
            ).createShader(bounds),
            child: Text(
              "Hey, I'm Ghazal Hazori 👋",
              style: GoogleFonts.poppins(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: titleSpacing),
          AnimatedBuilder(
            animation: _characterCount,
            builder: (context, child) {
              final displayText = _fullText.substring(0, _characterCount.value);
              return ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.tealAccent, Colors.blueAccent],
                ).createShader(bounds),
                child: Text(
                  displayText,
                  style: GoogleFonts.poppins(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          SizedBox(height: subtitleSpacing),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 0,
            ),
            child: Text(
              "Clean UI, smooth motion, and real-world performance — with a sprinkle of engineering and creativity.",
              style: GoogleFonts.poppins(
                fontSize: descriptionFontSize,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: buttonsSpacing),
          Wrap(
            spacing: buttonSpacing,
            runSpacing: buttonRunSpacing,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => widget.onButtonPressed("projects"),
                icon: Icon(Icons.rocket_launch_rounded, size: buttonIconSize),
                label: const Text("View Projects"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: getButtonColor("projects"),
                  foregroundColor: getTextColor("projects"),
                  side: const BorderSide(color: Colors.white70),
                  padding: EdgeInsets.symmetric(
                    horizontal: buttonPaddingH,
                    vertical: buttonPaddingV,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _launchURL();
                  widget.onButtonPressed("cv");
                },
                icon: Icon(Icons.description_outlined, size: buttonIconSize),
                label: const Text("View CV"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: getButtonColor("cv"),
                  foregroundColor: getTextColor("cv"),
                  side: const BorderSide(color: Colors.white70),
                  padding: EdgeInsets.symmetric(
                    horizontal: buttonPaddingH,
                    vertical: buttonPaddingV,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => widget.onButtonPressed("contact"),
                icon: Icon(Icons.mail_outline, size: buttonIconSize),
                label: const Text("Contact Me"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: getButtonColor("contact"),
                  foregroundColor: getTextColor("contact"),
                  side: const BorderSide(color: Colors.white70),
                  padding: EdgeInsets.symmetric(
                    horizontal: buttonPaddingH,
                    vertical: buttonPaddingV,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
