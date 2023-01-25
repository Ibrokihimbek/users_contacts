import 'package:equatable/equatable.dart';
import 'package:user_contacts/data/local/cached_user.dart';

class UserSingleState extends Equatable {
  final List<CachedUser> cachedUser;
  const UserSingleState({required this.cachedUser});

  UserSingleState copyWith({List<CachedUser>? cachedUser}) =>
      UserSingleState(cachedUser: cachedUser ?? this.cachedUser);

  @override
  List<Object?> get props => [
        CachedUser,
      ];
}
