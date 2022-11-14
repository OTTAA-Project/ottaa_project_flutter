import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServerRepository implements ServerRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> init() async {
    await Supabase.initialize(
      url: "https://your-supabase-url.supabase.co",
      anonKey: "your-supabase-anon-key",
    );
  }

  @override
  Future<void> close() async {
    return supabase.dispose();
  }

  @override
  Future<List<Map<String, dynamic>>?> getAllGroups(String userId, String languageCode) async {
    final List<Map<String, dynamic>> groups = [];

    final PostgrestResponse<dynamic> value = await supabase.from('groups').select().eq('user_id', userId).eq('language_code', languageCode);

    for (final row in value.data) {
      groups.add(row);
    }

    return groups;
  }

  @override
  Future<List<Map<String, dynamic>>?> getAllPictograms(String userId, String languageCode) async {
    final List<Map<String, dynamic>> pictograms = [];

    final PostgrestResponse<dynamic> value = await supabase.from('pictograms').select().eq('user_id', userId).eq('language_code', languageCode);

    for (final row in value.data) {
      pictograms.add(row);
    }

    return pictograms;
  }

  @override
  Future<String> getAvailableAppVersion() async {
    final PostgrestResponse<dynamic> value = await supabase.from('app_version').select().eq('platform', 'android').single();

    return value.data['version'];
  }

  @override
  Future<Map<String, dynamic>?> getUserInformation(String id) async {
    final PostgrestResponse<dynamic> value = await supabase.from('users').select().eq('id', id).single();

    return value.data;
  }

  @override
  Future<String?> getUserProfilePicture(String userId) async {
    final PostgrestResponse<dynamic> value = await supabase.from('users').select().eq('id', userId).single();

    return value.data['profile_picture'];
  }

  @override
  Future<List<Map<String, dynamic>>> getUserSentences(String userId, {required String language, required String type, bool isFavorite = false}) async {
    final List<Map<String, dynamic>> sentences = [];

    final PostgrestResponse<dynamic> value = await supabase.from('sentences').select().eq('user_id', userId).eq('language_code', language).eq('type', type).eq('is_favorite', isFavorite);

    for (final row in value.data) {
      sentences.add(row);
    }

    return sentences;
  }

  @override
  Future<UserType> getUserType(String userId) async {
    final PostgrestResponse<dynamic> value = await supabase.from('payments').select().eq('id', userId).single();

    if (value.data == null) return UserType.free;

    return UserType.premium;
  }

  @override
  Future<void> updateGroup(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    await supabase.from('groups').update(data).eq('user_id', userId).eq('language_code', language).eq('index', index);
  }

  @override
  Future<void> updatePictogram(String userId, String language, int index, {required Map<String, dynamic> data}) async {
    await supabase.from('pictograms').update(data).eq('user_id', userId).eq('language_code', language).eq('index', index);
  }

  @override
  Future<void> uploadGroups(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    await Future.forEach(data, (group) => supabase.from('groups').insert(group).eq('user_id', userId).eq('language_code', language));
  }

  @override
  Future<void> uploadPictograms(String userId, String language, {required List<Map<String, dynamic>> data}) async {
    await Future.forEach(data, (pictogram) => supabase.from('pictograms').insert(pictogram).eq('user_id', userId).eq('language_code', language));
  }

  @override
  Future<void> uploadUserInformation(String userId, Map<String, dynamic> data) async {
    await supabase.from('users').insert(data).eq('id', userId);
  }

  @override
  Future<void> uploadUserPicture(String userId, String picture, String photoUrl) async {
    await supabase.from('users').update({'profile_picture': picture, 'photo_url': photoUrl}).eq('id', userId);
  }

  @override
  Future<void> uploadUserSentences(String userId, String language, String type, List<Map<String, dynamic>> data) async {
    await Future.forEach(data, (sentence) => supabase.from('sentences').insert(sentence).eq('user_id', userId).eq('language_code', language).eq('type', type));
  }
}
