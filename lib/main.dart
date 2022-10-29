import 'package:flutter/material.dart';
import 'package:flutter_application_1/offices.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Networking",
      home: MyHomePAge(),
    );
  }
}

class MyHomePAge extends StatefulWidget {
  const MyHomePAge({Key? key}) : super(key: key);

  @override
  State<MyHomePAge> createState() => _MyHomePAgeState();
}

class _MyHomePAgeState extends State<MyHomePAge> {
  late Future<OfficesList> officesList;
  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Networking",
        ),
      ),
      body: FutureBuilder<OfficesList>(
        future: officesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.offices.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${snapshot.data?.offices[index].name}'),
                      subtitle:
                          Text('${snapshot.data?.offices[index].address}'),
                      leading: Image.network(
                          '${snapshot.data?.offices[index].image}'),
                      isThreeLine: true,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
