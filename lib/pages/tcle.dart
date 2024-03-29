import 'package:dezmente/pages/instructions.dart';
import 'package:dezmente/services/auth.dart';
import 'package:dezmente/services/signupdata.dart';
import 'package:dezmente/utils/buttons.dart';
import 'package:flutter/material.dart';

class Tcle extends StatefulWidget {
  const Tcle({Key? key}) : super(key: key);

  @override
  State<Tcle> createState() => _TcleState();
}

bool consent = false;
bool scrolled = false;

class _TcleState extends State<Tcle> {
  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;

    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.fromLTRB(10, 70, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "TERMO DE CONSENTIMENTO LIVRE E ESCLARECIDO",
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 375 * scrHfactor,
                margin: const EdgeInsets.all(20),
                child: NotificationListener(
                  onNotification: (n) {
                    if (n is ScrollEndNotification) {
                      setState(() {
                        scrolled = true;
                      });
                    }
                    return true;
                  },
                  child: const RawScrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        "     Nós, Viviane de Hiroki Flumignan Zétola, pesquisadora e neurologista, Isabele Ayumi Miyawaki, aluna de Medicina do Hospital de Clínicas da Universidade Federal do Paraná, Andresa Emy Miyawaki e Palloma Flumignan Zétola, alunas de Medicina e Psicologia da Pontifícia Universidade Católica do Paraná, estamos convidando o Senhor(a) a participar de um estudo intitulado “Desenvolvimento de aplicativo para auxílio de diagnóstico de comprometimento cognitivo leve”. Desenvolvemos um aplicativo para ajudar no diagnóstico precoce da doença “comprometimento cognitivo leve”, em que há perda de memória que pode ser reversível. Dessa forma, aplicaremos um teste por aplicativo para detecção dessa doença e, depois de 4 semanas, aplicaremos outro teste já validado. Você terá o resultado dos testes no final da segunda aplicação. \nÉ possível que o senhor(a) experimente algum desconforto, principalmente relacionado à cansaço na realização dos testes e possível constrangimento, por serem testes de memória. \nOs benefícios esperados com essa pesquisa são: detecção precoce de perda de memória e sugestão de procura de serviço especializado com o objetivo de confirmar o achado do estudo. \nAs informações relacionadas ao estudo poderão conhecidas apenas por pessoas autorizadas, ou seja, as pesquisadoras. No entanto, se qualquer informação for divulgada em relatório ou publicação, será feito sob forma codificada, para que a sua identidade seja preservada e seja mantida a confidencialidade.",
                        style: TextStyle(
                          fontFamily: "montserrat",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              CheckboxListTile(
                title: const Text(
                  "Declaro que li e concordo com os termos",
                  style: TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: consent,
                onChanged: ((value) {
                  if (scrolled) {
                    setState(() {
                      if (value != null) {
                        consent = value;
                      }
                    });
                  }
                }),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextButtom(
                      text: "Voltar",
                      callback: () async {
                        await AuthService().logOut();
                      },
                      bgColor: Colors.red,
                      sizes: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    ),
                    CustomTextButtom(
                      text: "Iniciar Teste",
                      callback: () {
                        if (consent) {
                          setTcle();
                          Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const Instructions(),
                          ));
                        }
                      },
                      bgColor: consent
                          ? const Color(0xff569DB3)
                          : const Color.fromARGB(255, 87, 113, 121),
                      sizes: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
