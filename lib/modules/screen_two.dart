import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_ali/models/posts_model.dart';
import 'package:flutter_assignment_ali/shared/cubit/cubit.dart';
import 'package:flutter_assignment_ali/shared/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class PostsScreen extends StatelessWidget {
  final String imageUrl;
  final int userId;

  const PostsScreen(this.imageUrl, this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => AppCubit()..getPost(userId),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Scaffold(
              body: ConditionalBuilder(
                condition: state is LoadingPostsState,
                fallback: (context) => Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 30.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(3.5.h),
                              bottomLeft: Radius.circular(3.5.h)),
                          child: Image(
                              fit: BoxFit.cover, image: NetworkImage(imageUrl)),
                        )),
                    Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildPostItem(cubit.userPosts[index]),
                          separatorBuilder: (context, state) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Container(
                                  color: Colors.grey[200],
                                  height: 3,
                                ),
                              ),
                          itemCount: cubit.userPosts.length),
                    ),
                  ],
                ),
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        ),
      );
    });
  }

  Widget buildPostItem(PostData postData) => Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(15),
            border: Border.all(color: Colors.grey.shade400, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${postData.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('${postData.body}'),
              ],
            ),
          ),
        ),
      );
}
