import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturesPage extends StatelessWidget {
  final List<Feature> features = [
    Feature(
      name: "Complaints",
      icon: Icons.comment,
      onTap: (context) {
        // Complaints Dialog with Image and Text
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Complaints'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The image displayed here
                Image.asset('lib/images/img.jpg'), // Ensure the image exists at the specified path
                const SizedBox(height: 10),
                const Text('Click below to proceed to the Complaint .'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // Close the dialog
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  const url = 'https://complain-frontend.vercel.app/';
                  Navigator.of(context).pop(); // Close the dialog before opening the URL
                  launch(url); // Directly launch the URL
                },
                child: const Text('Open in Browser'),
              ),
            ],
          ),
        );
      },
    ),
    Feature(
      name: "Requests",
      icon: Icons.request_page,
      onTap: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RequestFormPage()),
        );
      },
    ),
    Feature(
      name: "Vehicle Proximity",
      icon: Icons.location_on,
      onTap: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PlaceholderPage(title: "Vehicle Proximity")),
        );
      },
    ),
    Feature(
      name: "Feedback",
      icon: Icons.feedback,
      onTap: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeedbackFormPage()),
        );
      },
    ),
  ];

  FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FEATURES"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: features.map((feature) {
          return GestureDetector(
            onTap: () => feature.onTap(context),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    feature.icon,
                    size: 50,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    feature.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Feature {
  final String name;
  final IconData icon;
  final Function(BuildContext) onTap;

  Feature({required this.name, required this.icon, required this.onTap});
}

// Feedback Form Page
class FeedbackFormPage extends StatelessWidget {
  const FeedbackFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Form"),
        actions: [
          IconButton(
            icon: const Icon(Icons.email),
            onPressed: () {
              const emailUrl = 'mailto:complainbox757@gmail.com?subject=Feedback&body=Enter your feedback here';
              launch(emailUrl); // Directly launch the email client without error handling
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Feedback",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: feedbackController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your feedback here",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Feedback cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Feedback submitted successfully!")),
                      );
                      feedbackController.clear();
                    }
                  },
                  child: const Text("Submit Feedback"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Request Form Page
class RequestFormPage extends StatelessWidget {
  const RequestFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Form"),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView to avoid overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter your request details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Address cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Request Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Request submitted successfully!")),
                        );
                        // You can add logic here to send the request data to an API or save it locally
                        nameController.clear();
                        addressController.clear();
                        phoneController.clear();
                        descriptionController.clear();
                      }
                    },
                    child: const Text("Submit Request"),
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

// Placeholder Page for navigation
class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("This is the $title Page"),
      ),
    );
  }
}
