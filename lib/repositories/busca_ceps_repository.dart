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

  Future<CepsBuscaCepsModel> pesquisarCep(String cep) async {
    try {
      final response = await _dio
          .get("/buscaceps", queryParameters: {"where": '{"cep": "$cep"}'});
      return CepsBuscaCepsModel.fromJson(response.data);
    } catch (error) {
      if (error is DioException) {
        print("Erro ao buscar CEP ${error.response?.data}");
      } else {
        print("Erro ao buscar CEP $error");
      }
      throw error;
    }
  }

  Future<String> obterCepIdPorCep(String cep) async {
    try {
      final response =
          await _dio.get("/buscaceps", queryParameters: {"cep": cep});
      if (response.statusCode == 200) {
        final cepsBuscaCepsModel = CepsBuscaCepsModel.fromJson(response.data);
        if (cepsBuscaCepsModel.results.isNotEmpty) {
          // Se houver um CEP correspondente, retorne o objectId
          return cepsBuscaCepsModel.results[0].objectId ?? '';
        }
      }
      return ''; // Retorna uma string vazia se o CEP não for encontrado
    } catch (e) {
      // Lida com erros da chamada à API
      throw Exception('Erro ao obter CEP ID: $e');
    }
  }

  Future<void> criar(CepBuscaCepsModelAPI cepBuscaCepsModel) async {
    try {
      final response =
          await _dio.post("/buscaceps", data: cepBuscaCepsModel.toJson());

      if (response.statusCode == 201) {
        // A criação foi bem-sucedida
        print('Registro criado com sucesso: ${response.data}');
      } else {
        // Trate o erro de acordo com a resposta da API
        print(
            'Erro ao criar registro. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      // Trate erros de rede ou outros erros
      print('Erro ao criar registro: $e');
      rethrow; // Para repassar o erro para quem chamou o método
    }
  }

  Future<void> atualizarCEP(
      String cepId, CepBuscaCepsModelAPI cepsBuscaCepsModelAPI) async {
    try {
      final response = await _dio.put("/buscaceps/$cepId",
          data: cepsBuscaCepsModelAPI.toJson());

      if (response.statusCode == 200) {
        // Verifique se a resposta da API indica sucesso (código de status 200)
        print("CEP atualizado com sucesso.");
      } else {
        // Trate erros de resposta da API
        print(
            "Erro na chamada à API. Código de status: ${response.statusCode}");
        throw "Erro na chamada à API.";
      }
    } catch (e) {
      // Trate erros de conexão ou outros erros
      print("Erro na chamada à API: $e");
      throw "Erro na chamada à API: $e";
    }
  }

  Future<void> deletarCep(String id) async {
    try {
      await _dio.delete("/buscaceps/$id");
    } catch (error) {
      rethrow;
    }
  }
}
