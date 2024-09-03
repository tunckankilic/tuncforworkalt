import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

double height = 812.h;
double width = 375.w;

class AppConstants {
  static const kDark = Color(0xFF000000);
  static const kLight = Color(0xFFFFFFFF);
  static const kLightGrey = Color(0x95D1CECE);
  static const kDarkGrey = Color(0xFF9B9B9B);
  static const kOrange = Color(0xfff55631);
  static const kLightBlue = Color(0xff3663e3);
  static const kDarkBlue = Color(0xff1c153e);
  static const kLightPurple = Color(0xff6352c5);
  static const kDarkPurple = Color(0xff6352c5);

  String theId = "";

  String kDefaultImage = 'https://firebasestorage.googleapis'
      '.com/v0/b/fir-test-project-5.appspot.com/o/default_user.png?alt=media&'
      'token=6a260559-82da-4b43-89eb-5d80b4801e1d&_gl=1*50wf4w*_ga*MTIwMDc0ODU2'
      'Mi4xNjgzMTUxNzAw*_ga_CW55HF8NVT*MTY4NjI0ODgyNy40MS4xLjE2ODYyNDk2MzUuMC4wL'
      'jA.';

  Map<String, dynamic> job = {
    "_id": "645b8db2cddb17870c7ece99",
    "title": "Python Developer",
    "location": "Madrid (Remote)",
    "company": "Meta",
    "hiring": true,
    "description":
        "A senior product designer at Facebook provides UX/UI design support while understanding user-centered design principles and best practices, and the importance of enforcing this for a brand1. They work with a whole project management team to identify opportunities that would generate more revenue resources by analyzing public demands on industry trends2. They handle the allocation of materials and must be able to utilize digital tools and equipment to create content for brand awareness on different media platforms2. Facebook’s product design team works alongside product management and engineering, and they carry equal weight in decision making",
    "salary": "10k",
    "period": "monthly",
    "contract": "Full-Time",
    "requirements": [
      "Masters degree in design or related field Experience working in an Agile/Scrum development process",
      "Masters degree in design or related field Experience working in an Agile/Scrum development process",
      "Masters degree in design or related field Experience working in an Agile/Scrum development process",
      "Masters degree in design or related field Experience working in an Agile/Scrum development process",
      "Masters degree in design or related field Experience working in an Agile/Scrum development process"
    ],
    "imageUrl":
        "https://store-images.s-microsoft.com/image/apps.37935.9007199266245907.b029bd80-381a-4869-854f-bac6f359c5c9.91f8693c-c75b-4050-a796-63e1314d18c9",
    "updatedAt": "2023-05-10T12:27:30.201Z",
    "agentName": "Dr Dre"
  };

  Map<String, dynamic> userData = {
    "_id": "6506255d7ebce30f7a3b1797",
    "username": "Churchill",
    "location": "Churchill",
    "phone": "0123456789",
    "email": "churchill@dbestech.com",
    "uid": "M66BoxHyoBVZf0ohmUSJH9wvj3f2",
    "updated": false,
    "isAdmin": false,
    "isAgent": true,
    "skills": [false],
    "profile":
        "https://scontent.fadb2-1.fna.fbcdn.net/v/t1.6435-9/140319041_1151557678629753_2291501919177660954_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=2a1932&_nc_ohc=T2QJqYkkPRgQ7kNvgHsLI4S&_nc_ht=scontent.fadb2-1.fna&oh=00_AYBRElgwMN-YodYyFS0lXI-7U-xdbXMf8k03OUswJNWM3Q&oe=66F3EBFF",
    "updatedAt": "2023-09-16T15:55:23.004Z",
    "userToken":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1MDYyNTVkN2ViY2UzMGY3YTNiMTc5NyIsImlzQWRtaW4iOmZhbHNlLCJpc0FnZW50Ijp0cnVlLCJpYXQiOjE2OTk5NTI5OTAsImV4cCI6MTcwMTc2NzM5MH0.kWbkh5VJdDWDEAtTTnpoLQxkC_twIZyniMeoAcMpAz8"
  };

  List<String> requirements = [
    "Design and Build sophisticated and highly scalable apps using Flutter.",
    "Build custom packages in Flutter using the functionalities and APIs already available in native Android and IOS.",
    "Translate and Build the designs and Wireframes into high quality responsive UI code.",
    "Explore feasible architectures for implementing new features.",
    "Resolve any problems existing in the system and suggest and add new features in the complete system.",
    "Suggest space and time efficient Data Structures.",
  ];

  String desc =
      "Flutter Developer is responsible for running and designing product application features across multiple devices across platforms. Flutter is Google's UI toolkit for building beautiful, natively compiled apps for mobile, web, and desktop from a single codebase. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";

  List<String> skills = [
    "Node JS",
    "Java SpringBoot",
    "Flutter and Dart",
    "Firebase",
    "AWS",
  ];
  List<String> profile = [];
}
