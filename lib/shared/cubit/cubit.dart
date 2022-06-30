import 'package:flutter_assignment_ali/models/user_model.dart';
import 'package:flutter_assignment_ali/models/posts_model.dart';
import 'package:flutter_assignment_ali/shared/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../netWork/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? model;
  void getUsers() {
    emit(LoadingUsersState());
    DioHelper.getData(
      url:
          'https://my-json-server.typicode.com/SharminSirajudeen/test_resources/users',
    ).then((value) {
      model = UserModel.fromJson(value.data);
      for (var element in model!.data) {
        getPostsCount(element.userId!);
      }

      emit(GetUsersSuccessState());
    }).catchError((error) {
      emit(GetUsersErrorState());
    });
  }

  Map<int, int> postsCount = {};
  PostsModel? postsModel;
  void getPostsCount(int userId) {
    int sum = 0;
    emit(LoadingPostsState());
    DioHelper.getData(
      url:
          'https://my-json-server.typicode.com/SharminSirajudeen/test_resources/posts',
    ).then((value) {
      postsModel = PostsModel.fromJson(value.data);
      for (var element in postsModel!.data) {
        if (element.userId == userId) {
          sum++;
        }
      }

      postsCount.addAll({userId: sum});
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }

  List<PostData> userPosts = [];
  void getPost(int userId) {
    emit(LoadingPostsState());
    DioHelper.getData(
      url:
          'https://my-json-server.typicode.com/SharminSirajudeen/test_resources/posts',
    ).then((value) {
      postsModel = PostsModel.fromJson(value.data);
      for (var element in postsModel!.data) {
        if (element.userId == userId) {
          userPosts.add(element);
        }
      }

      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }
}
