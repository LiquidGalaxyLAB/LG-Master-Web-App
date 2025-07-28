<div><center>
<img src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjzI4JzY6oUy-dQaiW-HLmn5NQ7qiw7NUOoK-2cDU9cI6JwhPrNv0EkCacuKWFViEgXYrCFzlbCtHZQffY6a73j6_ATFjfeU7r6OxXxN5K8sGjfOlp3vvd6eCXZrozlu34fUG5_cKHmzZWa4axb-vJRKjLr2tryz0Zw30gTv3S0ET57xsCiD25WMPn3wA/s800/LIQUIDGALAXYLOGO.png" height="80" alt="LG logo"> <img src="https://media.licdn.com/dms/image/v2/D5622AQFBOm69p-dqTw/feedshare-shrink_800/feedshare-shrink_800/0/1726943125286?e=2147483647&v=beta&t=lb1DLkLO9TE_f32YzmFLJc7QxIMUEvBjZdu2IvImTdw" height="80" alt="GSoC 2025"> <img src="images/LGMasterWebAppLogo.png" height="100" alt="LG Master Web App logo">
</center></div>


# Liquid Galaxy Master Web and Flutter Application 


## INDEX

1. [Introduction. What is this guide, and how does it work?](#id1)
2. [Onboarding](#id2)  
   2.1. [Getting started and bonding period](#id21)  
   2.2. [Prepare your environment setup](#id22) 
   2.3. [GitHub methodology](#id23) 
   2.4. [Deliverables and documentation](#id24) 
3. [Project types and technologies](#id3) 
4. [Liquid Galaxy](#id4)  
   4.1. [What is Liquid Galaxy?](#id41)  
   4.2. [Essential LG functions](#id42) 
   4.3. [Data transmission to the Liquid Galaxy and KML management](#id43)  
5. [Flutter](#id5)  
   5.1. [What is Flutter?](#id51)  
   5.2. [How does Flutter work?](#id52) 
6. [Technical requirements and best practices](#id6)  
   6.1. [Rig testing and compatibility](#id61)  
   6.2. [Code quality and AI usage policy](#id62) 
   6.3. [Accessibility features and user experience/interface (UX/UI)](#id63) 
   6.4. [API key policy and Google services](#id64) 
7. [Responsibility and professionalism](#id7)  
   7.1. [Meeting schedule and attendance](#id71)  
   7.2. [Discord and email communication](#id72) 
   7.3. [Weekly Vlogs](#id73) 
   7.4. [Open source](#id74)
8. [Common mistakes and how to avoid them](#id8)
9. [Start your project](#id9)   
   9.1. [Minimum app features / screens](#id91) 
   9.2. [Code structure](#id92) 
   9.3. [How a Dart project works](#id93)
   9.4. [Phone and tablet emulator](#id94)
10. [Automatically generated files](#id10)
   10.1. [.dart_tool](#id101)
   10.2. [.flutter-plugins-dependencies](#id102)
11. [Your whole project step by step](#id11)  
   11.1. [.idea](#id111)
   11.2. [android](#id112)
   11.3. [assets](#id113)
   11.4. [ios](#id114)
   11.5. [lib](#id115)
   11.6. [linux](#id116)
   11.7. [macos](#id117)
   11.8. [node_server](#id118)
   11.9. [test](#id119)
   11.10. [web](#id1110)
   11.11. [windows](#id1111)
   11.12. [.env](#id1112)
   11.13. [.gitignore](#id1113)
   11.14. [.metadata](#id1114)
   11.15. [analysis_options.yaml](#id1115)
   11.16. [lg_master_web_app.iml](#id1116)
   11.17. [pubspec.lock](#id1117)
   11.18. [pubspec.yaml](#id1118)
12. [Further resources and documentation](#id12)
13. [Projects used to create this project](#id13)  

---

<h2 id="id1"> 1. Introduction. What is this guide, and how does it work? </h2>

Welcome to Google Summer of Code (GSoC) and to the Liquid Galaxy project! First and foremost, congratulations on being selected, as you are about to start a journey full of learning and professional growth. Starting a new project like this can feel intimidating or even overwhelming, especially if you’re unfamiliar with technologies like Liquid Galaxy, Flutter, or GitHub. However, you are not alone! This comprehensive guide has been carefully crafted to support you through every step of your GSoC experience, whether you are a complete beginner or already have some experience.
The purpose of this document is to serve as an all-in-one resource for anyone beginning their GSoC project with Liquid Galaxy. It complements a code repository that contains essential files and demonstrates how to build a basic Liquid Galaxy application, including its core screens and functionalities. Each line of code in this repository is commented with detailed explanations about what that line does and how it contributes to the overall structure of the file, making it easy to understand and follow. In this guide, everything is explained from scratch with examples, practical advice, and even links for further exploration. You will find key concepts explained step-by-step (from the technologies you will be using to how to structure your project), as well as overviews of project structure and organization, common mistakes and how to avoid them, and additional resources like documentation or previous projects in case you want to dig deeper. 
You are encouraged to use this guide as both a walkthrough and a reference manual, using it as a tutorial you can follow from the beginning or just jumping to specific sections whenever you need help. Also, as it was just said, alongside this guide you will have access to a project repository designed as a starting point. It shows how to organize your folders and files, where to place different functionalities, how to handle the configuration and connection to the Liquid Galaxy system, etc. Feel free to copy this code and adapt it for your project! That’s exactly what it was made for, so you already have somewhere to start.
GSoC is a challenge and can feel like a lot sometimes, but it is also a great opportunity! It is important to remember that mistakes are a natural part of learning, so don’t hesitate to reach out to your mentor for guidance. Above all, keep in mind that every small step forward counts. Each line of code, every solved bug, every problem solved, and every new concept learnt brings you closer to successfully completing your project. This guide is here to make sure you have all the tools and knowledge necessary to make your GSoC experience as easy and rewarding as possible. Welcome once again, and happy coding! :) 


<h2 id="id2"> 2. Onboarding </h2>

Working on your GSoC project is both an exciting and rewarding experience, but it can also feel overwhelming, especially if you don’t really know where or how to start. In order to make this process smoother, the Liquid Galaxy team offers a clear and structured onboarding process designed to help you integrate easily into both the development environment and the broader GSoC framework. This section outlines the most important steps to help you start strong and establish good habits that will support your progress throughout the entire program.

<h3 id="id21"> 2.1. Getting started and bonding period </h3>

The bonding period is a crucial phase for laying the foundation of your project and building a strong working relationship with your mentor (or mentors). This period takes place before the official coding phase begins (for exact dates, please refer to the [Liquid Galaxy website](https://www.liquidgalaxy.eu/)) and serves as an opportunity to clarify expectations, ask questions, and plan your project in detail. Its main purpose is to get to know your mentor, clear up any uncertainties, and overall make sure everyone is aligned before development begins.
Once GSoC officially starts, you will receive an email to schedule your first project meeting, which will involve your main mentor, listening mentors and potentially other team members. It is mandatory to attend this meeting LIVE, as it is essential for setting clear goals and making sure your project starts on the right track. While other collaborators (such as listening mentors) may attend to observe and/or take notes, only assigned mentors and contributors are expected to actively speak and participate.
During this initial meeting, you will present and refine your initial project proposal, define specific objectives and deliverables and confirm the technologies and tools you will be using. For this, you will also break down the project into clear milestones and assign realistic deadlines. This meeting sets the groundwork for your GSoC experience, and listening mentors will often take notes to document all key decisions and discussions for future reference. It is also essential to establish a regular meeting schedule with your main mentor (ideally meeting at least once a week) and, when doing so, make sure to use a clear and consistent naming convention, like for example GSoC_contributor_mainMentor_projectName. This helps avoid confusion in the shared team’s calendar and makes sure meetings are easy to identify, as mentors may be in charge of more than one contributor.
Remember, mentors are there to guide you and support you, not to write your code. Respect their time and take meetings seriously by being punctual, prepared, and proactive. Be ready to share the progress you have made since the last meeting, as well as any issues or questions you may have. Goals should be set collaboratively, and it is your responsibility to meet the deadlines you agree upon, as establishing a consistent workflow and transparent communication from the very beginning will set the tone for a successful and productive GSoC experience.

<h3 id="id22"> 2.2. Prepare your environment setup </h3>

Before you can begin coding, you will need to set up your development environment. This setup is critical not only for testing your code locally, but also to make sure that your application is fully compatible with the official Liquid Galaxy infrastructure used at the Liquid Galaxy headquarters in Lleida (Spain). All contributors are required to create and work with a personal Liquid Galaxy virtual rig, which simulates the behaviour of the real system and allows testing and validating your application in a local environment. Please note that, in order to successfully pass GSoC, the final version of your application must work on the real Liquid Galaxy rigs at Lleida. This is a non-negotiable requirement.
For most contributors, the local development setup involves using VirtualBox to run a local instance of a Liquid Galaxy rig. This virtual rig provides a safe and controlled environment for building, testing, and debugging your application without depending on remote systems. In order to avoid compatibility issues and ensure your virtual rig works the same as the real ones at the headquarters, you should carefully follow these guidelines for the VirtualBox installation:
- **Use a vanilla LG configuration.** This means installing Ubuntu 16.04 with no system updates and no additional software beyond what is strictly required.
- **Do not request additional tools or packages** to be installed on the Liquid Galaxy rigs at the headquarters, as this may cause compatibility issues or even break existing systems.
- Make sure your app runs smoothly on both virtual and real rigs **without manual intervention or additional setup**.
Taking the time to set up your environment correctly will save you countless hours of trouble later, so be patient and take the time to do it right. If you need help during this setup process, you can follow [this tutorial](https://youtu.be/wzv-CiN6VeA?si=lzARoxDQWIY81poc) that walks you through the entire installation and configuration. Once your virtual Liquid Galaxy rig is ready, you can set up your application development environment and workspace. Here’s a quick checklist of everything you need to do:
- **Install Flutter.** Flutter is the main framework used in most Liquid Galaxy GSoC projects, as it allows building cross-platform apps efficiently, and it integrates well with both Android devices and the Liquid Galaxy system. You can download and install Flutter from the official website, following [this link](https://docs.flutter.dev/get-started/install).
- **Choose your IDE.** You will need an Integrated Development Environment (IDE) in order to build your app efficiently, like for example Android Studio or VSCode. Make sure you have Dart and Flutter plugins on the IDE you choose (Dart is the programming language used to develop Flutter apps).
- **Set up an Android Emulator (or use a physical device).** Although your project must be compatible with Liquid Galaxy, it also needs to work properly on Android devices. For this, you have two options:
   - ***Use a physical Android phone.*** You can either connect it to your development environment via USB or build an APK and install it manually.
   - ***Set up an emulator using Android Studio.*** For this, you will need to install the Android Emulator component on Android Studio and create a virtual device. In the GSoC context, it should be an Android phone. You can follow this [tutorial](https://youtu.be/GhuiNcOEv1A?si=Bt0Rr6vETa27Iszw) in order to create the virtual device.
- **Create a first version of your project.** You can either do it from scratch or clone the code repository (lg_master_web_app) that goes along with this documentation, which provides a basic and functional Flutter app that connects to Liquid Galaxy.
- **Use GitHub from day one.** All Liquid Galaxy GSoC projects are tracked via GitHub, so make sure you commit your progress regularly and from the start! If you have never used GitHub, don’t worry, that’s what the next section is about. 

<h3 id="id23"> 2.3. GitHub methodology </h3>

<h3 id="id24"> 2.4. Deliverables and documentation </h3>


<h2 id="id3"> 3. Start your project </h2>

<h3 id="id31"> 3.1. Code structure </h3>

Ensure you install the **Dart extension**.

Project structure example:

```plaintext
your_Project/
│
├── lib/
│   ├── main.dart
│   ├── config/
│   │   └── lg_config.dart
│   │
│   ├── services/
│   │   └── lg_connection.dart
│   │
│   ├── optional_files/
│   │   ├── lg_ai.dart
│   │   ├── lg_google_earth.dart
│   │   └── lg_nodejs.dart
│   │
│   ├── screens/
│   │   ├── connection_screen.dart
│   │   ├── main_screen.dart
│   │   ├── help_screen.dart
│   │   └── settings_screen.dart
│   │
│   ├── ai/
│   │   └── api_config.dart
│   │
│   ├── nodejs/
│   │   ├── server.js
│   │   └── package.json
│   │
│   ├── kml/
│   │   └── example.kml
│   │
│   ├── models/
│   │
│   ├── providers/ (optional?)
│   ├── utils/ (optional?)
│   │
│   ├── linux/ (optional, depending on if you want your project to be visualized in this technology)
│   │
│   ├── macOS/ (optional, depending on if you want your project to be visualized in this technology)
│   │
│   ├── web/ (optional, depending on if you want your project to be visualized in this technology)
│   │
│   └── windows/ (optional, depending on if you want your project to be visualized in this technology)
│
├── test/
│     └── lg_service_test.dart
│
├── pubspec.yaml
├── README.md
└── .gitignore
```

- `lib/`.
- `main.dart`. The 'main' archive serves to execute the app and show the main screen (HomeView). It is the entry point of the Flutter application.
- `utils/`. Utility files. They can help to maintain consistency through the app and to make it easy to manage global settings and styles, for example.

<h3 id="id32"> 3.2. How a Dart project works </h3>

If you make changes to your app, if you want to run it and see those changes you have to rebuild the app.
- flutter clean
- flutter pub get
- flutter run or run the emulation using Android Studio

<h3 id="id33"> 3.3. Phone and tablet emulator </h3>
Android Studio (research here)

<h3 id="id34"> 3.4. Using GitHub </h3>
This may be the first time you have ever worked with GitHub, so everything can feel a little confusing at first. But don't worry! This guide is here to help. You have multiple options to upload your work to GitHub. You can do it using the GitHub web interface or upload it using git. To upload from your computer, you should do the following steps:

- Open the cmd.
- Go to the folder where you have your project. The command here is `cd your_project_route`.
- Initialize an empty git repository. The command here is `git init`.
- Add the origin route to your GitHub project repository. The command here is `git remote add origin https://github.com/your_github_repository_link.git`.

Once you have done all of this, your computer is ready to upload the files from your computer to your GitHub repository. Everytime you want to update the files in your repository with the files you have in your computer, you have to do the following:

- Open the cmd.
- Go to the folder where you have your project. The command here is `cd your_project_route`.
- Add the new content. The command here is `git add .`.
- Add a comment about the update. The command here is `git commit -m "whatever you want to say"`. This is not mandatory, but adding comments explaining what you added in each update is INCREDIBLY useful and helps keep track of your work.
- Make sure you are on the main branch of your project. The command here is `git branch`. In order to understand this part, let's assume your main branch is called "main" (this is the default name normally because it helps to understand the project easily, but you can also choose a different one). The output of this command will be a list that looks like this:
   - *main
   - other_branch1
   - other_branch2
   
  "*" indicates the branch you are in right now. In case you were not in the main branch, you would need to use the command `git checkout main`.
- Add the content and the comments to the main branch. The command here is `git push origin main`. Again, "main" is the default name for the name branch, but if you have a different name for this branch you can just use that name instead of name, like `git push origin your_main_branch_name`. 

<h2 id="id4"> 4. Projects used to create this project </h2>

| Project Title | Contributor | Year | Technologies / Languages |
|---------------|-------------|------|---------------------------|
| [LG Ship Automatic Identification System Visualization](https://github.com/LiquidGalaxyLAB/LG-Ship-Automatic-Identification-System-visualization) | Rofayda Bassem | 2024 | Dart (95.6%), C++ (2.2%), CMake (1.8%), Swift (0.2%), C (0.1%), HTML (0.1%) |
| [Super Liquid Galaxy Controller](https://github.com/LiquidGalaxyLAB/Super-Liquid-Galaxy-Controller) | Aritra Biswas | 2024 | Dart (98.6%), C++ (0.7%), CMake (0.5%), Swift (0.1%), HTML (0.1%) |
| [LG Gemini AI Touristic Tool](https://github.com/LiquidGalaxyLAB/LG-Gemini-AI-Touristic-info-tool) | Sidharth Mudgil | 2024 | Dart (100.0%) |
| [La Palma VolTrac](https://github.com/LiquidGalaxyLAB/La-Palma-Volcano-Eruption-Tracking-Tool) | Yash Raj Bharti | 2022 | Dart (100.0%) |
| [SatNOGS Visualization Tool](https://github.com/LiquidGalaxyLAB/SatNOGS-Visualization-Tool) | Michell Algarra | 2022 | Dart (89.0%), C++ (6.2%), CMake (2.9%), HTML (1.4%), C (0.3%), Swift (0.1%), Other (0.1%) |
| [Image Satellite Visualizer](https://github.com/LiquidGalaxyLAB/image-satellite-visualizer) | Octávio Müller | 2021 | Dart (96.0%), HTML (1.8%), Objective-C (0.7%), Ruby (0.7%), Java (0.5%), Swift (0.2%), Kotlin (0.1%) |
| [Liquid Galaxy Controller Application](https://github.com/LiquidGalaxyLAB/lg_controller) | Sreyas Ravichandran | 2019 | Dart (98.5%), Other (1.5%) |

---
