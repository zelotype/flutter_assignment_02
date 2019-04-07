import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/DB/db.dart';

class main_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return main_pageState();
  }
}

class main_pageState extends State<main_page> {
  int _state = 0;
  Icon addIcon = new Icon(Icons.add);
  Icon delIcon = new Icon(Icons.delete);
  static TodoProvider todo = TodoProvider();
  List<Todo> task = [];
  List<Todo> complete = [];
  @override
  Widget build(BuildContext context) {
    Future AddPressed() async {
      setState(() {
        Navigator.pushNamed(context, "/newsubject");
      });
    }

    final List button = <Widget>[
      IconButton(icon: addIcon, onPressed: AddPressed),
      IconButton(
          icon: delIcon,
          onPressed: () async {
            for (var item in complete) {
              print(item.id);
              await todo.delete(item.id);
            }
            setState(() {
              complete = [];
            });
          })
    ];

    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Todo'),
            actions: <Widget>[_state == 0 ? button[0] : button[1]],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _state,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment), title: Text("Task")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_all), title: Text("Complete")),
            ],
            onTap: (index) {
              setState(() {
                _state = index;
              });
            },
          ),
          body: _state == 0
              ?
              Container(
                  child: FutureBuilder<List<Todo>>(
                      future: todo.getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Todo>> snapshot) {
                        task = [];
                        //check before load data
                        if (snapshot.hasData) {
                          //add items in db to list
                          for (var items in snapshot.data) {
                            if (items.done == false) {
                              task.add(items);
                            }
                          }
                          //have a data yet? yes!
                          return task.length != 0
                              ? ListView.builder(
                                  itemCount: task.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Todo item = task[index];
                                    return ListTile(
                                      title: Text(item.title),
                                      trailing: Checkbox(
                                        onChanged: (bool value) async {
                                          setState(() {
                                            item.done = value;
                                          });
                                          todo.update(item);
                                        },
                                        value: item.done,
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text("No Data Found.."),
                                );
                        } else {
                          return Center(
                            child: Text("No Data Found.."),
                          );
                        }
                      }),
                )
              :
              Container(
                  child: FutureBuilder<List<Todo>>(
                      future: todo.getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Todo>> snapshot) {
                        complete = [];
                        //check before load data
                        if (snapshot.hasData) {
                          //add items in db to list
                          for (var items in snapshot.data) {
                            if (items.done == true) {
                              complete.add(items);
                            }
                          }
                          //have a data yet? yes!
                          return complete.length != 0
                              ? ListView.builder(
                                  itemCount: complete.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Todo item = complete[index];
                                    return ListTile(
                                      title: Text(item.title),
                                      trailing: Checkbox(
                                        onChanged: (bool value) async {
                                          setState(() {
                                            item.done = value;
                                          });
                                          todo.update(item);
                                        },
                                        value: item.done,
                                      ),
                                    );
                                  },
                                )
                              //Nope
                              : Center(
                                  child: Text("No Data Found.."),
                                );
                        } else {
                          return Center(
                            child: Text("No Data Found.."),
                          );
                        }
                      }),
                )),
    ));
  }
}
