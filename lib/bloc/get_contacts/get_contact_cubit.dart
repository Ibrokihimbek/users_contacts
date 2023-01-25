import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_contacts/bloc/add_contact_cubit/add_contact_state.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_state.dart';
import 'package:user_contacts/data/local/cached_user.dart';
import 'package:user_contacts/data/repository/contact_repo.dart';

class GetContactCubit extends Cubit<UserSingleState> {
  final ContactRepository contactRepository;
  GetContactCubit({required this.contactRepository})
      : super(const UserSingleState(cachedUser: [])) {
    _fetchAllContacts();
  }

  List<CachedUser> cachedUserContact = [];

  _fetchAllContacts() async {
    cachedUserContact = await contactRepository.getAllUsers();
    emit(
      state.copyWith(cachedUser: cachedUserContact as List<CachedUser>),
    );
  }
}
