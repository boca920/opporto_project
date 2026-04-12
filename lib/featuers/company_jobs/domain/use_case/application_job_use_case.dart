import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class ApplicationJobUseCase {
  JopRepo jopRepo;
  ApplicationJobUseCase({required this.jopRepo});
  Future<List<ApplicationModel>> call(String token) async {
    try {
      return await jopRepo.getApplications(token);
    } catch (e) {
      rethrow;

    }
  }
}