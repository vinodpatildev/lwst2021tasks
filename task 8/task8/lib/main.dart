import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'data_item.dart';
import 'data_item_widget.dart';
import 'info_card.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Vehicle Tracker'),
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
  Xml2Json xml2json = new Xml2Json();
  final List<Data> _vehicleData = [];

  final plateNumberController = TextEditingController();

  void _getDataOfVehicle() async {
    final enteredPlateNumber = plateNumberController.text;
    if (enteredPlateNumber.isEmpty) {
      return;
    }
    var url = Uri.https('www.regcheck.org.uk', '/api/reg.asmx/CheckIndia',
        {'RegistrationNumber': enteredPlateNumber, 'username': 'rto_user8'});
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
    xml2json.parse(response.body);

    var jsondata = xml2json.toGData();
    var data = json.decode(jsondata);
    var output = data['Vehicle']['vehicleJson']['\$t'];

    output = output.replaceAll("\\n", "");
    output = output.replaceAll("\\", "");
    output = jsonDecode(output);

    Data description =
        Data(title: "Description", value: output['Description']);

    Data registrationYear =
        Data(title: "Registration Year", value: output['RegistrationYear']);
    Data company =
        Data(title: "Company", value: output['CarMake']['CurrentTextValue']);
    Data model =
        Data(title: "Company", value: output['CarModel']['CurrentTextValue']);
    Data variant = Data(title: "Variant", value: output['Variant']);
    Data engineSize = Data(
        title: "Engine Size",
        value: output['EngineSize']['CurrentTextValue']);
    Data seats = Data(
        title: "Seats", value: output['NumberOfSeats']['CurrentTextValue']);
    Data inum =
        Data(title: "VIN No.", value: output['VechileIdentificationNumber']);
    Data enginenum =
        Data(title: "Engine Number", value: output['EngineNumber']);
    Data fueltype = Data(
        title: "Fuel Type", value: output['FuelType']['CurrentTextValue']);
    Data regiDate =
        Data(title: "Registraion Date", value: output['RegistrationDate']);
    Data owner = Data(title: "Owner", value: output['Owner']);
    Data fitness = Data(title: "Fitness", value: output['Fitness']);
    Data insurance = Data(title: "Insurance", value: output['Insurance']);
    Data pucc = Data(title: "PUCC", value: output['PUCC']);
    Data vehType = Data(title: "Vehicle Type", value: output['VehicleType']);
    Data location = Data(title: "Location", value: output['Location']);

    // print(description);
    // print(registrationYear);
    // print(company);
    // print(model);
    // print(variant);
    // print(engineSize);
    // print(seats);
    // print(inum);
    // print(enginenum);
    // print(fueltype);
    // print(regiDate);
    // print(owner);
    // print(fitness);
    // print(insurance);
    // print(pucc);
    // print(vehType);
    // print(location);

    setState(() {
      _vehicleData.add(description);
      _vehicleData.add(registrationYear);
      _vehicleData.add(company);
      _vehicleData.add(model);
      _vehicleData.add(variant);
      _vehicleData.add(engineSize);
      _vehicleData.add(seats);
      _vehicleData.add(inum);
      _vehicleData.add(enginenum);
      _vehicleData.add(fueltype);
      _vehicleData.add(regiDate);
      _vehicleData.add(owner);
      _vehicleData.add(fitness);
      _vehicleData.add(insurance);
      _vehicleData.add(pucc);
      _vehicleData.add(vehType);
      _vehicleData.add(location);
    });
    } else {
      print("****ERROR****");
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
                          labelText: "Vehicle Number",
                        ),
                        controller: plateNumberController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _getDataOfVehicle(),
                      ),
                      TextButton(
                        onPressed: _getDataOfVehicle,
                        child: Text("Search Vehicle."),
                      ),
                    ],
                  ),
                  InfoCard(_vehicleData),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
