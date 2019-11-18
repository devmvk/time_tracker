class Job{
  final String id;
  final String name;
  final int ratePerHour;

  Job({this.id, this.name, this.ratePerHour});

  factory Job.fromMap(Map<String, dynamic> data){
    return Job(
      id: data["id"],
      name : data["name"],
      ratePerHour: data["ratePerHour"]
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "id": this.id,
      "name": this.name,
      "ratePerHour": this.ratePerHour
    };
  }

}