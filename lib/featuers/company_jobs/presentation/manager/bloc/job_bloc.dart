import 'package:bloc/bloc.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/InterviewResponseModel.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/Interview_use_case.dart';

import 'package:opporto_project/featuers/company_jobs/domain/use_case/application_job_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/delete_job_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/get_Job_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/get_interview_ues_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/jop_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/update_application_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/update_profile_ues_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/user_company_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JopUseCase jopUseCase;
  final UserCompanyUseCase userCompanyUseCase;
  final UpdateProfileUesCase updateProfileUseCase;
  final GetJobUseCase getJobUseCase;
  final ApplicationJobUseCase getApplicationsUseCase;
  final UpdateApplicationUseCase updateApplicationUseCase;
  final InterviewUseCase interviewUseCase;
  final GetInterviewUesCase getInterviewUesCase;
  final DeleteJobUseCase deleteJobUseCase;

  JobBloc({required this.jopUseCase,
    required this.userCompanyUseCase,
    required this.updateProfileUseCase,
    required this.getJobUseCase,
    required this.getApplicationsUseCase,
    required this.updateApplicationUseCase,
    required this.interviewUseCase,
    required this.getInterviewUesCase,
    required this.deleteJobUseCase,


  }) : super(JobState()) {
    on<AddJobEvent>(onAddJobEvent);
    on<GetMyJobsEvent>(onGetMyJobsEvent);
    on<GetUserDataEvent>(onGetUserDataEvent);
    on<UpdateProfileEvent>(onUpdateProfileEvent);
    on<GetApplicationsEvent>(onGetApplicationsEvent);
    on<UpdateApplicationStatusEvent>(onUpdateApplicationStatusEvent);
    on<ScheduleInterviewEvent>(onScheduleInterviewEvent);
    on<GetMyInterviewsEvent>(onGetMyInterviewsEvent);
    on<DeleteJobEvent>(onDeleteJobEvent);

  }

  void onAddJobEvent(AddJobEvent event, Emitter<JobState> emit){
    emit(state.copyWith(status: RequestStatus.loading));

    try{
      var result = jopUseCase.call(event.jobData, event.userToken);
      emit(state.copyWith(status: RequestStatus.success));
    }catch(e){
      emit(state.copyWith(status: RequestStatus.error));
    }


  }
  Future<void> onGetMyJobsEvent(GetMyJobsEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      var result = await getJobUseCase.call(event.token);
      emit(state.copyWith(
        status: RequestStatus.success,
        jobs: result,
      ));

    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error));
    }
  }
  Future<void> onDeleteJobEvent(DeleteJobEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      await deleteJobUseCase.call(event.id, event.token);
      final updatedJobs = state.jobs.where((job) => job.id != event.id).toList();
      emit(state.copyWith(
        status: RequestStatus.success,
        jobs: updatedJobs,
      ));} catch (e) {
      emit(state.copyWith(status: RequestStatus.error));
    }

  }
  Future<void> onGetUserDataEvent(GetUserDataEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      var result = await userCompanyUseCase.call(event.userToken);

      final mergedUser = state.userModel?.copyWith(
        name: result.name,
        phone: result.phone,
      );

      emit(state.copyWith(
        status: RequestStatus.success,
        userModel: mergedUser ?? result,
      ));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error));
    }
  }
  Future<void> onUpdateProfileEvent(UpdateProfileEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      await updateProfileUseCase.call(
        token: event.token,
        name: event.name,
        phone: event.phone,
        about: event.about,
        industry: event.industry,
      );

      emit(state.copyWith(
        status: RequestStatus.success,
        userModel: state.userModel?.copyWith(
          name: event.name,
          phone: event.phone,
          about: event.about,
          industry: event.industry,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RequestStatus.error,
        message: e.toString(),
      ));
    }
  }
  Future<void> onGetApplicationsEvent(GetApplicationsEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      var result = await getApplicationsUseCase.call(event.token);

      emit(state.copyWith(
        status: RequestStatus.success,
        applications: result,
      ));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error));
    }
  }
  Future<void> onUpdateApplicationStatusEvent(
      UpdateApplicationStatusEvent event, Emitter<JobState> emit) async {

    emit(state.copyWith(status: RequestStatus.loading));

    try {
      await updateApplicationUseCase.call(event.id, event.status, event.token);

      final updatedApplications = state.applications.map((app) {
        return app.id == event.id
            ? app.copyWith(status: event.status)
            : app;
      }).toList();

      emit(state.copyWith(
        status: RequestStatus.success,
        applications: updatedApplications,
      ));

    } catch (e) {
      emit(state.copyWith(
        status: RequestStatus.error,
        message: e.toString(),
      ));
    }
  }
  Future<void> onScheduleInterviewEvent(
      ScheduleInterviewEvent event,
      Emitter<JobState> emit,
      ) async {

    emit(state.copyWith(status: RequestStatus.loading));

    try {
      final result = await interviewUseCase.call(
        applicationId: event.applicationId,
        scheduledAt: event.scheduledAt,
        interviewType: event.interviewType,
        locationOrLink: event.locationOrLink,
        token: event.token,
        notes: event.notes,
      );

      final currentList = state.interviews;

      final updatedList = List<InterviewData>.from(currentList)
        ..add(result);

      emit(state.copyWith(
        status: RequestStatus.success,
        interviews: updatedList,
      ));

    } catch (e) {
      emit(state.copyWith(
        status: RequestStatus.error,
        message: e.toString(),
      ));
    }
  }
  Future<void> onGetMyInterviewsEvent(
      GetMyInterviewsEvent event,
      Emitter<JobState> emit,
      ) async {

    emit(state.copyWith(status: RequestStatus.loading));

    try {
      final result = await getInterviewUesCase.call(event.token);

      emit(state.copyWith(
        status: RequestStatus.success,
        interviews: result,
      ));

    } catch (e) {
      emit(state.copyWith(
        status: RequestStatus.error,
        message: e.toString(),
      ));
    }
  }
}
