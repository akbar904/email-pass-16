
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';

class LoginForm extends StatefulWidget {
	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return BlocListener<AuthCubit, AuthState>(
			listener: (context, state) {
				if (state is AuthStateError) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(content: Text(state.message)),
					);
				}
			},
			child: BlocBuilder<AuthCubit, AuthState>(
				builder: (context, state) {
					if (state is AuthStateLoading) {
						return Center(
							child: CircularProgressIndicator(),
						);
					}

					return Padding(
						padding: const EdgeInsets.all(16.0),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								TextField(
									key: Key('emailField'),
									controller: _emailController,
									decoration: InputDecoration(labelText: 'Email'),
								),
								TextField(
									key: Key('passwordField'),
									controller: _passwordController,
									decoration: InputDecoration(labelText: 'Password'),
									obscureText: true,
								),
								SizedBox(height: 16.0),
								ElevatedButton(
									key: Key('loginButton'),
									onPressed: () {
										final email = _emailController.text;
										final password = _passwordController.text;
										context.read<AuthCubit>().login(email, password);
									},
									child: Text('Login'),
								),
							],
						),
					);
				},
			),
		);
	}
}
