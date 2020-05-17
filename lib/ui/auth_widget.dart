import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:porua/repository/authrepository.dart';
import 'package:porua/repository/model/apierror.dart';

class AuthWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthState();
}

class _AuthState extends State<AuthWidget> {
  bool _busy = false;
  String _error = null;

  final TextEditingController _emailTextEditController = TextEditingController();
  final TextEditingController _passwordTextEditController = TextEditingController();

  _AuthState() {
    _emailTextEditController.addListener(() {
      if (this._error != null) {
        this.setState(() {
          this._error = null;
        });
      }
    });

    _passwordTextEditController.addListener(() {
      if (this._error != null) {
        this.setState(() {
          this._error = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Email"
                        ),
                        controller: _emailTextEditController,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password"
                        ),
                        controller: _passwordTextEditController,
                      ),
                      Visibility(
                        visible: _error != null,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(_error ?? "",
                            style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _busy,
                        child: Padding(padding: const EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color.fromARGB(255, 0, 0, 255), width: 2.0),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text("Login"),
                        onPressed: () {
                          this._tryToAuthenticate();
                        },
                      ),
                    ])
            )
        )
    ));
  }

  void _tryToAuthenticate() {
    setState(() {
      this._busy = true;
      this._error = null;
    });
    AuthRepository authRepository = GetIt.I.get();
    authRepository.authenticate(_emailTextEditController.text,
        _passwordTextEditController.text)
        .then((authenticated) {
      print("Authenticated: $authenticated}");
      setState(() {
        this._busy = false;
        this._error = null;
      });
    }).catchError((Object error) {
      print("Error: $error");
      setState(() {
        this._busy = false;
        if (error is ApiError) {
          print("ApiError: status: ${error.status}");
          this._error = error.message;
        }
      });
      return null;
    });
  }

}