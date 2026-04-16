import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class UpdateApplicationUseCase {
  JopRepo jopRepo;
  UpdateApplicationUseCase({required this.jopRepo});
  Future<void> call(String id, String status, String token) async {
    try {
      await jopRepo.updateApplicationStatus(id, status, token);
    } catch (e) {
      rethrow;
    }
  }
}