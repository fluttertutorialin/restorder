import 'package:restorder/models/contact/contact_response.dart';

class ContactViewModel {
  List<ContactResponse> contactItems;
  ContactViewModel({this.contactItems});

  getContacts() =>
      <ContactResponse>[
        ContactResponse(
          name: 'Flutter Tutorial',
          address: 'Address',
          mobile: '0000000000',
          websiteName: 'https://fluttertutorial.in',
        )
      ];
}
