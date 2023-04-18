import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insuretech_ja_assure/data/policies_data.dart';
import 'package:insuretech_ja_assure/services/media_service.dart';
import 'package:insuretech_ja_assure/widgets/show_snack_bar.dart';

class APICalls {
  late final MediaService _mediaService;
  late BuildContext _context;

  APICalls(BuildContext context) {
    _mediaService = MediaService();
    _context = context;
  }

  createPolicy(Map<String, dynamic> data) async {
    try {
      print("LJSDF");
      var response = await _mediaService.post(
        '/policy/newPolicy/643e290bc106c626d12f6c17',
        data,
      );
      return response;
    } catch (e) {
      showSnackBar(
        _context,
        e.toString(),
        Colors.red,
      );
    }
  }

  Future<PolicyDetails> getAllPolicies() async {
    try {
      var response = await _mediaService.get(
        '/policy/getAllPolicies/643e290bc106c626d12f6c17',
      );
      return PolicyDetails.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      showSnackBar(
        _context,
        e.toString(),
        Colors.red,
      );
    }
    return PolicyDetails();
  }

  claimPolicy(String pid, Map<String, dynamic> data) async {
    try {
      var response = await _mediaService.post(
        '/claimAdd/643e290bc106c626d12f6c17/${pid}',
        data,
      );
      return response;
    } catch (e) {
      showSnackBar(
        _context,
        e.toString(),
        Colors.red,
      );
    }
  }
}
