import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../constants/paths.dart';
import '../../entities/user/user_entity.dart';
import '../../models/user/user_model.dart';
import 'i_auth_repository.dart';

class AuthRepository extends IAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository(
      {@required FirebaseAuth firebaseAuth,
      @required FirebaseFirestore firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<UserModel> _firebaseUserToUser(User firebaseUser) async {
    final userDoc = await _firebaseFirestore
        .collection(Paths.users)
        .doc(firebaseUser.uid)
        .get();
    if (userDoc.exists) {
      final user = UserModel.fromEntity(UserEntity.fromDocument(userDoc));
      return user;
    }

    return UserModel(id: firebaseUser.uid, email: '');
  }

  @override
  Future<UserModel> loginAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _firebaseUserToUser(authResult.user);
  }

  @override
  Future<UserModel> loginWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _firebaseUserToUser(authResult.user);
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      String email, String password) async {
    final currentUser = _firebaseAuth.currentUser;
    // Link the current anonymous user with an email and password
    // account when they sign up
    final authCredential =
        EmailAuthProvider.credential(email: email, password: password);
    // Link the two accounts
    final authResult = await currentUser.linkWithCredential(authCredential);
    final user = await _firebaseUserToUser(authResult.user);
    final userModel = UserModel(email: user.email, id: user.id);

    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .set(userModel.toEntity().toDocument());
    return user;
  }

  @override
  Future<UserModel> logout() async {
    await _firebaseAuth.signOut();

    return loginAnonymously();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return null;
    }
    final user = await _firebaseUserToUser(currentUser);
    return user;
  }

  @override
  Future<bool> isAnonymous() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser.isAnonymous;
  }
}
