//model class
class Info {
  int? id;
  int? phone;
  String? name;
  String? email;
  String? location;

  //constructor
  Info({
    this.id,
    this.phone,
    this.email,
    this.location,
    this.name,
  });


  //for saving data to db
  //name must be same as table name in db
  Map<String, dynamic> toMap() {
    return {
      'student_id':id,
      'student_name': name,
      'phone':phone,
      'email':email,
      'location':location,
    };
  }

  //for retrieving data from db
  static Info fromMap(Map<String, dynamic> map) {
    return Info(
      id: map['student_id'],
      name: map['student_name'],
      phone: map['phone'],
      email: map['email'],
      location: map['location'],
    );
  }
}