import 'package:apicepviaback4app/models/busca_ceps_model.dart';
import 'package:dio/dio.dart';

class CepsBuscaCepsRepository {
  var _dio = Dio();

  CepsBuscaCepsRepository() {
    _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] =
        'HQsEnN3Hfm9XsxUZz5k891scWy61aY4JKRpkWb1e';
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "c8xdq2ObjjOZuowZpPFkdOOOhtLea9EfqQeTVTTI";
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes";
  }

  Future<CepsBuscaCepsModel> obterTodosCeps() async {
    try {
      final response = await _dio.get("/buscaceps");
      return CepsBuscaCepsModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<CepsBuscaCepsModel> pesquisarCep(
    String cep,
  ) async {
    try {
      //await _dio.put("/buscaceps/$cep", data: cepsBuscaCepsModel.toJson());
      final response = await _dio.get(cep);
      return CepsBuscaCepsModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  // _dio = Dio();
  //   // _dio.options.headers["X-Parse-Application-Id"] =
  //   //     'HQsEnN3Hfm9XsxUZz5k891scWy61aY4JKRpkWb1e';
  //   // _dio.options.headers["X-Parse-REST-API-Key"] =
  //   //     "c8xdq2ObjjOZuowZpPFkdOOOhtLea9EfqQeTVTTI";
  //   // _dio.options.headers["Content-Type"] = "application/json";
  //   // _dio.options.baseUrl = "https://parseapi.back4app.com/classes";

  //   var result =
  //       await _dio.get('https://parseapi.back4app.com/classes/buscaceps');

  //   return CepsBuscaCepsModel.fromJson(result.data); // faz a chamada
  // }

  Future<void> criar(CepsBuscaCepsModel cepsBuscaCepsModel) async {
    try {
      await _dio.post("/buscaceps", data: cepsBuscaCepsModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(
      String id, CepsBuscaCepsModel cepsBuscaCepsModel) async {
    try {
      await _dio.put("/buscaceps/$id", data: cepsBuscaCepsModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletar(String id) async {
    try {
      await _dio.delete("/buscaceps/$id");
    } catch (e) {
      rethrow;
    }
  }
}