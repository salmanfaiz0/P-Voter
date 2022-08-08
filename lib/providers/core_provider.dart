import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  bool isLoading = false;
  bool isSignedIn = false;
  bool isUpdatingUserDetails = false;

  UserProvider() {
    initializeUser();
  }

  initializeUser() async {
    isLoading = true;
    notifyListeners();
    final fbUser = auth.FirebaseAuth.instance.currentUser;
    if (fbUser == null) {
      isLoading = false;

      notifyListeners();
      return;
    } else {
      try {
        final user = await UserAPI.getUser(fbUser.uid);
        _currentUser = user;
        isSignedIn = true;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future fetchUser(String id) async {
    print('ID' + id);
    try {
      final user = await UserAPI.getUser(id);
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      print(e);
      clearUser();
      throw e;
    }

    notifyListeners();
  }

  Future updateUserDetails(User oldUser, User newUser) async {
    isUpdatingUserDetails = true;
    notifyListeners();
    try {
      await UserAPI.updateUserDetails(oldUser, newUser);
      _currentUser = newUser;
    } catch (e) {
      print(e);
      throw e;
    }
    isUpdatingUserDetails = false;
    notifyListeners();
  }

  void addRegistration(String id) {
    if (currentUser!.registeredEvents.contains(id)) {
      return;
    } else {
      currentUser!.registeredEvents.add(id);
      notifyListeners();
    }
  }

  Future googleLogin() async {
    try {
      final guser = await AuthAPI.signInWithGoogle();
      await fetchUser(guser.uid);
      isSignedIn = true;
      notifyListeners();
    } catch (e) {
      clearUser();
      print(e);
      throw e;
    }
  }

  Future emailLogin(String email, String password) async {
    try {
      final user = await AuthAPI.signInWithEmail(
        email,
        password,
      );
      if (user.user == null) {
        throw Exception(
            'Could not fetch your account details, try again later');
      }
      await fetchUser(user.user!.uid);
      isSignedIn = true;
      notifyListeners();
    } on Exception catch (e) {
      print(e);
      clearUser();
      throw e;
    }
  }

  Future createAccount(String email, String password, UserType userType) async {
    try {
      final user = await AuthAPI.signUpWithEmail(
        email,
        password,
      );
      if (user.user == null) {
        throw Exception('SOMETHING WENT WRONG, PLEASE TRY LATER');
      }
      final newuser = await UserAPI.registerUser(
        user.user!.uid,
        email,
        '',
        userType,
      );
      setUser(newuser);
      isSignedIn = true;
      notifyListeners();
    } on Exception catch (e) {
      print(e);
      clearUser();
      throw e;
    }
  }

  Future googleSignUp(UserType userType) async {
    try {
      final guser = await AuthAPI.signUpWithGoogle();
      final newuser = await UserAPI.registerUser(
        guser.uid,
        guser.email!,
        guser.displayName ?? '',
        userType,
      );
      setUser(newuser);
      isSignedIn = true;
      notifyListeners();
    } on Exception catch (e) {
      clearUser();
      print(e);
      throw e;
    }
  }

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  User? get currentUser => _currentUser;

  void clearUser() {
    AuthAPI.signOut();
    _currentUser = null;
    isSignedIn = false;
    notifyListeners();
  }
}
