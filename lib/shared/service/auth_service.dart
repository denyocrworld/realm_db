import 'package:realm/realm.dart';
import 'package:realm_db/shared/service/realm_service.dart';

class AuthService {
  User? _currentUser;
  User? get currentUser {
    _currentUser ??= RealmService.app.currentUser;
    return _currentUser;
  }

  static AuthService get instance {
    return AuthService();
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _currentUser = await RealmService.app.logIn(
        Credentials.emailPassword(email, password),
      );

      return true;
    } on Exception catch (err) {
      print("$err");
      return false;
    }
  }

  Future logout() async {
    await RealmService.app.currentUser?.logOut();
  }

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = RealmService.app.currentUser != null;
    return isLoggedIn;
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      EmailPasswordAuthProvider authProvider =
          EmailPasswordAuthProvider(RealmService.app);
      await authProvider.registerUser(email, password);
      return true;
    } on Exception catch (err) {
      print("$err");
      return false;
    }
  }
}

example() async {
  await AuthService.instance.login(
    email: "admin@demo.com",
    password: "123456",
  );

  await AuthService.instance.isLoggedIn();
  await AuthService.instance.logout();

  await AuthService.instance.register(
    email: "admin@demo.com",
    password: "123456",
  );
}
