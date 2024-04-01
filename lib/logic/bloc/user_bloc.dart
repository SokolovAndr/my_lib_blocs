import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lib_blocs/data/repository/user_repository.dart';

import '../../data/model/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserInitialState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        final users = await _userRepository.getUsers();
        emit(UserSucessState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
