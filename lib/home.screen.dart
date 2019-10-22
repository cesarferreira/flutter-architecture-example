import 'package:flutter/material.dart';
import 'package:flutter_architecture/user.viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Container(
        color: userViewModel.isLoggedIn ? Colors.greenAccent : Colors.yellow,
        child: Stack(children: [
          Center(
              child: Text(
            userViewModel.isLoggedIn
                ? "Welcome ${userViewModel.name}"
                : 'NOT LOGGED IN',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(40),
              child: RaisedButton(
                color: !userViewModel.isLoggedIn
                    ? Colors.greenAccent
                    : Colors.yellow,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Text(
                  userViewModel.isLoggedIn ? 'LOGOUT' : 'LOGIN',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  userViewModel.isLoggedIn
                      ? await userViewModel.logout()
                      : await userViewModel.login();
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
