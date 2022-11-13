import 'dart:convert';

import 'package:http/http.dart' as http;
Future sendEmail({required String name, required String email}) async {
  final serviceId = 'service_h7p3f7v';
  final templateId = 'template_62olkxd';
  final userId = 'YQqWSSYMoKFLItixW';
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id' : templateId,
      'user_id': userId,
      'template_params': {
        'user_name' : name,
        'to_email' : email,
      }
    }),

  );
  print(response.body);
}
