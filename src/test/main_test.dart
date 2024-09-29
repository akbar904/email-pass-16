
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myapp/main.dart';
import 'package:myapp/cubits/auth_cubit.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('MainApp', () {
		testWidgets('renders LoginScreen initially', (WidgetTester tester) async {
			await tester.pumpWidget(MainApp());
			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('navigates to HomeScreen on successful login', (WidgetTester tester) async {
			final authCubit = MockAuthCubit();
			whenListen(authCubit, Stream.fromIterable([AuthState.success()]));

			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: authCubit,
					child: MainApp(),
				),
			);

			await tester.pumpAndSettle();

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});
}
