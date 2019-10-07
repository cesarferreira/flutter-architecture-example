import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  final userBloc = UserBloc(
      userRepo: UserRepository(prefs: await SharedPreferences.getInstance()));

//  var isLoggedIn = await userBloc.isLoggedIn();
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
        home: Home(),
      )));
}

class UserRepository {
  SharedPreferences prefs;

  UserRepository({this.prefs});

  static const String _IS_LOGGED_IN = "is_logged_in";
  static const String _NAME = "name";

  login(String name) async {
    await prefs.setBool(_IS_LOGGED_IN, true);
    await prefs.setString(_NAME, name);
  }

  Future<bool> isLoggedIn() async {
    return prefs.containsKey(_IS_LOGGED_IN);
  }

  Future<String> getName() async {
    return prefs.getString(_NAME);
  }

  logout() async {
    prefs.clear();
  }
}

class UserBloc extends ChangeNotifier {
  final UserRepository userRepo;

  UserBloc({@required this.userRepo});

  String name;
  bool isLoggedIn;

  init() async {
    await refreshAllStates();
  }

  refreshAllStates() async {
    isLoggedIn = await userRepo.isLoggedIn();
    name = await userRepo.getName();
  }

  login() async {
    await userRepo.login("John doe");
    await refreshAllStates();
    notifyListeners();
  }

  logout() async {
    await userRepo.logout();
    await refreshAllStates();
    notifyListeners();
  }
}

class Home extends StatelessWidget {
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
