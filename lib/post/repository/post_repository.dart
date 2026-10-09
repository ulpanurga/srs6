import 'dart:convert';

import 'package:srssix/models/get_posts.dart';
import 'package:srssix/post/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final _baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<void> getPosts(GetPostEvent event, Emitter<PostState> emit) async {
    emit(LoadingPostState());
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      final List<dynamic> jsonList = jsonDecode(response.body);
      final getPosts = jsonList.map((json) => Posts.fromJson(json)).toList();
      emit(FetchedPostsState(getPosts));
    } catch (e) {
      emit(FailurePostState());
    }
  }
}