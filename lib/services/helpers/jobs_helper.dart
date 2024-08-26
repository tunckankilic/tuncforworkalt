import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuncforworkalt/models/response/jobs/get_job.dart';
import 'package:tuncforworkalt/models/response/jobs/jobs_response.dart';

class JobsHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<JobsResponse>> getJobs() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('jobs').get();

      List<JobsResponse> jobsList = querySnapshot.docs
          .map((doc) => JobsResponse.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return jobsList;
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<GetJobRes> getJob(String jobId) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('jobs').doc(jobId).get();

      if (documentSnapshot.exists) {
        return GetJobRes.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("Job not found");
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<JobsResponse> getRecent() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('jobs')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return JobsResponse.fromJson(querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        throw Exception("No jobs found");
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<JobsResponse>> searchJobs(String searchQuery) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('jobs')
          .where('title', isGreaterThanOrEqualTo: searchQuery)
          .where('title', isLessThan: searchQuery + 'z')
          .get();

      List<JobsResponse> jobsList = querySnapshot.docs
          .map((doc) => JobsResponse.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return jobsList;
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
}