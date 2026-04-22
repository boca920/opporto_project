import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class UpdateJobUseCase {
  final JopRepo repo;

  UpdateJobUseCase({required this.repo});

  Future<JobModel> call({
    required String id,
    required String token,
    required Map<String, dynamic> data,
  }) {
    return repo.updateJob(
      id: id,
      token: token,
      data: data,
    );
  }
}