class Job{
  final String id;
  final String name;
  final int ratePerHour;

  Job({this.id, this.name, this.ratePerHour});

  Map<String, dynamic> toMap(){
    return {
      "id": this.id,
      "name": this.name,
      "ratePerHour": this.ratePerHour
    };
  }

}