// lib/data.dart
class PortfolioData {
  // ====== Personal ======
  static const String name = "Your Full Name";
  static const String role = "Flutter Developer";
  static const String heroSubtitle =
      "I build beautiful & performant mobile & web apps with Flutter.";
  static const String about =
      "Developer. Skilled in Dart, Flutter, UI/UX implementation, and problem-solving, I have worked on freelance projects, internships, and part-time roles with companies like Darrebni and Yes-apps Software. I’m passionate about building user-friendly, performant, and scalable mobile applications with clean code and maintainable architecture, and continuously learning to stay updated with the latest technologies.";

  // ====== Contact & Socials ======
  static const String email = "ghazalhazori2233@example.com";
  static const String phone = "+963 992 328 996 ";
  static const String linkedIn =
      "https://www.linkedin.com/in/ghazalhazori-022804254";
  static const String github = "https://github.com/GhazalHazori";
  static const String website = "https://yourwebsite.com";

  // ====== Skills ======
  static List<String> skills = [
    "Flutter",
    "Dart",
    "Firebase",
    "REST",
    "Git",
    "CI/CD",
    "Provider",
    "Clean Architecture",
    "SQLite",
    "Ui/Ux",
    "Getx",
    "Animations",
    "Jira",
    "bloc",
    "pusher",
    "Github",
    "Gitlab",
    "M-V-C",
    "M-V-V-M",
  ];

  static List<String> softSkills = [
    "Communication",
    "Problem Solving",
    "Teamwork",
    "Adaptability",
    "Time Management",
    "Quick Learner",
    "Professionalism",
    "Work Under Pressure",
  ];

  static List<Map<String, dynamic>> languages = [
    {"name": "Arabic", "level": 1.0},
    {"name": "English", "level": 0.85},
  ];

  // ====== Projects ======
  static const List<Project> projects = [
    Project(
      title: "🎉 Event Pop",
      description:
          "Graduation project • Event management system • Grade: 95/100 • Firebase & GetX & Rasa integration",

      url: "https://github.com/GhazalHazori/event_pop",
      videoUrl: "/my_portfolio/assets/videos/eventpop.mp4", // 🔹 فيديو محلي
      tags: ["Flutter", "GetX", 'Languages','Responsive','Firebase'],
    ),
    Project(
      title: "🌹 Gharsat Ward",
      description:
          "Retail sale of natural, artificial and stuffed flowers, gifts and decorative accessories",
      image: "assets/images/logo.png",
      url: "https://play.google.com/store/apps/details?id=com.pramji.xmas",
      // 🔹 فيديو على الإنترنت كمثال
      tags: ["Flutter", "Provider",'Languages','Responsive','Firebase'],
    ),
    Project(
      title: "👔 Outphet",
      description:
          "Outphet is an e-commerce app that offers a unique shopping experience, allowing users to explore carefully curated products selected by top celebrities from the Arab world.",
      image: "assets/images/outphet.png",
      url: "https://play.google.com/store/apps/details?id=com.outphetapp.com",
      // 🔹 فيديو على الإنترنت كمثال
      tags: ["Flutter", "Provider",'Languages','Responsive','Firebase'],
    ),
    Project(
      title: "👩‍🏫 TrKolej",
      description:
          "Outphet is an e-commerce app that offers a unique shopping experience, allowing users to explore carefully curated products selected by top celebrities from the Arab world.",
      image: "assets/images/tr_kolej.jpg",
      url: "",
      // 🔹 فيديو على الإنترنت كمثال
      tags: ["Flutter", "Bloc", 'Responsive','Languages','Firebase'],
    ),
    Project(
      title: "🏪 E-commerce",
      description:
          "A modern and user-friendly e-commerce platform designed to provide a seamless shopping experience featuring smart product management secure payments and elegant UI design",
      image: "",
      url: "https://github.com/GhazalHazori/electronic_project",
      videoUrl: "assets/videos/store.mp4",
      // 🔹 فيديو على الإنترنت كمثال
      tags: ["Flutter", "GetX",'Responsive'],
    ),
    Project(
      title: "🧑‍🦳 Enaya",
      description:
          "Health companion for seniors • Medicine reminders • Blood pressure & glucose tracking • Grade: 96/100",
      image: "",
      url: "https://github.com/GhazalHazori/CareEderly",
      videoUrl: "assets/videos/enaya.mp4",
      // 🔹 فيديو على الإنترنت كمثال
      tags: ["Flutter", "GetX", 'Firebase','Github','Languages','Responsive'],
    ),
    Project(
      title: "✨ SCCO",
      description:
          "A health companion mobile app designed for seniors to help them manage their daily medications and activities. The app features smart reminders for medicine schedules, tools to monitor blood pressure and glucose levels personalized health tips and educational content about common diseases all presented in a simple and accessible interface tailored for elderly users.",
      image: "assets/images/syrian.png",
      url: "",
      videoUrl: "",
      // 🔹 فيديو على الإنترنت كمثال
      tags: ["Flutter", "GetX", 'Pusher','Responsive'],
    ),
  ];

  static List<Course> courses = [
    Course(
      title: "Flutter Development",
      description:
          "Master mobile app development with Flutter. Learn to build beautiful, high-performance cross-platform apps for iOS and Android using Dart. Perfect for beginners and intermediate developers.",
      image: "assets/images/flutter.png",
      videoUrl: "",
    ),
    Course(
      title: "UI/UX Design",
      description:
          "Create stunning user interfaces and exceptional user experiences. Learn design principles, wireframing, prototyping, and modern design tools. Master the art of making apps that users love.",
      image: "assets/images/ui.png",
      videoUrl: "",
    ),
    // Course(
    //   title: ".NET Development",
    //   description:
    //       "Build powerful backend services and desktop applications with C# and .NET. Learn enterprise-level programming, databases, APIs, and cloud deployment for robust software solutions.",
    //   image:
    //       "assets/images/net.png",
    //   videoUrl: "",
    // ),
  ];

  static List<Certificate> certificates = [
    Certificate(
      title: "Training at Darrebni",
      image:
          "assets/images/darrebni.jpg",
      description:
          "Professional IT training program covering advanced software development, system administration, and enterprise solutions. Completed comprehensive coursework with hands-on projects.",
      url:
          "https://drive.google.com/file/d/14wTAY4Nd_XwEO0YHm6-JS-ciErhVtTWB/view?usp=drivesdk ",
    ),
    Certificate(
      title: "Networks and Monitoring Devices",
      image:
          "assets/images/Network.jpg",
      description:
          "Advanced certification in network infrastructure, device management, and monitoring systems. Covers network protocols, security standards, and real-time monitoring tools.",
      url:
          "https://drive.google.com/file/d/14sJSg2XXTJoZtmUX_2vCA4OskFJMjZv_/view?usp=drivesdk",
    ),
    Certificate(
      title: "Laptop Maintenance Course",
      image:
          "assets/images/Laptop.jpg",
      description:
          "Comprehensive training in hardware maintenance, troubleshooting, and repair. Includes system optimization, driver management, and preventive maintenance best practices.",
      url:
          "https://drive.google.com/file/d/15BRyOJpu2rapFa0XTOWfezmhnv9XdcIh/view?usp=drivesdk",
    ),
  ];
}

class Project {
  final String title;
  final String description;
  final String? image;
  final String url;
  final List<String> tags;
  final String? videoUrl; // 🔹 رابط الفيديو (اختياري)
  final String? role;
  final String? year;
  const Project({
    required this.title,
    required this.description,
    this.image,
    required this.url,
    this.tags = const [],
    this.videoUrl,
    this.role,
    this.year, // ← أضف هذا
  });
}

class Course {
  final String title;
  final String description;
  final String? image;
  final String? videoUrl;

  Course({
    required this.title,
    required this.description,
    this.image,
    this.videoUrl,
  });
}

class Certificate {
  final String title;
  final String image;
  final String description;
  final String url;

  Certificate({
    required this.title,
    required this.image,
    required this.description,
    required this.url,
  });
}
