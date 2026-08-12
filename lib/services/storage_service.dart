
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final client = Supabase.instance.client;

  Future<String> uploadOfferImage({
    required String offerId,
    required Uint8List bytes,
    required String extension,
  }) async {
    final path = '${client.auth.currentUser!.id}/$offerId/${DateTime.now().millisecondsSinceEpoch}.$extension';
    await client.storage.from('offer-images').uploadBinary(path, bytes);
    return client.storage.from('offer-images').getPublicUrl(path);
  }
}
