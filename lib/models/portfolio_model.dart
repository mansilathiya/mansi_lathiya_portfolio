import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String description;
  final List<String> tags;
  final String icon;
  final String platform;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? websiteUrl;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    required this.platform,
    this.playStoreUrl,
    this.appStoreUrl,
    this.websiteUrl,
  });
}

class ExperienceModel {
  final String company;
  final String? role;
  final String duration;
  final String location;
  final List<String>? responsibilitiesList;

  const ExperienceModel({
    required this.company,
    this.role,
    required this.duration,
    required this.location,
    this.responsibilitiesList,
  });
}

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class StoreLinkData {
  final IconData icon;
  final String label, url;
  final Color color;

  const StoreLinkData(this.icon, this.label, this.color, this.url);
}
