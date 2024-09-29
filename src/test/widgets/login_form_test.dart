
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/widgets/login_form.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthState());
  });

  group('LoginForm Widget Tests', () {
    late MockAuthCubit mockAuthCubit;

    setUp(() {
      mockAuthCubit = MockAuthCubit();
    });

    testWidgets('should find email and password TextFields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<AuthCubit>.value(
              value: mockAuthCubit,
              child: LoginForm(),
            ),
          ),
        ),
      );

      expect(find.byKey(Key('emailField')), findsOneWidget);
      expect(find.byKey(Key('passwordField')), findsOneWidget);
    });

    testWidgets('should find login button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<AuthCubit>.value(
              value: mockAuthCubit,
              child: LoginForm(),
            ),
          ),
        ),
      );

      expect(find.byKey(Key('loginButton')), findsOneWidget);
    });

    testWidgets('should show CircularProgressIndicator when loading', (WidgetTester tester) async {
      when(() => mockAuthCubit.state).thenReturn(AuthState.loading());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<AuthCubit>.value(
              value: mockAuthCubit,
              child: LoginForm(),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message on error state', (WidgetTester tester) async {
      const errorMessage = 'Login failed';
      when(() => mockAuthCubit.state).thenReturn(AuthState.error(errorMessage));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<AuthCubit>.value(
              value: mockAuthCubit,
              child: LoginForm(),
            ),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should call login on AuthCubit when login button is pressed', (WidgetTester tester) async {
      when(() => mockAuthCubit.state).thenReturn(AuthState.initial());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<AuthCubit>.value(
              value: mockAuthCubit,
              child: LoginForm(),
            ),
          ),
        ),
      );

      await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
      await tester.enterText(find.byKey(Key('passwordField')), 'password');
      await tester.tap(find.byKey(Key('loginButton')));

      verify(() => mockAuthCubit.login('test@example.com', 'password')).called(1);
    });
  });
}
