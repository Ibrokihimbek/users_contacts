import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_db/local/cached_user.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_state.dart';
import 'package:user_contacts/data/repository/contact_repo.dart';

class GetContactCubit extends Cubit<GetContactsState> {
  final ContactRepository contactRepository;

  GetContactCubit({required this.contactRepository})
      : super(GetContactsInitial());

  List<CachedUser> cachedUserContact = [];

  fetchAllContacts() async {
    emit(GetContactsInLoading());
    cachedUserContact = await contactRepository.getAllUsers();
    emit(GetContactsInSuccess(cachedUser: cachedUserContact));
  }
}
