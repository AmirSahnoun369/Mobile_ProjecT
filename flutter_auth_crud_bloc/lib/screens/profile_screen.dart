import 'package:flutter/material.dart';
import 'package:flutter_auth_crud_bloc/blocs/user_bloc.dart';
import '../models/user_model.dart';
import 'package:flutter_auth_crud_bloc/screens/auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  final UserBloc userBloc;

  ProfileScreen({required this.user, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Name: ${user.name}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: () {
                userBloc.add(LogoutEvent());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AuthScreen(userRepository: userBloc.userRepository),
                  ),
                );
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
