import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/button_with_loader.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;
  const TaskPage({super.key, required this.controller});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEc = TextEditingController();
  final _durationEc = TextEditingController();

  @override
  void dispose() {
    _nameEc.dispose();
    _durationEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.sucess) {
          Navigator.pop(context);
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar task').show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Criar nova task',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEc,
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                  validator: Validatorless.required('Nome é obrigatório'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _durationEc,
                  decoration: const InputDecoration(
                    label: Text('Duração da task'),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatória'),
                    Validatorless.number('permitido somente números'),
                  ]),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == TaskStatus.loading,
                    label: 'Salvar',
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final duration = int.parse(_durationEc.text);
                        widget.controller.register(_nameEc.text, duration);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
