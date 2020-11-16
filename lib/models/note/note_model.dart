import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../entities/note/note_entity.dart';

class NoteModel extends Equatable {
  final String id;
  final String userId;
  final String content;
  final String color;
  final DateTime timestamp;

  const NoteModel({
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

  NoteModel fromEntity(NoteEntity entity) => NoteModel(
      userId: entity.id,
      content: entity.content,
      color: entity.color,
      timestamp: entity.timestamp.toDate());

  NoteEntity toEntity() => NoteEntity(
      id: id,
      userId: userId,
      content: content,
      color: color,
      timestamp: Timestamp.fromDate(timestamp));

  NoteModel copyWith(
          {String userId, String content, String color, DateTime timestamp}) =>
      NoteModel(
          userId: userId ?? this.userId,
          content: content ?? this.content,
          color: color ?? this.color,
          timestamp: timestamp ?? this.timestamp);
}
