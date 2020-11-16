import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NoteEntity extends Equatable {
  final String id;
  final String userId;
  final String content;
  final String color;
  final Timestamp timestamp;

  const NoteEntity({
    @required this.userId,
    @required this.content,
    @required this.color,
    @required this.timestamp,
    this.id,
  });
  @override
  List<Object> get props => [id, userId, content, color, timestamp];

  @override
  String toString() => '''NoteEntity {id: $id, userId: $userId, color: $color, content: $content, timestamp: $timestamp}''';

  factory NoteEntity.fromDocument({@required DocumentSnapshot doc}) =>
      NoteEntity(
          id: doc.id,
          userId: doc.data()['userId'].toString() ?? '',
          color: doc.data()['color'].toString() ?? '#ffffff',
          content: doc.data()['content'].toString() ?? '',
          timestamp: doc.data()['timestamp'] as Timestamp);

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'userId': userId,
        'color': color,
        'content': content,
        'timestamp': timestamp
      };
}
