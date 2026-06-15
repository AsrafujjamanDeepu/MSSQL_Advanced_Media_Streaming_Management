# MSSQL Advanced Media Streaming Management
This project implements an Advanced Media Streaming Management System using Microsoft SQL Server (MSSQL), featuring a fully normalized relational design, comprehensive business rule enforcement, and robust transaction management for streaming service operations.
I've made the DDL part in a unique way with crude opeartion so that you can execute the script again and again continually without having any errors.

<img src="assets/screenshots/Screenshot 2026-06-15 080537.png" width="700" alt="Project Info"/>

1.1 Introduction </br>
Modern media streaming platforms require sophisticated database systems to manage complex relationships between users, content, subscriptions, viewing patterns, and payment processing. A well-structured database is essential for delivering personalized experiences, ensuring service reliability, and maintaining business continuity. This project implements an Advanced Media Streaming Management System using Microsoft SQL Server (MSSQL), featuring a fully normalized relational design, comprehensive business rule enforcement, and robust transaction management for streaming service operations.

1.2 Problem Statement </br>
Traditional media service providers using basic record-keeping systems face multiple challenges: </br>
•	Inconsistent User Experience: No personalized content recommendations based on viewing history </br>
•	Subscription Management Issues: Manual tracking of renewals, expirations, and payment cycles </br>
•	Content Discovery Limitations: Users struggle to find relevant content without intelligent categorization </br>
•	Analytics Deficiencies: Limited insights into viewing patterns, content popularity, and user engagement </br>
•	Concurrent Access Problems: No mechanism to enforce simultaneous streaming limits per subscription tier </br>
•	Revenue Tracking Gaps: Inadequate reporting on subscription revenue and payment trends </br>

1.3 Objectives </br>
•	Design a 3NF normalized database for users, content, subscriptions, and viewing activities </br>
•	Implement personalized content recommendations based on viewing history and genre preferences </br>
•	Create automated subscription management with renewal alerts and payment tracking </br>
•	Develop comprehensive analytics for user engagement, content popularity, and revenue reporting </br>
•	Enforce business rules through constraints, triggers, and stored procedures </br>
•	Ensure data integrity during user registration, subscription updates, and payment processing </br>
•	Provide real-time insights through encrypted views and reporting functions

1.4 Scope </br>
Included: </br>
•	User profile management with age validation </br>
•	Tiered subscription plans with quality and device limits </br>
•	Content catalog with metadata, genres, and creator credits </br>
•	Viewing history tracking with device and quality monitoring </br>
•	Review and rating system with helpfulness metrics </br>
•	Automated payment processing and revenue reporting </br>
•	Personalized recommendation engine </br>
•	Real-time device activity tracking </br>
•	Subscription expiration alerts

Excluded: </br>
•	Video transcoding and delivery infrastructure </br>
•	Mobile/Web application front-end </br>
•	Third-party payment gateway integration </br>
•	Content licensing and rights management </br>
•	Live streaming infrastructure </br>
•	Marketing and promotional modules

![App Demo](./assets/Animation.gif)

1.5 Conclusion </br>
The Advanced Media Streaming Management System provides a comprehensive, scalable database foundation that addresses critical needs of modern streaming services. By implementing sophisticated features like engagement scoring, personalized recommendations, automated subscription management, and detailed analytics, the system demonstrates both academic rigor and practical applicability. The database design ensures data integrity, supports business intelligence, and enables enhanced user experiences—making it suitable for academic evaluation while providing a robust foundation for real-world media streaming platforms in the digital entertainment industry.
