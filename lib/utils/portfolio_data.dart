import 'package:flutter/material.dart';
import 'package:mansi_lathiya_portfolio/models/portfolio_model.dart';

// Portfolio static data
class PortfolioData {
  static const name = "Mansi Lathiya";
  static const tagline = "Flutter Developer";
  static const bio =
      "Passionate Flutter Developer with 3+ years of experience crafting beautiful, "
      "performant cross-platform mobile & web applications. I love turning complex problems "
      "into elegant, user-friendly solutions with clean architecture and smooth animations.";
  static const heroDescription =
      "3+ years crafting beautiful, high-performance\nmobile & web apps with Flutter & GetX, Provider.";
  static const email = "mansilathiya2802@gmail.com";
  static const location = "Surat, Gujarat, India";
  static const github = "https://github.com/mansilathiya";
  static const linkedin =
      "https://www.linkedin.com/in/mansi-lathiya-3a4714224/";
  static const availableWork = "Avaialble for freelance & full time job";
  static const totalExperience = "3+ Years";
  static const projectsCompleted = "15+";
  // static const totalCompanies = "4";
  static const resumeUrl =
      "https://drive.google.com/file/d/1T3F4e4DVtLorn9H-ruJ_48IDGAvoRKxb/view?usp=sharing";

  static const sectionsList = [
    "Home",
    "About",
    "Skills",
    "Projects",
    "Experience",
    "Contact",
  ];

  static const techTagsList = [
    "Flutter",
    "Dart",
    "GetX",
    "Provider",
    "Firebase",
    "REST APIs",
    "Git & GitHub",
  ];

  static const navItems = [
    (Icons.home_outlined, 'Home'),
    (Icons.person_outline_rounded, 'About'),
    (Icons.psychology_outlined, 'Skills'),
    (Icons.apps_rounded, 'Projects'),
    (Icons.work_outline_rounded, 'Experience'),
    (Icons.email_outlined, 'Contact'),
  ];

  static const links = [
    (0, 'Home'),
    (1, 'About'),
    (2, 'Skills'),
    (3, 'Projects'),
    (4, 'Experience'),
    (5, 'Contact'),
  ];

  static const traitsList = [
    (
      Icons.track_changes_rounded,
      "Goal Oriented",
      "Delivering clean, scalable & maintainable code",
    ),
    (
      Icons.bolt_rounded,
      "Fast Learner",
      "Quick to adapt & master new technologies",
    ),
    (
      Icons.brush_rounded,
      "UI/UX Passion",
      "Pixel-perfect, delightful user experiences",
    ),
    (
      Icons.groups_rounded,
      "Team Player",
      "Agile, collaborative & communicative",
    ),
  ];

  // Projects
  static const projectsList = [
    ProjectModel(
      title: "My BAREL - Pet Care & Safety",
      description:
          "Cross-platform pet care management app enabling pet owners to securely manage pet info, connect with care providers, and access advanced pet safety features with NFC integration.",
      tags: [
        "Flutter",
        "GetX",
        "Firebase",
        "NFC",
        "REST APIs",
        "Push Notifications",
        "Socket.IO client",
      ],
      icon: "🐾",
      platform: "iOS",
      appStoreUrl: "https://apps.apple.com/us/app/my-barel/id1640267791",
    ),
    ProjectModel(
      title: "Ding Kosher - Food Delivery",
      description:
          "Cross-platform kosher food delivery platform for Android, iOS & Web. Features restaurant browsing, real-time order tracking, Stripe payments & Google Maps integration.",
      tags: [
        "Flutter",
        "GetX",
        "Firebase",
        "Stripe",
        "Google Maps",
        "REST APIs",
      ],
      icon: "🍽️",
      platform: "Android, iOS & Web",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.checkoutbyswiftee.customer",
      appStoreUrl:
          "https://apps.apple.com/us/app/ding-kosher-food-delivered/id1554540865",
      websiteUrl: "https://dingnow.co.uk/",
    ),
    ProjectModel(
      title: "Ovaluate - Real Estate Valuation",
      description:
          "Real estate valuation app enabling users to evaluate property values, compare assets, explore market insights, and make informed investment decisions.",
      tags: [
        "Flutter",
        "GetX",
        "Firebase",
        "Google Maps",
        "REST APIs",
        "Push Notifications",
      ],
      icon: "🏠",
      platform: "Android & iOS",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.ovaluate.app",
      appStoreUrl: "https://apps.apple.com/us/app/ovaluate/id6447247655",
    ),
    ProjectModel(
      title: "Next Appointment - Healthcare",
      description:
          "Healthcare appointment booking app enabling users to discover providers, schedule appointments, manage bookings with multi-language support and secure authentication.",
      tags: [
        "Flutter",
        "GetX",
        "Firebase",
        "REST APIs",
        "Multi-language",
        "Push Notifications",
      ],
      icon: "🏥",
      platform: "iOS",
      appStoreUrl:
          "https://apps.apple.com/au/app/next-appointment/id6450647230",
    ),
    ProjectModel(
      title: "Direct Msg & Save Status/Reels",
      description:
          "WhatsApp utility app to send messages without saving contacts, download & manage statuses/reels, share media efficiently with country code support.",
      tags: ["Flutter", "GetX", "Local Storage"],
      icon: "💬",
      platform: "Android",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.appgenix.gbwhatsdirect",
    ),
    ProjectModel(
      title: "QR & Barcode Scanner",
      description:
          "Fast and accurate QR & Barcode scanner app supporting multiple barcode formats, scan history, and a user-friendly camera integration experience.",
      tags: ["Flutter", "GetX", "Camera", "QR/Barcode"],
      icon: "📷",
      platform: "Android",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.appgenix.barcode",
    ),
    ProjectModel(
      title: "Meizo HRM - HR Management",
      description:
          "Enterprise HRM platform streamlining workforce management with employee management, attendance tracking, leave management, holiday calendar & push notifications.",
      tags: [
        "Flutter",
        "Provider",
        "Firebase",
        "REST APIs",
        "Push Notifications",
      ],
      icon: "👥",
      platform: "Android & iOS",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.meizo.app",
      appStoreUrl: "https://apps.apple.com/in/app/meizo-hrm/id6478219701",
    ),
    ProjectModel(
      title: "Connester - Business Networking",
      description:
          "Professional community platform enabling entrepreneurs and businesses to connect, collaborate, expand networks, and discover new business opportunities.",
      tags: [
        "Flutter",
        "Provider",
        "Firebase",
        "REST APIs",
        "Push Notifications",
        "Socket.IO",
      ],
      icon: "🤝",
      platform: "Android & iOS",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.connester.app",
      appStoreUrl: "https://apps.apple.com/in/app/connester/id6751829374",
    ),
    ProjectModel(
      title: "Acumen VISTA - Logistics",
      description:
          "Logistics & vehicle management platform with real-time tracking, fleet management, scheduling, vehicle allocation, and automated operational reporting.",
      tags: ["Flutter", "Provider", "Firebase", "GPS", "REST APIs"],
      icon: "🚛",
      platform: "Android & iOS",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.app.acumen",
      appStoreUrl: "https://apps.apple.com/in/app/acumen-vista/id6752249115",
    ),
    ProjectModel(
      title: "Eazy Ride - Micro-Mobility",
      description:
          "Bike, e-bike & scooter rental platform with real-time fleet tracking, geofencing, ride management, group rides, promo codes & flexible pricing.",
      tags: [
        "Flutter",
        "Provider",
        "Firebase",
        "Google Maps",
        "GPS",
        "Geofencing",
      ],
      icon: "🛴",
      platform: "Android & iOS",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.eazy.scooter",
      appStoreUrl: "https://apps.apple.com/in/app/eazy-ride/id6477535433",
    ),
    ProjectModel(
      title: "BBROS Mobility - Connected EV",
      description:
          "Connected EV management app with live vehicle tracking, battery monitoring, trip analytics, health dashboard, service requests & IoT integration.",
      tags: ["Flutter", "Provider", "Firebase", "GPS", "IoT", "REST APIs"],
      icon: "⚡",
      platform: "Android & iOS",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.app.bbros",
      appStoreUrl: "https://apps.apple.com/in/app/bbros-mobility/id6751926750",
    ),
    ProjectModel(
      title: "Titchfield Technician - Field Service",
      description:
          "Field service management app enabling technicians to manage jobs, update service requests, submit digital reports, upload photos & track work progress.",
      tags: ["Flutter", "Provider", "Firebase", "GPS", "REST APIs"],
      icon: "🔧",
      platform: "Android",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.titchfield.technician",
    ),
    ProjectModel(
      title: "Sopers House - Food & Community",
      description:
          "Food ordering & community engagement platform with menu browsing, class & event booking, reservation management, promotions & push notifications.",
      tags: ["Flutter", "Provider", "Firebase", "Payment", "REST APIs"],
      icon: "🍴",
      platform: "Android & iOS",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.sopers.customer",
      appStoreUrl: "https://apps.apple.com/us/app/sopers-house/id6751745355",
    ),
    ProjectModel(
      title: "Laao Electric - EV Rental & Mobility",
      description:
          "EV rental application allowing users to rent electric scooters through subscription-based plans. Simplifies vehicle booking, KYC verification, and rental management while promoting sustainable transportation.",
      tags: ["Flutter", "Provider", "Firebase", "REST APIs"],
      icon: "🛴",
      platform: "Android",
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.app.laaoelectric",
    ),
  ];

  // static const projectFiltersList = [
  //   "All",
  //   "iOS",
  //   "Android",
  //   "Cross-Platform",
  //   "Web",
  // ];

  static const List<String> rolesList = [
    "Flutter Developer",
    "Mobile App Developer",
    "Cross-Platform Expert",
  ];

  static const List<ExperienceModel> experiencesList = [
    ExperienceModel(
      company: "Squillion Technology",
      role: "Flutter Developer",
      duration: "May 2025 - Feb 2026",
      location: "Surat, Gujarat",
      responsibilitiesList: [
        "Implemented scalable application architecture using Provider and Clean Architecture.",
        "Optimized application performance, memory usage, and user experience.",
        "Collaborated with project manager, backend and designer teams throughout the development lifecycle.",
        "Integrated third-party SDKs and platform-specific native functionality.",
        "Participated in code reviews and maintained coding standards across projects.",
        "Managed app releases, bug fixing, and production support activities.",
      ],
    ),
    ExperienceModel(
      company: "Presiss Technologies",
      role: "Flutter Developer",
      duration: "May 2024 - Mar 2025",
      location: "Surat, Gujarat",
      responsibilitiesList: [
        "Implemented state management using Provider and GetX.",
        "Integrated Firebase Authentication, Firestore, and Analytics.",
        "Performed debugging, testing, and performance optimization.",
      ],
    ),
    ExperienceModel(
      company: "Appgenix Infotech",
      role: "Flutter Developer",
      duration: "Dec 2022 - Feb 2024",
      location: "Surat, Gujarat",
      responsibilitiesList: [
        "Collaborated with UI/UX designers to deliver pixel-perfect interfaces.",
        "Integrated REST APIs using Dio and managed application data flow.",
        "Developed reusable widgets and shared application components.",
      ],
    ),
    ExperienceModel(
      company: "Kurm Infotech",
      role: "Junior Flutter Developer",
      duration: "Apr 2022 - Nov 2022",
      location: "Surat, Gujarat",
      responsibilitiesList: [
        "Integrated Socket.IO for real-time messaging, notifications, and live data updates.",
        "Implemented responsive UI screens based on Figma and client requirements.",
        "Integrated REST APIs and handled data parsing, caching, and error handling.",
        "Worked with GetX for state management, dependency injection, and route management.",
        "Used Git and GitHub for version control, code reviews, and team collaboration.",
      ],
    ),
    ExperienceModel(
      company: "iFlutter",
      role: "Trainee Flutter Developer",
      duration: "Dec 2021 - Apr 2022",
      location: "Surat, Gujarat",
      responsibilitiesList: [
        "Learned Flutter fundamentals, built sample projects & gained hands-on experience with Dart & widget lifecycle.",
      ],
    ),
  ];

  static const List<SkillCategory> skillCategoriesList = [
    SkillCategory(
      title: "Mobile Development",
      icon: Icons.phone_android_rounded,
      skills: [
        "Flutter & Dart Expert",
        "Clean Architecture",
        "GetX & Provider",
        "Google Maps",
        "App Store Deployment",
      ],
    ),
    SkillCategory(
      title: "Backend & APIs",
      icon: Icons.storage_rounded,
      skills: [
        "REST API Integration",
        "Firebase Auth",
        "Firestore Database",
        "Socket.IO",
        "Push Notifications",
        "Payment Gateway",
      ],
    ),
    SkillCategory(
      title: "State Management",
      icon: Icons.account_tree_rounded,
      skills: [
        "GetX",
        "Provider",
        "Dependency Injection",
        "Reactive Programming",
      ],
    ),
    SkillCategory(
      title: "UI / UX",
      icon: Icons.design_services_rounded,
      skills: [
        "Responsive Design",
        "Material 3",
        "Flutter Web",
        "Animations",
        "Dark Theme",
        "Adaptive Layout",
      ],
    ),
    SkillCategory(
      title: "Tools & DevOps",
      icon: Icons.build_rounded,
      skills: [
        "Git & GitHub",
        "Postman",
        "Android Studio",
        "VS Code",
        "XCode",
        "Firebase Console",
      ],
    ),
    SkillCategory(
      title: "Professional Skills",
      icon: Icons.workspace_premium_rounded,
      skills: [
        "Problem Solving",
        "Agile Methodology",
        "Code Review",
        "Team Collaboration",
      ],
    ),
  ];

 static  IconData platformIcon(String p) {
    if (p.contains("iOS") && p.contains("Android")) {
      return Icons.devices_rounded;
    }
    if (p.contains("Web")) return Icons.language_rounded;
    if (p.contains("iOS")) return Icons.apple_rounded;
    return Icons.android_rounded;
  }

 static  String platformShort(String p) {
    if (p.contains("Android") && p.contains("iOS") && p.contains("Web")) {
      return "Android, iOS & Web";
    }
    if (p.contains("Android") && p.contains("iOS")) return "Android & iOS";
    if (p.contains("Web")) return "Web";
    if (p.contains("iOS")) return "iOS";
    return "Android";
  }
}
