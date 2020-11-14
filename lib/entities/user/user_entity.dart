import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;

  const UserEntity({@required this.email, this.id});

  @override
  List<Object> get props => [id, email];

  @override
  String toString() => 'UserEntity {id: $id, email: $email}';

  factory UserEntity.fromDocument(DocumentSnapshot doc) => UserEntity(
      email: doc.data()['email'] as String, id: doc.data()['id'] as String);

  Map<String, dynamic> toDocument() => <String, String>{'email': email};
}
