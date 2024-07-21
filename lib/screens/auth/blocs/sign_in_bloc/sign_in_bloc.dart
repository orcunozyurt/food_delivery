import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc(
      this._userRepository,
      ) : super(SignInInitial()) {

    on<SignInRequested>((event, emit) async {
      try {
        emit(SignInLoading());
        await _userRepository.login(event.email, event.password);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure(error: e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async{
      await _userRepository.logout();
    });

  }
}
