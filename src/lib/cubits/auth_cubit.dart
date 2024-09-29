
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_cubit_app/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
	final User user;
	AuthSuccess({required this.user});
}

class AuthFailure extends AuthState {
	final String message;
	AuthFailure({required this.message});
}

class AuthLoggedOut extends AuthState {}

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		emit(AuthLoading());
		// Simulate network call
		await Future.delayed(Duration(seconds: 1));
		if (email == 'test@example.com' && password == 'password123') {
			emit(AuthSuccess(user: User(email: email, id: '123')));
		} else {
			emit(AuthFailure(message: 'Invalid credentials'));
		}
	}

	void logout() {
		emit(AuthLoggedOut());
	}
}
