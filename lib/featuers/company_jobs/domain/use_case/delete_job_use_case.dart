import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class DeleteJobUseCase {
  JopRepo jopRepo;
  DeleteJobUseCase({required this.jopRepo});

  Future<void> call(String id, String token) async {
    try {
      await jopRepo.deleteJob(id, token);
    } catch (e) {
      rethrow;
    }
  }

}