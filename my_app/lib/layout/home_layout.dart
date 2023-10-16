import 'package:flutter/material.dart';
import 'package:my_app/modules/archived_task/archived_tasks_screen.dart';
import 'package:my_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:my_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  // const HomeLayout({super.key});
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  List<Widget> screens = const [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            var name = await getName();
            print(name);
            throw ('some error !!!');
          } catch (error) {
            print('error ${error.toString()}');
          }
          /*
          getName().then((value) {
            print(value);
            print('taz');
            throw ('error !');
          }).catchError((error) {
            print('error ${error.toString()}');
          });*/
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline), label: 'Done'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: 'Archive'),
          ]),
    );
  }

  Future<String> getName() async {
    return 'Moatez Kamoun';
  }

  void createDatabase() async {
    var database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)');
      },
      onOpen: (database) {
        print('database opened');
      },
    );
  }

  void insertDatabase() {}
}
