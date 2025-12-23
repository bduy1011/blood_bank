// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _BackendClient implements BackendClient {
  _BackendClient(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<AuthenticationResponse> login(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/login',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthenticationResponse _value;
    try {
      _value = AuthenticationResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<String> refreshToken() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<String>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/system-user/refresh-token',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<String>(_options);
    late String _value;
    try {
      _value = _result.data!;
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AuthenticationResponse> reLoadInformation() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<AuthenticationResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/system-user/re-load-information',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthenticationResponse _value;
    try {
      _value = AuthenticationResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<RegisterResponse>> register(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/register',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<RegisterResponse> _value;
    try {
      _value = GeneralResponseMap<RegisterResponse>.fromJson(
        _result.data!,
        (json) => RegisterResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> registerByPhone(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/register-phone',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AuthenticationResponse> checkOtp(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/check-otp',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthenticationResponse _value;
    try {
      _value = AuthenticationResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> resendOtp(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/resend-otp',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> changePassword(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/change-password/false',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> changePasswordByRegister(
    Map<String, dynamic> body,
    String token, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/change-password/true',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<RegisterResponse>> updateUser(
    Map<String, dynamic> body,
    String code,
    bool isModIdCard, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'PUT',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/update/${code}/${isModIdCard}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<RegisterResponse> _value;
    try {
      _value = GeneralResponseMap<RegisterResponse>.fromJson(
        _result.data!,
        (json) => RegisterResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> deleteAccount(
    String code, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'DELETE',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/delete-account/${code}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> logout({Options? options}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/logout',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<BloodType>> getBloodTypes({Options? options}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dm-chung/load-nhom-mau',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<BloodType> _value;
    try {
      _value = GeneralResponse<BloodType>.fromJson(
        _result.data!,
        (json) => BloodType.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<DmDonViCapMauResponse>> getDmDonViCapMau(
      {Options? options}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dm-don-vi-cap-mau/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<DmDonViCapMauResponse> _value;
    try {
      _value = GeneralResponse<DmDonViCapMauResponse>.fromJson(
        _result.data!,
        (json) => DmDonViCapMauResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<CauHinhTonKho>> initTonKhoTemplate(
    String ngay, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/cau-hinh-ton-kho/init?ngay=${ngay}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<CauHinhTonKho> _value;
    try {
      _value = GeneralResponseMap<CauHinhTonKho>.fromJson(
        _result.data!,
        (json) => CauHinhTonKho.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> createTonKho(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/cau-hinh-ton-kho',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> updateTonKho(
    Map<String, dynamic> body,
    String id, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'PUT',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/cau-hinh-ton-kho/${id}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<CauHinhTonKho>> getTonKho(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'PATCH',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/cau-hinh-ton-kho',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<CauHinhTonKho> _value;
    try {
      _value = GeneralResponse<CauHinhTonKho>.fromJson(
        _result.data!,
        (json) => CauHinhTonKho.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<CauHinhTonKho>> getTonKhoById(
    String id, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/cau-hinh-ton-kho/${id}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<CauHinhTonKho> _value;
    try {
      _value = GeneralResponseMap<CauHinhTonKho>.fromJson(
        _result.data!,
        (json) => CauHinhTonKho.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<GiaoDichTemplate>> getTemplateNhuongMau(
    String loaiPhieu, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/giao-dich/init/${loaiPhieu}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<GiaoDichTemplate> _value;
    try {
      _value = GeneralResponseMap<GiaoDichTemplate>.fromJson(
        _result.data!,
        (json) => GiaoDichTemplate.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> createGiaoDich(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/giao-dich/create',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> updateGiaoDich(
    String id,
    bool isApprove,
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'PUT',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/giao-dich/update/${id}/${isApprove}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> approveGiaoDich(
    String id,
    bool isApprove,
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'PUT',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/giao-dich/update/${id}/${isApprove}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> cancelGiaoDich(
    String id,
    bool isApprove,
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'PUT',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/giao-dich/update/${id}/${isApprove}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<GiaoDichTemplate>> getGiaoDichById(
    String id, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/giao-dich/get?id=${id}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<GiaoDichTemplate> _value;
    try {
      _value = GeneralResponseMap<GiaoDichTemplate>.fromJson(
        _result.data!,
        (json) => GiaoDichTemplate.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<GiaodichResponse>> loadGiaoDich(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/giao-dich/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<GiaodichResponse> _value;
    try {
      _value = GeneralResponse<GiaodichResponse>.fromJson(
        _result.data!,
        (json) => GiaodichResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> deleteGiaoDich(
    String id, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'DELETE',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/giao-dich/delete/${id}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<Ward>> getWards({Options? options}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dm-chung/load-xa',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<Ward> _value;
    try {
      _value = GeneralResponse<Ward>.fromJson(
        _result.data!,
        (json) => Ward.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<Province>> getProvinces({Options? options}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dm-chung/load-tinh',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<Province> _value;
    try {
      _value = GeneralResponse<Province>.fromJson(
        _result.data!,
        (json) => Province.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<District>> getDictricts({Options? options}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dm-chung/load-quan',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<District> _value;
    try {
      _value = GeneralResponse<District>.fromJson(
        _result.data!,
        (json) => District.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<BloodDonationEvent>> getBloodDonationEvents(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dot-lay-mau/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<BloodDonationEvent> _value;
    try {
      _value = GeneralResponse<BloodDonationEvent>.fromJson(
        _result.data!,
        (json) => BloodDonationEvent.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<SystemConfig>> getSystemConfig(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-config/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<SystemConfig> _value;
    try {
      _value = GeneralResponse<SystemConfig>.fromJson(
        _result.data!,
        (json) => SystemConfig.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<SlideModel>> getSystemSlides(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-slide/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<SlideModel> _value;
    try {
      _value = GeneralResponse<SlideModel>.fromJson(
        _result.data!,
        (json) => SlideModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<NewsResponse>> getNews(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/tin-tuc/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<NewsResponse> _value;
    try {
      _value = GeneralResponse<NewsResponse>.fromJson(
        _result.data!,
        (json) => NewsResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<NewsResponse>> getNewsById(
    String id, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/tin-tuc/get/${id}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<NewsResponse> _value;
    try {
      _value = GeneralResponseMap<NewsResponse>.fromJson(
        _result.data!,
        (json) => NewsResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<List<Question>> getQuestions({Options? options}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dm-chung/load-bang-cau-hoi',
    )..data = _data;
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<Question> _value;
    try {
      _value = _result.data!
          .map((dynamic i) => Question.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<RegisterDonationBloodResponse> registerDonateBlood(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dang-ky-hien-mau/create',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late RegisterDonationBloodResponse _value;
    try {
      _value = RegisterDonationBloodResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<RegisterDonationBloodHistoryResponse>>
      registerDonateBloodHistory(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dang-ky-hien-mau/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<RegisterDonationBloodHistoryResponse> _value;
    try {
      _value = GeneralResponse<RegisterDonationBloodHistoryResponse>.fromJson(
        _result.data!,
        (json) => RegisterDonationBloodHistoryResponse.fromJson(
            json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<RegisterDonationBloodHistoryResponse>>
      getRegisterDonateBloodById(
    String id, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dang-ky-hien-mau/get/${id}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<RegisterDonationBloodHistoryResponse> _value;
    try {
      _value =
          GeneralResponseMap<RegisterDonationBloodHistoryResponse>.fromJson(
        _result.data!,
        (json) => RegisterDonationBloodHistoryResponse.fromJson(
            json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<DonationBloodHistoryResponse>> donateBloodHistory(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/lich-su-hien-mau/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<DonationBloodHistoryResponse> _value;
    try {
      _value = GeneralResponse<DonationBloodHistoryResponse>.fromJson(
        _result.data!,
        (json) =>
            DonationBloodHistoryResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<RegisterDonationBloodHistoryResponse>>
      cancelRegisterDonateBlood(
    Map<String, dynamic> body,
    String id, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'PUT',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/dang-ky-hien-mau/update/${id}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<RegisterDonationBloodHistoryResponse> _value;
    try {
      _value =
          GeneralResponseMap<RegisterDonationBloodHistoryResponse>.fromJson(
        _result.data!,
        (json) => RegisterDonationBloodHistoryResponse.fromJson(
            json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<BloodDonor>> getDMNguoiHienMauByIdCard(
    String identityCard,
    String phoneNumber, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path:
          'api/dm-nguoi-hien-mau/get/${identityCard}?phoneNumber=${phoneNumber}',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<BloodDonor> _value;
    try {
      _value = GeneralResponseMap<BloodDonor>.fromJson(
        _result.data!,
        (json) => BloodDonor.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> createGopY(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/gop-y/create',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponse<FeedbackResponse>> getGopY(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/gop-y/load',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponse<FeedbackResponse> _value;
    try {
      _value = GeneralResponse<FeedbackResponse>.fromJson(
        _result.data!,
        (json) => FeedbackResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<String> getLetter(
    String id,
    String type, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'GET',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/files-manage/get-letter/${id}/${type}',
    )..data = _data;
    final _result = await _dio.fetch<String>(_options);
    late String _value;
    try {
      _value = _result.data!;
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GeneralResponseMap<dynamic>> requestForgotPassword(
    Map<String, dynamic> body, {
    Options? options,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      queryParameters: queryParameters,
      path: 'api/system-user/tao-yeu-cau-cap-mk',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GeneralResponseMap<dynamic> _value;
    try {
      _value = GeneralResponseMap<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions newRequestOptions(Object? options) {
    if (options is RequestOptions) {
      return options as RequestOptions;
    }
    if (options is Options) {
      return RequestOptions(
        method: options.method,
        sendTimeout: options.sendTimeout,
        receiveTimeout: options.receiveTimeout,
        extra: options.extra,
        headers: options.headers,
        responseType: options.responseType,
        contentType: options.contentType.toString(),
        validateStatus: options.validateStatus,
        receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        followRedirects: options.followRedirects,
        maxRedirects: options.maxRedirects,
        requestEncoder: options.requestEncoder,
        responseDecoder: options.responseDecoder,
        path: '',
      );
    }
    return RequestOptions(path: '');
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
