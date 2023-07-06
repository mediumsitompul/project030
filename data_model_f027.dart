class DataModel {
  String? locId;
  String? locX;
  String? locY;
  String? title1;
  String? snippet1;
  String? date1;
  String? time1;

  DataModel({this.locId, this.locX, this.locY, this.title1, this.snippet1});
  DataModel.fromJson(Map<String, dynamic> json) {
    locId = json['id'];
    locX = json['lat'];
    locY = json['lng'];
    title1 = json['title'];
    snippet1 = json['snippet'];
    date1 = json['date'];
    time1 = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = locId;
    data['lat'] = locX;
    data['lng'] = locY;
    data['title'] = title1;
    data['snippet'] = snippet1;
    data['date'] = date1;
    data['time'] = time1;

    return data;
  }
}

//========================================================
class ListDataModel {
  List<DataModel>? data;
  ListDataModel({this.data});

  ListDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
