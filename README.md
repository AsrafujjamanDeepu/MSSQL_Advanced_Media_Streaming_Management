# MSSQL Advanced Media Streaming Management
This project implements an Advanced Media Streaming Management System using Microsoft SQL Server (MSSQL), featuring a fully normalized relational design, comprehensive business rule enforcement, and robust transaction management for streaming service operations.
I've made the DDL part in a unique way with crude opeartion so that you can execute the script again and again continually without having any errors.

<img src="./assets/Screenshot 2026-06-15 080537.png" width="700" alt="Project Info"/>

1.1 Introduction
Modern media streaming platforms require sophisticated database systems to manage complex relationships between users, content, subscriptions, viewing patterns, and payment processing. A well-structured database is essential for delivering personalized experiences, ensuring service reliability, and maintaining business continuity. This project implements an Advanced Media Streaming Management System using Microsoft SQL Server (MSSQL), featuring a fully normalized relational design, comprehensive business rule enforcement, and robust transaction management for streaming service operations.

1.2 Problem Statement
Traditional media service providers using basic record-keeping systems face multiple challenges:
•	Inconsistent User Experience: No personalized content recommendations based on viewing history
•	Subscription Management Issues: Manual tracking of renewals, expirations, and payment cycles
•	Content Discovery Limitations: Users struggle to find relevant content without intelligent categorization
•	Analytics Deficiencies: Limited insights into viewing patterns, content popularity, and user engagement
•	Concurrent Access Problems: No mechanism to enforce simultaneous streaming limits per subscription tier
•	Revenue Tracking Gaps: Inadequate reporting on subscription revenue and payment trends

1.3 Objectives
•	Design a 3NF normalized database for users, content, subscriptions, and viewing activities
•	Implement personalized content recommendations based on viewing history and genre preferences
•	Create automated subscription management with renewal alerts and payment tracking
•	Develop comprehensive analytics for user engagement, content popularity, and revenue reporting
•	Enforce business rules through constraints, triggers, and stored procedures
•	Ensure data integrity during user registration, subscription updates, and payment processing
•	Provide real-time insights through encrypted views and reporting functions

1.4 Scope
Included:
•	User profile management with age validation
•	Tiered subscription plans with quality and device limits
•	Content catalog with metadata, genres, and creator credits
•	Viewing history tracking with device and quality monitoring
•	Review and rating system with helpfulness metrics
•	Automated payment processing and revenue reporting
•	Personalized recommendation engine
•	Real-time device activity tracking
•	Subscription expiration alerts

Excluded:
•	Video transcoding and delivery infrastructure
•	Mobile/Web application front-end
•	Third-party payment gateway integration
•	Content licensing and rights management
•	Live streaming infrastructure
•	Marketing and promotional modules

![App Demo](./assets/Animation.gif)

1.5 Conclusion
The Advanced Media Streaming Management System provides a comprehensive, scalable database foundation that addresses critical needs of modern streaming services. By implementing sophisticated features like engagement scoring, personalized recommendations, automated subscription management, and detailed analytics, the system demonstrates both academic rigor and practical applicability. The database design ensures data integrity, supports business intelligence, and enables enhanced user experiences—making it suitable for academic evaluation while providing a robust foundation for real-world media streaming platforms in the digital entertainment industry.
