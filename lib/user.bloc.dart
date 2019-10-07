import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture/user.repository.dart';

class UserBloc extends ChangeNotifier {
  final UserRepository userRepo;

  UserBloc({@required this.userRepo});

  String name;
  bool isLoggedIn;

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() async {
    isLoggedIn = await userRepo.isLoggedIn();
    name = await userRepo.getName();
  }

  login() async {
    await userRepo.login("John doe");
    await _refreshAllStates();
    notifyListeners();
  }

  logout() async {
    await userRepo.logout();
    await _refreshAllStates();
    notifyListeners();
  }
}
