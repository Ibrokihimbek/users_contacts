import 'package:local_db/local/cached_user.dart';
import 'package:local_db/local/local_database.dart';
class ContactRepository {
  static final ContactRepository _instance = ContactRepository._();

  factory ContactRepository() {
    return _instance;
  }

  ContactRepository._();

  /// Fetch data From Local DB
  Future<CachedUser> insertUser(CachedUser cachedUser) =>
      LocalDatabase.insertCachedUser(cachedUser);

  /// Delete user
  Future<int> deleteUSer(int id) => LocalDatabase.deleteCachedUserById(id);

  /// Get all user
  Future<List<CachedUser>> getAllUsers() => LocalDatabase.getAllCachedUsers();

  /// Update user
  Future<CachedUser> updateUser(CachedUser cachedUser) =>
      LocalDatabase.updateCachedUser(cachedUser);
}
