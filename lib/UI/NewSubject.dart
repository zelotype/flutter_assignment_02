import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/DB/db.dart';

class NewSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewSubjectState();
  }
}

class NewSubjectState extends State<NewSubject> {
  final _formkey = GlobalKey<FormState>();
  final formController = TextEditingController();
  Icon backIcon = new Icon(Icons.arrow_back);
  static TodoProvider todo = TodoProvider();
  @override
  Widget build(BuildContext context) {
    void backPressed() {
      setState(() {
        Navigator.pushNamed(context, "/");
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('New Subject'),
        leading: IconButton(icon: backIcon, onPressed: backPressed),
      ),
      body: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Subject"),
                controller: formController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please fill subject';
                  }
                },
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () async {
                  _formkey.currentState.validate();
                  if (formController.text.length > 0) {
                    await todo.open("todo.db");
                    Todo data = Todo();
                    data.title = formController.text;
                    data.done = false;
                    await todo.insert(data);
                    print(data);
                    print('insert complete');
                    Navigator.pop(context);
                  }
                  formController.text = "";
                },
              )
            ],
          )),
    );
  }
}
