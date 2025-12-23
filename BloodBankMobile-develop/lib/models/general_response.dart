class GeneralResponse<T> {
  List<T>? data;
  int? status;
  String? message;

  GeneralResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toMap) {
    return <String, dynamic>{
      'data': data?.map((x) => toMap(x)).toList(),
      'status': status,
      'message': message,
    };
  }

  GeneralResponse.fromJson(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromMap,
  ) {
    data = map['data'] != null
        ? List<T>.from(
            (map['data'] as List<dynamic>).map<T>(
              (x) => fromMap(x as Map<String, dynamic>),
            ),
          )
        : null;
    status = map['status'];
    message = map['message'];
  }
}

class GeneralResponseMap<T> {
  T? data;
  int? status;
  String? message;

  GeneralResponseMap({
    required this.data,
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toMap) {
    return <String, dynamic>{
      'data': data,
      'status': status,
      'message': message,
    };
  }

  GeneralResponseMap.fromJson(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromMap,
  ) {
    data = map['data'] != null && map['data'] is Map
        ? fromMap(map['data'] as Map<String, dynamic>)
        : map['data'];
    status = map['status'];
    message = map['message'];
  }
}
