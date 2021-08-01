import 'package:xml/xml.dart';

main(List<String> args) {
  final doc =
      '''<Vehicle xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://regcheck.org.uk">
<vehicleJson>{ "Description": "HERO HONDA PASSION PRO CAST - DRUM BRAKE", "RegistrationYear": "2018", "CarMake": { "CurrentTextValue": "HERO HONDA" }, "CarModel": { "CurrentTextValue": "PASSION PRO" }, "Variant": "CAST - DRUM BRAKE", "EngineSize": { "CurrentTextValue": "100" }, "MakeDescription": { "CurrentTextValue": "HERO HONDA" }, "ModelDescription": { "CurrentTextValue": "PASSION PRO" }, "NumberOfSeats": { "CurrentTextValue": "2" }, "VechileIdentificationNumber": "MBLHAR186JHC33217", "EngineNumber": "HA10ACJHC68921", "FuelType": { "CurrentTextValue": "Petrol" }, "RegistrationDate": "07/06/2018", "Owner": "", "Fitness": "", "Insurance": "", "PUCC": "", "VehicleType": "M-CYCLE/SCOOTER(2WN)", "Location": "DY. RTO VASAI-VIRAR", "ImageUrl": "http://www.carregistrationapi.in/image.aspx/@SEVSTyBIT05EQSBQQVNTSU9OIFBSTyBDQVNUIC0gRFJVTSBCUkFLRQ==" }</vehicleJson>
<vehicleData>
<Description>HERO HONDA PASSION PRO CAST - DRUM BRAKE</Description>
<RegistrationYear>2018</RegistrationYear>
<CarMake>
<CurrentTextValue>HERO HONDA</CurrentTextValue>
</CarMake>
<CarModel>PASSION PRO</CarModel>
<EngineSize>
<CurrentTextValue>100</CurrentTextValue>
</EngineSize>
</vehicleData>
</Vehicle>
  ''';

  final document = XmlDocument.parse(doc);

  print(document);
  }
