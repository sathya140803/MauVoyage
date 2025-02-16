import 'dart:io';

import 'dart:io';

import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_application/content/cloudinary_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../acc_management/authentications.dart'; // Add this package to handle image picking
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_url_gen/transformation/effect/effect.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';

var cloudinary = Cloudinary.fromStringUrl('cloudinary://536692114862856:9iIxu8-2cfLXuT_xwgKbCpsANSk@dtxlmb6ap');


Future<dynamic> uploadImage(File img) async{
  cloudinary.config.urlConfig.secure = true;
  var response = await cloudinary.uploader().upload(img,
      params: UploadParams(
          publicId: AuthService().getCurrentUser()?.uid,
          uniqueFilename: false,
          overwrite: true,
          invalidate: true
      )
  );
  return response;
}

Future<dynamic> getImage(String id) async{
  cloudinary.config.urlConfig.secure = true;
  return await cloudinary.image(id).toString();
}