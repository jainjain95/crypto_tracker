import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme); 
    return result;
  }

  static Future<String?> getTheme() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currentState = sharedPreferences.getString("theme");
    return currentState;
  }

  static Future<bool> addFavorite(String id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favrorites = sharedPreferences.getStringList("favorites") ?? [];
    favrorites.add(id);
    return await sharedPreferences.setStringList("favorites", favrorites);

  }

  static Future<bool> removeFavorite(String id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favrorites = sharedPreferences.getStringList("favorites") ?? [];
    favrorites.remove(id);
    return await sharedPreferences.setStringList("favorites", favrorites);
  }

  static Future<List<String>> fetchFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getStringList("favorites") ?? [];
  }

}