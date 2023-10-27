class CepsBuscaCepsModel {
  List<CepBuscaCepsModelAPI> results = [];

  CepsBuscaCepsModel(this.results);

  CepsBuscaCepsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <CepBuscaCepsModelAPI>[];
      json['results'].forEach((v) {
        results.add(CepBuscaCepsModelAPI.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class CepBuscaCepsModelAPI {
  String? objectId = '';
  String? cep = '';
  String? logradouro = '';
  String? complemento = '';
  String? bairro = '';
  String? localidade = '';
  String? uf = '';
  String? createdAt = '';
  String? updatedAt = '';

  CepBuscaCepsModelAPI(
      {this.objectId,
      this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.createdAt,
      this.updatedAt});

  CepBuscaCepsModelAPI.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
