import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authProvider = Provider<FirebaseAuth>(
  (ref) {
    return FirebaseAuth.instance;
  },
);

final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) {
    return FirebaseFirestore.instance;
  },
);

final storageProvider = Provider<FirebaseStorage>(
  (ref) {
    return FirebaseStorage.instance;
  },
);

final googleSignInProvider = Provider(
  (ref) {
    return GoogleSignIn();
  },
);
