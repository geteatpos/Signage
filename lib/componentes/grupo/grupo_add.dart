import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signages/controllers/main_controller.dart';

class AddGrupo extends StatefulWidget {
  final String restaurantId;
  const AddGrupo({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<AddGrupo> createState() => _AddGrupoState();
}

class _AddGrupoState extends State<AddGrupo> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  hintText: "Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_controller.text.trim().isNotEmpty) {
                    MainController.to.addGrupo(
                      widget.restaurantId,
                      _controller.text.trim(),
                    );
                    Get.back();
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
