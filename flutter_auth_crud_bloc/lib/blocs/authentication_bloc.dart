import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_auth_crud_bloc/models/user_model.dart';
import 'package:flutter_auth_crud_bloc/data/user_repository.dart';

class AuthenticationState {
  final bool isAuthenticated;

  AuthenticationState({required this.isAuthenticated});
}

class AuthenticationBloc extends Bloc<Object?, AuthenticationState> {
  final _userController = StreamController<User>.broadcast();
  UserRepository _userRepository;

  AuthenticationBloc(
    super.initialState, {
    required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  Stream<User> get user => _userController.stream;

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    // perform validation
    // ...

    // create new user
    final user = User(name: name, email: email, password: password, id: null);

    // add user to database
    await _userRepository.addUser(user);

    // update user stream
    _userController.add(user);
  }

  Future<void> logIn({required String email, required String password}) async {
    // perform validation
    // ...

    // get user from database
    final List<User> users = await _userRepository.getUsers();
    final user = users.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => throw Exception('Incorrect email or password'),
    );

    // check if user was found
    if (user == null) {
      throw Exception('Incorrect email or password');
    }

    // update user stream
    _userController.add(user);
  }

  void logOut() {
    // create a new user object to represent a logged-out state
    final loggedOutUser = User(name: '', email: '', password: '');

    // add the user to the stream
    _userController.add(loggedOutUser);
  }

  void dispose() {
    _userController.close();
  }
}
