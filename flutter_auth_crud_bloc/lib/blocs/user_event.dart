part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoad extends UserEvent {}

class UserAdd extends UserEvent {
  final User user;

  const UserAdd(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User Added {user: $user}';
}

class UserUpdate extends UserEvent {
  final User user;

  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User Updated {user: $user}';
}

class UserDelete extends UserEvent {
  final int id;

  const UserDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'User Deleted {id: $id}';
}
