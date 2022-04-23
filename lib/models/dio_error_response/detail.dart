class Detail {
  List<String>? loc;
  String? msg;
  String? type;

  Detail({this.loc, this.msg, this.type});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        loc: json['loc'] as List<String>?,
        msg: json['msg'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'loc': loc,
        'msg': msg,
        'type': type,
      };
}
