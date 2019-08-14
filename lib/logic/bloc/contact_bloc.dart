import 'dart:async';

import 'package:restorder/logic/viewmodel/contact_view_model.dart';
import 'package:restorder/models/contact/contact_response.dart';

class ContactBloc {
  final _contactVM = ContactViewModel();
  final contactController = StreamController<List<ContactResponse>>();

  Stream<List<ContactResponse>> get contactItems => contactController.stream;

  ContactBloc() {
    contactController.add(_contactVM.getContacts());
  }
}
