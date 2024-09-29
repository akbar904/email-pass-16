
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_cubit_app/models/user_model.dart';

void main() {
	group('User Model Tests', () {
		test('User model should correctly instantiate with given parameters', () {
			final user = User(email: 'test@example.com', id: '123');
			expect(user.email, 'test@example.com');
			expect(user.id, '123');
		});

		test('User model should correctly serialize to JSON', () {
			final user = User(email: 'test@example.com', id: '123');
			final json = user.toJson();
			expect(json['email'], 'test@example.com');
			expect(json['id'], '123');
		});

		test('User model should correctly deserialize from JSON', () {
			final json = {'email': 'test@example.com', 'id': '123'};
			final user = User.fromJson(json);
			expect(user.email, 'test@example.com');
			expect(user.id, '123');
		});
	});
}
