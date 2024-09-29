
// test/widgets/logout_button_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:com.example.simple_cubit_app/widgets/logout_button.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_cubit.dart';

// Mock AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});
		
		testWidgets('LogoutButton displays correct text', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>.value(
							value: mockAuthCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('LogoutButton triggers logout event when pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>.value(
							value: mockAuthCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
