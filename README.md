# CollabEase 🚀

**Team Collaboration Made Simple & Productive**

CollabEase is a comprehensive team collaboration web application that brings teams together in one intuitive workspace. Manage projects, tasks, and communication in real-time with our all-in-one collaboration platform.

![CollabEase](https://images.unsplash.com/photo-1579389083078-4e7018379f7e?auto=format&fit=crop&w=800)

## ✨ Features

### 🎯 **Task Management**
- Create, assign, and track tasks with due dates, priorities, and progress tracking
- Priority levels: LOW, MEDIUM, HIGH, URGENT
- Task status tracking: TODO, IN_PROGRESS, BLOCKED, COMPLETED
- Real-time task updates and notifications

### 👥 **Team Collaboration**
- Role-based access control (Admin, Manager, Member)
- Team workspace creation and management
- Project-based team organization
- Real-time communication and updates

### 📊 **Project Management**
- Comprehensive project creation and tracking
- Project status management: PLANNING, IN_PROGRESS, COMPLETED, ON_HOLD
- Deadline management and progress monitoring
- Visual project dashboards

### 🔔 **Real-Time Notifications**
- Task assignment notifications
- Deadline reminders
- Comment notifications
- Status update alerts

### 💬 **Communication**
- Task-based commenting system
- Real-time collaboration features
- Team communication tools

### 📈 **Analytics & Reporting**
- Visual dashboards for project progress
- Team performance analytics
- Progress tracking and reporting

## 🛠️ Technology Stack

- **Backend**: Java 17, Java Servlets, JSP (Java Server Pages)
- **Build Tool**: Apache Maven
- **Database**: MySQL 8.0+
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5
- **Security**: jBCrypt for password hashing
- **Additional Libraries**:
  - JSTL (JavaServer Pages Standard Tag Library)
  - Gson for JSON processing
  - Font Awesome for icons
  - Google Fonts (Poppins)

## 📋 Prerequisites

Before running CollabEase, ensure you have the following installed:

- **Java Development Kit (JDK) 17 or higher**
- **Apache Maven 3.6+**
- **MySQL Server 8.0+**
- **Apache Tomcat 9.0+** (or any servlet container)
- **Web Browser** (Chrome, Firefox, Safari, Edge)

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/MohitBytes/CollabEase.git
cd CollabEase
```

### 2. Database Setup

#### Create Database
```sql
-- Connect to MySQL and run:
CREATE DATABASE collabease_db;
USE collabease_db;
```

#### Run Database Schema
Execute the SQL schema file located at `src/SQL/schemas`:

```bash
mysql -u root -p collabease_db < src/SQL/schemas
```

#### Configure Database Connection
Update the database configuration in `src/main/java/com/collabease/db/DBConnection.java`:

```java
String url = "jdbc:mysql://localhost:3306/collabease_db?allowPublicKeyRetrieval=true&useSSL=false";
String user = "your_username";        // Replace with your MySQL username
String password = "your_password";    // Replace with your MySQL password
```

### 3. Build the Project

```bash
# Clean and compile the project
mvn clean compile

# Package the application as WAR file
mvn clean package
```

### 4. Deploy to Tomcat

1. Copy the generated WAR file to Tomcat's webapps directory:
   ```bash
   cp target/CollabEase.war $TOMCAT_HOME/webapps/
   ```

2. Start Tomcat server:
   ```bash
   $TOMCAT_HOME/bin/startup.sh    # On Linux/Mac
   $TOMCAT_HOME/bin/startup.bat   # On Windows
   ```

3. Access the application at: `http://localhost:8080/CollabEase`

## 📁 Project Structure

```
CollabEase/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── collabease/
│   │   │           ├── controller/     # Servlet controllers
│   │   │           ├── dao/           # Data Access Objects
│   │   │           ├── db/            # Database connection
│   │   │           ├── filter/        # Request filters
│   │   │           ├── job/           # Background jobs
│   │   │           ├── listener/      # Context listeners
│   │   │           ├── model/         # Data models
│   │   │           ├── service/       # Business logic
│   │   │           └── utils/         # Utility classes
│   │   └── webapp/
│   │       ├── Header/               # Header components
│   │       ├── Manager/              # Manager-specific pages
│   │       ├── Member/               # Member-specific pages
│   │       ├── Notifications/        # Notification pages
│   │       ├── Tasks/                # Task management pages
│   │       ├── admin/                # Admin-specific pages
│   │       ├── signin/               # Authentication pages
│   │       ├── WEB-INF/              # Web configuration
│   │       └── index.jsp             # Landing page
│   └── SQL/
│       └── schemas                   # Database schema
├── pom.xml                          # Maven configuration
└── README.md                        # This file
```

## 👤 User Roles

### Admin
- Full system access
- User management
- System configuration
- Global project oversight

### Manager
- Team management
- Project creation and management
- Task assignment
- Team member oversight

### Member
- Task execution
- Project participation
- Status updates
- Collaboration features

## 🔐 Default Access

After setting up the database, you can create users through the registration page or directly in the database. The application supports role-based access control.

## 🌟 Usage

1. **Registration/Login**: Create an account or login at `/signin/register.jsp` or `/signin/login.jsp`
2. **Dashboard**: Access your personalized dashboard based on your role
3. **Teams**: Create or join teams for collaboration
4. **Projects**: Create projects and manage them with your team
5. **Tasks**: Create, assign, and track tasks within projects
6. **Notifications**: Stay updated with real-time notifications
7. **Communication**: Collaborate through comments and updates

## 🤝 Contributing

We welcome contributions to CollabEase! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines

- Follow Java coding conventions
- Write meaningful commit messages
- Test your changes thoroughly
- Update documentation when necessary
- Ensure backward compatibility

## 🐛 Bug Reports

If you encounter any bugs or issues, please:

1. Check existing issues on GitHub
2. Create a new issue with detailed description
3. Include steps to reproduce
4. Provide system information (OS, Java version, etc.)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Bootstrap for the responsive UI framework
- Font Awesome for the beautiful icons
- Google Fonts for typography
- MySQL for the robust database system
- Apache Maven for build management
- Apache Tomcat for the servlet container

## 📞 Support

For support and questions:

- Create an issue on GitHub
- Check the documentation
- Review existing issues and discussions

---

**Made with ❤️ for better team collaboration**

*Transform your team collaboration experience with CollabEase!*