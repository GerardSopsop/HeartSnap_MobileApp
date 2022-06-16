import 'dart:convert';

import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> uploadImage(String filename) async {
  await Future.delayed(const Duration(milliseconds: 1000));
  final request = http.MultipartRequest(
      'POST', Uri.parse('http://137.184.183.61:7777/image'));
  request.files.add(await http.MultipartFile.fromPath('image', filename));
  final res = await request.send();
  final result = jsonDecode(await res.stream.bytesToString());
  final String name = result["name"];
  final Map<String, dynamic> infos = result["info"];
  return {
    "status": true,
    "name": name,
    "kcal": "${infos["kcal"]}",
    "trans": "-",
    "saturated": "${infos["saturated"]}",
    "omega": "${infos["omega"]}",
    "fiber": "${infos["fiber"]}",
    "alcohol": '-',
    "sodium": "${infos["sodium"]}",
    "cholesterol": "${infos["cholesterol"]}"
  };
}

Future<Map<String, dynamic>> uploadName(String food) async {
  http.Response response = await http.post(
    Uri.parse('http://137.184.183.61:7777/name'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: food,
  );
  final message = jsonDecode(response.body)[food];
  return {
    "kcal": "${message["kcal"]}",
    "trans": "-",
    "saturated": "${message["saturated"]}",
    "omega": "${message["omega"]}",
    "fiber": "${message["fiber"]}",
    "alcohol": "-",
    "sodium": "${message["sodium"]}",
    "cholesterol": "${message["cholesterol"]}"
  };
}

Future<Map<String, dynamic>> uploadBarcode(String barcode) async {
  ProductResult response =
      await OpenFoodAPIClient.getProduct(ProductQueryConfiguration(barcode));
  if (response.product == null) {
    return {"status": false};
  }
  Nutriments nutriments = response.product!.nutriments!;
  double healthyFat = 0;
  bool hf = false;
  if (nutriments.monounsaturatedServing != null) {
    hf = true;
    healthyFat += nutriments.monounsaturatedServing!;
  }
  if (nutriments.polyunsaturatedServing != null) {
    hf = true;
    healthyFat += nutriments.polyunsaturatedServing!;
  }
  if (nutriments.omega3FatServing != null) {
    hf = true;
    healthyFat += nutriments.omega3FatServing!;
  }
  if (nutriments.omega6FatServing != null) {
    hf = true;
    healthyFat += nutriments.omega6FatServing!;
  }
  return {
    "status": true,
    "name": response.product!.productName,
    "kcal": nutriments.energyKcal ?? "-",
    "saturated": nutriments.saturatedFatServing ?? "-",
    "cholesterol": nutriments.cholesterolServing ?? "-",
    "sodium": nutriments.sodiumServing ?? "-",
    "fiber": nutriments.fiberServing ?? "-",
    "alcohol": nutriments.alcoholServing ?? "-",
    "trans": nutriments.transFatServing ?? "-",
    "omega": hf ? healthyFat : "-"
  };
}
