import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/database/findacc.dart';
import 'package:heartsnap_monorepo/util/textfield.dart';

class SettingsButton extends StatefulWidget {
  const SettingsButton({Key? key, required this.user}) : super(key: key);

  final String user;
  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      mini: true,
      splashColor: Colors.transparent,
      onPressed: () async {
        final Map<String, dynamic> infos = await findAccount(widget.user);
        showDialog<String>(
                context: context,
                builder: (BuildContext context) => popUp(context, infos))
            .then((value) => {
                  if (value == "yes")
                    {Navigator.of(context).popUntil((route) => route.isFirst)}
                });
      },
      child: const Icon(
        Icons.person,
        size: 30,
      ),
      backgroundColor: const Color.fromRGBO(242, 193, 113, 1),
    );
  }

  Widget popUp(BuildContext context, Map<String, dynamic> infos) {
    final double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(242, 193, 113, 1),
      actionsAlignment: MainAxisAlignment.center,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: const Text(
        "ACCOUNT",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            TextInput(
              label: "Name: ${infos["name"]}",
              controller: TextEditingController(),
              type: TextInputType.name,
              editable: false,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            TextInput(
              label: "Sex: ${infos["sex"]}",
              controller: TextEditingController(),
              type: TextInputType.name,
              editable: false,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            TextInput(
              label: "Weight(kg): ${infos["weight"]}",
              controller: TextEditingController(),
              type: TextInputType.name,
              editable: false,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            TextInput(
              label: "Height(cm): ${infos["height"]}",
              controller: TextEditingController(),
              type: TextInputType.name,
              editable: false,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            TextInput(
              label: "Daily calorie goal: ${infos["calorie"]}",
              controller: TextEditingController(),
              type: TextInputType.name,
              editable: false,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            SizedBox(
              width: width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    splashFactory: NoSplash.splashFactory,
                    primary: const Color.fromRGBO(152, 206, 111, 1),
                    shadowColor: Colors.transparent),
                child: const Text(
                  "Log out",
                  style: TextStyle(fontFamily: "DMSans"),
                ),
                onPressed: () {
                  Navigator.pop(context, "yes");
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
