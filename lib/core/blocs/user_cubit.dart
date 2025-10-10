import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clock_mate/core/blocs/user_state.dart';
import 'package:clock_mate/core/data/models/app_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> loggedUser(AppUser user) async {
    emit(UserLoading());
    try {
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
