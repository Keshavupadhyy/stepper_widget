import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddressStepperPage(),
    );
  }
}

class AddressStepperPage extends StatefulWidget {
  @override
  _AddressStepperPageState createState() => _AddressStepperPageState();
}

class _AddressStepperPageState extends State<AddressStepperPage> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  List<Step> getSteps() => [
        Step(
          title: Text("Personal Info"),
          content: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Phone Number"),
              ),
            ],
          ),
          isActive: _currentStep >= 0,
          state: _currentStep >= 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text("Address"),
          content: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Street Address"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "City"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Postal Code"),
              ),
            ],
          ),
          isActive: _currentStep >= 1,
          state: _currentStep >= 2 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text("Payment"),
          content: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Credit Card Number"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Expiration Date"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "CVV"),
              ),
            ],
          ),
          isActive: _currentStep >= 2,
          state: _currentStep >= 3 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text("Confirm"),
          content: Column(
            children: [
              Text("Please review and confirm your details."),
            ],
          ),
          isActive: _currentStep >= 3,
          state: _currentStep >= 4 ? StepState.complete : StepState.indexed,
        ),
      ];

  void _nextStep() {
    if (_currentStep < getSteps().length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout Process")),
      body: Form(
        key: _formKey,
        child: Stepper(
          steps: getSteps(),
          currentStep: _currentStep,
          onStepContinue: _nextStep,
          onStepCancel: _prevStep,
          onStepTapped: (step) => setState(() => _currentStep = step),
          controlsBuilder: (context, ControlsDetails details) {
            return Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text('Continue'),
                ),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text('Back'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
