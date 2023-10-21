class CepsBuscaCepsModel {
  // altere aqui - removar ? e declare como vazia []
  List<CepBuscaCepsModel> ceps = []; // RENOMEAR pelo F2 para ceps

  CepsBuscaCepsModel(this.ceps); // remove Obrigátoriedade

  CepsBuscaCepsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      ceps = <CepBuscaCepsModel>[];
      json['results'].forEach((v) {
        ceps.add(CepBuscaCepsModel.fromJson(v));
      });
    }
  }

  get estado => null;

  get bairros => null;

  get cidades => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = ceps.map((v) => v.toJson()).toList();
    return data;
  }
}

// alterar classe para - CEP
class CepBuscaCepsModel {
  // Obrigado a Instânciar( declarar a variavel )
  // por ultimo - renomear para CepBuscaCepsModel

  String objectId = '';
  String cep = '';
  String logradouro = '';
  String bairro = '';
  String estado = ''; //Construtor - CepBuscaCepsModel
  String uf = '';
  String createdAt = '';
  String updatedAt = '';
  String localidade = '';

  // apagar
  // Cep(
  //     {this.objectId,
  //     this.cep,
  //     this.endereco,
  //     this.bairro,
  //     this.estado,
  //     this.uf,
  //     this.createdAt,
  //     this.updatedAt,
  //     this.cidade});

  CepBuscaCepsModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    estado = json['estado'];
    uf = json['uf'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    localidade = json['localidade'];
  }

  Map<String, dynamic> toJson() {
    // converter para map literal
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['estado'] = estado;
    data['uf'] = uf;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['localidade'] = localidade;
    return data;
  }
}
