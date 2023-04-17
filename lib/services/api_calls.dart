import 'package:flutter/material.dart';
import 'package:insuretech_ja_assure/services/media_service.dart';
import 'package:insuretech_ja_assure/widgets/show_snack_bar.dart';

class APICalls {
  late final MediaService _mediaService;
  late BuildContext _context;

  APICalls(BuildContext context) {
    _mediaService = MediaService();
    _context = context;
  }

  createPolicy(Map<String, dynamic> data) {
    try {
      var response = _mediaService.post(
        '/policy/newPolicy/643d7d8385ea2ebf2f6b2a60',
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
