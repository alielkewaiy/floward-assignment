import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment_ali/modules/screen_two.dart';
import 'package:flutter_assignment_ali/shared/cubit/cubit.dart';
import 'package:flutter_assignment_ali/shared/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUsers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Users'),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,

                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
              ),
            ),
            body: ConditionalBuilder(
              condition: state is LoadingUsersState,
              fallback: (context) => ListView.separated(
                  itemBuilder: (context, index) =>
                      buildUserItem(cubit.model!.data[index], context),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 2,
                      ),
                  itemCount: cubit.model!.data.length),
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  Widget buildUserItem(UserData? userData, context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .1), offset: Offset(6, 8)),
              ],
              borderRadius: BorderRadiusDirectional.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsetsDirectional.all(0),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PostsScreen(userData!.url!, userData.userId!)));
              },
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(userData!.url!),
              ),
              title: Text(
                '${userData.name}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle:
                  Text('${AppCubit.get(context).postsCount[userData.userId]}'),
            ),
          ),
        ),
      );
}
