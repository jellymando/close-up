class Account {
  final String id;
  final String email;
  final String? nickname;
  final String? profileImageUrl;

  Account({
    required this.id,
    required this.email,
    required this.nickname,
    required this.profileImageUrl,
  });

  Account.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email'],
        nickname = map['nickname'],
        profileImageUrl = map['profileImageUrl'];
}
