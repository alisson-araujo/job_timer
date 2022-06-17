import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_pie_chart.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_task_tile.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailController controller;
  const ProjectDetailPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.failure) {
            AsukaSnackbar.alert('Erro interno');
          }
        },
        builder: (context, state) {
          final projectModel = state.projectModel;

          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Carregando projeto'),
              );
            case ProjectDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProjectDetailStatus.complete:
              return _buildProjectDetail(context, projectModel!);
            case ProjectDetailStatus.failure:
              if (projectModel != null) {
                return _buildProjectDetail(context, projectModel);
              }
              return const Center(
                child: Text('Erro ao carregar projeto'),
              );
          }
        },
      ),
    );
  }

  Widget _buildProjectDetail(BuildContext context, ProjectModel projectModel) {
    return CustomScrollView(
      slivers: [
        ProjectDetailAppbar(
          projectModel: projectModel,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
              child: ProjectPieChart(),
            ),
            ProjectTaskTile(),
            ProjectTaskTile(),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                  label: const Text('Finalizar projeto')),
            ),
          ),
        )
      ],
    );
  }
}
