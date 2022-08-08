class User {
  final String userId;
  final String name;
  final int age;
  final String phoneNumber;
  User({
    required this.userId,
    required this.name,
    required this.age,
    this.phoneNumber = '',
  });

  static User fromJson(Map<String, dynamic> json) => User(
        userId: json['voter_id'],
        name: json['voter_name'],
        age: json['age'] ?? '',
        phoneNumber: json['mobile'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'age': age,
        'phoneNumber': phoneNumber,
      };
}
