import 'package:flutter/material.dart';
import 'package:flutter_architecture/user.bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    return Scaffold(
      body: Container(
        color: userBloc.isLoggedIn ? Colors.greenAccent : Colors.yellow,
        child: Stack(children: [
          Center(
              child: Text(
            userBloc.isLoggedIn ? "Welcome ${userBloc.name}" : 'NOT LOGGED IN',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(40),
              child: RaisedButton(
                color:
                    !userBloc.isLoggedIn ? Colors.greenAccent : Colors.yellow,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Text(
                  userBloc.isLoggedIn ? 'LOGOUT' : 'LOGIN',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  userBloc.isLoggedIn
                      ? await userBloc.logout()
                      : await userBloc.login();
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
