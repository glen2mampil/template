﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'SysDev.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201709070459006_InitialCreationModel'
BEGIN
    CREATE TABLE [dbo].[AspNetRoles] (
        [Id] [nvarchar](128) NOT NULL,
        [Name] [nvarchar](256) NOT NULL,
        CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY ([Id])
    )
    CREATE UNIQUE INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]([Name])
    CREATE TABLE [dbo].[AspNetUserRoles] (
        [UserId] [nvarchar](128) NOT NULL,
        [RoleId] [nvarchar](128) NOT NULL,
        CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId])
    )
    CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]([UserId])
    CREATE INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]([RoleId])
    CREATE TABLE [dbo].[AspNetUsers] (
        [Id] [nvarchar](128) NOT NULL,
        [Email] [nvarchar](256),
        [EmailConfirmed] [bit] NOT NULL,
        [PasswordHash] [nvarchar](max),
        [SecurityStamp] [nvarchar](max),
        [PhoneNumber] [nvarchar](max),
        [PhoneNumberConfirmed] [bit] NOT NULL,
        [TwoFactorEnabled] [bit] NOT NULL,
        [LockoutEndDateUtc] [datetime],
        [LockoutEnabled] [bit] NOT NULL,
        [AccessFailedCount] [int] NOT NULL,
        [UserName] [nvarchar](256) NOT NULL,
        CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY ([Id])
    )
    CREATE UNIQUE INDEX [UserNameIndex] ON [dbo].[AspNetUsers]([UserName])
    CREATE TABLE [dbo].[AspNetUserClaims] (
        [Id] [int] NOT NULL IDENTITY,
        [UserId] [nvarchar](128) NOT NULL,
        [ClaimType] [nvarchar](max),
        [ClaimValue] [nvarchar](max),
        CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY ([Id])
    )
    CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]([UserId])
    CREATE TABLE [dbo].[AspNetUserLogins] (
        [LoginProvider] [nvarchar](128) NOT NULL,
        [ProviderKey] [nvarchar](128) NOT NULL,
        [UserId] [nvarchar](128) NOT NULL,
        CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey], [UserId])
    )
    CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]([UserId])
    ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201709070459006_InitialCreationModel', N'SysDev.Migrations.Configuration',  0x1F8B0800000000000400DD5C5B6FE3B6127E3FC0F90F829E7A0E522B97B38B6D60EF2275929EA09B0BD6D9A26F0B5AA21D61254A95A83441D15FD687FEA4FE850E254A166FBAD88AED140B2C2272F8CD70382487C3A1FFFAE3CFF187A730B01E7192FA1199D847A343DBC2C48D3C9F2C27764617DFBEB33FBCFFF7BFC6175EF864FD54D29D303A6849D289FD40697CEA38A9FB8043948E42DF4DA2345AD0911B850EF222E7F8F0F03BE7E8C8C100610396658D3F6584FA21CE3FE0731A1117C73443C175E4E120E5E55033CB51AD1B14E234462E9ED8B3E7F41C3F8E0A42DB3A0B7C0442CC70B0B02D4448441105114F3FA7784693882C673114A0E0FE39C640B740418AB9E8A72BF2AEBD383C66BD70560D4B28374B6914F6043C3AE16A71E4E66B29D7AED4068ABB0005D367D6EB5C7913FBCAC379D1A7280005C80C4FA741C28827F675C5E22C8D6F301D950D4705E4650270BF46C9D7511DF1C0EADCEEA032A3E3D121FB77604DB38066099E109CD1040507D65D360F7CF747FC7C1F7DC5647272345F9CBC7BF31679276FFF874FDED47B0A7D053AA1008AEE9228C609C8861755FF6DCB11DB3972C3AA59AD4DA115B0259811B6758D9E3E62B2A40F30578EDFD9D6A5FF84BDB2841BD767E2C304824634C9E0F3260B02340F7055EF34F264FF37703D7EF37610AE37E8D15FE6432FF1878993C0BCFA8483BC367DF0E3627A09E3FD85935D2651C8BE45FB2A6ABFCCA22C7159672223C93D4A96988AD28D9D95F17632690635BC5997A8FB6FDA4C52D5BCB5A4AC43EBCC8492C5B6674329EFCBF2ED6C7167710C83979B16D34893C109FBD4486A786015D52B8339EA6A30043AF24F5EFF2E42E407032C801DB880DBB1F0931057BDFC3E027343A4B7CC77284D61FE7BFF47E94383E8F0E700A2CFB09B256096338AC2F8C5B9DD3D4404DF64E19C59FBF6780D3634F7BF4697C8A551724158AB8DF13E46EED728A317C43B47147FA66E09C83EEFFDB03BC020E29CB92E4ED34B3066EC4D23F0AA4BC02B424F8E7BC3B1B569D70EC834407EA8F740A455F44B49BAF242F4148A276220D379234DA27E8C963EE9266A496A16B5A068159593F5159581759394539A05CD095AE52CA806F3EFF2111ADEC1CB61F7DFC3DB6CF336AD053535CE6085C43F60821358C6BC3B44294EC86A04BAAC1BBB7016F2E1634C5F7C6FCA39FD84826C68566BCD867C11187E36E4B0FB3F1B7231A1F8D1F79857D2E1D85312037C277AFD89AA7DCE49926D7B3A08DDDC36F3EDAC01A6E97296A691EBE7B34013F0E2E10A517EF0E1ACF6D845D11B39FE011D0343F7D9960725D0375B36AA5B728E034CB175E61601C1294A5DE4A96A840E793D042B77548D60AB388828DC7F159E60E938618D103B04A530537D42D569E113D78F51D0AA25A965C72D8CF5BDE221D79CE31813C6B055135D98EBC31E4C808A8F34286D1A1A3B358B6B364483D76A1AF336177635EE4A34622B36D9E23B1BEC92FB6F2F6298CD1ADB827136ABA48B00C610DE2E0C949F55BA1A807C70D93703954E4C0603E52ED5560C54D4D80E0C5454C9AB33D0E288DA75FCA5F3EABE99A77850DEFEB6DEA8AE1DD8A6A08F3D33CDC2F78436145AE04435CFF339ABC44F5473380339F9F92CE5AEAE6C220C7C86A918B259F9BB5A3FD46906918DA8097065682DA0FCF24F015226540FE1CA585EA374DC8BE8015BC6DD1A61F9DA2FC1D66C40C5AE5F82D608CD57A5B271763A7D543DABAC4131F24E87851A8EC620E4C54BEC7807A598E2B2AA62BAF8C27DBCE15AC7F8603428A8C5733528A9ECCCE05A2A4DB35D4B3A87AC8F4BB6919624F7C9A0A5B233836B89DB68BB92344E410FB7602315895BF84093AD8C7454BB4D5537768AB4285E30760CF953E36B14C73E59D6F2A97889352B92A9A6DFCEFAA71A850586E3A69A8CA34ADA8A138D12B4C4522DB006492FFD24A5E788A23962719EA9172A64DABDD5B0FC972CEBDBA73A88E53E5052B3BFF9CDAA70652F6CB3AA1FC29B5F42E742E6CCE41174CDD0EB9B5B2CB50D0528D104EDA7519085C4EC5B995B175777F5F645898A307624F915DF495194E2E18A5AEF3426EA7CD87C7C2AAF65FD31324398345DFA9C755D9BFC50334A1996AAA39842553B1B3393FBD2759C64A7B0FF30B522BCCC6CE2992875005ED413A396CCA080D5EABAA38AF926754CB1A63BA29454528794AA7A48594F1D1184AC57AC8567D0A89EA23B073559A48EAED67647D6A48DD4A135D56B606B6496EBBAA36A324BEAC09AEAEED8AB341379FDDCE3FDCA78545967C32A0EB29BED58068C97590C87D9F06AF7F575A05A714F2C7E23AF80F1F2BD3424E3696E1D432A42179B199201C3BCDE0897DCE272D378336FC6146EAE8525BDE9E6DE8CD7CF5C5FD42894739C4C5271AFCE73D2B96DCCCF50ED8F6394435541625BA51A7353A2381C3182D1EC97601AF8982DDE25C13522FE02A7B4C8D6B08F0F8F8EA54736FBF3E0C549532FD09C414DAF5EC431DB42E215794489FB8012350D628347212B5025C27C453CFC34B17FCB5B9DE6C10AF6575E7C605DA59F89FF4B0615F74986ADDFD5B4CE6192E49B4F557BFAA4A1BB56AF7EFE52343DB06E139831A7D6A1A4CB7546587CE8D04B9AA2E906D2ACFDFCE1F54E28E1958116559A10EB3F2A98FB74900705A594DF84E8E93F7D45D33E1AD80851F3306028BC4154684AFC5F07CB98F4EFC127CD93FEFB7556FF08601DD18C0F007CD21F4C4EFFEFBE0C952D77B8D5688E43DB5892723DB7A64F6F944BB9EBBD49C9B2DE68A2AB99D43DE036C8965EC3325E59A2F160BBA3268F7830EC5D9AF68B270FEF4BBEF02A9363B769C2DBCC0C6EB807FA472504EF410A9B262567F769BFDBB635530877CF7327FB25F7EE99B1F144ADDDA7F06EDBD84C61DE3D37B65E89BA7B666BBBDA3F776C699DB7D09DA7DDAA194486AB185D2CB82DADB6089CC3097F1E8111141E65F11A529FC7D59483DAC2704562666A4E2093192B1347E1AB5034B3EDD757BEE1377696D334B335A45D36F1E6EB7F236F4ED3CCDB90CCB88B84606D3AA12E49BB651D6BCA7A7A4D09C0424F5AF2CDDB7CD6C67BF5D794EF3B885284D963B8237E3DE9BD83A864C8A9D3239D57BDEE85BDB3F68B89B07FA7FE7205C17E3F916057D8352B9A2BB288CACD5B92A824912234D798220FB6D4B384FA0BE452A86631E6FC39771EB763371D73EC5D91DB8CC619852EE3701E08012FE60434F1CF73964599C7B771FECB24437401C4F4596CFE967C9FF98157C97DA9890919209877C123BA6C2C298BEC2E9F2BA49B887404E2EAAB9CA27B1CC60180A5B764861EF13AB281F97DC44BE43EAF22802690F68110D53E3EF7D1324161CA3156EDE1136CD80B9FDEFF0D58E9F6E338540000 , N'6.1.3-40302')
END

IF @CurrentMigration < '201709080327419_AddedModels'
BEGIN
    CREATE TABLE [dbo].[AuditTrails] (
        [Id] [int] NOT NULL IDENTITY,
        [ModuleId] [int] NOT NULL,
        [PageId] [int] NOT NULL,
        [Action] [nvarchar](max),
        [UserProfileId] [int] NOT NULL,
        [Description] [nvarchar](max),
        [DateCreated] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.AuditTrails] PRIMARY KEY ([Id])
    )
    CREATE INDEX [IX_UserProfileId] ON [dbo].[AuditTrails]([UserProfileId])
    CREATE TABLE [dbo].[UserProfiles] (
        [Id] [int] NOT NULL IDENTITY,
        [FirstName] [nvarchar](50) NOT NULL,
        [LastName] [nvarchar](50) NOT NULL,
        [MiddleName] [nvarchar](50) NOT NULL,
        [Address] [nvarchar](50) NOT NULL,
        [ContactNo] [nvarchar](50) NOT NULL,
        [CompanyName] [nvarchar](50) NOT NULL,
        [CompanyId] [nvarchar](50) NOT NULL,
        [Gender] [nvarchar](50) NOT NULL,
        [MaritalStatus] [nvarchar](50) NOT NULL,
        [DateCreated] [nvarchar](50) NOT NULL,
        CONSTRAINT [PK_dbo.UserProfiles] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[MasterDatas] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [Description] [nvarchar](max),
        [Status] [nvarchar](max),
        [OrderNumber] [int] NOT NULL,
        [DateTimeCreated] [datetime] NOT NULL,
        [DateTimeUpdated] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.MasterDatas] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[MasterDetails] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [Value] [nvarchar](max),
        [Description] [nvarchar](max),
        [Status] [nvarchar](max),
        [OrderNumber] [int] NOT NULL,
        [DateTimeCreated] [datetime] NOT NULL,
        [DateTimeUpdated] [datetime] NOT NULL,
        [MasterDataId] [int] NOT NULL,
        CONSTRAINT [PK_dbo.MasterDetails] PRIMARY KEY ([Id])
    )
    CREATE INDEX [IX_MasterDataId] ON [dbo].[MasterDetails]([MasterDataId])
    CREATE TABLE [dbo].[Permissions] (
        [Id] [int] NOT NULL IDENTITY,
        [IdentityRoleId] [nvarchar](128),
        [MasterDetailId] [int] NOT NULL,
        [AllowView] [int] NOT NULL,
        [AllowCreate] [int] NOT NULL,
        [AllowEdit] [int] NOT NULL,
        [AllowDelete] [int] NOT NULL,
        [AllowGenerateReport] [int] NOT NULL,
        CONSTRAINT [PK_dbo.Permissions] PRIMARY KEY ([Id])
    )
    CREATE INDEX [IX_IdentityRoleId] ON [dbo].[Permissions]([IdentityRoleId])
    CREATE INDEX [IX_MasterDetailId] ON [dbo].[Permissions]([MasterDetailId])
    ALTER TABLE [dbo].[AspNetUsers] ADD [Status] [nvarchar](max)
    ALTER TABLE [dbo].[AspNetUsers] ADD [UserProfileId] [int] NOT NULL DEFAULT 0
    CREATE INDEX [IX_UserProfileId] ON [dbo].[AspNetUsers]([UserProfileId])
    ALTER TABLE [dbo].[AspNetUsers] ADD CONSTRAINT [FK_dbo.AspNetUsers_dbo.UserProfiles_UserProfileId] FOREIGN KEY ([UserProfileId]) REFERENCES [dbo].[UserProfiles] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[AuditTrails] ADD CONSTRAINT [FK_dbo.AuditTrails_dbo.UserProfiles_UserProfileId] FOREIGN KEY ([UserProfileId]) REFERENCES [dbo].[UserProfiles] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[MasterDetails] ADD CONSTRAINT [FK_dbo.MasterDetails_dbo.MasterDatas_MasterDataId] FOREIGN KEY ([MasterDataId]) REFERENCES [dbo].[MasterDatas] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[Permissions] ADD CONSTRAINT [FK_dbo.Permissions_dbo.AspNetRoles_IdentityRoleId] FOREIGN KEY ([IdentityRoleId]) REFERENCES [dbo].[AspNetRoles] ([Id])
    ALTER TABLE [dbo].[Permissions] ADD CONSTRAINT [FK_dbo.Permissions_dbo.MasterDetails_MasterDetailId] FOREIGN KEY ([MasterDetailId]) REFERENCES [dbo].[MasterDetails] ([Id]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201709080327419_AddedModels', N'SysDev.Migrations.Configuration',  0x1F8B0800000000000400ED5DD96EDCCA117D0F907F20F89404BA1A2DB1E108D2BDD095AC4488B5C0231B79135A646B4498CB5C2EB284205F96877C527E21CD6DD8FB42F670388EE017AB9753CDEAAAEAEEEA9EAAFFFEFB3FC7BFBC44A1F30CD32C48E213777F77CF7560EC257E102F4EDC227FFCE983FBCBCFBFFFDDF1473F7A71BEB6ED0ECB76A8679C9DB84F79BE3C9ACD32EF094620DB8D022F4DB2E431DFF5926806FC6476B0B7F797D9FEFE0C2208176139CEF1E722CE8308567FA03FCF92D883CBBC00E155E2C3306BCA51CDBC4275AE4104B325F0E0893B7FCDCEE1F36EDDD0754EC300A041CC61F8E83A208E931CE46888475F3238CFD3245ECC97A8008477AF4B88DA3D823083CDD08FBAE6BA5FB177507EC5ACEBD842794596279121E0FE61C39619DDBD1773DD15DB10E33E2206E7AFE55757CC3B714F0B3FC8EF521084AE43933B3A0BD3B229C5DDDDAECF8E53D7ECAC6400894AF96FC7392BC2BC48E1490C8B3C05A8E56DF11006DEDFE1EB5DF20DC627711186F8D0D0E0501D51808A6ED36409D3FCF5337C6C067CE9BBCE8CEC37A33BAEBA617DEA0FB98CF3C303D7B946C4C1430857338F7DF43C4F52F85718C314E4D0BF05790ED3B8C48015EF18EA142DC4A322846A8A72945BB0188C71EAD532D34C619E22E5759D2BF0F209C68BFC090D15BCB8CE45F002FDB6A4C1FD120748D751A73C2D9464904AA5A8E83118FED5E730F3D26039CAB0CFD1EC9EA5B09CE39656597487EC8F7ADCD7E0395854E2226686EB7C8661D5267B0A96B52DC254E79E687A9126D1E7242414126F713F4F8AD4430DEF1269B33B902E604E8EF778D669BDD4161023D2350658A7376BC0D0BA08D22C2FFF2B91E7777B5AE26CA84B9FC086085F05BE1FC28D903EF5FD1466D9E874D14625075E7E9D6C8072B404F1EB46B8DDD0EED46934CA481F7D988E2FD9200D7210CE916928C61732CE82B526DADA0BC615B23130450303FAEB45D7E76DB9606829F4D8D2CE67C45D965257EC90B949913DB82EA287CE2AF4DC81365BC0DE3B4301DE97A5DF03CF5411616E748EC37BBD29E36694F12B088B37957F5379315EB7601A1FAF85C7547CE1E69C5271C3708FB7ED8EA98226CC3955D46ED041F516A65190659534EB1ABBAECF9BA9E3D0AADB957326DDCFEF1F7CB0A0BBB8500CF6728561F2FD6B00BF5B80A94D8005A08F7E905B80398721B4329E56323EC365929A8E4C684570A9E1DA914EE7EEC9B69D1D113461EC88A81DCF8E6858BE66A7241F33D9963B66C2BC49C64CB41B64FB48468AADDFD5EA4EE0345B5EC37CB7EDB85B435EA408EE7B927EDBC511771CED7E9DF93CD0359F87FB0F8F871FDEBD07FEE1FB3FC3C377E39BD20126CD50EF14BBC78377EFAD50957AA233AE8413FAD334EB849BAD65E49AD3C48A489750F6C5BA459DBE68972365C59BDBB45DA84D35A12531B63658DB58D8392F9F2E9768F22AD12A396270F54976DCBAADE478333ED231D0E2EDE3C7A85AE7079B6C0D2A6749FC18A451773AFC35410A02E21EF7C459862C96FF37903DADFF640FBD22458A84A6365AAE9DDAED531243F2803F062D6B5373F73DB9001E3A977D8CCB5E83F13E25DEB7A4C83FC67EE94AF8927BAC674113C0CA704E3D0F66D9051266E89F25453CF0BC53EAF1A6B74C67210822FE9E89B2FBF76D53ECDE9EDB82BDB7E737333DC67C4A1641AC37D4B6A978A8750BE5509B66A6432DC1F446DAB4140FB46AA01C67DDCA7498CA971B1415D1F30D7133E5C0AD3DE4C0B7BE9580D9DF5157B0D3DF524FDDF1B6A9FD78357D25D1B52FAD15A575DC72F4D286CA86D9D7860A76FADA500D13153F07D5F3098D7366DB18C16BB5E71F61D53A478D6C6C75203E736CE2E3D80091BA9C6659E2059516304F8289458EFC06B40D75F41E2CD65F453E7E449F87C43D28973F34A413F74F0C8F94F8ED0289E1134B324960DFA565F726AEBDEB4EFD4C16192A9079C067670BF1CD274B90B8C3B4546C501EE432A4AE419CB3BA11C45EB004A1D66750BD35D7B272742B3A74CD395C96CFA4E25C6B9E7406409DB5D9B1AC48521C5431EC788649A15C3845579322E951DE5376E243BAFBF5055475C5C992A8EE52A726A08ACF1841421573A53302F2B27C2312CA71AF8B2447E66BEF8486BCF159A3D84807C69166D66FAF529A5E8229E6D2083229E6840E71BE9B7E244114DDBE8A265D7915DBCD3CFE0043DF50AAEE7035657E6F7777DF8E6429063482782978AE3702F2EDC6A6658D58463544817F856E51D6B877EF9AEBFEE69765C5878C2BA3BCB9325896570F7E3622A3021FAEF0DCA170E862E71AFA367194355AE14916ACD38D3B702D0BB59C63631C71A42CD13DE24C46401BCFBDAE00D06EFCA90928757F2010D0C643378A80921CDB8080922CD93A01AD2F6C74E79FBABD999A7892D746E31F73A4ECDA806C12FCD83AD1D4F25CEADCD5698BA9D487A971D3B7358E4CF5B76C405AB7C6A5597BE1AB5F0C07314C59F13D7F282BE14BCEB9A642C36D6EAAB2C6E94F4B5C093E8739E3CACF5CA7F3FF73FCF18CE89240189F784884C02AA03A171D0F09F790EA0155870A095473AE538075871C1E147E065500358F181808D2A3A100A1971C1960B72C69CC21570C68BB6630B8F61D8C7474CD99C300B67DB322856D768A142CA6763C3D20DF6D608DE5013A68BBA07DFDB5FA4A4A19194BA37DE18521925A499B7B92131A5C12FEEC8B6593D6358CD1450CF65994624B58A5BA7A61416BB3339855BC37F42C97545701BA9701D86734D640C21389EF1EC3E15898C14C11FEDC87E58C966FDAC83B8D7D1B61CB259C52F9A3556C1FC622727992B248EC523572AA0E6311D78DAAABB53D58257A72C9B1D91A8E3D13D71E656115D65AEE8613A85CFB31D6B9D4AE9C6A2EF1BC4B26FEA5415CA27C41022EB51F639D4B8D3AAB99C4F17018F83806B188F447ACD9744B5FB7AAD9A4B955D2386F0F62D97AB64BEDCBA9D5996D55773CAB03513605C73341C4CAE32BB05C06F1028B60D99438F33A7CE5D94F73F3E08E518D31F30809A54F982B4A79928205A46ACB304E3EACC294957BA30750BE1B3BF323A619F7842AD8D1B724D943283B97ED06BFED53FEBFF9B98920E824E760DF74BE401F18953E82EA552E77EBCD7676CA70A2200429E719F0591216512C7658887B776120718CAE541FA90D0589E3B465FA286D30481CA52DD347A1DC253898C29322C6246293E0884485011E1E278BC0C32B58BCE31925458C2F881156C6BF46CABF96761046A9BF7A482CB0867E487BAF4741B0C888380856AC8FD5C53AC4A1BA5203B5C58217128A8B951B285D1B8F90D0BAB6501F078B2F882361C5265858C440120DAB30C6A385012BD6C76AE3FAE1406D99C11C9261FA886924AB7E58A3823B3BFADB14B15F47C3A4C83AAFC7A2B0226D2ACBB697229E089ACB1E11E90A87222ACC6499087845CB3351698EBB0A7CC5C35D554E4D571ABFC5606DE13A69F4F545D07DAA1AD3FCB00B87688ADEB46E3BB44EBC8AE22FE9C94554F6C67E637A8CBB34FB6B3176D367AEC3B2CEEBD160FAF12F89247F18AC9CFBD5734DCEEC0B9F728A51B1486DC47EB82B36C46AC3B531686D85215E1DB58D41AB8B0DB1DAD06D0C5A5B61884747706370E90693D14B910B55572365F7431A3A29EFBEE975754373C2BA9087CFCFEA1D42FF391243C81C523C4F94D97CF1ACA7D86A6ED05134C8814A3DF3E8E1455521AC479BECECE7D6E1BA6C2246E1584D91210616748801C3EA4C9CC6785C28D2758CD718CC0219FC89980CB2CA6094788827629078452F3C0147F92DF429B0419D7074B6D6C087C98677229C996C750F6CCE98E93A932B0526021479BBC0549B692BBB8A76A593B1CA9C4B7D3B4B69FD686ED85A2AC0588F99B6B314638169087772576C88C5F150E0E5931424E1D38C3E82543F931C2648020CB1BD21A2B990E6461A82468C498468214CBA2C448D18CF4C5CD72A14CC0303BAC98A7A53B2FA7BF5C0A0B9DC57E7C9646EFBEB26AED3B2B112A51C46BB6583DDF96FE15918C0D278B70DAE401C3CC22CAFC312B9077BFB0754BECDE9E4BE9C65991F721E47E0A160054F03C6882F16947C55461033CD174125A0AC880C4A3FD907814C3E193F83D47B02E91F22F0F2471CAB7788D76A4CCCEF232E631FBE9CB8FFAC7A1E3997FFB8273AEF3895F3F6C8D973FE652339E5A0CFE2E4F32A9DB4B9C5B440E21F416DAB7033F914DB296092A00D4C97680B97CD86680B994A76680B96C965680F9849556819BA933D5BC064A2416B32C1CB23680B9C6356FA41F7C902F86318199E88F633F196970CBEC4F482E2A4CFEAB3CC0B9267692E64623C2A7996ED855112A3E6FF5E688958AD6FE2BF45E2CF5B69D8DC71BA3B67BCAFC1C6B94F12B71F4303F949D4BAC55783E72404C9753A20AC99C0F353AE19CA42D37BD0318AC9D7D6EB74C9666BEB0D83E76AEB0D42666AEB0DC3CFD3A686EB973D6C74B5E36E442961EEBDD8A905B9FCE8F27F55F18E73997D8983DF0A547187148852B12AD9845D9EF36FB7279A1ACAC86CD55D75CD558F845146A331339E36D3486DAF4259DC5A4DC45D476473E2F28952F1FEC99B1E823E1E563671D3B0CD312F39D320444E02265B785658284AB0D4074B985C89B7F5D6F9587EB2A53E4313265AEAB3CBE86ED04D0D6BDB73838B27E73A7B6B0F0BD35A6D99743083149D4DF962003720AD4B0FC9D8B28C28D6D6FB5B36E18935EC4D8AF6DAB29C100111B080546385EAE38587EA9D5CA557DC3FF92F8C758CAED32F5DC94403F959CB4D5285D8C26672A42421FC285A0332A20CC93AC2FF8DA975A152FC468FA5B7BDF944A69242A40B4F2808E33752E690319385487E0AA1EBAF1949B86E0D7384F492306EC20E5E8CB1DE791FB6423AA43F2DE45193FF7C6F92793D7A2D256BB2409B922BE345665CB9FA0172714C207A3C27BEAD607D1B31E3C6D86B9CE8370A06F717D3CFAB3131616BA21E0B846DC4EC19630B9BE8770C131736A31C191393B54DEDDB372C69DA1BC24909DA9679B1FA0BFE96FAB37AC8F4F84E2DEA8748ABF7D57488507A5A9BDF3631BE5545D689FAC74727AEFF503E37AFBDBA9230F9B2B414AAAC143C52D280B0342DDC2DC790C22B799464D1E705849AA3928854532D212688C44D93C3CF430C31BC9247EA561C475C98E0A15E38185264355732B2E535CCF9218F45C4BA954A48B06B22262A8EB5CCC83E6DBC5805A05BC8C99A7D6B73DA907E6CD3464E5610A15C46BBD97C4A69376DE4B40571BFC74EEDC1B12E4CB454D628F36F6AB0EE92B43BD3CCD981993C3AB4A3ECF379768C0D75379C056BCEC5C18DBDCE4BB8A3D8467350BACAC14C103972ADE4DE18CE0E7691A103A6596581FDDC1ABD847974168C973383B468F20C522AC7994033F869A3A69C22C30A538855541089C13E53D69511C30A4BC630A0A364C018BCA3E8CF5C3B092ED83813E8B059C4E50BC9FAAF7398058B0EE21861C6D0238E99AB3697F163D21E7AA911B54DE85FB12033EBA37DC7699A078FC0CB5175F938328817AE533D382B9FE83E40FF32BE29F26591A34F86D14348BCD42A4FCD32FA55160F72CCC737D58FD8321B9F808619948F4A6FE25F8B20F457E3BEE03C66124094C7F1E62962399779F92471F1BA42BA4E624DA0867D2B2FC21D8C962102CB6EE23978867DC68644EF135C00EFB57BBA2602514F04C9F6E3F3002C5210650D46D71FFD8964D88F5E7EFE1FC0B635F8BCB80000 , N'6.1.3-40302')
END

IF @CurrentMigration < '201709100444330_addOverridedApplicationUserProperties'
BEGIN
    ALTER TABLE [dbo].[AspNetUsers] ALTER COLUMN [Email] [nvarchar](256) NOT NULL
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201709100444330_addOverridedApplicationUserProperties', N'SysDev.Migrations.Configuration',  0x1F8B0800000000000400ED5DD96EDCCA117D0F907F20F89404BA1A2DB1E108D2BDD095AC4488B5C0231B79135A646B4498CB5C2EB284205F96877C527E21CD6DD8FB42F670388EE017AB9753CDEAAAEAEEEA9EAAFFFEFB3FC7BFBC44A1F30CD32C48E213777F77CF7560EC257E102F4EDC227FFCE983FBCBCFBFFFDDF1473F7A71BEB6ED0ECB76A8679C9DB84F79BE3C9ACD32EF094620DB8D022F4DB2E431DFF5926806FC6476B0B7F797D9FEFE0C2208176139CEF1E722CE8308567FA03FCF92D883CBBC00E155E2C3306BCA51CDBC4275AE4104B325F0E0893B7FCDCEE1F36EDDD0754EC300A041CC61F8E83A208E931CE46888475F3238CFD3245ECC97A8008477AF4B88DA3D823083CDD08FBAE6BA5FB177507EC5ACEBD842794596279121E0FE61C39619DDBD1773DD15DB10E33E2206E7AFE55757CC3B714F0B3FC8EF521084AE43933B3A0BD3B229C5DDDDAECF8E53D7ECAC6400894AF96FC7392BC2BC48E1490C8B3C05A8E56DF11006DEDFE1EB5DF20DC627711186F8D0D0E0501D51808A6ED36409D3FCF5337C6C067CE9BBCE8CEC37A33BAEBA617DEA0FB98CF3C303D7B946C4C1430857338F7DF43C4F52F85718C314E4D0BF05790ED3B8C48015EF18EA142DC4A322846A8A72945BB0188C71EAD532D34C619E22E5759D2BF0F209C68BFC090D15BCB8CE45F002FDB6A4C1FD120748D751A73C2D9464904AA5A8E83118FED5E730F3D26039CAB0CFD1EC9EA5B09CE39656597487EC8F7ADCD7E0395854E2226686EB7C8661D5267B0A96B52DC254E79E687A9126D1E7242414126F713F4F8AD4430DEF1269B33B902E604E8EF778D669BDD4161023D2350658A7376BC0D0BA08D22C2FFF2B91E7777B5AE26CA84B9FC086085F05BE1FC28D903EF5FD1466D9E874D14625075E7E9D6C8072B404F1EB46B8DDD0EED46934CA481F7D988E2FD9200D7210CE916928C61732CE82B526DADA0BC615B23130450303FAEB45D7E76DB9606829F4D8D2CE67C45D965257EC90B949913DB82EA287CE2AF4DC81365BC0DE3B4301DE97A5DF03CF5411616E748EC37BBD29E36694F12B088B37957F5379315EB7601A1FAF85C7547CE1E69C5271C3708FB7ED8EA98226CC3955D46ED041F516A65190659534EB1ABBAECF9BA9E3D0AADB957326DDCFEF1F7CB0A0BBB8500CF6728561F2FD6B00BF5B80A94D8005A08F7E905B80398721B4329E56323EC365929A8E4C684570A9E1DA914EE7EEC9B69D1D113461EC88A81DCF8E6858BE66A7241F33D9963B66C2BC49C64CB41B64FB48468AADDFD5EA4EE0345B5EC37CB7EDB85B435EA408EE7B927EDBC511771CED7E9DF93CD0359F87FB0F8F871FDEBD07FEE1FB3FC3C377E39BD20126CD50EF14BBC78377EFAD50957AA233AE8413FAD334EB849BAD65E49AD3C48A489750F6C5BA459DBE68972365C59BDBB45DA84D35A12531B63658DB58D8392F9F2E9768F22AD12A396270F54976DCBAADE478333ED231D0E2EDE3C7A85AE7D76EB27964CF92F83148A3EEB8F86B823406C43D2E8EB30C9930FF6F207B5AFF511F7A458A340BCD75B45C3BB5DBA72486E4897F0C5AD6A6E6EE7B72013C7450FB1897BD06E37D4ABC6F49917F8CFDD2B7F025F7585783268095E19C7A1ECCB20B24CCD03F4B8A78E001A854EC4DEFA1CE421044FC4D14B510DCB74DB18B7C6E0BF6229FDFCCF45CF3295904B1DE50DBA6E2A1D62D94436D9A990EB504D31B69D3523CD0AA81729C752BD3612A9F72505444EF39C4CD9403B7F6B203DF0B5702667F8B5DC14E7F8F3D754FDCA636E8D5F49544D7BEB45694D671EDD14B1B2A1B665F1B2AD8E96B43354C54FC1C54EF29340E9E6D6304AFD59E7FA655EB1C35B2B1D581F8CCB1898F630344EA729A658917545AC0BC11261639F21BD036D4D17BC1587F15F91A127D1E12F7A05CFED0904EDC3F313C52E2B70B24864F2CC924817D9796DD9BB876B73BF5BB5964A840E6019F9D2DC4379F2C41E20ED352B1417990CB90BA0671CEEA46107BC112845A9F41F5D65CCBCAD1ADE8D035E77059BE9B8A73AD79D2190075F866C7B222497150C5B0E319268572E114DD558AA4477971D9890FE9FFD71750D59D274BA2BA5C9D9A802A3E63040955CC95CE08C8DBF38D4828C7DF2E921C99F3BD131AF20A688D62231D18479A5947BE4A697A09A6984B23C8A498133AC4F97EFB910451741D2B9A74E5DD6C37F3F88B0C7D43A9BAD4D594F9BDDDDD7D3B92A518D008E2A5E0B9DE08C8C71C9B96356219D51005FE9DBA4559E35EC66BAEFB9B5F96151F32AE8CF2E6CA60595EBD00DA888C0A7CB8C27387C2A18B9D6BE8EBC551D668852759B04E37EEC0B52CD4728E8D71C491B244F7883319016D3CF7BA0240BBF1A726A0D4FD8140401B0FDD28024A726C03024AB264EB04B4BEB0D19D7FEAF6666AE2495E1B8D7FCC91B26B03B249F063EB4453CB73A97357A72DA6521FA6C64DDFD63832D5DFB20169DD1A9766ED85AF7E421CC43065C5F7FCA1AC842F39E79A0A0DB7B9A9CA1AA73F2D7125F81CE68C2B3F739DCEFFCFF1C733A24B02617CE2211102AB80EA5C743C24DC43AA07541D2A2450CDB94E01D61D727850F8195401D43C626020488F8602845E726480DDB2A431875C31A0ED9AC1E0DA7730D2D135670E03D8F6CD8A14B6D92952B098DAF1F4807CB781359647ECA0ED82F6F5D7EA2B2965642C8DF6851786486A256DEE494E687049F83B30964D5AD730461731D867518A2D6195EAEA8505ADCDCE6056F11ED5B35C525D05E85E06609FD15803094F24BE7B0C876361063345F8FB1F96335ABE6923EF34F66D842D97704AE58F56B17D188BC8E549CA22B14BD5C8A93A8C455C37AAAED6F66095E8C925C7666B38F64C5C7B948555586BB91B4EA072EDC758E752BB72AAB9C4F32E99F897067189F20509B8D47E8C752E35EAAC6612C7C361E0E318C422D21FB166D32D7DDDAA6693E65649E3BC3D8865EBD92EB52FA75667B655DDF1AC8E4CD9141CCF04212C8FAFC07219C40B2CA46553E2CCEB7896673FCDCDA33D4635C6CC2324943E61AE28E5490A1690AA2DE33AF9B08A5B56EE8D1E40F96EECCC8F9866DC13AA6047DF92640FA1EC5CB61BFCB64FF9FFE6E7268228949C837DD3F9027D6054FA08AA57B9DCAD37DBD929E38B8210A49C67C067495844B1D86121EEDDC585C431BA527DA43636248ED396E9A3B4D1217194B64C1F857297E0600A4F8A1893085682231215067878E02C020FAF60F18E67941431BE20465819FF1A29FF5ADA4118A5FEEA21B1C01AFA21EDBD1E05C14225E22058B13E5617FC1087EA4A0DD4168B6648282E566EA0746D804242EBDA427D1C2CE0208E84159B606121044934ACC2188F1606AC581FAB0DF48703B565067348C6ED23A691ACFA618D0AEEECE86F53C47E1D0D9322EBBC1E8BC28AB4A92CDB5E8A7822682E7B44E82B1C8AA83093652202162DCF44A539EE2A12160F775539355D69FC1683B585EBA4D1D71741F7A96A4CF3C32E1CA2297AD3BAEDD03AF12A8ABFA4271751D91BFB8DE931EED2ECAFC5D84D9FB90ECB3AAF4783E9C7BF2492FC61B072EE57CF3539B32F7CCA2946C542B711FBE1AED810AB8DDFC6A0B515867875183706AD2E36C46A63B931686D85211E1DD28DC1A51B4C462F452E545D8D94DD0F69E8A4BCFBA6D7D50DCD09EB421E3E3FAB7708FDE7480C217348F13C5166F3C5B39E62ABB94147D120072AF5CCA387175585B01E6DB2B39F5B87EBB2092185633545861858D021060CAB33711AE371A148D7315E63300B64F0276232C82A8351E2219E8841E215BDF0041CE5B7D0A7C00675C2D1D95A031F261BDE897066B2D53DB03963A6EB4CAE14980850E4ED02536DA6ADEC2ADA954EC62A732EF5ED2CA5F5A3B9616BA900633D66DACE528C05A621DCC95DB12116C74381974F5290844F33FA0852FD4C7298200930C4F68688E6429A1B69081A312611A28530E9B21035623C33715DAB50300F0CE8262BEA4DC9EAEFD50383E6725F9D3893B9EDAF9BB84ECBC64A947218ED960D76E7BF856761004BE3DD36B80271F008B3BC0E4BE41EECED1F500938A7930C7396657EC8791C81C786153C0D1823BE5850F2551941CC3481049591B22232281F651F04321B65FC0C52EF09A47F88C0CB1F71ACDE315FAB3131BF8FB88C7DF872E2FEB3EA79E45CFEE39EE8BCE354CEDB2367CFF9978D6C95833E8B93E0AB74D2E616F304897F04B5ADC2CD24586CA780C98A36307FA22D5C363DA22D642AFBA12D5826B9A13D602677A165E84EF66C01939907ADC9042FB1A02D708E59E907DD272DE08F61647822DACFC45B5E32F812D30B8A934FABCF322FC8A6A5B99089F1A86C5AB61746498C9AFF7BA12562B5BE89FF16893F6FA56193C9E9EE9CF1BE061BE73E59DD7E0C0DE46755EB165F0D9E931024D7E980B06602CFCFC166280B4DEF41C72826815BAFD3259BBEAD370C9EBCAD370899BAAD370C3F719B1AAE5F3AB1D1D58EBB11A584B9F762A716E4F2A3CBFF55C53BCE65F6250E7E2B50C51D52204AC5AA64137679CEBFDD9E68AE2823B35577D535573D3248198DC6CC78DACC2BB5BD0A65716B3511771D91DE89CB27B58A0B509914410F411F172B9BB969D8EE98979D6910222703932D3C2B2C146558EA8325CCAEC4DB7BEB7C2C3FDB529FA109332DF5D9667457E8A696B5EDB9C1D593739FBDB5A785692DB74C3E98418ACEE67C31801B90D7A587646C594A146B0BFE2D9BF1C41AF626457B6D694E8888085844AAB162F5F1E243F5CEAED22BF09FFC27C63A46D7E997AF64A291FCAC2527A9626C6133395296107E18AD01295186A41DE1FFC8D4BA50297EA4C7D2DBDE842253C921D2C52714C4F11B2975C898D94224BF85D075D88C245CB78649427A49183763072FC858EFC40F5B211DD2DF16F2A8C97FBF37C9C41EBD96923559A04DC995F12233AE5CFD00C93826103E9E13E056B0BE8D987263EC354EF42305830B8CE927D69898B035618F05C23662FA8CB1854DF44386890B9B51928C89C9DAA6F6ED1B9634ED0DE1A4046DCBBC58FD057F4BFD593D647A7CA716F54BA4D5036B3A46283DADCD8F9B18DFAA22ED44FDEBA313D77F28DF9BD75E5D499C7C595E0A555A0A1E296944589A16EE966348E1953C4AB2F0F30242CD514944AAA996101384E2A6C9E1E72186185EC923752B0E242ECCF0502F1C0C29B29A2B19D9F21AE6FC98C72262DD4A2524D835111315075B66649F365EAC02D02DE464CDBEB5396D483FB66923272B08512EA3DD6C3EA5B49B3672DA82C0DF63E7F6E05817265C2A6B94F93735587749DE9D6926EDC04C1E1DDB51F6F93C3BC6C6BA1BCE823527E3E0065FE765DC516CA339285DE56026881CB956926F0C6707BBC8D011D3ACB2C07E728D5EC23C3A0BC64B9A415A34790A2995E34CA019FCBC5153CE91618529C42A2A08C5609F29EB4A896185256318D05152600CDE51F467AE9D0C176CA00974D82CE2F28564FDD739CC824507718C3063E811C7CC559BCBF831690FBDD488DA26F4CF589099F5D1BEE334CD8347E0E5A8BA7C1C19C40BD7A91E9C954F741FA07F19DF14F9B2C8D127C3E821245E6A95A76619FD2A8D0739E6E39BEA576C998D4F40C30CCA47A537F1AF4510FAAB715F701E330920CAE378F314B19CCBBC7C92B8785D215D27B12650C3BE9517E10E46CB10816537F11C3CC33E6343A2F7092E80F7DA3D5D1381A8278264FBF17900162988B206A3EB8FFE4432EC472F3FFF0FD9F21710CEB80000 , N'6.1.3-40302')
END

IF @CurrentMigration < '201709100453322_addOverridedPropertiesApplicationUser'
BEGIN
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201709100453322_addOverridedPropertiesApplicationUser', N'SysDev.Migrations.Configuration',  0x1F8B0800000000000400ED5DD96EE4BA117D0F907F10F49404BE6E2F99C1C4B0EF85AF3D4E8C8C174C7B06793368896E0BA3A5AF168F8D205F96877C527E21D4D6E2BE486CB57A62F8C5CDE5902C5615C92255F5DF7FFFE7F8979728749E619A05497CE2EEEFEEB90E8CBDC40FE2C5895BE48F3F7D707FF9F9F7BF3BFEE8472FCED7B6DC61590ED58CB313F729CF9747B359E63DC10864BB51E0A549963CE6BB5E12CD809FCC0EF6F6FE32DBDF9F4104E1222CC739FE5CC47910C1EA07FA7996C41E5CE60508AF121F8659938E72E615AA730D22982D81074FDCF96B760E9F77EB82AE731A060075620EC347D701719CE420475D3CFA92C1799E26F162BE440920BC7B5D4254EE1184196CBA7ED415D71DC5DE41398A5957B185F28A2C4F2243C0FDC3862C33BA7A2FE2BA2BB221C27D4404CE5FCB5157C43B714F0B3FC8EF521084AE4337777416A665518ABABB5D9D1DA7CED959F1006295F26FC7392BC2BC48E1490C8B3C05A8E46DF11006DEDFE1EB5DF20DC62771118678D750E7501E9180926ED36409D3FCF5337C6C3A7CE9BBCE8CAC37A32BAEAA6175EA815CC6F9E181EB5CA3C6C1430857338F0D7A9E2729FC2B8C610A72E8DF823C87695C62C08A764CEB545B88464508D52DCA516EC16230C6A957F34C3385798A84D775AEC0CB27182FF227D455F0E23A17C10BF4DB9406F74B1C20594795F2B4503683442A45498FC1F0519FC3CC4B83E528DD3E47B37B96C2728EDBB6CAA43BA47FD4FDBE06CFC1A2621731315CE7330CAB32D953B0AC7511263AF744D18B34893E272121907889FB7952A41E2A7897488BDD81740173B2BFC7B34EEAA5BA80E891AE32C02ABD6903A6AD8B20CDF2F25F093FBFDBD362674359FA0436D4F055E0FB21DC48D3A7BE9FC22C1BBD5DB451C981975F271B68395A82F87523D46EDAEEC469B496913CFA301D9FB3411AE4209C23D5508CCF649C056B4D6D6B2F185748C7C014750CE8AF175D9DB7E582694B21C796763E23EEB294B262A7999B14E983EB227AE8B442CF1D68B305ECBD3314E07D59FA3DF04C0511E646E738BCD69B306E4618BF82B07813F9379117E3750BA6F1F15A784CC5176ECE2915570CF778D9EE982A28C29C5345E5061D546F611A05595671B3AEB2EBEABCA93A4E5B75B972CEA4FBF9FD830F166417678AC156AE304CBE7F0DE0770B30B50AB000F4D10F720B30E7308456FAD372C667B84C52D39E09B508CE355C3DD2C9DC3D59B6D32382228C1E1195E3E9110DCDD7EC94E47D26CB72FB4CA837499F897283741F4948B1F6BB5ADD099C66CB6B98EFB615776BC88B14C17D4FD26FBB38E28EA35DAF539F07BAEAF370FFE1F1F0C3BBF7C03F7CFF6778F86E7C553A40A519CA9D62F778F0EEBD9556A596E88CCBE184FC34C53AE6667319BEE614B1C2D225947DB66E51A7CFDA654F59F6E6166D176A5349689B185B1AAC6D2CEC9C974F974B3479156B951431B8FA242B6EDD5672BC191FE91868F1F6F16354ADF36B57D99C118CB458F0067C96C48F411A7507D55F1324AB20EE71659D654879FA7F03D9D3FA8D0CD02B5224D388CBA2E5DA5BBB7D4A6248DA1AC668CBDAD4DC7D4F2E80878E881FE3B2D660BC4F89F72D29F28FB15F5A35BEE41E6BE4D004B0D29D53CF835976819819FA6749115B3BE09C852088F89B286A21B86F8B6217F9DC12EC453EBF98E9B9E653B20862BDAEB645C55DAD4B28BBDA1433ED6A09A6D7D3A6A4B8A35501653FEB52A6DD543EE5A05A11BDE710175376DCDACB0E7C2F5C3198FD2D76053BFD3DF6D42D719BDAA057D35736BAF605AE6A691DD71EBDA4A1D261F6A5A1829DBE3454DD44C9CF41F59E42E3E0D91646F05AE5F9675AB5CC513D1B5B1C88618EDDF8383A40242EA7599678412505CC1B61629123C78036838EDE0BC67A54E46B48343CC4EE41B9FCA12E9DB87F6268A4C46F17480C9F5892C906F65D9A776FE2DADCEED4EF6691A20299077C76B610DD7C3205B13B4C4BC106E5712A43E21AC4392B1B41EC054B106A0D83AAADB99695BD5BB543E79CC365F96E2ACEB5E649A703D4E19BEDCBAA498A822A821DCF302E9433A7E8AE52C43DCA8BCB8E7D48FBBF3E83AAEE3CD926AACBD5A931A862182370A862AE747A40DE9E6F844339F67611E7C88CEF1DD39057406B641B69C738DCCC1AF25542D38B31C5541A8127C594D0699C6FB71F891145D7B1A24957DECD76338FBFC8D05794AA4B5D4D9EDFDBDDDDB7C3598A0E8DC05E0A9AEBF5807CCCB1695E2396510D56E0DFA95BE435EE65BCE6BABFF965593190717994375706CBF2EA05D046785460C3159E3B14065DEC5C435F2F8EB2462B2CC98275BA3107AE65A196536C8C238E9424BA479CC9306863B9D76500DA8C3F3506A5EE0F040CDA58E846615092621B605092245BC7A0F5858DEEFC53B73753634FF2DA68FC638E945C1BE04D821E5BC79A5A964B9DBB3A6D3695DA30356EFAB6C690A91ECB06B8756B4C9AB515BEFA84388861CAB2EFF94399095F72CE3515EA6E73539535467F9AE34AF039CC19537EE63A9DFD9F638F67589704C2E8C44322185601D599E87848B885540FA83A5448A09A739D02AC3BE4F0A0F033A802A879C4C04090160D0508BDE4C800BB6549630EB96C40EB3583CEB5EF60A4BD6BCE1C06B0ED9B15296CB353A46031B1E3C901F96E032B2CF7D841EB05EDEBAFD528296164348DF6851786484A25ADEE494A685049F81D184B26AD6B18A38B186C5894604B48A5BA7A61416BB5339854BC47F52C95545701BA9701D8301A6D20A189C4768FE17034CC60A208BFFF6129A3659B36B24E63632374B984522A7BB48AECC348442E4F5212894DAA4646D56124E29A5175A5B607A9444F2E393A5BC3B06762DAA334AC425BCBCD7002916B07639D4AEDCAA9A612CFBA64625F1A4425CA1624A0523B18EB546AC4594D248E85C3C0C6318844A43D62CDAA5BFABA554D26CDAD92C6797B10C9D6B35D6A5F4EADCE6CABBCE359ED99B249389E095C581E5F81E5328817984BCB26C599D7FE2CCF7E9A9B7B7B8C6A8C994770287DC25CB594272958402AB7F4EBE4C3CA6F59B9377A00E5BBB1333F628A714FA8821D7DDB247B0865E7B2DDE0B775CAFF9B8F3E045E283907FBA6F2051A6054DA08AA57B9DCAD375BD929FD8B8210A49C67C067495844B1D86021AEDDF985C431BA547DA4D637248ED3A6E9A3B4DE217194364D1F853297E0600A4B8A18937056822312190678B8E32C020FCF60F18E67141731B620865919FB1AC9FF5AD24128A5FEE221D1C01AF221ADBD1E01C15C25E22058B23E56E7FC1087EA520DC416F36648082E966E2074AD834242EADA447D1CCCE1208E84259B60612E0449342CC3188F66062C591FAB75F48703B569067348FAED23A691CCFA61950A6EECE8AF53C4761D0D9522ABBC1E8DC2B2B4292FDB5E8A782C68CE7B84EB2B1C8AC830E365C20316CDCF44A639EECA13160F779539355969EC1683A5856BA4D1971741F5A94A4CF361170ED124BD49DD76489D7815C55FD2938BA8EC8DFDC6E4183769F69762ECA6CF5C866595D723C1F4E35F1249FE305839F7ABE79A9CD9173EE514A362AEDB88FD70976C88D5FA6F63D0DA0C43BCDA8D1B8356271B62B5BEDC18B436C3108F76E9C6E0D2052623972213AAAE44CAEE873464525E7DD3EBEA86E68435210F9F9FD53B84FE7324869019A4789628B3F9E2694FB1D6DCA0A1689001957AE6D1C38AAA42588F34D9D9CFADC374D9B890C2B19A24B37EB1FAA24B35EC0DE64488E9169667627EC6FD3C9146683CC7603E49674EC4B4925906BDC45D36119DC4337AE10928CA2FA1DF02EBA4094767730DACA1ACBB26C22CCA66F7C0E6F499CE33B99C603C3A91F7144CF664B432E752DFCE525A3F9A1BB6960A30D6A3A6ED2CC598631AC29CDC251B62712C1478FA241949F834A30F23D5CF248731920043AC25086F2EA49290BAA01163122E5A08452C735123C63363D7B53205F3C0802EB26ABD4959FD5E3D30682EF7D5813399DBFEBA88EBB464AC582987D16E596077FE5B781606B054B96D812B10078F30CB6BB744EEC1DEFE011580733AC1306759E6879CC711B86F58C1D38031FC8B05255D951EC44C0348501129AB4606C5A3EC834046A38C9F41EA3D81F40F1178F9238ED5DBE76BD527E6FB88CBD8872F27EE3FAB9A47CEE53FEE89CA3B4E65BC3D72F69C7FD988563968589C005FA59136B7182748FC11D4B632371360B19D02262ADAC0F889B670D9F088B690A9E887B66099E086F68099D88596A13BDEB3054C461EB4C613BCC082B6C0396AA51F749FB0803F8692E1B1683F156F79C9E0734C2F284E3CAD3ECBBC209A96E64226C6A3A269D95E18253E6AFEEF9996F0D5FAC6FE5BC4FEBC95860D26A7BB73C6EB1A6C9CFB4475FB3124901F55AD5B7C35684E429054A71DC29A313C3F069B212F34B5071DA398006EBD4E976CF8B6DE3078F0B6DE2064E8B6DE30FCC06D6AB87EE1C446173BEE469462E6DE8B9D9A91CB4197FF55C93BCE65F6250E7E2B50C61D12204AC4AA182C7669CEBFDD9E68AC2823B55557D555573D224819F5C64C79DA8C2BB5BD0265716B3511731D11DE894B27B588F307D74FF9B435ED281FC1789910420F411FE32F1BD969D8BE9D17BD6910222742932D3C2B24144560EA83258CBEC43B15E80C961F8DA94FD7849198D6B06311DC676FED69615ACB2D130F669038B1315F0CE006C475E9C1195B1612C5DA827FCB463CB186BD49D65E5B9813C22302E6916A2C5F7D3CFF50BDA3ABF472FC27FFC45847E93AFDE2954CD4939FB5E024958F2D6C26478A12C277A3352024CA90B023FC8F4CAD3395E2233DB6BDED0D28329518229D7F42811FBF9142878C192D44F22D84AEC16624E6BA350C12D28BC3B8113B784EC67A077ED80AEE907E5BC86B4DFEFDDE24037BF45A4AD6A48136C557C68BCCB87CF50304E39880FB788E835BC1FA3662C88DB1D738D1470A061718D30FAC3131666BDC1E0B986DC4F01963339BE8438689339B51908C89F1DAA6F6ED1BE634ED0DE1A4186DCBAC58FD197F4BED593D787A7CA316F525D2EA8135ED23949ED6E6E326C6B6AA083B517F7D74E2FA0FE57BF3DAAA2BF1932F8B4BA10A4BC16B4AEA11966E0B37CB314DE199BC9664EEE7050D35472551534DB6A431812B6EBA39FC3CC4348667F29ABA153B12174678A8170EA629329BCB19D9F21AE67C9FC7A2C6BA954AD8605744DCA8D8D932C3FBB4F26205802E216FD66CACCD69433AD8A68CBC59818B7259DBCDE653DA765346DEB6C0F1F7D8B13D38DA857197CA2A65FE4D0D565D1277679A413B309547FB76940D9FA7C7585F77C349B0E6601C5CE7EBBC883B8A6D3407A5CB1C4C049121D74AF08DE1E4601719DA639A5512D80FAED18B994727C1784133488D260F21A5329C0924831F376ACA3132AC1085584505AE18EC13655D2131AC90640C053A4A088CC13B8AFEC4B513E1827534810E9B455CBE43AC7F9DC32C587410C70833861E71CC5C95B98C1F93F6D04BF5A82D427FC682D4AC8FF61DA7691E3C022F47D9E513C4205EB84EF5E0AC7C08FB00FDCBF8A6C897458E860CA3879078A9559E9A65ED57613CC83E1FDF545FB165368680BA19944F376FE25F8B20F457FDBEE03C66124094C7F1E62962399779F92471F1BA42BA4E624DA0867C2B2BC21D8C962102CB6EE23978867DFA8658EF135C00EFB57BBA2602514F0449F6E3F3002C5210650D46571FFD443CEC472F3FFF0F8ED6A50DCEB80000 , N'6.1.3-40302')
END
