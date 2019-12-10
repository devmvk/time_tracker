import 'dart:ui';

class Job{
  final String id;
  final String name;
  final int ratePerHour;

  Job({this.id, this.name, this.ratePerHour});

  factory Job.fromMap(Map<String, dynamic> data){
    return data != null && data['name'] != null ? Job(
      id: data["id"],
      name : data["name"],
      ratePerHour: data["ratePerHour"]
    ): null; 
  }

  Map<String, dynamic> toMap(){
    return {
      "id": this.id,
      "name": this.name,
      "ratePerHour": this.ratePerHour
    };
  }

  @override
  int get hashCode => hashValues(id, name, ratePerHour);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Job otherJob = other;
    return id == otherJob.id &&
        name == otherJob.name &&
        ratePerHour == otherJob.ratePerHour;
  }

  @override
  String toString() => 'id: $id, name: $name, ratePerHour: $ratePerHour';
}
