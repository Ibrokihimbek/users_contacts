import 'package:local_db/local/cached_user.dart';

abstract class GetContactsState {}

class GetContactsInitial extends GetContactsState {}

class GetContactsInLoading extends GetContactsState {}

class GetContactsInSuccess extends GetContactsState {
  GetContactsInSuccess({required this.cachedUser});

  final List<CachedUser> cachedUser;
}
