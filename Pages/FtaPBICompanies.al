page 6042301 PBICompaniesFTA
{
    Caption = 'FtaCompanies';
    PageType = API;
    APIPublisher = 'contoso';
    APIGroup = 'app1';
    EntityName = 'FtaCompanies';
    EntitySetName = 'FtaCompanies';
    DelayedInsert = true;
    SourceTable = Company;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(DisplayName; "Display Name")
                {
                    ApplicationArea = All;
                }
                field(VatRegistrationNo; gVatRegNo)
                {
                    ApplicationArea = All;
                }
                field(HomePage; gHomePage)
                {
                    ApplicationArea = All;
                }
                field(PowerBIEnabledFTA; gPBIEnabled)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        lCompanyInformation: Record "Company Information";
    begin
        if lCompanyInformation.ChangeCompany(Name) then
            if lCompanyInformation.Get() then begin
                gVatRegno := lCompanyInformation."VAT Registration No.";
                gHomePage := lCompanyInformation."Home Page";
                gPBIEnabled := lCompanyInformation.FtaPowerBIEnabled;
            end;

    end;

    trigger OnInit()
    var
        lCompany: Record Company;
        lCompanyInformation: Record "Company Information";
    begin
        if lCompany.FindSet() then
            repeat
                if lCompanyInformation.ChangeCompany(lCompany.Name) then begin
                    IF NOT lCompanyInformation.FINDFIRST THEN BEGIN
                        lCompanyInformation.INIT;
                        lCompanyInformation."Created DateTime" := CURRENTDATETIME;
                        lCompanyInformation.INSERT;
                    END;
                    if lCompanyInformation.Get() then
                        if true then begin //lCompanyInformation.FtaPowerBIEnabled then begin
                            Rec := lCompany;
                            Rec.Insert();
                        end;
                end;
            until lCompany.Next() = 0;
    end;

    var
        gVatRegno: Text;
        gHomePage: Text;
        gPBIEnabled: Boolean;

}
