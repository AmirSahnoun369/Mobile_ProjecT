import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_auth_crud_bloc/blocs/authentication_bloc.dart';
import 'package:flutter_auth_crud_bloc/data/user_repository.dart';
import 'package:flutter_auth_crud_bloc/screens/auth_screen.dart';

void main() {
  UserRepository userRepository = UserRepository();
  AuthenticationBloc authenticationBloc =
      AuthenticationBloc(userRepository: userRepository);

  runApp(MyApp(
    authenticationBloc: authenticationBloc,
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  MyApp({required this.authenticationBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth CRUD Bloc',
      home: BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
        child: AuthScreen(
          userRepository: UserRepository(),
        ),
      ),
    );
  }
}
