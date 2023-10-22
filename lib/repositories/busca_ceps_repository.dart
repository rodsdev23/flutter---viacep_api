import 'dart:convert';

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

  Future<List<String?>> pesquisarCep(String cep) async {
    try {
      final response = await _dio.get("/buscaceps?where={\"cep\":\"$cep\"}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null &&
            data is Map<String, dynamic> &&
            data.containsKey("results")) {
          final results = data["results"];
          if (results is List) {
            // Extrair os CEPs da lista de resultados
            List<String?> ceps = results
                .map((result) {
                  if (result is Map<String, dynamic> &&
                      result.containsKey("cep")) {
                    return result["cep"].toString();
                  }
                  return null;
                })
                .where((cep) => cep != null)
                .toList();

            if (ceps.isNotEmpty) {
              return ceps;
            }
          }
        }
      }

      // Se nenhum CEP for encontrado, retorne uma lista vazia.
      return [];
    } catch (error) {
      rethrow;
    }
  }

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
