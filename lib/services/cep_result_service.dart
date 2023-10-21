import 'package:dio/dio.dart';
import '../models/busca_ceps_model.dart';

class CepResultService {
  final _dio = Dio();

  CepResultService() {
    // Configuração de autenticação (deve ser feita apenas uma vez no construtor)
    _dio.options.headers["X-Parse-Application-Id"] =
        'HQsEnN3Hfm9XsxUZz5k891scWy61aY4JKRpkWb1e';
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "c8xdq2ObjjOZuowZpPFkdOOOhtLea9EfqQeTVTTI";
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes";
  }

  // static Future<CepResultModel> fetchCep({String? cep}) async {
  //   final dio = Dio();
  //   final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
  //   if (response.statusCode == 200) {
  //     return CepResultModel.fromJson(response.data);
  //   } else {
  //     throw Exception('Requisição inválida!');
  //   }
  // }
}
