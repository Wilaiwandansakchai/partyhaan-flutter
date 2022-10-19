part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final SignupStatus status;

  const SignupState(
      {required this.email, required this.password, required this.status});

  factory SignupState.initial() {
    return const SignupState(
        email: '', password: '', status: SignupStatus.initial);
  }

  @override
  List<Object?> get props => [email, password, status];

  SignupState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
  }) {
    return SignupState(
        email: email ?? this.email,
        password: password ?? this.email,
        status: status ?? this.status);
  }
}
