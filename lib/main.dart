import 'package:flutter/material.dart';
import 'package:flutter_architecture/user.repository.dart';
import 'package:flutter_architecture/user.viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.screen.dart';
import 'user.viewmodel.dart';

main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  final userViewModel = UserViewModel(
      userRepo: UserRepository(prefs: await SharedPreferences.getInstance()));

  await userViewModel.init();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>.value(value: userViewModel),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      )));
}
