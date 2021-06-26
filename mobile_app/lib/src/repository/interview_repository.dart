import 'dart:convert';
import 'package:http/http.dart';

import 'package:interview_app/src/repository/network_config.dart';

class _InterviewRepository {
  Client _client = Client();

  Future<Response> getInterviews() async {
    return await _client.get(
      Uri.parse('$baseURL/interview/all'),
    );
  }

  Future<Response> scheduleInterview(int startTiming, int endTiming,
      int interviewerId, int intervieweeId) async {
    return await _client.post(
      Uri.parse('$baseURL/interview/'),
      body: jsonEncode(<String, dynamic>{
        'startTiming': startTiming,
        'endTiming': endTiming,
        'interviewerId': interviewerId,
        'intervieweeId': intervieweeId
      }),
    );
  }

  Future<Response> modifyInterview(int startTiming, int endTiming,
      int interviewerId, int intervieweeId, int id) async {
    return await _client.put(
      Uri.parse('$baseURL/interview/'),
      body: jsonEncode(<String, dynamic>{
        'startTiming': startTiming,
        'endTiming': endTiming,
        'interviewerId': interviewerId,
        'intervieweeId': intervieweeId,
        'id': id
      }),
    );
  }

  Future<Response> checkAvailability(int startTiming, int endTiming,
      int interviewerId, int intervieweeId, int id) async {
    return await _client.post(
      Uri.parse('$baseURL/interview/check'),
      body: jsonEncode(<String, dynamic>{
        'startTiming': startTiming,
        'endTiming': endTiming,
        'interviewerId': interviewerId,
        'intervieweeId': intervieweeId,
      }),
    );
  }
}

_InterviewRepository? _interviewRepository;

_InterviewRepository get interviewRepository {
  if (_interviewRepository == null) {
    _interviewRepository = _InterviewRepository();
  }
  return _interviewRepository!;
}
