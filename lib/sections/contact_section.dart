import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedHoverContactCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isHovering;
  final Function(bool) onHoverChanged;

  const AnimatedHoverContactCard({
    required this.child,
    required this.onTap,
    required this.isHovering,
    required this.onHoverChanged,
    super.key,
  });

  @override
  State<AnimatedHoverContactCard> createState() =>
      _AnimatedHoverContactCardState();
}

class _AnimatedHoverContactCardState extends State<AnimatedHoverContactCard> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onHoverChanged(true),
      onExit: (_) => widget.onHoverChanged(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: widget.isHovering
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.translationValues(0, 0, 0),
        decoration: BoxDecoration(
          color:  Color.fromARGB(255, 37, 15, 68),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: widget.isHovering
                ? const Color.fromARGB(255, 150, 100, 200)
                : const Color.fromARGB(100, 150, 100, 200),
            width: widget.isHovering ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isHovering
                  ? const Color.fromARGB(255, 150, 100, 200).withOpacity(0.4)
                  : Colors.black.withOpacity(0.3),
              blurRadius: widget.isHovering ? 20 : 8,
              spreadRadius: widget.isHovering ? 2 : 0,
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

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final List<bool> _hovering = [false, false, false, false];

  Future<void> _mail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _call(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;

    final titleFontSize = isMobile ? 20.0 : (isTablet ? 23.0 : 26.0);
    final crossAxisCount = isMobile ? 1 : 2;
    final mainAxisExtent = isMobile ? 140.0 : (isTablet ? 150.0 : 160.0);
    final spacing = isMobile ? 10.0 : (isTablet ? 12.0 : 14.0);
    final titleSpacing = isMobile ? 16.0 : 24.0;
    final cardPadding = isMobile ? 12.0 : 16.0;
    final iconSize = isMobile ? 40.0 : 50.0;
    final iconIconSize = isMobile ? 18.0 : 24.0;
    final labelFontSize = isMobile ? 12.0 : 14.0;
    final valueFontSize = isMobile ? 10.0 : 11.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact",
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisExtent: mainAxisExtent,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: 4,
          itemBuilder: (context, i) {
            if (i == 0) {
              // Email
              return AnimatedHoverContactCard(
                isHovering: _hovering[0],
                onHoverChanged: (val) => setState(() => _hovering[0] = val),
                onTap: () => _mail(PortfolioData.email),
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 150, 100, 200),
                              Color.fromARGB(255, 100, 150, 200),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Icons.email, color: Colors.white, size: iconIconSize),
                        ),
                      ),
                      SizedBox(height: isMobile ? 10 : 12),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _hovering[0] ? labelFontSize + 1 : labelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Text("Email", textAlign: TextAlign.center),
                      ),
                      SizedBox(height: isMobile ? 3 : 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: _hovering[0]
                              ? const Color.fromARGB(255, 150, 100, 200)
                              : Colors.white,
                          fontSize: _hovering[0] ? valueFontSize + 1 : valueFontSize,
                          fontWeight: _hovering[0] ? FontWeight.w600 : FontWeight.w400,
                        ),
                        child: Text(
                          PortfolioData.email,
                          maxLines: _hovering[0] ? null : 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (i == 1) {
              // Phone
              return AnimatedHoverContactCard(
                isHovering: _hovering[1],
                onHoverChanged: (val) => setState(() => _hovering[1] = val),
                onTap: () => _call(PortfolioData.phone),
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 150, 100, 200),
                              Color.fromARGB(255, 100, 150, 200),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Icons.phone, color: Colors.white, size: iconIconSize),
                        ),
                      ),
                      SizedBox(height: isMobile ? 10 : 12),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _hovering[1] ? labelFontSize + 1 : labelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Text("Phone", textAlign: TextAlign.center),
                      ),
                      SizedBox(height: isMobile ? 3 : 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: _hovering[1]
                              ? const Color.fromARGB(255, 150, 100, 200)
                              : Colors.white,
                          fontSize: _hovering[1] ? valueFontSize + 1 : valueFontSize,
                          fontWeight: _hovering[1] ? FontWeight.w600 : FontWeight.w400,
                        ),
                        child: Text(
                          PortfolioData.phone,
                          maxLines: _hovering[1] ? null : 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (i == 2) {
              // LinkedIn
              return AnimatedHoverContactCard(
                isHovering: _hovering[2],
                onHoverChanged: (val) => setState(() => _hovering[2] = val),
                onTap: () => _launchURL(PortfolioData.linkedIn),
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 150, 100, 200),
                              Color.fromARGB(255, 100, 150, 200),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.white,
                            size: isMobile ? 16 : 20,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 10 : 12),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _hovering[2] ? labelFontSize + 1 : labelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Text("LinkedIn", textAlign: TextAlign.center),
                      ),
                      SizedBox(height: isMobile ? 3 : 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: _hovering[2]
                              ? const Color.fromARGB(255, 150, 100, 200)
                              : Colors.white,
                          fontSize: _hovering[2] ? valueFontSize + 1 : valueFontSize,
                          fontWeight: _hovering[2] ? FontWeight.w600 : FontWeight.w400,
                        ),
                        child: const Text(
                          "Connect with me",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // GitHub
              return AnimatedHoverContactCard(
                isHovering: _hovering[3],
                onHoverChanged: (val) => setState(() => _hovering[3] = val),
                onTap: () => _launchURL(PortfolioData.github),
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 150, 100, 200),
                              Color.fromARGB(255, 100, 150, 200),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.github,
                            color: Colors.white,
                            size: isMobile ? 16 : 20,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 10 : 12),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _hovering[3] ? labelFontSize + 1 : labelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Text("GitHub", textAlign: TextAlign.center),
                      ),
                      SizedBox(height: isMobile ? 3 : 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: _hovering[3]
                              ? const Color.fromARGB(255, 150, 100, 200)
                              : Colors.white,
                          fontSize: _hovering[3] ? valueFontSize + 1 : valueFontSize,
                          fontWeight: _hovering[3] ? FontWeight.w600 : FontWeight.w400,
                        ),
                        child: const Text(
                          "View projects",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}