-- =================================================================================================================
--									ADVANCED MEDIA STREAMING MANAGEMENT SYSTEM
												 -- DDL PART --
-- =================================================================================================================


/*Contents In Orders:
					=> Part-1 CHECK DATABASE EXISTENCE & CREATE DATABASE
					=> Part-2 CLEAN UP EXISTING OBJECTS
							  (DROP VIEWS, TABLES, STORED PROCEDURE, FUNCTIONS, TRIGGERS)
					=> Part-3 CREATE TABLES
							  (WITH COLUMN DEFINITION RELATED TO THE PROJECT)
					=> Part-4 CREATE INDEXES
					=> Part-5 CREATE VIEWS
							  (WITH ENCRYPTION)
					=> Part-6 CREATE FUNCTIONS
							  (WITH SCALAR VALUED AND MULTI-STATEMENT TABLE VALUED)
					=> Part-7 CREATE STORED PROCEDURES
							  (WITH TRANSACTION)
					=> Part-8 CREATE TRIGGERS
							  (FOR INSERT AND UPDATE)*/







-- ======================Part-1=========================
--	    CHECK DATABASE EXISTENCE & CREATE DATABASE
-- =====================================================
If Not Exists(Select * From sys.databases Where Name = 'MediaStreamingDB')
Begin
    Create Database MediaStreamingDB;
    Print 'Database Created successfully.';
End
Else
Begin
    Print 'Database already exists.';
End
Go

Use MediaStreamingDB;
Go

-- ======================Part-2=========================
--				CLEAN UP EXISTING OBJECTS
-- =====================================================

-- 2.1=> Drop objects in correct order (Due to depEndencies)

If Exists(Select * From sys.Views Where Name = 'ActiveSubscriptions') Drop View ActiveSubscriptions;
Go
If Exists(Select * From sys.Views Where Name = 'UserWatchStats') Drop View UserWatchStats;
Go
If Exists(Select * From sys.Views Where Name = 'ContentPopularity') Drop View ContentPopularity;
Go
If Exists(Select * From sys.Views Where Name = 'ContentRatingss') Drop View ContentRatingss;
Go
If Exists(Select * From sys.Views Where Name = 'MonthlyRevenue') Drop View MonthlyRevenue;
Go
If Exists(Select * From sys.Views Where Name = 'UserEngagement') Drop View UserEngagement;
Go

-- 2.2=> Drop tables in correct order

If Exists(Select * From sys.tables Where Name = 'WatchHistory') Drop table WatchHistory;
Go
If Exists(Select * From sys.tables Where Name = 'UserReviews') Drop table UserReviews;
Go
If Exists(Select * From sys.tables Where Name = 'ContentGenres') Drop table ContentGenres;
Go
If Exists(Select * From sys.tables Where Name = 'ContentCredits') Drop table ContentCredits;
Go
If Exists(Select * From sys.tables Where Name = 'Payments') Drop table Payments;
Go
If Exists(Select * From sys.tables Where Name = 'StreamingDevices') Drop table StreamingDevices;
Go
If Exists(Select * From sys.tables Where Name = 'UserSubscriptions') Drop table UserSubscriptions;
Go
If Exists(Select * From sys.tables Where Name = 'Content') Drop table Content;
Go
If Exists(Select * From sys.tables Where Name = 'Genres') Drop table Genres;
Go
If Exists(Select * From sys.tables Where Name = 'ContentCreators') Drop table ContentCreators;
Go
If Exists(Select * From sys.tables Where Name = 'SubscriptionPlans') Drop table SubscriptionPlans;
Go
If Exists(Select * From sys.tables Where Name = 'Users') Drop table Users;
Go

-- 2.3=> Drop stored procedures

If Exists(Select * From sys.procedures Where Name = 'AddNewUserWithSubscription') Drop procedure addnewUserwithSubscription;
Go
If Exists(Select * From sys.procedures Where Name = 'UpdateUserSubscription') Drop procedure UpdateUserSubscription;
Go
If Exists(Select * From sys.procedures Where Name = 'DeleteUserAcCount') Drop procedure DeleteUserAcCount;
Go
If Exists(Select * From sys.procedures Where Name = 'GetUserRecommendations') Drop procedure GetUserRecommendations;
Go
If Exists(Select * From sys.procedures Where Name = 'GenerateMonthlyRevenueReport') Drop procedure GenerateMonthlyRevenueReport;
Go
If Exists(Select * From sys.procedures Where Name = 'ManageContent') Drop procedure ManageContent;
Go
If Exists(Select * From sys.procedures Where Name = 'RecordWatchSession') Drop procedure RecordWatchSession;
Go
If Exists(Select * From sys.procedures Where Name = 'EndWatchSession') Drop procedure EndWatchSession;
Go
If Exists(Select * From sys.procedures Where Name = 'GetUserStatistics') Drop procedure GetUserStatistics;
Go

-- 2.4=> Drop functions

If Exists(Select * From sys.objects Where Name = 'CalculateEngagementScore' and Type = 'FN') Drop function CalculateEngagementScore;
Go
If Exists(Select * From sys.objects Where Name = 'GetTopContentByGenre' and Type = 'TF') Drop function GetTopContentByGenre;
Go
If Exists(Select * From sys.objects Where Name = 'GetSimilarContent' and Type = 'TF') Drop function GetSimilarContent;
Go
If Exists(Select * From sys.objects Where Name = 'GetContentAge' and Type = 'FN') Drop function GetContentAge;
Go

-- 2.5=> Drop triggers

If Exists(Select * From sys.triggers Where Name = 'Trigger_check_concurrent_streams') Drop trigger Trigger_check_concurrent_streams;
Go
If Exists(Select * From sys.triggers Where Name = 'Trigger_Update_Device_activity') Drop trigger Trigger_Update_Device_activity;
Go
If Exists(Select * From sys.triggers Where Name = 'Trigger_Subscription_expiry_alert') Drop trigger Trigger_Subscription_expiry_alert;
Go
If Exists(Select * From sys.triggers Where Name = 'Trigger_Content_audit') Drop trigger Trigger_Content_audit;
Go
If Exists(Select * From sys.triggers Where Name = 'Trigger_valIDate_Watch_age') Drop trigger Trigger_valIDate_Watch_age;
Go
If Exists(Select * From sys.triggers Where Name = 'Trigger_Update_Ratings_stats') Drop trigger Trigger_Update_Ratings_stats;
Go

-- ================Part-3=======================
--				CREATE TABLES
-- =============================================

-- 3.1=> Users table
Create table Users (
    UserId int Identity(1001, 1) primary key,
    UserName varchar(100) not null,
    Email varchar(255) Unique not null,
    DateOfBirth Date not null,
    CountryCode char(3) not null,
    RegistrationDate DateTime default Getdate(),
    IsActive bit default 1,
    constraint chk_Email check (Email like '%@%.%'),
    constraint chk_age check (DatedIff(year, DateOfBirth, Getdate()) >= 13)
);
Print 'Created table: Users';
Go

-- 3.2=> Subscription Plans table
Create table SubscriptionPlans (
    PlanId int Identity(1, 1) primary key,
    PlanName varchar(50) not null,
    MonthlyPrice decimal(10, 2) not null,
    maxQuality varchar(20) check (maxQuality in ('sd', 'hd', '4k', '8k')),
    maxsimultaneousstreams int default 1,
    adfree bit default 0
);
Print 'Created table: SubscriptionPlans';
Go

-- 3.3=> User Subscriptions table
Create table UserSubscriptions (
    SubscriptionId int Identity(1, 1) primary key,
    UserId int not null foreign key references Users(UserId),
    PlanId int not null foreign key references SubscriptionPlans(PlanId),
    StartDate Date not null,
    EndDate Date,
    AutoRenew bit default 1,
    PaymentMethod varchar(30) check (PaymentMethod in ('Creditcard', 'Bkash', 'Banktransfer', 'Nagad')),
    constraint chk_Dates check (EndDate is null or EndDate > StartDate)
);
Print 'Created table: UserSubscriptions';
Go

-- 3.4=> Content table
Create table Content (
    ContentId int Identity(1, 1) primary key,
    Title varchar(255) not null,
    Description text,
    ContentType varchar(20) check (ContentType in ('movie', 'tvshow', 'documentary', 'liveevent')),
    ReleaseDate Date,
    DurationMinutes int,
    imdbRatings decimal(3, 1),
    IsExclusive bit default 0,
    AddedDate DateTime default Getdate()
);
Print 'Created table: Content';
Go

-- 3.5=> Genres table
Create table Genres (
    GenreId int Identity(1, 1) primary key,
    GenreName varchar(50) Unique not null,
    Description varchar(255)
);
Print 'Created table: Genres';
Go

-- 3.6=> Content-Genre junction table
Create table ContentGenres (
    ContentGenreId int Identity(1, 1) primary key,
    ContentId int not null foreign key references Content(ContentId),
    GenreId int not null foreign key references Genres(GenreId),
    Unique(ContentId, GenreId)
);
Print 'Created table: ContentGenres';
Go

-- 3.7=> Watch History table
Create table WatchHistory (
    WatchId bigint Identity(1, 1) primary key,
    UserId int not null foreign key references Users(UserId),
    ContentId int not null foreign key references Content(ContentId),
    StartTime DateTime not null,
    EndTime DateTime,
    DeviceType varchar(30),
    Quality varchar(10),
    PercentWatched decimal(5, 2) default 0,
    constraint chk_Percent check (PercentWatched between 0 and 100),
    constraint chk_Time check (EndTime is null or EndTime > StartTime)
);
Print 'Created table: WatchHistory';
Go

-- 3.8=> Payments table
Create table Payments (
    PaymentId int Identity(1, 1) primary key,
    SubscriptionId int not null foreign key references UserSubscriptions(SubscriptionId),
    Amount decimal(10, 2) not null,
    PaymentDate DateTime default Getdate(),
    Status varchar(20) default 'completed' check (Status in ('pEnding', 'completed', 'failed', 'refunded')),
    TransactionId varchar(100) Unique
);
Print 'Created table: Payments';
Go

-- 3.9=> Streaming Devices table
Create table streamingDevices (
    DeviceId int Identity(1, 1) primary key,
    UserId int not null foreign key references Users(UserId),
    DeviceName varchar(100) not null,
    DeviceType varchar(30) check (DeviceType in ('smarttv', 'mobile', 'tablet', 'desktop', 'gamingconsole')),
    lastActive DateTime,
    IsActive bit default 1
);
Print 'Created table: streamingDevices';
Go

-- 3.10=> User Reviews table
Create table UserReviews (
    ReviewId int Identity(1, 1) primary key,
    UserId int not null foreign key references Users(UserId),
    ContentId int not null foreign key references Content(ContentId),
    Ratings int check (Ratings between 1 and 5),
    Reviewtext text,
    ReviewDate DateTime default Getdate(),
    IsHelpful int default 0
);
Print 'Created table: UserReviews';
Go

-- 3.11=> Content Creators table
Create table ContentCreators (
    CreatorId int Identity(1, 1) primary key,
    CreatorName varchar(100) not null,
    Biography text,
    Country varchar(50),
    Activeyears varchar(20)
);
Print 'Created table: ContentCreators';
Go

-- 3.12=> Content Credits table
Create table ContentCredits (
    CreditId int Identity(1, 1) primary key,
    ContentId int not null foreign key references Content(ContentId),
    CreatorId int not null foreign key references ContentCreators(CreatorId),
    Role varchar(50) not null
);
Print 'Created table: ContentCredits';
Go

-- ===============Part-4========================
--				CREATE INDEXES
-- =============================================

Create index Idx_Users_Email on Users(Email);
Create index Idx_Users_Country on Users(Countrycode);
Create index Idx_Content_Title on Content(Title);
Create index Idx_Content_Release on Content(ReleaseDate);
Create index Idx_Watch_User on WatchHistory(UserId);
Create index Idx_Watch_Content on WatchHistory(ContentId);
Create index Idx_Watch_Time on WatchHistory(StartTime);
Create index Idx_Subscriptions_User on UserSubscriptions(UserId);
Create index Idx_Subscriptions_Dates on UserSubscriptions(StartDate, EndDate);
Create index Idx_Reviews_Content on UserReviews(ContentId);
Create index Idx_Reviews_User on UserReviews(UserId);
Create index Idx_Payments_Date on Payments(PaymentDate);
Create index Idx_Payments_Status on Payments(Status);
Print 'Created indexes';
Go

-- ================Part-5=======================
--				 CREATE VIEWS
-- =============================================

-- 5.1=> View for Active User Subscriptions
Create View ActiveSubscriptions With Encryption as
Select 
    u.UserId,
    u.UserName,
    u.Email,
    sp.PlanName,
    sp.MonthlyPrice,
    us.StartDate,
    us.EndDate,
    Case 
        When us.EndDate is null Then null
        Else DatedIff(Day, Getdate(), us.EndDate)
    End as Daysremaining
From Users u
join UserSubscriptions us on u.UserId = us.UserId
join SubscriptionPlans sp on us.PlanId = sp.PlanId
Where us.EndDate is null or us.EndDate > Getdate();
Go
Print 'Created View: ActiveSubscriptions';
Go

-- 5.2=> View for User Watch Statistics
Create View UserWatchstats With Encryption as
Select 
    w.UserId,
    u.UserName,
    Count(distinct w.ContentId) as TotalContentWatched,
    sum(Case When w.EndTime is not null Then DatedIff(minute, w.StartTime, w.EndTime) Else 0 End) as TotalMinutesWatched,
    Avg(w.PercentWatched) as AvgCompletionrate,
    max(w.StartTime) as lastWatched
From WatchHistory w
join Users u on w.UserId = u.UserId
Group by w.UserId, u.UserName;
Go
Print 'Created View: UserWatchstats';
Go

-- 5.3=> View for Content popularity
Create View Contentpopularity With Encryption as
Select 
    c.ContentId,
    c.Title,
    c.ContentType,
    Count(distinct w.UserId) as UniqueViewers,
    Count(w.WatchId) as TotalViews,
    Avg(w.PercentWatched) as AvgCompletionrate
From Content c
left join WatchHistory w on c.ContentId = w.ContentId
Group by c.ContentId, c.Title, c.ContentType;
Go
Print 'Created View: Contentpopularity';
Go

-- 5.4=> View for Content Ratingss summary
Create View ContentRatingss With Encryption as
Select 
    c.ContentId,
    c.Title,
    Count(r.ReviewId) as TotalReviews,
    Avg(cast(r.Ratings as decimal(3,2))) as averageRatings,
    min(r.Ratings) as minRatings,
    max(r.Ratings) as maxRatings
From Content c
left join UserReviews r on c.ContentId = r.ContentId
Group by c.ContentId, c.Title;
Go
Print 'Created View: ContentRatingss';
Go

-- =================Part-6======================
--				CREATE FUNCTIONS
-- =============================================

-- 6.1=> Function to Calculate User Engagement Score (Scalar Valued)
Create function calculateengagementscore(@UserId int)
Returns decimal(5, 2)
as
Begin
    Declare @score decimal(5, 2);
    
    Declare @UniqueContent int;
    Declare @TotalMinutes int;
    Declare @DaysSinceFirstWatch int;
    
    Select 
        @UniqueContent = Count(distinct ContentId),
        @TotalMinutes = sum(Case When EndTime is not null Then DatedIff(minute, StartTime, EndTime) Else 0 End),
        @DaysSinceFirstWatch = Case When Count(*) > 0 Then DatedIff(Day, min(StartTime), Getdate()) Else 0 End
    From WatchHistory
    Where UserId = @UserId;
    
    Set @score = 
        (isnull(@UniqueContent, 0) * 0.3) + 
        (log10(isnull(@TotalMinutes, 0) + 1) * 0.4) + 
        (Case When isnull(@DaysSinceFirstWatch, 0) > 0 
              Then log10(@DaysSinceFirstWatch) * 0.3 
              Else 0 End);
    
    Return isnull(@score, 0);
End;
Go
Print 'Created function: CalculateEngagementScore';
Go

-- 6.2=> Function to Get Top Content by Genre (Multi-statement Table Valued)
Create function getTopContentbyGenre(@GenreName varchar(50), @topn int = 5)
Returns @result table (
    ContentId int,
    Title varchar(255),
    ContentType varchar(20),
    imdbRatings decimal(3, 1),
    ViewerCount int,
    AvgCompletion decimal(5, 2)
)
as
Begin
    insert into @result
    Select top(@topn)
        c.ContentId,
        c.Title,
        c.ContentType,
        c.imdbRatings,
        Count(distinct wh.UserId) as ViewerCount,
        Avg(wh.PercentWatched) as AvgCompletion
    From Content c
    join ContentGenres cg on c.ContentId = cg.ContentId
    join Genres g on cg.GenreId = g.GenreId
    left join WatchHistory wh on c.ContentId = wh.ContentId
    Where g.GenreName = @GenreName
    Group by c.ContentId, c.Title, c.ContentType, c.imdbRatings
    Order by ViewerCount desc, AvgCompletion desc;
    
    Return;
End;
Go
Print 'Created function: gettopContentbyGenre';
Go

-- ================Part-7=======================
--		   CREATE STORED PROCEDURES
-- =============================================

-- 7.1=> Procedure to add new User with Subscription (Transaction)
Create procedure addnewUserwithSubscription
    @UserName varchar(100),
    @Email varchar(255),
    @DateOfBirth Date,
    @Countrycode char(3),
    @PlanId int,
    @PaymentMethod varchar(30)
as
Begin
    Begin try
        Begin Transaction;
        
        -- insert User
        insert into Users (UserName, Email, DateOfBirth, Countrycode)
        values (@UserName, @Email, @DateOfBirth, @Countrycode);
        
        Declare @newUserId int = scope_Identity();
        
        -- Create Subscription
        insert into UserSubscriptions (UserId, PlanId, StartDate, PaymentMethod)
        values (@newUserId, @PlanId, Getdate(), @PaymentMethod);
        
        Declare @newSubscriptionId int = scope_Identity();
        
        -- Create initial Payment
        Declare @Amount decimal(10, 2);
        Select @Amount = MonthlyPrice From SubscriptionPlans Where PlanId = @PlanId;
        
        insert into Payments (SubscriptionId, Amount, TransactionId)
        values (@newSubscriptionId, @Amount, 'trx' + cast(@newSubscriptionId as varchar) + format(Getdate(), 'yyyyMMddHHmmss'));
        
        commit Transaction;
        
        Select 'success' as result, @newUserId as UserId, @newSubscriptionId as SubscriptionId;
    End try
    Begin catch
        rollback Transaction;
        throw;
    End catch
End;
Go
Print 'Created procedure: AddNewUserWithSubscription';
Go

-- 7.2=> Procedure for Monthly Revenue Report
Create procedure generateMonthlyRevenueReport
    @year int,
    @Month int
as
Begin
    Select 
        DateName(Month, PaymentDate) as MonthName,
        sp.PlanName,
        Count(distinct p.SubscriptionId) as TotalSubscriptions,
        sum(p.Amount) as TotalRevenue,
        Avg(p.Amount) as averagePayment,
        min(p.Amount) as minPayment,
        max(p.Amount) as maxPayment
    From Payments p
    join UserSubscriptions us on p.SubscriptionId = us.SubscriptionId
    join SubscriptionPlans sp on us.PlanId = sp.PlanId
    Where year(p.PaymentDate) = @year
    and Month(p.PaymentDate) = @Month
    and p.Status = 'completed'
    Group by sp.PlanName, DateName(Month, PaymentDate)
    order by TotalRevenue desc;
End;
Go
Print 'Created procedure: generateMonthlyRevenueReport';
Go

-- 7.3=> Procedure to get User Recommendations
Create procedure getUserRecommendations
    @UserId int,
    @maxresults int = 10
as
Begin
    Select top(@maxresults)
        c.ContentId,
        c.Title,
        c.ContentType,
        c.imdbRatings,
        Count(distinct wh.UserId) as similarUsersWatched
    From Content c
    join ContentGenres cg on c.ContentId = cg.ContentId
    join WatchHistory wh on c.ContentId = wh.ContentId
    Where cg.GenreId in (
        Select distinct cg2.GenreId
        From WatchHistory wh2
        join ContentGenres cg2 on wh2.ContentId = cg2.ContentId
        Where wh2.UserId = @UserId
        and wh2.PercentWatched > 70
    )
    and wh.UserId != @UserId
    and c.ContentId not in (
        Select ContentId From WatchHistory Where UserId = @UserId
    )
    Group by c.ContentId, c.Title, c.ContentType, c.imdbRatings
    order by similarUsersWatched desc, c.imdbRatings desc;
End;
Go
Print 'Created procedure: getUserRecommendations';
Go

-- 7.4=> Procedure for User Statistics
Create procedure getUserStatistics
    @UserId int
as
Begin
    Select 
        u.UserName,
        u.Email,
        u.Countrycode,
        dbo.calculateengagementscore(u.UserId) as engagementscore,
        (Select Count(*) From WatchHistory Where UserId = @UserId) as Totalsessions,
        (Select Count(distinct ContentId) From WatchHistory Where UserId = @UserId) as UniqueContentWatched,
        (Select sum(Case When EndTime is not null Then DatedIff(minute, StartTime, EndTime) Else 0 End) From WatchHistory Where UserId = @UserId) as TotalWatchMinutes,
        (Select Count(*) From UserReviews Where UserId = @UserId) as Reviewsgiven
    From Users u
    Where u.UserId = @UserId;
End;
Go
Print 'Created procedure: getUserStatistics';
Go

-- =================Part-8======================
--				 CREATE TRIGGERS
-- =============================================

-- 8.1=> Trigger to Update last Active On Device
Create trigger Trigger_Update_Device_activity
on WatchHistory
after insert
as
Begin
    Set noCount on;
    
    Update sd
    Set lastActive = Getdate()
    From streamingDevices sd
    join inserted i on sd.UserId = i.UserId
    Where sd.DeviceType = i.DeviceType
    and sd.UserId = i.UserId;
End;
Go
Print 'Created trigger: Trigger_Update_Device_activity';
Go

-- 8.2=> Trigger for Subscription Expiration Notification
Create trigger Trigger_Subscription_expiry_alert
on UserSubscriptions
after Update
as
Begin
    Set NoCount on;
    
    If Update(EndDate)
    Begin
        Declare @UserId int, @EndDate Date, @Daysleft int;
        
        Select @UserId = inserted.UserId, @EndDate = inserted.EndDate
        From inserted;
        
        Set @Daysleft = DatedIff(Day, Getdate(), @EndDate);
        
        If @Daysleft between 1 and 7
        Begin
            Print 'User ' + cast(@UserId as varchar) + ': Subscription expires in ' + cast(@Daysleft as varchar) + ' Days. Send Renewal reminder.';
        End
        Else If @Daysleft < 0
        Begin
            Print 'User ' + cast(@UserId as varchar) + ': Subscription expired. Send reactivation offer.';
        End
    End
End;
Go
Print 'Created trigger: Trigger_Subscription_expiry_alert';
Go

Print '================================================================';
Print 'ddl script completed successfully!';
Print 'all tables, views, functions, procedures, and triggers Created.';
Print '================================================================';
Go