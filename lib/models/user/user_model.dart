import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../entities/user/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String email;

  const UserModel({@required this.email, this.id});

  @override
  List<Object> get props => [id, email];

  @override
  String toString() => 'UserModel {id: $id, email: $email}';

  factory UserModel.fromEntity(UserEntity entity) =>
      UserModel(email: entity.email, id: entity.id);

  UserEntity toEntity() => UserEntity(email: email, id: id);
}
