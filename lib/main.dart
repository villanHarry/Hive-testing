import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/Enteries.dart';
import 'package:hive_test/boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EnteriesAdapter());
  await Hive.openBox<Enteries>('enteries');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hive'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    Hive.box('enteries').close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _diaogue(),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ValueListenableBuilder<Box<Enteries>>(
                    valueListenable: Boxes.getEnteries().listenable(),
                    builder: (context, box, _) {
                      final enteries = box.values.toList().cast<Enteries>();
                      return buildEnteries(
                        enteries: enteries,
                      );
                    })
              ]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  addEnteries(String Name, String Email, String Message) {
    final enteries = Enteries()
      ..Name = Name
      ..Email = Email
      ..Message = Message;

    final box = Boxes.getEnteries();
    box.add(enteries);
  }

  _diaogue() {
    final TextEditingController _controller = TextEditingController();
    final TextEditingController _controller2 = TextEditingController();
    final TextEditingController _controller3 = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Login'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        icon: Icon(Icons.account_box),
                      ),
                    ),
                    TextFormField(
                      controller: _controller2,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      controller: _controller3,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        icon: Icon(Icons.message),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              MaterialButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    if (_controller.text.isNotEmpty &&
                        _controller2.text.isNotEmpty &&
                        _controller3.text.isNotEmpty) {
                      addEnteries(_controller.text, _controller2.text,
                          _controller3.text);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Add All Enteries")));
                      Navigator.pop(context);
                    }
                  })
            ],
          );
        });
  }
}

class buildEnteries extends StatelessWidget {
  const buildEnteries({Key? key, required this.enteries}) : super(key: key);

  final List<Enteries> enteries;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: enteries.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 5),
                          blurRadius: 5)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => deleteEnteries(enteries[index]),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.account_box),
                        Text(" Name: ${enteries[index].Name}"),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.email),
                        Text(" Email: ${enteries[index].Email}"),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.message),
                        Text(" Message: ${enteries[index].Message}")
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  deleteEnteries(Enteries enteries) {
    final box = Boxes.getEnteries();
    box.delete(enteries.key);
  }
}
