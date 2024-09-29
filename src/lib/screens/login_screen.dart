
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';
import 'package:simple_cubit_app/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Login Screen'),
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: BlocProvider(
					create: (context) => AuthCubit(),
					child: LoginForm(),
				),
			),
		);
	}
}
