-- =================================================================================================================
--									ADVANCED MEDIA STREAMING MANAGEMENT SYSTEM
												 -- DML PART --
-- =================================================================================================================

/* Contents In Orders:
					=> Part-1 INSERT DATA INTO USERS TABLE
					=> Part-2 INSERT DATA INTO SUBSCRIPTION PLANS TABLE
					=> Part-3 INSERT DATA INTO USER SUBSCRIPTIONS TABLE
					=> Part-4 INSERT DATA INTO CONTENT TABLE
					=> Part-5 INSERT DATA INTO GENRES TABLE
					=> Part-6 INSERT DATA INTO CONTENT-GENRE JUNCTION TABLE
					=> Part-7 INSERT DATA INTO CONTENT CREATORS TABLE
					=> Part-8 INSERT DATA INTO CONTENT CREDITS TABLE
					=> Part-9 INSERT DATA INTO WATCH HISTORY TABLE
					=> Part-10 INSERT DATA INTO STREAMING DEVICES TABLE
					=> Part-11 INSERT DATA INTO USER REVIEWS TABLE
					=> Part-12 INSERT DATA INTO PAYMENTS TABLE
					=> Part-13 VERIFY DATA WITH SELECT QUERIES */







-- ======================Part-1=========================
--			Insert DATA Into USERS TABLE
-- =====================================================
Use MediaStreamingDB;
Go

Print 'Inserting data Into Users table...';
Insert Into Users (UserName, Email, DateOfBirth, CountryCode, RegistrationDate, IsActive) Values
('Abdur Rahman', 'abdur.rahman@gmail.com', '1990-05-15', 'BD', '2023-01-10', 1),
('Fatima Begum', 'fatima.begum@yahoo.com', '1995-08-22', 'BD', '2023-02-14', 1),
('Mohammad Ali', 'mohammad.ali@outlook.com', '1988-03-30', 'BD', '2023-03-05', 1),
('Sakib Hasan', 'sakib.hasan@gmail.com', '1992-11-11', 'BD', '2023-04-18', 1),
('Rina Akter', 'rina.akter@gmail.com', '1998-07-25', 'BD', '2023-05-22', 1),
('Kamal Uddin', 'kamal.uddin@yahoo.com', '1991-12-05', 'BD', '2023-06-30', 1),
('Moushumi Rahman', 'moushumi.rahman@gmail.com', '1994-09-14', 'BD', '2023-07-11', 1),
('Jamal Khan', 'jamal.khan@outlook.com', '1985-06-20', 'BD', '2023-08-09', 1),
('Sharmin Sultana', 'sharmin.sultana@gmail.com', '1997-04-03', 'BD', '2023-09-25', 1),
('Rafiq Islam', 'rafiq.islam@yahoo.com', '1993-10-19', 'BD', '2023-10-30', 1);
Print '10 users Inserted successfully.';
Go

-- ======================Part-2=========================
--			Insert DATA Into SUBSCRIPTION PLANS TABLE
-- =====================================================
Print 'Inserting data Into SubscriptionPlans table...';
Insert Into SubscriptionPlans (PlanName, MonthlyPrice, maxQuality, maxsimultaneousstreams, adfree) Values
('Basic', 299.00, 'sd', 1, 0),
('Standard', 499.00, 'hd', 2, 1),
('Premium', 799.00, '4k', 4, 1),
('Ultra', 1299.00, '8k', 6, 1);
Print '4 subscription plans Inserted successfully.';
Go

-- ======================Part-3=========================
--			Insert DATA Into USER SUBSCRIPTIONS TABLE
-- =====================================================
Print 'Inserting data Into UserSubscriptions table...';
Insert Into UserSubscriptions (UserId, PlanId, StartDate, EndDate, AutoRenew, PaymentMethod) Values
(1001, 3, '2023-01-10', '2024-01-10', 1, 'Creditcard'),
(1002, 2, '2023-02-14', '2024-02-14', 1, 'Bkash'),
(1003, 1, '2023-03-05', '2024-03-05', 0, 'Nagad'),
(1004, 4, '2023-04-18', '2024-04-18', 1, 'Banktransfer'),
(1005, 2, '2023-05-22', '2024-05-22', 1, 'Bkash'),
(1006, 3, '2023-06-30', '2024-06-30', 1, 'Nagad'),
(1007, 1, '2023-07-11', '2024-07-11', 0, 'Creditcard'),
(1008, 4, '2023-08-09', '2024-08-09', 1, 'Bkash'),
(1009, 2, '2023-09-25', '2024-09-25', 1, 'Nagad'),
(1010, 3, '2023-10-30', '2024-10-30', 1, 'Banktransfer');
Print '10 user subscriptions Inserted successfully.';
Go

-- ======================Part-4=========================
--				Insert DATA Into CONTENT TABLE
-- =====================================================
Print 'Inserting data Into Content table...';
Insert Into Content (Title, Description, ContentType, ReleaseDate, DurationMinutes, imdbRatings, IsExclusive, AddedDate) Values
('The Last Sunset', 'A thrilling drama about survival and hope.', 'movie', '2023-01-15', 128, 7.5, 1, '2023-01-20'),
('City of Dreams', 'A political drama series set in a fictional city.', 'tvshow', '2022-11-10', NULL, 8.2, 0, '2023-02-01'),
('Wild Bangladesh', 'Documentary about wildlife in Bangladesh.', 'documentary', '2023-03-22', 94, 8.7, 1, '2023-03-25'),
('Champions League Final 2023', 'Live football match between two top teams.', 'liveevent', '2023-06-10', 120, NULL, 0, '2023-06-01'),
('Midnight Shadows', 'A horror movie with unexpected twists.', 'movie', '2022-10-31', 105, 6.9, 0, '2023-04-15'),
('Tech Revolution', 'Documentary about the evolution of technology.', 'documentary', '2023-05-12', 88, 7.8, 0, '2023-05-20'),
('Love in Dhaka', 'Romantic comedy set in Dhaka city.', 'movie', '2023-02-14', 116, 7.1, 1, '2023-02-20'),
('Space Odyssey', 'Sci-fi series exploring the universe.', 'tvshow', '2023-07-01', NULL, 8.9, 1, '2023-07-05'),
('The River Bank', 'Documentary about life along the rivers of Bangladesh.', 'documentary', '2023-04-05', 102, 8.5, 1, '2023-04-10'),
('Cricket World Cup 2023', 'Live cricket match between Bangladesh and India.', 'liveevent', '2023-10-19', 210, NULL, 0, '2023-10-15');
Print '10 content records Inserted successfully.';
Go

-- ======================Part-5=========================
--				Insert DATA Into GENRES TABLE
-- =====================================================
Print 'Inserting data Into Genres table...';
Insert Into Genres (GenreName, Description) Values
('Drama', 'Emotional and character-driven stories.'),
('Thriller', 'Suspenseful and exciting plots.'),
('Documentary', 'Non-fiction educational content.'),
('Sports', 'Live sports events and related content.'),
('Horror', 'Scary and frightening movies.'),
('Romance', 'Love and relationship stories.'),
('Sci-Fi', 'Science fiction and futuristic themes.'),
('Comedy', 'Humorous and funny content.');
Print '8 genres Inserted successfully.';
Go

-- ======================Part-6=========================
--			Insert DATA Into CONTENT-GENRE JUNCTION TABLE
-- =====================================================
Print 'Inserting data Into ContentGenres table...';
Insert Into ContentGenres (ContentId, GenreId) Values
(1, 1), (1, 2),
(2, 1), (2, 2),
(3, 3),
(4, 4),
(5, 5), (5, 2),
(6, 3),
(7, 6), (7, 8),
(8, 7),
(9, 3),
(10, 4);
Print 'Content-Genre relationships Inserted successfully.';
Go

-- ======================Part-7=========================
--			Insert DATA Into CONTENT CREATORS TABLE
-- =====================================================
Print 'Inserting data Into ContentCreators table...';
Insert Into ContentCreators (CreatorName, Biography, Country, Activeyears) Values
('Tareque Masud', 'Renowned Bangladeshi filmmaker.', 'Bangladesh', '1990-2011'),
('Rubaiyat Hossain', 'Award-winning Bangladeshi director.', 'Bangladesh', '2008-Present'),
('Nurul Alam Atique', 'Popular Bangladeshi screenwriter and director.', 'Bangladesh', '2000-Present'),
('James Cameron', 'Famous international filmmaker.', 'USA', '1978-Present'),
('Christopher Nolan', 'Acclaimed British-American director.', 'UK', '1998-Present'),
('Shekhar Kapur', 'Indian film director and producer.', 'India', '1974-Present'),
('Satyajit Ray', 'Legendary Indian filmmaker.', 'India', '1950-1992'),
('Michael Bay', 'American film director and producer.', 'USA', '1986-Present');
Print '8 content creators Inserted successfully.';
Go

-- ======================Part-8=========================
--			Insert DATA Into CONTENT CREDITS TABLE
-- =====================================================
Print 'Inserting data Into ContentCredits table...';
Insert Into ContentCredits (ContentId, CreatorId, Role) Values
(1, 1, 'Director'),
(1, 2, 'Producer'),
(2, 3, 'Director'),
(2, 4, 'Executive Producer'),
(3, 5, 'Director'),
(4, 6, 'Producer'),
(5, 7, 'Director'),
(6, 8, 'Producer'),
(7, 1, 'Director'),
(8, 4, 'Director'),
(9, 2, 'Director'),
(10, 6, 'Producer');
Print 'Content credits Inserted successfully.';
Go

-- ======================Part-9=========================
--			Insert DATA Into WATCH HISTORY TABLE
-- =====================================================
Print 'Inserting data Into WatchHistory table...';
Insert Into WatchHistory (UserId, ContentId, StartTime, EndTime, DeviceType, Quality, PercentWatched) Values
(1001, 1, '2023-11-01 20:00:00', '2023-11-01 22:08:00', 'smarttv', '4k', 100.00),
(1001, 3, '2023-11-02 19:30:00', '2023-11-02 21:04:00', 'mobile', 'hd', 95.50),
(1002, 2, '2023-11-03 21:00:00', NULL, 'desktop', 'hd', 45.00),
(1002, 7, '2023-11-04 18:00:00', '2023-11-04 19:56:00', 'tablet', 'sd', 100.00),
(1003, 5, '2023-11-05 22:00:00', '2023-11-05 23:45:00', 'smarttv', 'hd', 100.00),
(1004, 8, '2023-11-06 20:30:00', NULL, 'gamingconsole', '4k', 30.00),
(1005, 10, '2023-11-07 14:00:00', '2023-11-07 17:30:00', 'smarttv', 'hd', 100.00),
(1006, 4, '2023-11-08 19:00:00', '2023-11-08 21:00:00', 'desktop', 'sd', 100.00),
(1007, 6, '2023-11-09 16:00:00', '2023-11-09 17:28:00', 'mobile', 'hd', 100.00),
(1008, 9, '2023-11-10 15:00:00', '2023-11-10 16:42:00', 'tablet', '4k', 100.00),
(1009, 1, '2023-11-11 20:00:00', '2023-11-11 22:08:00', 'smarttv', 'hd', 100.00),
(1010, 3, '2023-11-12 19:00:00', NULL, 'mobile', 'sd', 60.00);
Print '12 watch history records Inserted successfully.';
Go

-- ======================Part-10=========================
--			Insert DATA Into STREAMING DEVICES TABLE
-- ======================================================
Print 'Inserting data Into streamingDevices table...';
Insert Into streamingDevices (UserId, DeviceName, DeviceType, lastActive, IsActive) Values
(1001, 'Samsung Smart TV', 'smarttv', '2023-11-02 22:08:00', 1),
(1001, 'Xiaomi Mobile', 'mobile', '2023-11-02 21:04:00', 1),
(1002, 'HP Laptop', 'desktop', '2023-11-03 22:30:00', 1),
(1002, 'iPad Air', 'tablet', '2023-11-04 19:56:00', 1),
(1003, 'LG Smart TV', 'smarttv', '2023-11-05 23:45:00', 1),
(1004, 'PlayStation 5', 'gamingconsole', '2023-11-06 21:00:00', 1),
(1005, 'Sony Bravia TV', 'smarttv', '2023-11-07 17:30:00', 1),
(1006, 'Dell Desktop', 'desktop', '2023-11-08 21:00:00', 1),
(1007, 'Samsung Galaxy', 'mobile', '2023-11-09 17:28:00', 1),
(1008, 'iPad Pro', 'tablet', '2023-11-10 16:42:00', 1),
(1009, 'OnePlus TV', 'smarttv', '2023-11-11 22:08:00', 1),
(1010, 'Realme Mobile', 'mobile', '2023-11-12 20:00:00', 1);
Print '12 streaming devices Inserted successfully.';
Go

-- ======================Part-11=========================
--			Insert DATA Into USER REVIEWS TABLE
-- ======================================================
Print 'Inserting data Into UserReviews table...';
Insert Into UserReviews (UserId, ContentId, Ratings, Reviewtext, ReviewDate, IsHelpful) Values
(1001, 1, 5, 'Amazing movie with great acting!', '2023-11-02', 12),
(1001, 3, 4, 'Beautiful documentary about our country.', '2023-11-03', 8),
(1002, 2, 3, 'Good but could be better.', '2023-11-04', 3),
(1003, 5, 2, 'Not scary enough for me.', '2023-11-06', 1),
(1004, 8, 5, 'Mind-blowing sci-fi series!', '2023-11-07', 15),
(1005, 10, 5, 'Best cricket match ever!', '2023-11-08', 20),
(1006, 4, 4, 'Exciting football final.', '2023-11-09', 10),
(1007, 6, 3, 'Informative but too technical.', '2023-11-10', 5),
(1008, 9, 5, 'Loved the river documentary!', '2023-11-11', 9),
(1009, 1, 4, 'Good drama with suspense.', '2023-11-12', 7);
Print '10 user reviews Inserted successfully.';
Go

-- ======================Part-12=========================
--			Insert DATA Into PAYMENTS TABLE
-- ======================================================
Print 'Inserting data Into Payments table...';
Insert Into Payments (SubscriptionId, Amount, PaymentDate, Status, TransactionId) Values
(1, 799.00, '2023-01-10', 'completed', 'trx1-20230110'),
(2, 499.00, '2023-02-14', 'completed', 'trx2-20230214'),
(3, 299.00, '2023-03-05', 'completed', 'trx3-20230305'),
(4, 1299.00, '2023-04-18', 'completed', 'trx4-20230418'),
(5, 499.00, '2023-05-22', 'completed', 'trx5-20230522'),
(6, 799.00, '2023-06-30', 'completed', 'trx6-20230630'),
(7, 299.00, '2023-07-11', 'completed', 'trx7-20230711'),
(8, 1299.00, '2023-08-09', 'completed', 'trx8-20230809'),
(9, 499.00, '2023-09-25', 'completed', 'trx9-20230925'),
(10, 799.00, '2023-10-30', 'completed', 'trx10-20231030');
Print '10 payment records Inserted successfully.';
Go

-- ======================Part-13=========================
--			VERIFY DATA WITH Select QUERIES
-- ======================================================
Print 'Verifying data with sample Select queries...';
Print '================================================================';

-- 13.1 Select all users From Bangladesh
Print '1. All Bangladeshi Users:';
Select * From Users Where CountryCode = 'BD';
Go

-- 13.2 Select active subscriptions
Print '2. Active Subscriptions:';
Select * From ActiveSubscriptions;
Go

-- 13.3 Select watch history for user 1001
Print '3. Watch History for User 1001:';
Select * From WatchHistory Where UserId = 1001;
Go

-- 13.4 Select content with their genres
Print '4. Content with Genres:';
Select c.Title, g.GenreName 
From Content c
JOIN ContentGenres cg ON c.ContentId = cg.ContentId
JOIN Genres g ON cg.GenreId = g.GenreId
Order By c.Title;
Go

-- 13.5 Select user reviews with content title
Print '5. User Reviews with Content Titles:';
Select u.UserName, c.Title, ur.Ratings, ur.Reviewtext
From UserReviews ur
JOIN Users u ON ur.UserId = u.UserId
JOIN Content c ON ur.ContentId = c.ContentId;
Go

-- 13.6 Test the CalculateEngagementScore function
Print '6. User Engagement Scores:';
Select UserId, UserName, dbo.CalculateEngagementScore(UserId) AS EngagementScore
From Users
Order By EngagementScore DESC;
Go

-- 13.7 Test the GetTopContentByGenre function
Print '7. Top Content by Documentary Genre:';
Select * From dbo.GetTopContentByGenre('Documentary', 5);
Go

-- 13.8 Test the GetUserRecommendations procedure
Print '8. Recommendations for User 1001:';
Exec GetUserRecommendations @UserId = 1001;
Go

-- 13.9 Test the GetUserStatistics procedure
Print '9. Statistics for User 1002:';
Exec GetUserStatistics @UserId = 1002;
Go

Print '================================================================';
Print 'DML script completed successfully!';
Print 'All sample data Inserted and verified.';
Print '================================================================';
Go