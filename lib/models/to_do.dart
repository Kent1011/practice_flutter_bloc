import 'package:flutter/material.dart';

@immutable
class ToDo {
  final String id;
  final String name;
  final bool isFinished;

  ToDo(this.id, this.name, this.isFinished);

  ToDo copyWith({
    String id,
    String name,
    bool isFinished,
  }) {
    return ToDo(
      id ?? this.id,
      name ?? this.name,
      isFinished ?? this.isFinished,
    );
  }
}
