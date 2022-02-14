import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/shared_pref_client.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:http/http.dart' as http;

class EditPictoController extends GetxController {
  RxBool text = true.obs;
  RxBool frame = false.obs;
  RxBool tags = false.obs;
  RxBool pictoBorder = true.obs;
  final _homeController = Get.find<HomeController>();
  final _ttsController = Get.find<TTSController>();
  final sharedPref = SharedPrefClient();
  TextEditingController nameController = TextEditingController();
  Rx<Pict?> pict = Rx<Pict?>(null);
  late String lang;
  final databaseRef = FirebaseDatabase.instance.reference();
  final ImagePicker picker = ImagePicker();
  RxBool editingPicture = false.obs;
  Rx<File?> fileImage = Rx<File?>(null);
  Rx<String> selectedPhotoUrl = ''.obs;

  late String url;

  Future<void> uploadToFirebase({required String data}) async {
    // final language = _ttsController.languaje;
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('Picto/${auth!.uid}/');
    await ref.set({
      'data': data,
    });
  }

  Future<void> pictsExistsOnFirebase() async {
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('PictsExistsOnFirebase/${auth!.uid}/');
    await ref.set({
      'value': true,
    });
  }

  Future<SearchModel?> fetchPhotoFromArsaac({required String text}) async {
    url =
        "http://arasaac.org/api/index.php?callback=json&language=${lang.toUpperCase()}&word=${text.replaceAll(' ', '+')}&catalog=colorpictos&thumbnailsize=150&TXTlocate=4&KEY=${dotenv.env['API_KEY']!}";
    var urlF = Uri.parse(url);
    http.Response response = await http.get(
      urlF,
      headers: {"Accept": "application/json"},
    );
    // print(url);
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // print(data['symbols'][0]['name']);
        SearchModel searchModel =
            SearchModel.fromJson(jsonDecode(response.body));
        // print(searchModel.itemCount);
        // print(searchModel.symbols[0].name);
        // print(jsonDecode(response.body));
        return searchModel;
      } else {
        // return null;
        print('else');
      }
    } catch (e) {
      print('failed');
    }
  }

  Future<void> fetchData() async {}

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    pict.value = _homeController.pictToBeEdited;
    lang = _ttsController.languaje;
  }

  @override
  void onReady() {
    super.onReady();
    nameController.text =
        lang == 'en' ? pict.value!.texto.en : pict.value!.texto.es;
  }
}
