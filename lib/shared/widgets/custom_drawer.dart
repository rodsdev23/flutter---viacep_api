import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.amberAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // clicar abre o modal de selecção de imagem
              showModalBottomSheet(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  context: context,
                  builder: (BuildContext bc) {
                    // wrap - elimina o espaço em branco do modal, exibindo somente os
                    // componentes que nele estiverem.
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera_alt_sharp),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Galeria"),
                          leading: const Icon(Icons.album_sharp),
                        )
                      ],
                    );
                  });
            },
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    border: Border(
                        bottom:
                            BorderSide(width: 10, color: Colors.deepOrange))),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container() //Image.asset(AppImages.user2),
                    ),
                accountName: const Text("Rodrigo Sousa"),
                accountEmail: const Text("email@email.com")),
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                    ),
                    Text(
                      "Dados Cadastrais",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ],
                )),
            onTap: () {
              // tira a tela do menu do drawer,
              // quando retorna para main page.
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const DadosCadastraisHivePage()));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.info),
                    Text(
                      "Termos de uso e privacidade",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ],
                )),
            onTap: () {
              showModalBottomSheet(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Wrap(
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Termos de uso e Serviço",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              Container(
                                height: 15,
                              ),
                              const Text(
                                "No mundo atual, a execução dos pontos do programa facilita a criação das posturas dos órgãos dirigentes com relação às suas atribuições. Acima de tudo, é fundamental ressaltar que a contínua expansão de nossa atividade estende o alcance e a importância de alternativas às soluções ortodoxas. O incentivo ao avanço tecnológico, assim como a complexidade dos estudos efetuados cumpre um papel essencial na formulação da gestão inovadora da qual fazemos parte. Gostaria de enfatizar que o fenômeno da Internet causa impacto indireto na reavaliação das diretrizes de desenvolvimento para o futuro.",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.app_blocking),
                    Text(
                      "Configurações",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext bc) =>
              //             const ConfiguracoesHivePage()));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    Text(
                      "Sair",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ],
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      alignment: Alignment.centerLeft,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: const Text("Meu app"),
                      content: const Wrap(
                        children: [
                          Text("Você sairá do aplicativo!"),
                          Text("Deseja realmente sair do app ?"),
                        ],
                      ),
                      // botoes de sair
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Não")),
                        TextButton(
                          onPressed: () {
                            // volta pra tela de login e limpa a stack inteira.
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const LoginPage()));
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
