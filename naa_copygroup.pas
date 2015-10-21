
unit naa_db;



{$MODE OBJFPC}



interface



uses
	SysUtils,
	USupportLibrary,
	ODBCConn,
	SqlDb;
	
	
	
const
	DSN = 					'DSN_ADBEHEER_32';
	
	TBL_ACC	=				'account';
	FLD_ACC_ID = 			'account_id';
	FLD_ACC_FULLNAME = 		'full_name';
	FLD_ACC_FNAME = 		'first_name';
	FLD_ACC_MNAME = 		'middle_name';
	FLD_ACC_LNAME = 		'last_name';
	FLD_ACC_SUPP_ID = 		'ref_supplier_id';
	FLD_ACC_TIT_ID = 		'ref_title_id';
	FLD_ACC_MOBILE = 		'mobile';
	FLD_ACC_EMAIL = 		'email';
	FLD_ACC_RCD = 			'rcd';
	FLD_ACC_RLU = 			'rlu';
	
	TBL_ADT = 				'account_detail';
	FLD_ADT_ID = 			'account_detail_id';
	FLD_ADT_ACC_ID =		'ref_account_id';
	FLD_ADT_DOM_ID = 		'ref_domain_id';
	FLD_ADT_REQ_ID = 		'ref_requestor_id';
	FLD_ADT_UN = 			'user_name';
	FLD_ADT_DN = 			'dn';
	FLD_ADT_UPN = 			'upn';
	FLD_ADT_PW =			'init_pw';
	FLD_ADT_DO_UNLOCK =		'do_unlock';
	FLD_ADT_DO_RESET =		'do_reset';
	FLD_ADT_STATUS =		'status';
	FLD_ADT_RCD =			'rcd';
	FLD_ADT_RLU = 			'rlu';

	
	TBL_DOM = 				'account_domain';
	FLD_DOM_ID = 			'domain_id';
	FLD_DOM_UPN = 			'upn';
	FLD_DOM_NT = 			'domain_nt';
	FLD_DOM_OU = 			'org_unit';
	FLD_DOM_USE_OU = 		'use_supplier_ou';
	FLD_DOM_IS_ACTIVE = 	'is_active';
	FLD_DOM_RCD = 			'rcd';
	FLD_DOM_RLU = 			'rlu';
	
	
	VIE_CAA = 				'view_create_admin_account';
	FLD_CAA_DETAIL_ID = 	'account_detail_id';
	FLD_CAA_ACCOUNT_ID = 	'account_id';
	FLD_CAA_FULLNAME = 		'full_name';
	FLD_CAA_DN = 			'dn';
	FLD_CAA_USER_NAME = 	'user_name';
	FLD_CAA_FNAME = 		'first_name';
	FLD_CAA_MNAME = 		'middle_name';
	FLD_CAA_LNAME = 		'last_name';
	FLD_CAA_TITLE = 		'ref_title_id';
	FLD_CAA_MOBILE = 		'mobile';
	FLD_CAA_EMAIL = 		'email';
	FLD_CAA_INIT_PW = 		'init_pw';
	FLD_CAA_UPN = 			'upn';
	FLD_CAA_UPN_SUFF = 		'upn_suffix';
	FLD_CAA_DOM_ID = 		'ref_domain_id';
	FLD_CAA_NT = 			'domain_nt';
	FLD_CAA_OU = 			'org_unit';
	FLD_CAA_USE_SUPP_OU = 	'use_supplier_ou';
	FLD_CAA_SUPP_ID = 		'ref_supplier_id';
	FLD_CAA_SUPP_NAME = 	'name';
	FLD_CAA_STATUS = 	 	'status';

	TBL_ACT = 				'account_action_act';
	FLD_ACT_ID = 			'act_id';
	FLD_ACT_DESC = 			'act_description';
	FLD_ACT_RCD = 			'act_rcd';
	FLD_ACT_RLU = 			'act_rlu';
	
	TBL_AAD =				'account_action_detail_aad';
	FLD_AAD_ID = 			'aad_id';
	FLD_AAD_ACT_ID =		'aad_act_id';
	FLD_AAD_CMD = 			'aad_command';
	FLD_AAD_EL = 			'aad_error_level';
	FLD_AAD_RCD = 			'aad_rcd';
	FLD_AAD_RLU = 			'aad_rlu';
	
	
var
	gConnection: TODBCConnection;               // uses ODBCConn
	gTransaction: TSQLTransaction;  			// Uses SqlDB
	
	

//function DoesObjectIdExist(strObjectId: string): boolean;
function FixNum(const s: string): string;
function FixStr(const s: string): string;
procedure DatabaseClose();
procedure DatabaseOpen();
//procedure InsertRecord(strDomainNetbios: string; strDn: string; strSam: string; strObjectId: string; strUpn: string; strRcd: string; strRlu: string);
//procedure MarkInactiveRecords(strDomainNetbios: string; strLastRecordUpdated: string);
//procedure UpdateRecord(strDomainNetbios: string; strDn: string; strSam: string; strObjectId: string; strUpn: string; strRlu: string);



implementation



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
end;


{
function DoesObjectIdExist(strObjectId: string): boolean;
	//
	//	Search for a record in the table with value strObjectId
	//
	//	if found then return true
	//if not found return false

var
	rs: TSQLQuery;							// Uses SqlDB
	q: Ansistring;
begin
	q := 'SELECT ' + FLD_LA_ID + ' ';
	q := q + 'FROM ' + TBL_LA + ' ';
	q := q + 'WHERE ' + FLD_LA_OID + '='+ FixStr(strObjectId) + ';';
	
	rs := TSQLQuery.Create(nil);
	rs.Database := gConnection;
	rs.PacketRecords := -1;
	rs.SQL.Text := q;
	rs.Open;

	//WriteLn('Run query: ' + q);
	
	DoesObjectIdExist := rs.Eof;
	//if rs.Eof = false then
	//	DoesObjectIdExist := false
	//else
	//	DoesObjectIdExist := true;
		
	rs.Free;
end; // of function DoesObjectIdExist
}

{
procedure InsertRecord(strDomainNetbios: string; strDn: string; strSam: string; strObjectId: string; strUpn: string; strRcd: string; strRlu: string);
//InsertRecord(DOMAIN, DN, SAM, OBJECTID,UPN);
var
	qi: Ansistring;
	q: TSQLQuery;
	t: TSQLTransaction;
begin
	//WriteLn('INSERT NEW RECORD!');
	//WriteLn(strDomainNetbios);
	//WriteLn(strDn);
	//WriteLn(strSam);
	//WriteLn(strObjectId);
	
	qi := 'INSERT INTO ' + TBL_LA + ' ';
	qi := qi + 'SET ';
	qi := qi + FLD_LA_DN + '=' + FixStr(strDn) + ',';
	qi := qi + FLD_LA_DOM + '=' + FixStr(strDomainNetbios) + ',';
	qi := qi + FLD_LA_UPN + '=' + FixStr(LowerCase(strUpn)) + ',';
	qi := qi + FLD_LA_NB + '=' + FixStr(strDomainNetbios + '\\' + strSam) + ',';
	qi := qi + FLD_LA_OID + '=' + FixStr(strObjectId) + ',';
	qi := qi + FLD_LA_UN + '=' + FixStr(strSam) + ',';
	qi := qi + FLD_LA_ISOBSO + '=' + FixNum('0') + ',';
	qi := qi + FLD_LA_RCD + '=' + FixStr(strRcd) + ',';			// Record Creation Date
	qi := qi + FLD_LA_RLU + '=' + FixStr(strRlu) + ';';			// Record Last Update
	
	//WriteLn(qi);
	
	t := TSQLTransaction.Create(gConnection);
	t.Database := gConnection;
	q := TSQLQuery.Create(gConnection);
	q.Database := gConnection;
	q.Transaction := t;
	
	q.SQL.Text := qi;
	
	//gConnection.ExecuteDirect(q);
	q.ExecSQL;
	t.Commit;
end; // procedure InsertRecord
}

{
procedure UpdateRecord(strDomainNetbios: string; strDn: string; strSam: string; strObjectId: string; strUpn: string; strRlu: string);
//InsertRecord(DOMAIN, DN, SAM, OBJECTID,UPN);
var
	qu: Ansistring;
	q: TSQLQuery;
	t: TSQLTransaction;
begin
	//WriteLn('UPDATE RECORD!');
	//WriteLn(strDomainNetbios);
	//WriteLn(strDn);
	//WriteLn(strSam);
	//WriteLn(strObjectId);
	
	qu := 'UPDATE ' + TBL_LA + ' ';
	qu := qu + 'SET ';
	qu := qu + FLD_LA_DN + '=' + FixStr(strDn) + ',';
	qu := qu + FLD_LA_DOM + '=' + FixStr(strDomainNetbios) + ',';
	qu := qu + FLD_LA_UPN + '=' + FixStr(LowerCase(strUpn)) + ',';
	qu := qu + FLD_LA_NB + '=' + FixStr(strDomainNetbios + '\\' + strSam) + ',';
	qu := qu + FLD_LA_UN + '=' + FixStr(strSam) + ',';
	qu := qu + FLD_LA_ISOBSO + '=' + FixNum('0') + ',';
	qu := qu + FLD_LA_RLU + '=' + FixStr(strRlu) + ' ';
	qu := qu + 'WHERE ' + FLD_LA_OID + '=' + FixStr(strObjectId) + ';';
	
	//WriteLn(qu);
	
	t := TSQLTransaction.Create(gConnection);
	t.Database := gConnection;
	q := TSQLQuery.Create(gConnection);
	q.Database := gConnection;
	q.Transaction := t;
	
	q.SQL.Text := qu;
	
	//gConnection.ExecuteDirect(q);
	q.ExecSQL;
	t.Commit;
end; // procedure UpdateRecord
}

{
procedure MarkInactiveRecords(strDomainNetbios: string; strLastRecordUpdated: string);
	//
	//	Change the is_active field to 0 when the last record update 
	//	for this domain strDomainNetbios was before strLastRecordUpdated.
	//
	//	strDomainNetbios:		DOMAIN
	//	gstrLastRecordUpdated:	YYYY-MM-DD HH:MM:SS
var	
	qu: Ansistring;
	q: TSQLQuery;
	t: TSQLTransaction;
begin
	qu := 'UPDATE ' + TBL_LA + ' ';
	qu := qu + 'SET ';
	// Change the  Obsolete field to 1 when the field is not change during this batch.
	qu := qu + FLD_LA_ISOBSO + '=1 ';
	qu := qu + 'WHERE ' + FLD_LA_DOM + '=' + FixStr(strDomainNetbios) + ' ';
	qu := qu + 'AND ' + FLD_LA_RLU + '<' + FixStr(strLastRecordUpdated) + ';';
	
	//WriteLn('MarkInactiveRecords():');
	//WriteLn(qu);
	WriteLn('Mark inactive accounts for domain ' + strDomainNetbios);
	
	t := TSQLTransaction.Create(gConnection);
	t.Database := gConnection;
	q := TSQLQuery.Create(gConnection);
	q.Database := gConnection;
	q.Transaction := t;
	
	q.SQL.Text := qu;
	
	q.ExecSQL;
	t.Commit;
end; // of procedure MarkInactiveRecords
}


end.

// end of program