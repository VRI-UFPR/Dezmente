import 'package:dezmente/common/teste_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dezmente/widgets/help.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

const debugMode = false;

class _TesteState extends State<Teste> {
  @override
  void initState() {
    super.initState();

    TestCtrl.instance.setCallback = () => setState(() {});

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        TestCtrl.instance.init();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: TestCtrl.instance.build(),
      ),
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(17, 0, 17, 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xff569DB3)),
        child: Row(
          children: [
            _buildBottomBarButton(
              icon: Icons.question_mark_outlined,
              label: "Informações",
              onPressed: () => TestCtrl.instance.pushTestHelpPage("Voltar"),
            ),
            if (TestCtrl.instance.needErase)
              _buildBottomBarButton(
                icon: Icons.backspace,
                label: "Apagar",
                onPressed: () => TestCtrl.instance.erase(),
              ),
            _buildBottomBarButton(
              icon: Icons.check_circle_outline,
              label: "Concluir",
              onPressed: () => TestCtrl.instance.nextTest(),
              onLongPress:
                  !debugMode ? null : () => TestCtrl.instance.debugMode(),
            ),
          ],
        ),
      ),
    );
  }

  void callHelpHud() => Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) =>
              HelpTemplateButton(
            audioFile: TestCtrl.instance.audioFile,
            callback: () {
              Navigator.pop(this.context);
            },
            titleText: TestCtrl.instance.title,
            description: TestCtrl.instance.description,
            buttonText: "Voltar",
          ),
        ),
      );

  Widget _buildBottomBarButton({
    required IconData icon,
    required String label,
    void Function()? onPressed,
    void Function()? onLongPress,
  }) =>
      Expanded(
        child: TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            decoration: BoxDecoration(
              color: const Color(0xffB7D5DF),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
            ),
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
