# flutter_firebase_auth

This project demonstrates how to integrate Firebase Authentication into a Flutter application. It includes features such as user registration, login, and logout using Firebase's authentication services.

## Installation

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Install Firebase using the following command:

   ```sh
   flutter pub add firebase_auth
   ```

   ```sh
   dart pub global activate flutterfire_cli
   ```

3. Link the Flutter project to your Firebase project:
   ```sh
   flutterfire configure --project=[FIREBASE-PROJECT-ID]
   ```
4. Enable authentication using the Email/Password method in the Firebase console.

## Initialize Firebase in the App

To use Firebase in the project, initialize it in `main()`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_auth/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}
```

## Authentication Service

This project includes an authentication service (`auth_service.dart`) that handles user registration, login, and logout.

```dart
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}
```

## Create a New Account

Use `createUserWithEmailAndPassword()` to create a new user with email and password:

```dart
final FirebaseAuth _auth = FirebaseAuth.instance;

UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  email: email,
  password: password,
);
```

## Login an Existing User

Use `signInWithEmailAndPassword()` to log in a user:

```dart
final FirebaseAuth _auth = FirebaseAuth.instance;

UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  email: email,
  password: password,
);
```

## Logout a User

Use the `signout()` function from `auth_service.dart` to log out the user:

```dart
final AuthService _authService = AuthService();
await _authService.signout();
```
