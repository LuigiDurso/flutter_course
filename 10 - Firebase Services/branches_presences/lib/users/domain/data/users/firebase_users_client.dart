import 'package:branches_presences/users/domain/data/users/users_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../models/user.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {

  const SignUpWithEmailAndPasswordFailure([
    this.message = 'Errore inaspettato.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email non valida.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'Utente disabilitato.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'Email esistente.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operazione non consentita.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Password debole.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {

  const LogInWithEmailAndPasswordFailure([
    this.message = 'Errore inaspettato.',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email non valida.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'Utente disabilitato.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email non trovata.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Password errata.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class UsersNotFoundFailure implements Exception {}

class UsersRequestFailure implements Exception {}

class LogOutFailure implements Exception {}

class FirebaseUsersClient implements UsersDataProvider {

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseUsersClient({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;


  User _fromFirestoreUserConverter(DocumentSnapshot<Map<String, dynamic>> userMap, SnapshotOptions? options) {
    return userMap.data() != null ?
    User.fromMap(userMap.data()!).copyWith(uid: userMap.id) : const User.empty();
  }

  Map<String, dynamic> _toFirestoreUserConverter(User user, SetOptions? options) {
    return user.isNotEmpty ? user.toMap() : {};
  }

  @override
  Future<User> getUserByEmail(String email) async {
    var result = await _firestore.collection("/users")
        .where("email", isEqualTo: email.toLowerCase())
        .withConverter<User>(
        fromFirestore:  _fromFirestoreUserConverter,
        toFirestore: _toFirestoreUserConverter
    ).get();
    if ( result.docs.isEmpty ) {
      throw UsersNotFoundFailure();
    }
    return result.docs.first.data();
  }

  @override
  Future<void> authenticate(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> signUp( String email, String password ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<User> updateUser(
      String id, String name, String email, String imagePath, String about,
      ) async {
    await _firestore.collection("/users").doc(id)
        .withConverter<User>(
        fromFirestore:  _fromFirestoreUserConverter,
        toFirestore: _toFirestoreUserConverter
    ).update({
      "name": name,
      "email": email,
      "imagePath": imagePath,
      "about": about,
    });
    return await getUserByEmail(email);
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}
