import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/applicant_details_screen/applicant_details_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/vacancy_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(title: "Welcome to Opporto", isBack: false,),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Posted Vacancy", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const VacancyCard(
                  jobTitle: "Junior Front-End Developer",
                  jobType: "Full time . Remotely",
                  logoPath: "assets/images/logo1.png",
                ),
                const SizedBox(height: 20),
                const Text("Applications", style: TextStyle(fontWeight: FontWeight.bold)),


                ApplicationCard(
                  name: "Mark Kamel",
                  subtitle: "Junior Front-End Developer",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.indigo),
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicantDetailsScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}