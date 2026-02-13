--liquibase formatted sql

--changeset JMcDonald:Update_Comment_Test_Proc_CoCurItemsAdd labels:sds-569 runOnChange:true

CREATE OR ALTER PROCEDURE [dbo].[Test_Proc_CoCurItemsAdd]
        @CompanyCurriculumid     int,
        @Classgenericid  int,
		@CustomerAliasCourseName varchar(50),
		@YearsAfter int = 0,
		@SpecificExpiration datetime = '1/1/1900'
AS 
----------------------------------------------------------------------------------------
--	WHERE IS THIS USED: 2008-12-13-XXX
--		CompanyCurriculumUpdateDoIT.asp
--		CompanyCurriculum.asp
--      New Website: SCObjects_Data.ClsCurriculum_Data.ClsUpdateCurriculumCourse
--
--  updated 2025-11-10 Charles and Jerry added this comment to test Liquidbase
--
--  updated 2011-01-24 jjc added 2 optional parameters YearsAfter and SpecificExpiration (so can change Expiration Date)
--
--  updated 2008-12-13 djl added another parameter CustomerAliasCourseName
--			(so that customers can have their own names of the training or make them equivalent to each other)
--
--  to note: as of today 12-13-08 when ever items are added to the curriculum
--           another procedure runs which updates the parent curriculum details to lastupdate
--			 this procedure and that procedure are two separate calls (Proc_CoCurDetailsUpdate)
----	TEST CODE:
--			declare
--			@CompanyCurriculumid     int,
--			@Classgenericid     int,
--			@CustomerAliasCourseName varchar(50)
--
--			set @CompanyCurriculumid =2318
--			set @Classgenericid=2998
--			set @CustomerAliasCourseName = 'BASF'
--
--			exec Proc_CoCurItemsAdd @CompanyCurriculumid,@Classgenericid,@CustomerAliasCourseName

--	to note: I converted the Alias Name to upper so that their is no confusion in the select statements
--			 (capitalization differences would screw up group by clauses)
----------------------------------------------------------------------------------------
BEGIN
/* Determine if the curriculum exists for this company */
declare @locCurriculumId int
declare @testId int
select @locCurriculumId=CompanyCurriculumlinkid from CompanyCurriculum where @CompanyCurriculumid=CompanyCurriculumid AND @Classgenericid=Classgenericid
set @CustomerAliasCourseName = upper(@CustomerAliasCourseName)
IF @locCurriculumId is null
    BEGIN
    INSERT CompanyCurriculum( CompanyCurriculumid, Classgenericid, TrainingEquivalencyName, ZExpirationIDCur, SpecificClassExpirationDateCur) 
    VALUES( @CompanyCurriculumid, @Classgenericid, @CustomerAliasCourseName, @YearsAfter, @SpecificExpiration)
	END
ELSE
	BEGIN
	UPDATE CompanyCurriculum
    set TrainingEquivalencyName=@CustomerAliasCourseName,
    ZExpirationIDCur = @YearsAfter,
    SpecificClassExpirationDateCur = @SpecificExpiration
	WHERE @CompanyCurriculumid=CompanyCurriculumid AND @Classgenericid=Classgenericid
	END
END


--rollback ALTER PROCEDURE [dbo].[Test_Proc_CoCurItemsAdd]
--rollback         @CompanyCurriculumid     int,
--rollback         @Classgenericid     int,
--rollback 		@CustomerAliasCourseName varchar(50),
--rollback 		@YearsAfter int = 0,
--rollback 		@SpecificExpiration datetime = '1/1/1900'
--rollback AS 
--rollback ----------------------------------------------------------------------------------------
--rollback --	WHERE IS THIS USED: 2008-12-13
--rollback --		CompanyCurriculumUpdateDoIT.asp
--rollback --		CompanyCurriculum.asp
--rollback --      New Website: SCObjects_Data.ClsCurriculum_Data.ClsUpdateCurriculumCourse
--rollback --
--rollback --  updated 2011-01-24 jjc added 2 optional parameters YearsAfter and SpecificExpiration (so can change Expiration Date)
--rollback --
--rollback --  updated 2008-12-13 djl added another parameter CustomerAliasCourseName
--rollback --			(so that customers can have their own names of the training or make them equivalent to each other)
--rollback --
--rollback --  to note: as of today 12-13-08 when ever items are added to the curriculum
--rollback --           another procedure runs which updates the parent curriculum details to lastupdate
--rollback --			 this procedure and that procedure are two separate calls (Proc_CoCurDetailsUpdate)
--rollback ----	TEST CODE:
--rollback --			declare
--rollback --			@CompanyCurriculumid     int,
--rollback --			@Classgenericid     int,
--rollback --			@CustomerAliasCourseName varchar(50)
--rollback --
--rollback --			set @CompanyCurriculumid =2318
--rollback --			set @Classgenericid=2998
--rollback --			set @CustomerAliasCourseName = 'BASF'
--rollback --
--rollback --			exec Proc_CoCurItemsAdd @CompanyCurriculumid,@Classgenericid,@CustomerAliasCourseName
--rollback 
--rollback --	to note: I converted the Alias Name to upper so that their is no confusion in the select statements
--rollback --			 (capitalization differences would screw up group by clauses)
--rollback ----------------------------------------------------------------------------------------
--rollback BEGIN
--rollback /* Determine if the curriculum exists for this company */
--rollback declare @locCurriculumId int
--rollback select @locCurriculumId=CompanyCurriculumlinkid from CompanyCurriculum where @CompanyCurriculumid=CompanyCurriculumid AND @Classgenericid=Classgenericid
--rollback set @CustomerAliasCourseName = upper(@CustomerAliasCourseName)
--rollback IF @locCurriculumId is null
--rollback     BEGIN
--rollback     INSERT CompanyCurriculum( CompanyCurriculumid, Classgenericid, TrainingEquivalencyName, ZExpirationIDCur, SpecificClassExpirationDateCur) 
--rollback     VALUES( @CompanyCurriculumid, @Classgenericid, @CustomerAliasCourseName, @YearsAfter, @SpecificExpiration)
--rollback 	END
--rollback ELSE
--rollback 	BEGIN
--rollback 	UPDATE CompanyCurriculum
--rollback     set TrainingEquivalencyName=@CustomerAliasCourseName,
--rollback     ZExpirationIDCur = @YearsAfter,
--rollback     SpecificClassExpirationDateCur = @SpecificExpiration
--rollback 	WHERE @CompanyCurriculumid=CompanyCurriculumid AND @Classgenericid=Classgenericid
--rollback 	END
--rollback END