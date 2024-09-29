
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/screens/login_screen.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';
import 'package:simple_cubit_app/widgets/login_form.dart';

// Mock classes
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('renders LoginForm widget', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LoginScreen(),
					),
				),
			);
			expect(find.byType(LoginForm), findsOneWidget);
		});

		testWidgets('displays login screen title', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LoginScreen(),
					),
				),
			);
			expect(find.text('Login Screen'), findsOneWidget);
		});
	});

	group('AuthCubit Login Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthState.loading, AuthState.success] when login is successful',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.login('email@example.com', 'password'),
			expect: () => [AuthState.loading(), AuthState.success()],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthState.loading, AuthState.failure] when login fails',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.login('email@example.com', 'wrong_password'),
			expect: () => [AuthState.loading(), AuthState.failure()],
		);
	});
}
