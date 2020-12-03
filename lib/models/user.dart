class LoginUser {
  final String uid;
  LoginUser({this.uid});
}

class PersonData {
  final String adderId;
  final String firstName;
  final String lastName;
  final String personId;
  final String personOccupation;

  PersonData(
      {this.adderId,
      this.firstName,
      this.lastName,
      this.personId,
      this.personOccupation});
}
