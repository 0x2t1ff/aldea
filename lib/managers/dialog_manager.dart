import 'package:flutter/material.dart';
import '../locator.dart';
import '../models/dialog_models.dart';
import '../services/dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final controller = TextEditingController();

  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(request.title, style: TextStyle(color: Colors.white)),
              content: !request.hasTextArea
                  ? Text(request.description, style: TextStyle(color: Colors.white),)
                  : TextField(
                      controller: controller,
                      style: TextStyle(color: Colors.white),
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: "Escribe el cuerpo de tu solicitud...",
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white24),
                          filled: true,
                          fillColor: Color(0xff15232B),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
              backgroundColor: Color(0xff17191E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              actions: <Widget>[
                if (isConfirmationDialog)
                  FlatButton(
                    child: Text(request.cancelTitle),
                    onPressed: () {
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: false));
                    },
                  ),
                FlatButton(
                  child: Text(request.buttonTitle),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: true, textField: controller.text));
                  },
                ),
              ],
            ));
  }
}
