-- =============================================
-- Author:		ASMITH
-- Create date: 2025-09-15
-- Description:	Sample SQL
--
--
--	exec dbo.Proc_TestProc
-- =============================================
ALTER PROCEDURE [dbo].[Proc_TestProc]

AS
BEGIN

	SET NOCOUNT ON;
	-- allow dirty reads to occur (similar to with (NOLOCK) )
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    
	
	
	--DECLARE @locGlAcct_Ilevel as int = 76

	DECLARE @locEmailMessage varchar(max)= ''
	DECLARE @locEmailRecipients varchar(400) = 'asmith2@noemail.org' --'asmith@noemail.org'
	DECLARE @locEmailRecipientsBcc varchar(400) = 'asmith@noemail.org'
	Declare @Loc_EmailAddressForMasterOnDb varchar(250) = dbo.sysAdminConstants('MASTER','EMAIL')
	
	DECLARE @locEmail_OkToSend int = 0	


	--------------------------------------------
	--	EMAIL (send or do not send)
	--------------------------------------------	
	if (len(@locEmailRecipients) >= 5 or len(@locEmailRecipientsBcc) >= 5) and len(@Loc_EmailAddressForMasterOnDb) >= 5
		begin
		set @locEmail_OkToSend = 1
		end

	--------------------------------------------
	--	DATES
	--------------------------------------------
	--DECLARE @locDateBegin as datetime = dateadd(month,-12,getdate()) --'3/1/2014'
	--set @locDateBegin = cast(month(@locDateBegin) as varchar)+'/1/'+cast(year(@locDateBegin) as varchar)
	--DECLARE @locDateEnd as datetime = convert(varchar(10),EOMONTH(dateadd(month,-1,getdate())),101)+' 23:59'    --to ensure we get all records
	----select @locDateBegin,@locDateEnd
	

 	--------------------------------------------
	--	GET THE DATA
	--------------------------------------------

select
RowNum = ROW_NUMBER() OVER (ORDER BY DateCompleted asc )
,*
into #tempAttendanceRecordsABC
from (select S.NameLastFirstPlusID, cr.ClassDescriptionForDisplay, convert(varchar,r.ClassDate,101) as ClassDate, r.Grade, convert(varchar,r.TimeIn,101) as DateStarted, convert(varchar,r.TimeOut,101) as DateCompleted
       from classesgeneric cr left join registration R on r.classgenericid_regi = cr.classgenericid
       left join STUDENTS S on R.studentid = S.Studentid
       where R.Grade IN ('P', 'F') AND R.Classgenericid_Regi in (10232,10234,10265,10755,10756) AND R.TimeOut > dateadd(DAY,-7,getdate()))  
as T ORDER BY DateCompleted

--select
--RowNum = ROW_NUMBER() OVER (ORDER BY TimeOut asc )
--,*
--into #tempAttendanceRecordsABC
--from (
--	   (select S.NameLastFirstPlusID, cr.ClassDescriptionForDisplay, convert(varchar,r.ClassDate,101) as ClassDate, r.Grade, convert(varchar,r.TimeIn,120) as TimeIn, convert(varchar,r.TimeOut,120) as TimeOut
--       from classesgeneric cr left join registration r on r.classgenericid_regi = cr.classgenericid
--       left join STUDENTS S on r.studentid = S.Studentid
--       where r.[classdate] < dateadd(month,-6,getdate())
--       and r.Grade='S'
--       and Classgenericid_Regi in (10232,10234,10265,10755,10756))
--		Union
--       (select S.NameLastFirstPlusID, cr.ClassDescriptionForDisplay, convert(varchar,r.ClassDate,101) as ClassDate, r.Grade, convert(varchar,r.TimeIn,120) as TimeIn, convert(varchar,r.TimeOut,120) as TimeOut
--       from classesgeneric cr left join registration r on r.classgenericid_regi = cr.classgenericid
--       left join STUDENTS S on r.studentid = S.Studentid
--       where r.registrationid in 
--       (select distinct(RegistrationID) from RegistrationIdentityLog where 
--              DateCreatedChange > dateadd(month,-12,getdate())
--              and RegistrationID in (select distinct(registrationid) from REGISTRATION where Classgenericid_Regi in (10232,10234,10265,10755,10756)
--		)))
--)  as T ORDER BY TimeOut

--	select * from #tempAttendanceRecordsABC

 	-----------------------------------------------------------
	--	START EMAIL MESSAGE BUILDING -DECLARATIONS
	-----------------------------------------------------------
		declare 
		@locRowNumber int
		,@locNameLastFirstPlusID [nvarchar] (100)
		,@locClassDescriptionForDisplay [nvarchar] (255)
		,@locClassDate [nvarchar] (30)
		,@locGrade [nvarchar] (20)
		,@locTimeIn [nvarchar] (30)
		,@locTimeOut [nvarchar] (30)
		
 	-----------------------------------------------------------
	--	EMAIL HEADER
	-----------------------------------------------------------
		set @locEmailMessage = '<br/>'
		set @locEmailMessage = @locEmailMessage +'<br/><br/>=================<br/>'
		set @locEmailMessage = @locEmailMessage +'Company: BAC'
		set @locEmailMessage = @locEmailMessage +'<br/>'
		--set @locEmailMessage = @locEmailMessage +'Total number of records: '
		set @locEmailMessage = @locEmailMessage +'This is a list of training records that were completed in the past week'
		set @locEmailMessage = @locEmailMessage +'<br/>'
		set @locEmailMessage = @locEmailMessage +'<br/>=================<br/><br/>'

		set @locEmailMessage = @locEmailMessage +'<table border="1" width="100%" bgcolor="#008080" cellspacing="0" cellpadding="2" font="arial">'
		set @locEmailMessage = @locEmailMessage +'<tr style="background-color: NAVY; color: White;">'
		set @locEmailMessage = @locEmailMessage +'<td>Name(ID)</td>'
		set @locEmailMessage = @locEmailMessage +'<td>Course</td>'
		set @locEmailMessage = @locEmailMessage +'<td>Class Date</td>'
		set @locEmailMessage = @locEmailMessage +'<td>Grade</td>'
		set @locEmailMessage = @locEmailMessage +'<td>Date Started</td>'
		set @locEmailMessage = @locEmailMessage +'<td>Date Completed</td>'
		set @locEmailMessage = @locEmailMessage +'</tr>'

 	-----------------------------------------------------------
	--	EMAIL BODY
	-----------------------------------------------------------
		while exists(select top(1)rowNum from #tempAttendanceRecordsABC order by rowNum)
			begin
			set @locRowNumber = (select top(1)rowNum from #tempAttendanceRecordsABC order by rowNum)
			select 	@locNameLastFirstPlusID = NameLastFirstPlusID
					,@locClassDescriptionForDisplay = ClassDescriptionForDisplay
					,@locClassDate = ClassDate
					,@locGrade = Grade
					,@locTimeIn = ISNULL(DateStarted,'N/A')
					,@locTimeOut = ISNULL(DateCompleted,'N/A')
			from #tempAttendanceRecordsABC where @locRowNumber=rowNum

			set @locEmailMessage = @locEmailMessage +'<tr  style="background-color:White ; color: NAVY;">'
			set @locEmailMessage = @locEmailMessage +'<td>'+@locNameLastFirstPlusID+'</td>'
			set @locEmailMessage = @locEmailMessage +'<td>'+@locClassDescriptionForDisplay+'</td>'
			set @locEmailMessage = @locEmailMessage +'<td>'+@locClassDate+'</td>'
			set @locEmailMessage = @locEmailMessage +'<td>'+@locGrade+'</td>'
			set @locEmailMessage = @locEmailMessage +'<td>'+@locTimeIn+'</td>'
			set @locEmailMessage = @locEmailMessage +'<td>'+@locTimeOut+'</td>'
			set @locEmailMessage = @locEmailMessage +'</tr>'

			--print @locRowNumber	
			delete #tempAttendanceRecordsABC where RowNum=@locRowNumber 
		end
		
		set @locEmailMessage = @locEmailMessage +'</table>'
		set @locEmailMessage = @locEmailMessage +'<br/><br/> ABC Attendance report<br/> *** generated by Proc_ZRptAttendanceABC'


 	-----------------------------------------------------------
	--	EMAIL SEND
	-----------------------------------------------------------
	IF @locEmail_OkToSend = 1
		begin
		declare @locMailSubject as varchar(200) = 'ABC - Activity in the past week'
		declare @locAdminEmailFromAddress as varchar(75) = dbo.sysAdminConstants('MASTER', 'EMAIL')
		exec msdb.dbo.sp_send_dbmail 
		@from_address=@Loc_EmailAddressForMasterOnDb
		,@reply_to = @Loc_EmailAddressForMasterOnDb
		,@Subject=@locMailSubject
		,@Recipients=@locEmailRecipients
		,@blind_copy_recipients = @locEmailRecipientsBcc
		,@body=@locEmailMessage
		,@body_format = 'HTML' 
		end	

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Proc_TestProc] TO [DATICAL_USER]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Proc_TestProc] TO [DATICAL_USER]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Proc_TestProc] TO [DATICAL_USER]
    AS [dbo];