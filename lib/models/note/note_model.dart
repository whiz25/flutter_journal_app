import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../entities/note/note_entity.dart';

class Note extends Equatable {
  final String id;
  final String userId;
  final String content;
  final Color color;
  final DateTime timestamp;

  const Note({
    @required this.userId,
    @required this.content,
    @required this.color,
    @required this.timestamp,
    this.id,
  });
  @override
  List<Object> get props => [id, userId, content, color, timestamp];

  @override
  String toString() =>
      'NoteModel {id:$id,userId:$userId,content:$content,color:$color,timestamp:$timestamp}';

  factory Note.fromEntity(NoteEntity entity) => Note(
      userId: entity.id,
      content: entity.content,
      color: HexColor(entity.color),
      timestamp: entity.timestamp.toDate());

  NoteEntity toEntity() => NoteEntity(
      id: id,
      userId: userId,
      content: content,
      color: '#${color.value.toRadixString(16)}',
      timestamp: Timestamp.fromDate(timestamp));

  Note copyWith(
          {String userId, String content, Color color, DateTime timestamp}) =>
      Note(
          userId: userId ?? this.userId,
          content: content ?? this.content,
          color: color ?? this.color,
          timestamp: timestamp ?? this.timestamp);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
