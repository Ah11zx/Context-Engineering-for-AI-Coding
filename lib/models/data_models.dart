import 'package:flutter/material.dart';

enum TemplateCategory { image, video, audio }

String templateCategoryLabel(TemplateCategory category) {
  switch (category) {
    case TemplateCategory.image:
      return 'قالب صور';
    case TemplateCategory.video:
      return 'قالب فيديو';
    case TemplateCategory.audio:
      return 'قالب صوتي';
  }
}

class Reminder {
  Reminder({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
  });

  final String title;
  final String description;
  final DateTime dateTime;
  bool isCompleted;
}

class Note {
  Note({
    required this.title,
    required this.content,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String title;
  final String content;
  final DateTime createdAt;
}

class MealPlan {
  MealPlan({
    required this.day,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    this.snack,
  });

  final String day;
  final String breakfast;
  final String lunch;
  final String dinner;
  final String? snack;
}

class WorkoutRoutine {
  WorkoutRoutine({
    required this.name,
    required this.focusArea,
    required this.duration,
    required this.description,
    this.completed = false,
  });

  final String name;
  final String focusArea;
  final String duration;
  final String description;
  bool completed;
}

class TrainerTip {
  const TrainerTip({required this.title, required this.detail, this.icon});

  final String title;
  final String detail;
  final IconData? icon;
}

class TemplateAsset {
  const TemplateAsset({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.accentColor,
    required this.icon,
    required this.aspectRatio,
  });

  final String id;
  final String name;
  final TemplateCategory category;
  final String description;
  final Color accentColor;
  final IconData icon;
  final double aspectRatio;
}

class GeneratedContent {
  const GeneratedContent({
    required this.title,
    required this.category,
    required this.prompt,
    required this.timestamp,
  });

  final String title;
  final TemplateCategory category;
  final String prompt;
  final DateTime timestamp;
}
