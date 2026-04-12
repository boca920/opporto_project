import 'dart:io';

import 'package:opporto_project/core/model/user_model.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class UpdateProfileUesCase {
  JopRepo jopRepo;
  UpdateProfileUesCase({required this.jopRepo});

  Future<UserModel> call ({required String token, required String name, required String phone, String? about, String? industry, File? imageFile}) async {
    return await jopRepo.updateProfile(
      token: token,
      name: name,
      phone: phone,
      about: about,
      industry: industry,
      imageFile: imageFile,
    );

  }

}