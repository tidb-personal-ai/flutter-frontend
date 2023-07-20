import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumios/providers/ai_provider.dart';

class CreateAiScreen extends ConsumerStatefulWidget {
  const CreateAiScreen({super.key, required this.aiProvider});

  final Refreshable<AiProvider> aiProvider;

  @override
  ConsumerState<CreateAiScreen> createState() => _CreateAiScreenState();
}

class _CreateAiScreenState extends ConsumerState<CreateAiScreen> {  
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _items = [
    'Adaptable',
    'Articulate',
    'Benevolent',
    'Brave',
    'Charismatic',
    'Cheerful',
    'Determined',
    'Diplomatic',
    'Efficient',
    'Energetic',
    'Farsighted',
    'Friendly',
    'Generous',
    'Humble',
    'Harmonious',
    'Imaginative',
    'Inventive',
    'Joyful',
    'Jovial',
    'Kind',
    'Knowledgeable',
    'Logical',
    'Loyal',
    'Meticulous',
    'Motivated',
    'Noble',
    'Nurturing',
    'Observant',
    'Optimistic',
    'Patient',
    'Proactive',
    'Quiet',
    'Quick-thinking',
    'Resilient',
    'Respectful',
    'Stoic',
    'Sincere',
    'Trustworthy',
    'Tolerant',
    'Unbiased',
    'Understanding',
    'Versatile',
    'Vivacious',
    'Wise',
    'Witty',
    'Yielding',
    'Youthful',
    'Zealous',
    'Zestful',
  ];
  final List<String> _selectedItems = [];
  final _dropdownKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Create AI')),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        key: _dropdownKey,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        hint: const Text('Select the traits for the AI'),
                        validator: (value) {
                          if (_selectedItems.isEmpty && (value?.isEmpty ?? true)) {
                            return 'Please select at least one trait';
                          }
                          if (_selectedItems.contains(value)) {
                            return 'Please select a different trait';
                          }
                          if(_selectedItems.length == 3 && (value?.isNotEmpty ?? false)) {
                            return 'Please select no more than 3 traits';
                          }
                          return null;
                        },
                        onChanged: (String? newValue) {
                          if(_dropdownKey.currentState!.validate()) {
                            setState(() {
                              _selectedItems.add(newValue!);
                              _dropdownKey.currentState!.reset();
                            });
                          }
                        },
                        items: _items.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: _selectedItems.map((item) {
                          return ListTile(
                            title: Text(item),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                setState(() {
                                  _selectedItems.remove(item);
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ref.read(widget.aiProvider).createAi(_nameController.text, _selectedItems);
                            }
                          },
                          child: const Text('Create'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) => Navigator.pushNamed(context, '/login'));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: const Text('Logout'),
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
