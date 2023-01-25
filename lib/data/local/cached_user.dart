const String userTable = "cached_user";

class CachedUsersFields {
  static final List<String> values = [
    /// Add all fields
    id, userName, phoneNumber,
  ];
  static const String id = "_id";
  static const String userName = "user_name";
  static const String phoneNumber = "phoneNumber";
}

class CachedUser {
  final int? id;
  final String phoneNumber;
  final String userName;

  CachedUser({
    this.id,
    required this.phoneNumber,
    required this.userName,
  });

  CachedUser copyWith({
    int? id,
    String? phoneNumber,
    String? userName,
  }) =>
      CachedUser(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  static CachedUser fromJson(Map<String, Object?> json) => CachedUser(
        id: json[CachedUsersFields.id] as int?,
        userName: json[CachedUsersFields.userName] as String,
        phoneNumber: json[CachedUsersFields.phoneNumber] as String,
      );

  Map<String, Object?> toJson() => {
        CachedUsersFields.id: id,
        CachedUsersFields.userName: userName,
        CachedUsersFields.phoneNumber: phoneNumber,
      };

  @override
  String toString() => '''
        ID: ${this.id} 
        USER NAME ${this.userName} 
        PHONE NUMBER ${this.phoneNumber} 
      ''';
}