import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm({
    String? email,
    String? password,
    String? username,
    bool? isLogin,
    BuildContext? ctx,
    File? image,
  }) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin!) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        final ref = FirebaseStorage.instance.ref().child('user_image').child(
              '${authResult.user!.uid}.jpg',
            );

        await ref.putFile(image!);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }
    } on FirebaseException catch (err) {
      var message = 'An error occurred, please check your credentionals!';

      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(ctx!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      // ignore: avoid_print
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitFn: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
