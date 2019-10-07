import 'package:flutter/material.dart';
import 'package:flutter_architecture/user.bloc.dart';
import 'package:flutter_architecture/user.repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.screen.dart';
import 'user.bloc.dart';

main() async {
  final userBloc = UserBloc(
      userRepo: UserRepository(prefs: await SharedPreferences.getInstance()));

  await userBloc.init();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserBloc>.value(value: userBloc),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      )));
}
