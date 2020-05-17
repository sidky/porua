import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:porua/repository/authrepository.dart';
import 'package:porua/ui/auth_widget.dart';
import 'package:porua/ui/feed_widget.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _checkNextScreen(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(
          fit: BoxFit.cover,
            image: AssetImage("assets/splash.jpg"))),
      ),
    );
  }

  Future<void> _checkNextScreen(BuildContext context) {
    AuthRepository authRepository = GetIt.I.get();

    authRepository.initialize().then((value) {
      print("Initialized");

      if (authRepository.isAuthenticated()) {
        print("authenticated");
        Navigator.push(context, MaterialPageRoute(builder: (context) => FeedWidget()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AuthWidget()));
      }
    });
  }
}