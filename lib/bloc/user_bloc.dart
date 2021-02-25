import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tayangin_flutter/models/models.dart';
import 'package:tayangin_flutter/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // kalo dia load user, maka akan ambil data dari firestore
    if (event is LoadUser) {
      UserApp user = await UserServices.getUser(event.id);

      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      UserApp updatedUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.profileImage);
      await UserServices.updateUser(updatedUser);
      yield UserLoaded(updatedUser);
    } else if (event is TopUp) {
      if (state is UserLoaded) {
        try {
          UserApp updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance + event.amount);

          await UserServices.updateUser(updatedUser);
          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      if (state is UserLoaded) {
        try {
          UserApp updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance - event.amount);

          await UserServices.updateUser(updatedUser);
          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
