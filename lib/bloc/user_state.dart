part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final UserApp user;

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}
