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
   4.2. [Essential Liquid Galaxy functions](#id42) 
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
   9.3. [Phone and tablet emulator](#id93) 
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

All contributors will work within the official Liquid Galaxy GitHub, where your project’s repository will be hosted. This centralized approach ensures consistency across all projects, facilitates collaboration and allows mentors to track your progress. Once your personal repository is created, you will be granted access, and from there your day-to-day workflow will begin. Keep in mind that **all project repositories are private until the end of GSoC**. They will only be made public at the end of the program, once the final version of your application is ready and approved.

There are multiple ways to upload your code to GitHub. You can **use the GitHub web interface** (which is useful for simpler updates, like small edits or uploading files manually) or **use Git from your cmd** (which is the recommended option for regular development work, as it gives you full control over versioning, branches, and collaboration). To start working with Git and make sure you are able to upload your changes correctly, you must follow these steps:
- **Open your cmd.**
- **Navigate to the directory where you want to store your project locally.** If you have never done this, the command here is `cd your_project_path`. This directory is where your GitHub repository will be cloned, and you can choose any location (your Desktop, a specific folder, etc.). As an example, I created a folder called “FlutterProjects”, navigated into it, and cloned my repository there. As a result, a new folder called “LG-Master-Web-App” (the name of my GitHub repository) was created inside the “FlutterProjects” folder.
- **Clone your GitHub repository into this place.** The command here is `git clone your_github_repository_url`. To easily copy this URL (which should have the structure https://github.com/your_github_repository_link.git), you can find it clicking on the green “Code” button on the web interface and copying the link under “HTTPS”.
- **A new folder with the repository’s name will be created automatically.** This is the folder where you must work from now on.
- **Navigate to the repository folder using cd on the cmd again.**
- **Initialize an empty git repository.** The command here is `git init`.
- **Add the origin route to your GitHub project repository.** The command here is `git remote add origin https://github.com/your_github_repository_link.git`.

Once this setup is complete, you are ready to start working and uploading your progress to GitHub using Git. Each week, you are required to raise a Pull Request (PR) to show your progress, which will be merged at the end of the week. A Pull Request is a GitHub feature that allows you to propose changes from one branch (usually a feature branch, which is a branch different to the main one) into another (typically the `main` branch). This process allows mentors to review your code before it is merged into the main codebase. 

Your weekly PRs serve multiple purposes, as they act as a historical record of your work, they allow mentors to review progress, and they form the basis of your GSoC evaluations. It is really **IMPORTANT** to remember that you are expected to **raise and merge your own PRs** each week (unless a different process is discussed and approved with your mentor). Also, it is better to **avoid pushing code directly to the `main` branch**. Instead, create feature branches for different parts of your project (for example, main-screen-features, connection-features, etc.) and merge them into main via PRs to keep your project history clean and organized. If you want to **create a new branch**, the command here (make sure you are inside your repository folder) would be `git checkout -b feature-name`, with “feature-name” being the name you want to give your branch.

Every time you want to make changes locally and want to upload them to GitHub, you have to follow this process:
- **Open the cmd.**
- **Navigate to your folder project.** The command here is `cd your_project_path`.
- **Make sure you are on the correct branch of your project.** The command to get a list with all the branches is `git branch`. In order to understand this part, let's assume your main branch is called `main` (this is the default name, normally because it helps to understand the project easily, but you can also choose a different one) and that you have two feature branches called “other-branch1” and “other-branch2”. The output of this command will be a list that looks like this:
   - *main
   - other_branch1
   - other_branch2
   
  "*" indicates the branch you are in right now. In case you were not in the main branch, you would need to use the command `git checkout main`.
- **Add the new or modified files.** The command here is `git add .`.
- **Add a comment about the update.** The command here is `git commit -m "whatever you want to say"`. This is not mandatory, but adding comments explaining what you added in each update is INCREDIBLY useful and helps keep track of your work.
- **Add the content and the comments to your branch (push your changes into your branch).** The command here is `git push origin your-branch-name`. For example, let’s say you are on the branch called “other-branch-1”. The command here would be `git push origin other-branch-1`. 

It is better to update changes into separate feature branches rather than directly in the main branch. This is because branches act as safe, isolated workspaces where you can experiment, organize your work, and ensure quality before integrating changes into your main project. This approach also prevents accidental disruptions to the main codebase. To open and merge a Pull Request, you will have to go to the GitHub web interface and do the following:
- If you have recently pushed a new branch, GitHub will usually suggest opening a PR automatically. You should click on **“Compare and pull request”**.
- Alternatively, you can go to the **“Pull requests”** tab and click **“New pull request”**. 
- In the PR form, you will have to select the **source branch** (your feature branch) and the **target branch** (usually `main`). 
- **You can also write a brief title and description summarizing your changes.** As with the work updates, this is optional, but very useful to keep track of what you have done. 
- Finally, click **“Create pull request”**. 

Once your Pull Request is open, any additional commits pushed to the same feature branch will automatically be included in the Pull Request. At the end of the week (unless told otherwise), you are expected to merge the PR yourself by opening the PR on GitHub, scrolling down, clicking **“Merge pull request”** and then confirm by clicking **“Confirm merge”**.


<h3 id="id24"> 2.4. Deliverables and documentation </h3>

In addition to writing code, you are also expected to maintain **clear, detailed and well-organized documentation** throughout the entire duration of your GSoC project. Documentation is just as important as the code itself, as it makes sure that others (including mentors, users of your application, or even your future self) can understand, use, and build upon your work. Good documentation significantly improves the long-term value and usability of your contribution.

To help you manage and store all deliverables, you will receive a **shared Google Drive folder** dedicated specifically to your GSoC project. This folder should be updated regularly and kept properly organized, as it will serve as the central location for all final project materials. It will be reviewed during evaluations and may also be shared with future contributors, so take it as seriously as writing code. Your shared folder should include the following components:
- **APK builds.** Create a subfolder for each APK version you generate during the project. These subfolders should be clearly named using version numbers and their corresponding build dates according to the following structure: `appname_X.Xv_contributorName_GSoCyear`. For example, lgMasterWebApp_v1.0_luciaFernandez_GSoC2025, lgMasterWebApp_v2.1_luciaFernandez_GSoC2025, etc.). **Never delete or overwrite older versions**, as keeping a full history of APK versions allows mentors to track your progress over time and provides the option to roll back if needed. A rollback refers to the ability to revert your application back to an earlier version in case the new one introduces bugs, performance issues, or other problems.
- **Project documentation.** This is one of the most important components of your final submission. You must maintain a document that includes setup instructions for running your application (both on Liquid Galaxy and on Android), code explanations, a usage guide (explaining how users would interact with the application), and architecture decisions (why you built things the way you did). It is also important to paste relevant code snippets into the document and explain their purpose and behaviour, and diagrams and screenshots can also be helpful to visually support your explanation. This document should be started at the beginning of your project and updated continuously as your code evolves, since waiting until the last minute will make it much harder to recall decisions or provide accurate context. This project documentation should be a **README.md** that will be included in the GitHub repository.
- **Worklog.** You will be required to log your weekly progress in an Excel file. To begin, you will copy a pre-made template and rename the file with the following format: `Surname_Name_GSOCyear_Worklog`. In this document, you will have to record the daily and weekly work you have completed, any blockers or bugs with their possible solution, and your planned work for the upcoming week. This worklog will be extremely useful during your evaluations, as it provides a clear and consistent record of your progress, learning, and problem-solving approach.
- **Other assets.** Basically any additional files that are part of your project or relevant for your final submission. These might include logos, media files, etc.

<h2 id="id3"> 3. Project types and technologies </h2>

Liquid Galaxy GSoC projects involve a diverse and evolving set of technologies, all centred around building innovative, real-world applications that interact with the Liquid Galaxy rig, a multiscreen panoramic visualization system used for presenting geographic, scientific, and educational data in a dynamic, immersive environment (more information on the Liquid Galaxy in the next section). Depending on the focus of your project, you may be working on mobile applications, robotics integrations, AI-enhanced applications, or other creative implementations. Each project type comes with specific technical requirements and development workflows, and understanding these early in the process will help you ensure a smooth and productive development experience.

For GSoC, students can either apply to work on a **pre-defined idea from an accepted organization** (you can check the list of the GSoC 2025 organizations here, but the list is updated each year) or **propose their own original project** that fits within the scope of that organization. **Liquid Galaxy also publishes a list of suggested project ideas each year**, but **students are encouraged to think creatively and submit their own ideas**, especially if they align with Liquid Galaxy’s mission of open data, geospatial visualization, education, and real-world impact. So, if you have a unique and innovative project idea, you are more than encouraged to submit a proposal! Demonstrating creativity, technical clarity and preparation in this proposal will make a strong impression on mentors and improve your chances of being selected.

Most Liquid Galaxy GSoC projects involve developing **mobile applications using Flutter**, an open-source framework developed by Google that enables fast and cross-platform app development with a strong emphasis on UI and performance (more on Flutter in a later section). These applications must be **compatible with Android phones**, and your apps will be installed and tested on these devices, so you should design your app with this screen configuration in mind. These apps can serve a wide variety of purposes: data visualization tools, interactive maps, educational games, control panels, and more. Be creative! You have the flexibility to explore novel ideas, as long as they align with the core mission of the Liquid Galaxy project and are achievable within the GSoC timeframe.

Some projects go beyond mobile development and explore robotics integration with Liquid Galaxy. These applications often still use Flutter for the user interface, but are also closely tied with **physical or simulated robotic systems**. To manage complexity and ensure cross-platform compatibility, these projects use Docker, a tool that allows to package your application and its dependencies into a single container that can be easily deployed in any environment. You must provide a complete **Docker image** of your project, including a well-documented **Dockerfile** with instructions for building, running, and configuring your app. If your project relies on auxiliary services (for example, communication with Arduino boards, sensor data collection, microcontroller scripts, etc.), these must also be documented within your Docker setup. Docker not only simplifies deployment and testing, but also makes sure your application behaves consistently across different environments, whether on your local machine or in the robotics lab. Additionally, if your project requires robotic simulations, you can use tools like [**Gazebo**](https://gazebosim.org/home), [**Webots**](https://cyberbotics.com/), or [**ROS-based simulators**](https://docs.ros.org/en/foxy/Tutorials/Advanced/Simulators/Simulation-Main.html) to test and visualize robotic behaviours virtually. This is especially useful if you’re working remotely or have limited access to hardware.

Some Liquid Galaxy applications are developed as web-based tools (for example, remote dashboards, administrative interfaces, or content managers). These applications often act as **control points or data input interfaces** that interact with the Liquid Galaxy rig over a network. Depending on the scope of your application, you may use [**Node.js**](https://nodejs.org/es), [**Python Flask**](https://flask.palletsprojects.com/en/stable/) or [**React**](https://react.dev/). You will receive specific deployment guidelines from your mentor regarding how to host and configure your web app within the Liquid Galaxy headquarters in Lleida. Make sure your web app is optimized for performance, tested in real scenarios, and securely integrated with the rest of the system. While your mentor will support you in setting up hosting environments, you are expected to follow best practices in terms of web development, including **responsive design and proper data handling**.

More advanced Liquid Galaxy projects may include **Artificial Intelligence components** to improve user interaction or automate data processing. These applications are typically built with Flutter as the frontend and integrate AI services like Google’s Gemini AI, which supports advanced text, image, or data analysis. You must also implement a settings section within the app where users can enter their own API key to connect to the Gemini service, and all the requests to AI services must be handled securely and transparently. **If you plan to use any third-party APIs or AI services other than Gemini** (for example, OpenAI), **you MUST first request approval from the Liquid Galaxy admin team before integrating them into your project**. These projects offer possibilities such as smart assistants, natural language interfaces, or intelligent recommendation systems, but they also require careful consideration of API limits, latency, and user privacy.

Liquid Galaxy projects may involve a variety of programming languages and tools, depending on the type and scope of your project. You can find information on the most commonly used technologies [**on this link**](https://www.liquidgalaxy.eu/2024/05/tech-stack-and-use-cases.html#content-wrapper), but here is a small summary:
- **Linux.** Used for Ubuntu-based systems, rig-level configurations, and sending commands to the Liquid Galaxy rig. Due to its performance and reliability under high network demands, Linux (usually Ubuntu LTS) is the chosen open-source operating system for Liquid Galaxy environments.
- **Python.** Used for backend scripts, data analysis, or automation. Currently one of the most popular and versatile scripting languages.
- **Node.js.** Used for building web servers and enabling real-time communication between multiple Chromium browsers (the open-source version of Google Chrome) running on the Liquid Galaxy system.
- **Flutter / Dart.** Used for cross-platform mobile app development. This SDK (Software Development Kit) enables high-performance and high-fidelity apps for iOS and Android from a single codebase. More on Flutter and Dart in a later section.
- **Android SDK.** Used for mobile integration and testing. It is the standard toolkit for interacting with devices compatible with Android and Chrome OS.
- **TensorFlow.** An open-source software library developed by Google. Used for tasks like analysing and processing data to be displayed on the Liquid Galaxy rig. 
- **Large Language Models (LLMs).** Used to process GIS (Geographic Information System) data in order to create visualizations and tours on the Liquid Galaxy rig. LLMs enable computers to understand and generate text similar to how humans communicate.
- **Docker.** Used for isolated deployment, especially in robotics projects. Essential for containerizing applications.

You are encouraged to **experiment and explore new tools and technologies**, as long as they are stable, well-supported, and align with your project’s goals. If you are ever unsure about whether a particular tool or framework is a good option, consult your mentor to make sure it fits within the GSoC timeline and expectations.

<h2 id="id4"> 4. Liquid Galaxy </h2>

<h3 id="id41"> 4.1. What is Liquid Galaxy? </h3>

Liquid Galaxy is an open-source project founded by Google that allows users to navigate Google Earth, view videos and photos, create interactive tours, and visually display GIS data in an immersive and panoramic format. Created in 2008 by Google employee Jason Holt, Liquid Galaxy was originally conceived as a multiscreen viewer for Google Earth. Since then, it has evolved into a powerful and versatile tool used for much more than just exploring geographic data, as it is now also used for data visualization, virtual tours, and more. 

A typical Liquid Galaxy rig consists of multiple high-resolution screens connected and arranged to create a seamless panoramic environment. This immersive setup surrounds the viewer, providing a wide-angle, unified display that enhances the visual experience. **In the case of the Lleida labs, the Liquid Galaxy rig consists of 5 screens**, but this number can vary depending on the specific installation (some setups use just three, while others use five or more depending on the available space, hardware, and project needs). This flexibility makes the system highly adaptable to be used in both small labs and large exhibitions.

If this is your first time hearing about Liquid Galaxy, imagine yourself walking into a room surrounded by several large monitors, each displaying a segment of a single, synchronized scene, whether it’s a dynamic Google Earth view, a real-time video stream, or an interactive 3D map. The collective display stretches across the user’s entire field of vision, immersing them in the content and allowing real-time interaction using traditional controls like a keyboard and mouse, or more advanced features like voice commands, touch interfaces, or external sensors.

The technical foundation of Liquid Galaxy is built on a master-slave architecture, which ensures smooth coordination and synchronization between screens. **Each screen is powered by its own dedicated computer, and the system typically requires one computer per display, all connected over a local network**. One of these computers is designated as the **master node** (responsible for controlling the content and camera movements across all screens and the navigation commands), while the others act as **slave nodes** (which simply follow the instructions they receive from the master and mirror the master actions to make sure all displays remain perfectly synchronized). This **distributed architecture** offers both high performance and easy scalability, as new screens can be added to the setup simply by introducing new slave nodes and updating the system configuration, without needing to redesign the entire rig. Here's how it works:
- **Master/slave architecture.** When a user interacts with the master screen (for example, by zooming in, rotating the view, or navigating across Google Earth), the master computer sends real-time commands to all slave computers. These commands instruct each slave display to adjust their views accordingly, creating a seamless panoramic effect, which ensures that all screens act as a unified, coordinated display.
- **Independent rendering.** Each screen runs its own independent instance of the visual software (traditionally Google Earth, though today this can include custom visualizations or interactive applications). Despite rendering different portions of the scene, all screens remain perfectly in sync thanks to the master node’s continuous updates.
- **UDP network communication.** The coordination process between master and slave nodes is managed using UDP (User Datagram Protocol), a fast and simple communication protocol is known for its low latency and minimal overhead, making it ideal for real-time environments like Liquid Galaxy. UDP is used to transmit information such as camera angles, zoom levels, and scene transitions across the network.

Although Google Earth is frequently used as the central visual engine, it’s important to note that **Liquid Galaxy itself is a separate open-source project**. This distinction is important because it means **developers are not limited to Google Earth**, and they can freely design and deploy a wide variety of open-source applications, including tools that visualize custom GIS data, live dashboards, sensor outputs, robotic controls, and more. As a fun fact, Google Earth itself is not open-source software, but it is free to use and can be integrated into Liquid Galaxy setups through approved APIs and methods. Today, Liquid Galaxy is used by a wide range of companies, nonprofit organizations, and universities to present information in a more engaging and interactive way. Google itself continues to use Liquid Galaxy for trade shows and exhibits, using it as a platform to promote its own geospatial technologies.

One of the best aspects of Liquid Galaxy development is that **you don’t need a full rig to start building**. In fact, most developers (especially students participating in programs like GSoC) do their work on a single screen setup, using simulators or portable Liquid Galaxy kits, testing them later on larger installations. These alternatives replicate the rig’s functionality on a smaller scale, making development more accessible, affordable, and convenient, and allow developers to simulate the master-slave architecture virtually (or connect a few monitors to test multiscreen behaviour locally). Once your application is working properly in this scaled-down environment, it can be deployed and tested on a full rig for final validation. Whether you are developing an application that sends KML tours to the rig, controls robotics functions, manages real-time data feeds, or integrates with AI tools, your project’s success will depend on how well it integrates with the core architecture, multiscreen synchronization, and immersive capabilities of Liquid Galaxy.

<h3 id="id42"> 4.2. Essential Liquid Galaxy functions </h3>

When developing an application for Liquid Galaxy, there are several core features and behaviours that must be implemented to ensure proper functionality and user experience. These features are essential to how your application integrates with and supports the capabilities of the Liquid Galaxy system.

One of the most frequent issues in previous projects has been the lack of synchronization between the map displayed on the user’s mobile device and the Google Earth view on the Liquid Galaxy rig. **Your application must make sure that any interaction on the mobile device** (whenever a user navigates, searches for a location, or interacts with a map on their phone) **is reflected in real time on the Liquid Galaxy rig’s multiscreen setup**. This synchronization must create a unified and seamless experience across devices and **maintain consistent coordinates, camera angles and zoom levels**. It must also be **bidirectional** if necessary, which means that updates from the Liquid Galaxy rig (such as orbit animations or tour progress) should also be reflected on the mobile app interface.

Your application should also **implement a QR code scanning feature to quickly and easily connect to the Liquid Galaxy rig**. When the app is launched for the first time (or whenever reconfiguration is needed), the user should be able to scan a QR code generated by the Liquid Galaxy system or configuration tool. This QR code should contain key information such as IP address, port numbers or network credentials, enabling automatic connection setup. The goal of this process is to make the Liquid Galaxy configuration a simple, quick and error-free, even for users without advanced technical knowledge.

Your application should also be capable of **storing the previous configuration settings from the last session and using them to automatically reconnect when the app is launched again**, a behaviour that saves time and avoids redundant setup steps. Upon startup, the app should immediately attempt to connect to the Liquid Galaxy rig using the stored settings. If the connection is successful, a brief confirmation message (for example, a popup message or a notification) should be shown. The app should also display the Liquid Galaxy logo or relevant branding (logos of brands or technologies used during the project) during the startup (this will be displayed on a screen called “splash screen”, more on that on later sections). Additionally, **any previously sent KML files** (which include geographical data or overlays) **should be cleared or replaced**, making sure the system is clean and ready for a new session.

Liquid Galaxy is particularly effective at displaying immersive 3D views, especially when used with Google Earth. To take full advantage of this capability, your application must carefully control the camera settings. **You should avoid using a purely zenithal (top-down) view**, as it flattens the scene and diminishes depth perception. Instead, **set the camera to approximately 2 kilometres above the ground and use a tilt angle of at least 45 degrees**. It is important to combine appropriate pan and tilt settings to deliver a more engaging and realistic 3D visualization. This approach enhances how users perceive landscapes, buildings, and landmarks.

When **displaying KML content** (such as placemarks, tours, or data overlays), **your application must make sure that the camera viewpoint is zoomed in enough for the content to appear across the central three screens of the Liquid Galaxy rig**. It is important to **avoid camera positions that are too distant** (which results in content only appearing on the central screen) **or too wide** (which makes key information too small to interact with effectively). This is particularly critical for Points Of Interest (POIs), where central visibility and scale are key to immersion.

**Each POI displayed by your application should include an option to orbit around it** (to showcase the location from all angles), a feature that improves user engagement and allows for better spatial understanding. You must make sure that this orbiting tool includes **controls such as play, pause, or stop buttons**, as well as allows users to **choose the rotation speed or direction** (if possible). Orbiting is especially useful when showing architectural models, geographical landmarks, or custom 3D objects.

Finally, to make sure your application feels complete and user-friendly, **make sure to include a predefined list of content or interactions that the user can explore**. This list might include suggested search terms, featured locations, saved tours, or datasets relevant to the app’s purpose, and **the goal is to give users a starting point rather than requiring them to input everything manually**. This is particularly useful for demos, educational uses, and public exhibitions, where immediate content access is essential, and all contributors are expected to implement this feature as part of the project baseline.

<h3 id="id43"> 4.3. Data transmission to the Liquid Galaxy and KML management </h3>

<h2 id="id5"> 5. Flutter </h2>

<h3 id="id51"> 5.1. What is Flutter? </h3>

<h3 id="id52"> 5.2. How does Flutter work? </h3>

If you make changes to your app, if you want to run it and see those changes you have to rebuild the app.
- flutter clean
- flutter pub get
- flutter run or run the emulation using Android Studio

<h2 id="id6"> 6. Technical requirements and best practices </h2>

<h3 id="id61"> 6.1. Rig testing and compatibility </h3>

<h3 id="id62"> 6.2. Code quality and AI usage policy </h3>

<h3 id="id63"> 6.3. Accessibility features and user experience/interface (UX/UI) </h3>

<h3 id="id64"> 6.4. API key policy and Google services </h3>

<h2 id="id7"> 7. Responsibility and professionalism </h2>

<h3 id="id71"> 7.1. Meeting schedule and attendance </h3>

<h3 id="id72"> 7.2. Discord and email communication </h3>

<h3 id="id73"> 7.3. Weekly Vlogs </h3>

<h3 id="id74"> 7.4. Open source </h3>

<h2 id="id8"> 8. Common mistakes and how to avoid them </h2>

<h2 id="id9"> 9. Start your project </h2>

<h3 id="id91"> 9.1. Minimum app features / screens </h3>

<h3 id="id92"> 9.2. Code structure </h3>

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


<h3 id="id93"> 9.3. Phone and tablet emulator </h3>
Android Studio (research here)

<h2 id="id10"> 10. Automatically generated files </h2>

<h3 id="id101"> 10.1. .dart_tool </h3>

<h3 id="id102"> 10.2. .flutter-plugins-dependencies </h3>

<h2 id="id11"> 11. Your whole project step by step </h2>

<h3 id="id111"> 11.1. .idea </h3>

<h3 id="id112"> 11.2. android </h3>

<h3 id="id113"> 11.3. assets </h3>

<h3 id="id114"> 11.4. ios </h3>

<h3 id="id115"> 11.5. lib </h3>

<h3 id="id116"> 11.6. linux </h3>

<h3 id="id117"> 11.7. macos </h3>

<h3 id="id118"> 11.8. node_server </h3>

<h3 id="id119"> 11.9. test </h3>

<h3 id="id1110"> 11.10. web </h3>
<h3 id="id1111"> 11.11. windows </h3>

<h3 id="id1112"> 11.12. .env </h3>

<h3 id="id1113"> 11.13. .gitignore </h3>

<h3 id="id1114"> 11.14. .metadata </h3>

<h3 id="id1115"> 11.15. analysis_options.yaml </h3>

<h3 id="id1116"> 11.16. lg_master_web_app.iml </h3>

<h3 id="id1117"> 11.17. pubspec.lock </h3>

<h3 id="id1118"> 11.18. pubspec.yaml </h3>

<h3 id="id1119"> 11.19. README.md </h3>

<h2 id="id12"> 12. Further resources and documentation </h2>

<h2 id="id13"> 13. Projects used to create this project </h2>

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
