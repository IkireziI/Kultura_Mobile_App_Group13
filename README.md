# **Kultura App**  
*Version: 1.0*  
*Last Updated: November 28, 2024*

## **Project Overview**
**Kultura** is a mobile application that provides a platform for African artists to showcase their work, connect with buyers and investors, and access educational resources. The app fosters appreciation of African art, culture, and design while also supporting job creation and skill development through its unique blend of a marketplace and learning hub.

## **Key Features**
- **Artist Portfolio Management**: Artists can create profiles, upload artwork, manage portfolios, and receive feedback from users.
- **Marketplace**: Investors and buyers can browse, save, and purchase artwork securely, as well as communicate with artists directly.
- **Educational Resources**: Provides articles, tutorials, and videos on African art and culture, along with tools to help artists enhance their skills using AI.
- **Cultural Exploration**: Showcases a diverse array of African art, including blogs and event listings that highlight global art trends and traditions.
- **Community Features**: A platform for networking, discussions, and collaborations, enabling users to connect and share knowledge.

## **Getting Started**

### **Prerequisites**
- **Android**: Android 7.0 (Nougat) and above
- **iOS**: iOS 12.0 and above
- **Flutter SDK**: The app is built using **Flutter**, so developers should have Flutter installed along with dependencies like **Firebase** and **Java** for authentication and cloud storage.

### **Installation Steps**
1. Clone the repository:
    ```bash
    git clone https://github.com/IkireziI/Kultura_Mobile_App_Group13.git
    ```
2. Navigate to the project directory:
    ```bash
    cd kultura
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Run the app:
    ```bash
    flutter run
    ```

## **App Architecture**
- **Frontend**: Flutter (cross-platform mobile development)
- **Backend**: Firebase (real-time database, authentication, storage)

##  Authentication (User)
- **Google Sign-In**
Tap the "Sign in with Google" button.
Select a Google account to authenticate.
The user is redirected to the dashboard after successful login.

- **Email Authentication**
Register with an email and password.

Log in with the same credentials to access the app.

## Authentication Methods (Developer)
- **Google Sign-In**

*Setup:*

Enable Google Sign-In in Firebase Console.

Integrate the google_sign_in Flutter package.

- **Email and Password Authentication**
Setup:

Enable Email/Password Authentication in Firebase Console.

## Security Rules
We use Firebase Security Rules to enforce strict access control for Firestore.

## Testing Security Rules
Use the Firebase Emulator Suite for local testing: Unit Testing

Simulate user actions in the Emulator UI to verify rule enforcement.


## **All Links**
- Figma: https://www.figma.com/design/QNS4ZaYxoaapEorJmvNNnY/kultura--app?node-id=184-112&node-type=frame&t=nWQ9q8ihmjvdG4Ku-0
- Front-end Demo Video: https://www.youtube.com/watch?v=8LyMIz6y8cU
- Firebase Project: https://console.firebase.google.com/project/kultura-app-group13/overview
- Entity-Relationship Diagrams: https://docs.google.com/document/d/1on0IlsrnYmv6Ff18IQxFvneYTaQ_gyp7u_RXqdV_JgI/edit?usp=sharing
- Final Presentation slides: https://www.canva.com/design/DAGXvg4iANA/8AmnRjuutk34-jkMdnTpDg/edit?utm_content=DAGXvg4iANA&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton
- Backend = Firebase Database Demo Video: https://drive.google.com/file/d/1fzNx9XiAsozqfSRYyQm3WEZDpymiSqjT/view?usp=drive_link
- APK File: https://drive.google.com/file/d/1fLw_5U9FH5GNx40YtCO2NDUeOoTaGI8U/view?usp=drive_link

## **Contributing**
We welcome contributions! Here’s how you can help:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m "Add some feature"`).
4. Push to the branch (`git push origin feature-name`).
5. Open a pull request.

## **Team Members**
- **Eunice Adewusi (Climiradi)**: Project Lead, SRS Documentation
- **Sifa Mwachoni**: Backend Developer, Flutter Features
- **Lilian Kayitesi**: Market Research, Competitor Analysis
- **Ines Ikirezi**: Feature Design, Educational Resources
- **Ruth Iradukunda**: Appendix, Market Research
- **Bryan Aurel Bakongo**: Lead Product Designer

## **Contact Information**
For more information, feel free to contact Eunice at e.adewusi@alustudent.com
