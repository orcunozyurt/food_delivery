part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends SignUpEvent {
  final MyUser user;
  final String password;

  const SignUpRequested({
    required this.user,
    required this.password,
  });

  @override
  List<Object> get props => [user, password];
}
