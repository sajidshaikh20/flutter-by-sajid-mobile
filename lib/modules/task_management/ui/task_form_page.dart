import 'package:intl/intl.dart';
import '../../../utils/exports.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import '../model/task_model.dart';
import '../repository/task_repository_impl.dart';

@RoutePage()
/// Unified page for adding or editing a task.
/// If [task] is null, it's in add mode. If [task] is provided, it's in edit mode.
class TaskFormPage extends StatelessWidget {
  /// Creates a [TaskFormPage].
  /// [task] is optional - null for add mode, provided for edit mode.
  const TaskFormPage({this.task, super.key});

  /// The task to edit. If null, the page is in add mode.
  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (BuildContext context) => TaskCubit(
        repository: TaskRepositoryImpl(),
      ),
      child: TaskFormView(task: task),
    );
  }
}

/// View widget for the task form.
class TaskFormView extends StatefulWidget {
  /// Creates a [TaskFormView].
  const TaskFormView({this.task, super.key});

  /// The task to edit. If null, the page is in add mode.
  final TaskModel? task;

  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late DateTime _selectedDate;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _isEditMode = widget.task != null;
    
    if (_isEditMode) {
      _titleController = TextEditingController(text: widget.task!.title);
      _descriptionController = TextEditingController(text: widget.task!.description);
      _selectedDate = widget.task!.dueDate;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _selectedDate = DateTime.now().add(const Duration(days: 1));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MainConfig.appColors.mainColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MainConfig.appColors.mainColor,
              ),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                color: Colors.black,
                fontSize: Dimens.fontSize20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MainConfig.appColors.mainColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MainConfig.appColors.mainColor,
              ),
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      if (_isEditMode) {
        final TaskModel updatedTask = widget.task!.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          dueDate: _selectedDate,
        );
        await context.read<TaskCubit>().updateTask(updatedTask);
      } else {
        final TaskModel newTask = TaskModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          dueDate: _selectedDate,
          createdAt: DateTime.now(),
        );
        await context.read<TaskCubit>().addTask(newTask);
      }

      if (mounted) {
        Navigator.of(context).pop(true); // Return true to indicate success
        displaySnackBar(
          _isEditMode ? 'Task updated successfully' : 'Task added successfully',
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: CustomTextLabelWidget(
          label: _isEditMode ? 'Edit Task' : 'Add Task',
          textAlign: TextAlign.start,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title *',
                  hintText: 'Enter task title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Enter task description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 4,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task description';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const CustomTextLabelWidget(
                        label: 'Due Date & Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _selectDate(context),
                              icon: const Icon(Icons.calendar_today),
                              label: CustomTextLabelWidget(
                                label: DateFormat('MMM dd, yyyy').format(_selectedDate),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _selectTime(context),
                              icon: const Icon(Icons.access_time),
                              label: CustomTextLabelWidget(
                                label: DateFormat('hh:mm a').format(_selectedDate),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<TaskCubit, TaskState>(
                builder: (BuildContext context, TaskState state) {
                  return ElevatedButton(
                    onPressed: state.status == BaseStateStatus.loading
                        ? null
                        : _saveTask,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: state.status == BaseStateStatus.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : CustomTextLabelWidget(
                            label: _isEditMode ? 'Update Task' : 'Save Task',
                            style: const TextStyle(fontSize: 16),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

