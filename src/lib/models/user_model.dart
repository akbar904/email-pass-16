
import 'dart:convert';

class User {
	final String email;
	final String id;

	User({required this.email, required this.id});

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			email: json['email'],
			id: json['id'],
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'email': email,
			'id': id,
		};
	}
}
