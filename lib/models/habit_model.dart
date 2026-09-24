import 'package:flutter/material.dart';

class HabitModel {
  final IconData icon;

  final String title;

  final String subtitle;

  final String notes;

  final String category;

  final String startTime;

  final String endTime;

  final String duration;

  final String target;

  final String repeat;

  final bool reminderEnabled;

  /// TAMBAHAN
  final DateTime date;

  bool completed;

  final DateTime createdAt;

  HabitModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.notes,
    required this.category,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.target,
    required this.repeat,
    required this.reminderEnabled,
    required this.date,
    this.completed = false,
    required this.createdAt,
  });

  HabitModel copyWith({
    bool? completed,
    DateTime? createdAt,
  }) {
    return HabitModel(
      icon: icon,
      title: title,
      subtitle: subtitle,
      notes: notes,
      category: category,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      target: target,
      repeat: repeat,
      reminderEnabled: reminderEnabled,
      date: date,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
