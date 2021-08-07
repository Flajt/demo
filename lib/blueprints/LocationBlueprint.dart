import 'package:equatable/equatable.dart';

class LocationBlueprint extends Equatable{
  final String name;
  final double longitude;
  final double latitude;
  LocationBlueprint(this.name,this.latitude,this.longitude);
  LocationBlueprint.fromJson(Map<String,dynamic> json) : 
  this.name = json["name"],
  this.longitude = json["longitude"],
  this.latitude = json["latitude"];
  
  Map<String,dynamic>toJson(){
    return {"name":name,"longitude":longitude,"latitude":latitude};
  }

  @override
  List<Object?> get props => [name,latitude,longitude];
}