
// lib/widgets/logout_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ElevatedButton(
			onPressed: () {
				BlocProvider.of<AuthCubit>(context).logout();
			},
			child: Text('Logout'),
		);
	}
}
