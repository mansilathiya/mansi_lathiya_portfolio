import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailJSService {
  static const serviceId = 'service_9hux04f';
  static const templateId = 'template_t0tx4ei';
  static const publicKey = 'QNG-00HcW6ar1ffe6';

  static Future<bool> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'https://mansi-lathiya-portfolio.vercel.app',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey,
        'template_params': {
          'from_name': name,
          'from_email': email,
          'subject': subject,
          'message': message,
        },
      }),
    );
    return response.statusCode == 200;
  }
}
