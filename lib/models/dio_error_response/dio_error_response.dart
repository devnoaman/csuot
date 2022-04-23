import 'detail.dart';

class DioErrorResponse {
  List<Detail>? detail;

  DioErrorResponse({this.detail});

  factory DioErrorResponse.fromJson(Map<String, dynamic> json) {
    return DioErrorResponse(
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => Detail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'detail': detail?.map((e) => e.toJson()).toList(),
      };
}
