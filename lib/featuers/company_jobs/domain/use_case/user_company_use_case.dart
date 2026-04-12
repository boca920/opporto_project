import 'package:opporto_project/core/model/user_model.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class UserCompanyUseCase {
  JopRepo jopRepo;
  UserCompanyUseCase({required this.jopRepo});

  Future<UserModel> call(String token)async{
    return await jopRepo.getUserData(token);
  }
}