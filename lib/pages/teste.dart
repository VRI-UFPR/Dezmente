import 'package:dezmente/pages/common/super.dart';
import 'package:dezmente/pages/common/teste_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dezmente/widgets/help.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

const debugMode = true;
GlobalObjectKey<SuperTestState> _globalKey = const GlobalObjectKey("key");

class _TesteState extends State<Teste> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) async {
        await Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) =>
                HelpTemplateButton(
              callback: () {
                Navigator.pop(this.context);
              },
              title: "",
              description: TestCtrl.getInstace().description,
              buttonText: "Começar",
            ),
          ),
        );
        _globalKey.currentState?.init();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: TestCtrl.getInstace().build(context),
      ),
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(17, 0, 17, 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xff569DB3)),
        child: Row(
          children: [
            _buildBottomBarButton(Icons.question_mark_outlined, "Informações",
                () {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HelpTemplateButton(
                        callback: () {
                          Navigator.pop(this.context);
                        },
                        title: "",
                        description: TestCtrl.getInstace().description,
                        buttonText: "Voltar",
                      )));
            }, null),
            if (TestCtrl.getInstace().needErase)
              _buildBottomBarButton(Icons.backspace, "Apagar", () {
                setState(
                  () {
                    _globalKey.currentState?.erase();
                  },
                );
              }, null),
            _buildBottomBarButton(
              Icons.check_circle_outline,
              "Concluir",
              () {
                setState(() {
                  TestCtrl.getInstace().nextTest(this.context);
                });
              },
              !debugMode
                  ? null
                  : () {
                      setState(
                        () {
                          // currentTest = DebugSelectTest(
                          //   testList: _testes,
                          //   onTestSelected: (i) {
                          //     setState(() {
                          //       nextTest(i: i);
                          //     });
                          //   },
                          // );
                        },
                      );
                    },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBarButton(IconData icon, String label, dynamic onPressed,
          dynamic onLongPress) =>
      Expanded(
        child: TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            decoration: BoxDecoration(
                color: const Color(0xffB7D5DF),
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(icon, color: const Color(0xff060607)),
                Text(
                  label,
                  style: const TextStyle(color: Color(0xff060607)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
}
