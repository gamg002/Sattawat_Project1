class map_model {
  String id;
  String traval;
  String name;
  String other;
  String lat;
  String lng;

  map_model({this.id, this.traval, this.name, this.other, this.lat, this.lng});

  map_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    traval = json['traval'];
    name = json['name'];
    other = json['other'];
    lat = json['Lat'];
    lng = json['Lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['traval'] = this.traval;
    data['name'] = this.name;
    data['other'] = this.other;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    return data;
  }
}
