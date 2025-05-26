// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_cab_cotizaciones.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _ApiCabCotizaciones implements ApiCabCotizaciones {
  _ApiCabCotizaciones(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'http://192.168.1.222:8080/api/operaciones/POSCotizacion';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<List<CabCotizacion>> getCabsCotizacionesRango(
    int idAlmacen,
    int tipoFecha,
    String fechaInicio,
    String fechaFin,
    int idCliente,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'idAlmacen': idAlmacen,
      r'tipoFecha': tipoFecha,
      r'fechaInicio': fechaInicio,
      r'fechaFin': fechaFin,
      r'idCliente': idCliente,
      r'idSaas': idSaas,
      r'idCompany': idCompany,
      r'idSubscription': idSubscription,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<CabCotizacion>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/GetCabsCotRango',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<CabCotizacion> _value;
    try {
      _value =
          _result.data!
              .map(
                (dynamic i) =>
                    CabCotizacion.fromJson(i as Map<String, dynamic>),
              )
              .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
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

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
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
