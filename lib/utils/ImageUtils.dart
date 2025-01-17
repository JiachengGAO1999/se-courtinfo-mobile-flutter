import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class ImageUtility {
  static const String KEY = "IMAGE_KEY";

  static Future<List<String>> getImagesFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imgList = prefs.getStringList(KEY) ?? [];
    return imgList;
  }

  static Future<bool> saveImageToPreferences(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentImages =
        prefs.getStringList(KEY) ?? []; // getting current loaded images
    currentImages.add(value); // adding the new image
    return prefs.setStringList(
      KEY,
      currentImages,
    ); // saving the array of images
  }

  static Future<bool> resetImages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(KEY, []); // deleting all saved images
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Future<bool> saveImageBytesToPreference(Uint8List imageBytes) async {
    String base64String = ImageUtility.base64String(imageBytes);
    return await saveImageToPreferences(base64String);
  }

  static Future<bool> removeImage(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> images = prefs.getStringList(KEY) ?? [];
    if (images.length > 0) {
      images.removeAt(index);
      prefs.setStringList(KEY, images);
      return true;
    }
    return false;
  }

  static Future<bool> replaceImagesOnPref(List<String> images) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(KEY, images);
  }
}
