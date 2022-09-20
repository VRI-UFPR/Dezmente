class SignUpData {
  int age;
  String gender;
  String city;
  String school;
  bool active;
  bool healthIssue;
  bool medic;
  int physHours;
  bool hasMonitor;
  int monAge;
  Map<String, bool>? treatments;

  SignUpData(
      {this.age = 0,
      this.gender = "",
      this.city = "",
      this.school = "",
      this.active = false,
      this.healthIssue = false,
      this.medic = false,
      this.physHours = 0,
      this.hasMonitor = false,
      this.monAge = 0,
      this.treatments});

  Map<String, dynamic> toFirestore() {
    return {
      "age": age,
      "gender": gender,
      "city": city,
      "school": school,
      "active": active ? "Trabalhando" : "Aposentado",
      "healthIssue": healthIssue,
      "useMedicine": medic,
      "physExerHours": physHours,
      "hasMonitor": hasMonitor,
      "monAge": monAge,
      if (treatments != null) "treatments": treatments
    };
  }
}
