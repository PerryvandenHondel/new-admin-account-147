//
//	Admin Account Management -- Global definitions
//


unit aam_global;


{$MODE OBJFPC}
{$H+}			// Large string support


interface


uses
	ODBCConn,
	USupportLibrary,
	SysUtils,
	SqlDb;
	
const
	DSN = 						'DSN_ADBEHEER_32';		
		// Data Source Name of the ODBC connection (32-bits)
	
	PROG_ID = 					147;					
		// Unique program ID
	
	VALID_ACTIVE = 				9;						
		// Only process records with _is_active = 9. 0 = inactive, 1 = active, 9 = development records
	
	SLEEP_NEXT_ACTION = 		1500;
		// Sleep time before next action during processing, 1000 = 1 second.
									
	MAIL_FROM = 				'noreply@ns.nl';
		// Default from address of all send e-mail
									
	MAIL_BCC = 					'perry.vandenhondel@ns.nl';
		// Default BCC of all e-mail send by this program

	ACTION_NEW =	 			1;						// Create a new account
	ACTION_RESET = 				2;						// Reset the password
	ACTION_SAME = 				3;						// Make the group membership the same as a reference account.
	ACTION_UNLOCK = 			4;						// Unlock an account
	ACTION_DISABLE = 			5;						// Disable an account
	ACTION_DELETE = 			6;						// Delete an account
	
	TBL_ACC	=					'account';
	FLD_ACC_ID = 				'account_id';
	FLD_ACC_FULLNAME = 			'full_name';
	FLD_ACC_FNAME = 			'first_name';
	FLD_ACC_MNAME = 			'middle_name';
	FLD_ACC_LNAME = 			'last_name';
	FLD_ACC_SUPP_ID = 			'ref_supplier_id';
	FLD_ACC_TIT_ID = 			'ref_title_id';
	FLD_ACC_MOBILE = 			'mobile';
	FLD_ACC_EMAIL = 			'email';
	FLD_ACC_RCD = 				'rcd';
	FLD_ACC_RLU = 				'rlu';
	
	TBL_ADT = 					'account_detail';
	FLD_ADT_ID = 				'account_detail_id';
	FLD_ADT_ACC_ID =			'ref_account_id';
	FLD_ADT_DOM_ID = 			'ref_domain_id';
	FLD_ADT_REQ_ID = 			'ref_requestor_id';
	FLD_ADT_UN = 				'user_name';
	FLD_ADT_DN = 				'dn';
	FLD_ADT_UPN = 				'upn';
	FLD_ADT_PW =				'init_pw';
	//FLD_ADT_DO_UNLOCK =			'do_unlock';
	//FLD_ADT_DO_RESET =			'do_reset';
	FLD_ADT_STATUS =			'status';
	FLD_ADT_RCD =				'rcd';
	FLD_ADT_RLU = 				'rlu';

	
	TBL_DOM = 					'account_domain';
	FLD_DOM_ID = 				'domain_id';
	FLD_DOM_UPN = 				'upn';
	FLD_DOM_NT = 				'domain_nt';
	FLD_DOM_OU = 				'org_unit';
	FLD_DOM_USE_OU = 			'use_supplier_ou';
	FLD_DOM_IS_ACTIVE = 		'is_active';
	FLD_DOM_RCD = 				'rcd';
	FLD_DOM_RLU = 				'rlu';
	
	
	VIE_CAA = 					'view_create_admin_account';
	FLD_CAA_DETAIL_ID = 		'account_detail_id';
	FLD_CAA_ACCOUNT_ID = 		'account_id';
	FLD_CAA_FULLNAME = 			'full_name';
	FLD_CAA_DN = 				'dn';
	FLD_CAA_USER_NAME = 		'user_name';
	FLD_CAA_FNAME = 			'first_name';
	FLD_CAA_MNAME = 			'middle_name';
	FLD_CAA_LNAME = 			'last_name';
	FLD_CAA_TITLE = 			'ref_title_id';
	FLD_CAA_MOBILE = 			'mobile';
	FLD_CAA_EMAIL = 			'email';
	FLD_CAA_INIT_PW = 			'init_pw';
	FLD_CAA_UPN = 				'upn';
	FLD_CAA_UPN_SUFF = 			'upn_suffix';
	FLD_CAA_DOM_ID = 			'ref_domain_id';
	FLD_CAA_NT = 				'domain_nt';
	FLD_CAA_OU = 				'org_unit';
	FLD_CAA_USE_SUPP_OU = 		'use_supplier_ou';
	FLD_CAA_SUPP_ID = 			'ref_supplier_id';
	FLD_CAA_SUPP_NAME = 		'name';
	FLD_CAA_STATUS = 	 		'status';

	//
	//	View definition 
	//
	//
	VIEW_RESET = 				'account_action_view_reset';
	VIEW_RESET_ID = 			'arp_id';
	VIEW_RESET_IS_ACTIVE = 		'arp_is_active';
	VIEW_RESET_ACTION_SHA1 = 	'arp_action_sha1';
	VIEW_RESET_ATV_ID = 		'arp_atv_id';
	VIEW_RESET_DN = 			'atv_dn';
	VIEW_RESET_UPN = 			'atv_upn'; 
	VIEW_RESET_SORT = 			'atv_sort';
	VIEW_RESET_ARQ_ID = 		'atv_arq_id';
	VIEW_RESET_MAIL_TO = 		'arq_mail_to';
	VIEW_RESET_FNAME = 			'arq_fname';
	VIEW_RESET_REFERENCE =	 	'arp_reference';
	VIEW_RESET_INITPW = 		'arp_initial_password';
	VIEW_RESET_STATUS = 		'arp_status';
	VIEW_RESET_RCD = 			'arp_rcd';

	//
	//	AAD = Action Account Do table
	//	Table that contain all the actions that are to be done to perform an action. 
	//
	TBL_AAD =					'account_action_do_aad';
	FLD_AAD_ID = 				'aad_id';
	FLD_AAD_IS_ACTIVE = 		'aad_is_active';
	FLD_AAD_ACTION_SHA1 = 		'aad_action_sha1';	// Unique Action SHA1: 40 chars Hex number.
	FLD_AAD_ACTION_NR = 		'aad_action_nr';
	FLD_AAD_ACTION_ID =			'aad_action_id';
	FLD_AAD_CMD = 				'aad_command';
	FLD_AAD_EL = 				'aad_error_level';
	//FLD_AAD_STATUS = 			'aad_status';
	FLD_AAD_RCD = 				'aad_rcd';
	FLD_AAD_RLU = 				'aad_rlu';
	
	TBL_ATV = 					'account_active_atv';
	FLD_ATV_ID = 				'atv_id';
	FLD_ATV_IS_ACTIVE = 		'atv_is_active';
	FLD_ATV_APS_ID = 			'atv_person_aps_id'; // APS_ID
	FLD_ATV_SORT = 				'atv_sort';
	FLD_ATV_UPN = 				'atv_upn';
	FLD_ATV_SAM = 				'atv_sam';
	FLD_ATV_DN = 				'atv_dn';
	FLD_ATV_MAIL = 				'atv_mail';
	FLD_ATV_CREATED = 			'atv_created';
	FLD_ATV_RLU = 				'atv_rlu';
	

var	
	gConnection: TODBCConnection;               // uses ODBCConn
	gTransaction: TSQLTransaction;  			// Uses SqlDB
	
	
function FixNum(const s: string): string;
function FixStr(const s: string): string;
function GenerateSha1(): string;
function GenerateUniqueActionNumber(actionNumber: integer): Ansistring; // Same as a SHA1 code of 40 chars in length
procedure AddRecordToTableAad(actionSha1: Ansistring; command: Ansistring);
procedure DatabaseClose();
procedure DatabaseOpen();
procedure RunQuery(qryString: string);
procedure TableAadProcess(curAction: integer; recId: integer);
procedure TableAadProcessNew(actionSha1: string);
procedure TableAadRemovePrevious(actionNumber: integer; recordId: integer);
procedure UpdateAadErrorLevel(recId: integer; errorLevel: integer);
procedure UpdateOneFieldString(table: string; keyField: string; keyValue: integer; updateField: string; updateValue: string);
procedure TableAadProcessActions(uniqueActionNumber: Ansistring);


implementation


procedure UpdateOneFieldString(table: string; keyField: string; keyValue: integer; updateField: string; updateValue: string);
//
//	Update a specific field in a table, use the key field and record id to specify one record.
//
//		table
//		keyField
//		keyValue
//		updateField
//		updateValue
//
var
	qu: Ansistring;
begin
	qu := 'UPDATE ' + table;
	qu := qu + ' SET';
	qu := qu + ' ' + updateField + '=' + EncloseSingleQuote(updateValue);
	qu := qu + ' WHERE ' + keyField + '=' + IntToStr(keyValue);
	qu := qu + ';';
	RunQuery(qu);
end;


procedure AddRecordToTableAad(actionSha1: string; command: string);
//
//	Add a record to the table AAD
//
//		actionSha1			Unique Action SHA1 of Hex number of 40 chars length
//		command				Full command to execute
//		isActive			Is this active?  0=INACTIVE, 1=ACTIVE, 9=TEST
//
var
	qi: Ansistring;
begin
	qi := 'INSERT INTO ' + TBL_AAD;
	qi := qi + ' SET'; 
	qi := qi + ' ' + FLD_AAD_ACTION_SHA1 + '=' + EncloseSingleQuote(actionSha1);
	qi := qi + ',' + FLD_AAD_IS_ACTIVE + '=' + IntToStr(VALID_ACTIVE);
	qi := qi + ',' + FLD_AAD_CMD + '=' + FixStr(command) + ';';
	//WriteLn('AddRecordTableAdd(): ', qi);
	RunQuery(qi);
end; // of procedure NewTableAadAdd



procedure TableAadProcessActions(uniqueActionNumber: Ansistring);
var
	qs: Ansistring;
	rs: TSQLQuery;
	recId: integer;
	cmd: string;
	r: integer;
begin
	WriteLn('ProcessActions(): ', uniqueActionNumber);
	
	// Select all records where the error level is not filled in,
	// And the is_active field = 9.
	qs := 'SELECT *';
	qs := qs + ' FROM ' + TBL_AAD;
	qs := qs + ' WHERE ' + FLD_AAD_EL + ' IS NULL';
	qs := qs + ' AND ' + FLD_AAD_ACTION_SHA1 + '=' + EncloseSingleQuote(uniqueActionNumber);
	qs := qs + ' AND ' + FLD_AAD_IS_ACTIVE + '=' + IntToStr(VALID_ACTIVE);
	qs := qs + ' ORDER BY ' + FLD_AAD_RCD;
	qs := qs + ';';
	
	WriteLn(qs);
	
	rs := TSQLQuery.Create(nil);
	rs.Database := gConnection;
	rs.PacketRecords := -1;
	rs.SQL.Text := qs;
	rs.Open;

	if rs.EOF = true then
		WriteLn('ProcessActions(): ', uniqueActionNumber, ': No records found!')
	else
	begin
		while not rs.EOF do
		begin
			recId := rs.FieldByName(FLD_AAD_ID).AsInteger;
			cmd := rs.FieldByName(FLD_AAD_CMD).AsString;
			r := RunCommand(cmd);
			UpdateAadErrorLevel(recId, r);
			rs.Next;
		end;
	end;
	rs.Free;
end; // of procedure ProcessActions




procedure TableSetStatus(table: string; fieldRecord: string; recId: integer; fieldStatus: string; newStatus: integer);
//
//	Set a new status for the table 
//		ANW		Account Action New
//		ARP		Account Action Password
//	
//		table:				Table name
//		fieldRecord:		Field name of the record ID
//		recId: 				Record ID
//		fieldStatus:		Field name of the Status ID
//		newStatus:			New status to update record
//
var
	qu: Ansistring;
begin
	qu := 'UPDATE ' + table;
	qu := qu + ' SET';
	qu := qu + ' ' + fieldStatus + '=' + IntToStr(newStatus);
	qu := qu + ' WHERE ' + fieldRecord + '=' + IntToStr(recId);
	qu := qu + ';';
	
	WriteLn('TableSetStatus(): ', qu);
	
	RunQuery(qu);
end; // of procedure TableAnwSetStatus


function GenerateUniqueActionNumber(actionNumber: integer): string;
//
//	Generate an unique action number
//
//	Layout: [actionNumber:2][38 random chars]
//
const
	MAX_LENGTH = 38;
var
	i: integer;
	sValidChars: string;
	r: string;				// Return value
begin
	// List of valid chars. Pick one at a time.
	//ValidChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
	sValidChars := '0123456789abcdef';
	
	Sleep(10);
	// Initialize the random number generator.
	Randomize;
	
	r := '';
	for i := 1 to MAX_LENGTH do
	begin
		//WriteLn(i, TAB, sValidChars[Random(Length(sValidChars))+1]);
		r := r + sValidChars[Random(Length(sValidChars))+1]
	end; // of for
	GenerateUniqueActionNumber := NumberAlign(actionNumber, 2) + r;
end; // of function GenerateUniqueActionNumber


function GenerateSha1(): string;
const
	MAX_LENGTH = 40;
var
	i: integer;
	sValidChars: string;
	r: string;				// Return value
begin
	// List of valid chars. Pick one at a time.
	//ValidChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
	sValidChars := '0123456789abcdef';
	
	// Initialize the random number generator.
	Randomize;
	
	r := '';
	for i := 1 to MAX_LENGTH do
	begin
		//WriteLn(i, TAB, sValidChars[Random(Length(sValidChars))+1]);
		r := r + sValidChars[Random(Length(sValidChars))+1]
	end; // of for
	GenerateSha1 := r;
end; // of function GenerateSha1


procedure UpdateAadErrorLevel(recId: integer; errorLevel: integer);
var
	qu: Ansistring;
begin
	qu := 'UPDATE ' + TBL_AAD;
	qu := qu + ' SET';
	qu := qu + ' ' + FLD_AAD_EL + '=' + IntToStr(errorLevel);
	qu := qu + ' WHERE ' + FLD_AAD_ID + '=' + IntToStr(recId);
	qu := qu + ';';
	//WriteLn('UpdateAadErrorLevel(): ', qu);
	RunQuery(qu);
end; // of procedure UpdateAadErrorLevel


procedure TableAadProcess(curAction: integer; recId: integer);
var
	qs: Ansistring;
	rs: TSQLQuery;
	
	cmd: string;
	//upn: string;
	//initialPassword: string;
	//actId: integer;
	//stepNum: integer;
	r: integer;
begin
	WriteLn('TableAadProcess()');
	
	// Select all records where the error level is not filled in,
	// And the is_active field = 9.
	qs := 'SELECT *';
	qs := qs + ' FROM ' + TBL_AAD;
	qs := qs + ' WHERE ' + FLD_AAD_EL + ' IS NULL';
	qs := qs + ' AND ' + FLD_AAD_IS_ACTIVE + '=' + IntToStr(VALID_ACTIVE);
	qs := qs + ' AND ' + FLD_AAD_ACTION_ID + '=' + IntToStr(recId);
	qs := qs + ' AND ' + FLD_AAD_ACTION_NR + '=' + IntToStr(curAction);
	qs := qs + ' ORDER BY ' + FLD_AAD_RCD;
	qs := qs + ';';
	
	WriteLn(qs);
	
	rs := TSQLQuery.Create(nil);
	rs.Database := gConnection;
	rs.PacketRecords := -1;
	rs.SQL.Text := qs;
	rs.Open;

	if rs.EOF = true then
		WriteLn('ProcessActions(): No records found!')
	else
	begin
		while not rs.EOF do
		begin
			recId := rs.FieldByName(FLD_AAD_ID).AsInteger;
			cmd := rs.FieldByName(FLD_AAD_CMD).AsString;
			
			r := RunCommand(cmd);
			
			WriteLn(recId:6, ' RunCommand: ', cmd);
			WriteLn('     >ERRORLEVEL=' , r);
			
			UpdateAadErrorLevel(recId, r);
			
			rs.Next;
			Sleep(SLEEP_NEXT_ACTION); // Wait SLEEP_NEXT_ACTION seconds before the next action is processed.
		end;
	end;
	rs.Free;
end; // of procedure TableAadProcess


procedure TableAadProcessNew(actionSha1: string);
var
	qs: Ansistring;
	rs: TSQLQuery;
	recId: integer;
	cmd: string;
	r: integer;
begin
	WriteLn('TableAadProcessNew(): ', actionSha1);
	
	// Select all records where the error level is not filled in,
	// And the is_active field = 9.
	qs := 'SELECT *';
	qs := qs + ' FROM ' + TBL_AAD;
	qs := qs + ' WHERE ' + FLD_AAD_EL + ' IS NULL';
	qs := qs + ' AND ' + FLD_AAD_ACTION_SHA1 + '=' + EncloseSingleQuote(actionSha1);
	qs := qs + ' ORDER BY ' + FLD_AAD_RCD;
	qs := qs + ';';
	
	WriteLn(qs);
	
	rs := TSQLQuery.Create(nil);
	rs.Database := gConnection;
	rs.PacketRecords := -1;
	rs.SQL.Text := qs;
	rs.Open;

	if rs.EOF = true then
		WriteLn('ProcessActions(): No records found!')
	else
	begin
		while not rs.EOF do
		begin
			recId := rs.FieldByName(FLD_AAD_ID).AsInteger;
			cmd := rs.FieldByName(FLD_AAD_CMD).AsString;
			
			r := RunCommand(cmd);
			
			//WriteLn(recId:6, ' RunCommand: ', cmd);
			//WriteLn('     >ERRORLEVEL=' , r);
			
			UpdateAadErrorLevel(recId, r);
			
			rs.Next;
			Sleep(SLEEP_NEXT_ACTION); // Wait SLEEP_NEXT_ACTION seconds before the next action is processed.
		end;
	end;
	rs.Free;
end; // of procedure TableAadProcess


procedure TableAadRemovePrevious(actionNumber: integer; recordId: integer);
//
//	Remove previous records from the table AAD
//
//		actionNumber	Number of the action, 1=new, 2=reset, etc
//		recordId		Record number of the specific action to remove
//
var
	qu: Ansistring;
begin
	qu := 'DELETE FROM ' + TBL_AAD;
	qu := qu + ' WHERE ' + FLD_AAD_ACTION_NR + '=' + IntToStr(actionNumber);
	qu := qu + ' AND ' + FLD_AAD_ACTION_ID + '=' + IntToStr(recordId);
	qu := qu + ';';
	
	WriteLn('TableAadRemovePrevious():');
	WriteLn(qu);
	WriteLn;
	
	RunQuery(qu);
	
end; // of procedure TableAadRemovePrevious


function FixStr(const s: string): string;
var
	r: string;
begin
	if Length(s) = 0 then
		r := 'Null'
	else
	begin
		// Replace a single quote (') to double quote's ('').
		r := StringReplace(s, '''', '''''', [rfIgnoreCase, rfReplaceAll]);
	
		r := EncloseSingleQuote(r);
	end;

	FixStr := r;
end; // of function FixStr


function FixNum(const s: string): string;
var
	r: string;
	i: integer;
	code: integer;
begin
	Val(s, i, code);
	i := 0; 
	if code <> 0 then
		r := 'Null'
	else
		r := s;
		
	FixNum := r;
end; // of function FixNum


procedure RunQuery(qryString: string);
//
//	Run a query 
//
var
	q: TSQLQuery;
	t: TSQLTransaction;
begin
	t := TSQLTransaction.Create(gConnection);
	t.Database := gConnection;
	q := TSQLQuery.Create(gConnection);
	q.Database := gConnection;
	q.Transaction := t;
	q.SQL.Text := qryString;
	q.ExecSQL;
	t.Commit;
end; // of procedure RunQuery


procedure DatabaseOpen();
{
	Open a DSN connection with name strDsnNew
}
begin
	WriteLn('DatabaseOpen(): Opening database using DSN: ',  DSN);
	
	gConnection := TODBCCOnnection.Create(nil);
	//query := TSQLQuery.Create(nil);
	gTransaction := TSQLTransaction.Create(nil);
	
	gConnection.DatabaseName := DSN; // Data Source Name (DSN)
	gConnection.Transaction := gTransaction;
end;


procedure DatabaseClose();
begin
	//WriteLn('DatabaseClose(): Closing database DSN: ', DSN);
	gTransaction.Free;
	gConnection.Free;
	WriteLn('DatabaseClose()');
end;


end. // of unit aam_action_reset
