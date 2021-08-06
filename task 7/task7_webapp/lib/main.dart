import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'terminal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Web Docker'),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Quicksand',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<String> _Output = [];

  final commandController = TextEditingController();

  getKubeOutput() async {
    final enteredCommand = commandController.text;
    if (enteredCommand.isEmpty) {
      return;
    }

    try {
      var url = Uri.http('13.235.73.200', '/cgi-bin/k8s.py', {
      'command': enteredCommand,
    });

    var result = await http.get(url);

    setState(() {
      _Output.add(result.body);
    });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.lightBlue.shade200,
        child: Card(
          margin: EdgeInsets.all(60),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Docker Command",
                        ),
                        controller: commandController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          getKubeOutput();
                          commandController.value = 
                          commandController.value.copyWith(
                            text: "",
                            selection: TextSelection.collapsed(offset: 0),
                          );
                        },
                        
                      ),
                      TextButton(
                        onPressed: getKubeOutput,
                        child: Text("Submit Command"),
                      ),
                    ],
                  ),
                  Terminal(_Output),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
