class AddressLocationTable {
  static const String tableName = 'categories';
  static const String columnId = 'id';
  static const String columnLong = 'long';
  static const String columnLat = 'lat';

  String? id;
  String? long;
  String? lat;

  Map<String, dynamic> toJson() => <String, dynamic>{
        columnId: id,
        columnLong: long,
        columnLat: lat,
      };

  static List<AddressLocationTable> fromJsonList(List<Map> json) {
    List<AddressLocationTable> list = [];
    for (Map obj in json) {
      list.add(AddressLocationTable.fromJson(obj as Map<String, dynamic>));
    }

    return list;
  }

  AddressLocationTable.fromJson(Map<String, dynamic> json) {
    id = json[columnId] as String;
    long = json[columnLong] as String;
    lat = json[columnLat] as String;
  }

  AddressLocationTable.fromParam({
    this.id,
    this.long,
    this.lat,
  });

  static String create() {
    return "CREATE TABLE $tableName ("
        "$columnId TEXT, "
        "$columnLong TEXT, "
        "$columnLat TEXT, "
        ")";
  }
}
