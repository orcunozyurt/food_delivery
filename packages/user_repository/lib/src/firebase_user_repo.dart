import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user async* {
    await for (final firebaseUser in _firebaseAuth.authStateChanges()) {
      if (firebaseUser == null) {
        yield MyUser.empty;
      } else {
        final userDoc = await usersCollection.doc(firebaseUser.uid).get();
        yield MyUser.fromEntity(MyUserEntity.fromDocument(userDoc.data()!));
      }
    }
  }

  @override
  Future<MyUser> signup(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );
      myUser.userId = user.user!.uid;
      return myUser;

    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async{
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setUser(MyUser myUser) async{
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      rethrow;
    }
  }

}
