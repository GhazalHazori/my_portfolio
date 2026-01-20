import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_portfolio/sections/certificate_section.dart';
import 'package:my_portfolio/sections/course_section.dart';
import 'package:my_portfolio/sections/education_section.dart';
import 'package:my_portfolio/sections/experience_section.dart';
import 'package:my_portfolio/sections/profile_section.dart';
import 'package:my_portfolio/sections/cta_section.dart';
import 'package:my_portfolio/sections/development_process_section.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

/// Widget للتعامل مع responsive layout لكل section
class ResponsiveSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final double titleFontSize;
  final Widget child;

  const ResponsiveSection({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.titleFontSize,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey profileKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey coursesKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();
  final GlobalKey ctaKey = GlobalKey();
  final GlobalKey developmentKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  
  late ScrollController _scrollController;
  String activeButton = "";
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    final RenderObject? renderObject = context.findRenderObject();
    if (renderObject == null) return;

    final RenderAbstractViewport viewport = RenderAbstractViewport.of(renderObject);
    final offset = viewport.getOffsetToReveal(renderObject, 0.0).offset;
    
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }
  
  void _navigateToSection(int index) {
    setState(() => _bottomNavIndex = index);
    
    final keys = [
      profileKey,
      aboutKey,
      skillsKey,
      projectsKey,
      experienceKey,
      educationKey,
      coursesKey,
      certificatesKey,
      ctaKey,
      developmentKey,
      contactKey,
    ];
    
    if (index < keys.length) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollTo(keys[index]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isTablet = mq.width > 600 && mq.width <= 1200;
    final isDesktop = mq.width > 1200;
    final isMobile = mq.width <= 600;

    // تحديد قيم responsive للـ padding والـ spacing
    final horizontalPadding = isMobile ? 16.0 : (isTablet ? 24.0 : 40.0);
    final maxWidth = isDesktop ? 1200.0 : double.infinity;
    final sectionSpacing = isMobile ? 20.0 : (isTablet ? 24.0 : 28.0);
    final titleFontSize = isMobile ? 18.0 : (isTablet ? 20.0 : 22.0);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 15, 68),
      appBar: isMobile ? null : _buildDesktopAppBar(),
      bottomNavigationBar: isMobile ? _buildMobileBottomNav() : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 🏠 HomeSection مع تمرير GlobalKeys و activeButton
            HomeSection(
              activeButton: activeButton,
              onButtonPressed: (buttonName) {
                setState(() => activeButton = buttonName);

                if (buttonName == "projects") {
                  scrollTo(projectsKey);
                } else if (buttonName == "contact") {
                  scrollTo(contactKey);
                }
              },
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  children: [
                    SizedBox(height: isMobile ? 24 : 36),

                    // باقي الأقسام
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      ResponsiveSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        titleFontSize: titleFontSize,
                        child: Container(key: profileKey, child: const ProfileSection()),
                      ),
                      SizedBox(height: sectionSpacing),
                      ResponsiveSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        titleFontSize: titleFontSize,
                        child: Container(key: aboutKey, child: const AboutSection()),
                      ),
                      SizedBox(height: sectionSpacing),
                      ResponsiveSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        titleFontSize: titleFontSize,
                        child: Container(key: skillsKey, child: const SkillsSection()),
                      ),
                      SizedBox(height: sectionSpacing),
                      ResponsiveSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        titleFontSize: titleFontSize,
                        child: ProjectsSection(key: projectsKey),
                      ),
                      // SizedBox(height: sectionSpacing),
                      // ResponsiveSection(
                      //   isMobile: isMobile,
                      //   isTablet: isTablet,
                      //   titleFontSize: titleFontSize,
                      //   child: Container(key: experienceKey, child: const ExperienceSection()),
                      // ),
                      SizedBox(height: sectionSpacing),
                      ResponsiveSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        titleFontSize: titleFontSize,
                        child: Container(key: educationKey, child: const EducationSection()),
                      ),
                      SizedBox(height: sectionSpacing),
                      ResponsiveSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        titleFontSize: titleFontSize,
                        child: Container(key: coursesKey, child: CoursesSection()),
                      ),
                      SizedBox(height: sectionSpacing),
                      ResponsiveSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        titleFontSize: titleFontSize,
                        child: Container(key: certificatesKey, child: CertificatesSection()),
                      ),
                      SizedBox(height: sectionSpacing),
                      Container(
                        key: ctaKey,
                        child: const CTASection(),
                      ),
                      SizedBox(height: sectionSpacing),
                      Container(
                        key: developmentKey,
                        child: const DevelopmentProcessSection(),
                      ),
                      SizedBox(height: sectionSpacing),
                      ResponsiveSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        titleFontSize: titleFontSize,
                        child: ContactSection(key: contactKey),
                      ),
                      SizedBox(height: sectionSpacing),
                    ],
                  ),
                ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // AppBar للديسكتوب
  AppBar _buildDesktopAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 37, 15, 68),
      elevation: 1,
      title: const Text(
        'Ghazal Hazori',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => scrollTo(profileKey),
          child: const Text('Profile', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => scrollTo(aboutKey),
          child: const Text('About', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => scrollTo(skillsKey),
          child: const Text('Skills', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => scrollTo(projectsKey),
          child: const Text('Projects', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => scrollTo(experienceKey),
          child: const Text('Experience', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => scrollTo(educationKey),
          child: const Text('Education', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => scrollTo(coursesKey),
          child: const Text('Courses', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => scrollTo(certificatesKey),
          child: const Text('Certificates', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => scrollTo(contactKey),
          child: const Text('Contact', style: TextStyle(color: Colors.white70)),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  // BottomNavigationBar للموبايل
  BottomNavigationBar _buildMobileBottomNav() {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 37, 15, 68),
      selectedItemColor: Colors.deepPurpleAccent,
      unselectedItemColor: Colors.white54,
      currentIndex: _bottomNavIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _navigateToSection,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Skills',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business_center),
          label: 'Exp',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Education',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Certs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Contact',
        ),
      ],
    );
  }
}
