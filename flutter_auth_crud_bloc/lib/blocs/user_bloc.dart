import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_auth_crud_bloc/data/user_repository.dart';

import '../models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLoad) {
      yield* _mapUserLoadToState();
    } else if (event is UserAdd) {
      yield* _mapUserAddToState(event.user);
    } else if (event is UserUpdate) {
      yield* _mapUserUpdateToState(event.user);
    } else if (event is UserDelete) {
      yield* _mapUserDeleteToState(event.id);
    }
  }

  Stream<UserState> _mapUserLoadToState() async* {
    yield UserLoading();
    try {
      final users = await userRepository.getUsers();
      yield UserLoadSuccess(users);
    } catch (_) {
      yield UserOperationFailure();
    }
  }

  Stream<UserState> _mapUserAddToState(User user) async* {
    yield UserLoading();
    try {
      await userRepository.addUser(user);
      final users = await userRepository.getUsers();
      yield UserLoadSuccess(users);
    } catch (_) {
      yield UserOperationFailure();
    }
  }

  Stream<UserState> _mapUserUpdateToState(User user) async* {
    yield UserLoading();
    try {
      await userRepository.updateUser(user);
      final users = await userRepository.getUsers();
      yield UserLoadSuccess(users);
    } catch (_) {
      yield UserOperationFailure();
    }
  }

  Stream<UserState> _mapUserDeleteToState(int id) async* {
    yield UserLoading();
    try {
      await userRepository.deleteUser(id);
      final users = await userRepository.getUsers();
      yield UserLoadSuccess(users);
    } catch (_) {
      yield UserOperationFailure();
    }
  }
}

class LogoutEvent extends UserEvent {}
