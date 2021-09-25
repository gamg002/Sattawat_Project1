class Post {
  String idOrder;
  String date;
  String time;
  String fname;
  String work;
  String type;
  String cost;
  String unit;
  String sum;

  Post(
      {this.idOrder,
      this.date,
      this.time,
      this.fname,
      this.work,
      this.type,
      this.cost,
      this.unit,
      this.sum});

  Post.fromJson(Map<String, dynamic> json) {
    idOrder = json['idOrder'];
    date = json['date'];
    time = json['time'];
    fname = json['fname'];
    work = json['work'];
    type = json['type'];
    cost = json['cost'];
    unit = json['unit'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOrder'] = this.idOrder;
    data['date'] = this.date;
    data['time'] = this.time;
    data['fname'] = this.fname;
    data['work'] = this.work;
    data['type'] = this.type;
    data['cost'] = this.cost;
    data['unit'] = this.unit;
    data['sum'] = this.sum;
    return data;
  }
}