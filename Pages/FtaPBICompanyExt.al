pageextension 6042302 CompaniesExtFTA extends Companies
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field(FtaPowerBIEnabled; gFtaPowerBIEnabled)
            {
                ApplicationArea = All;
                Caption = 'PowerBI enabled', Comment = 'PowerBI aktiveret';
                Editable = true;

                trigger OnValidate()
                var
                    Temp: Boolean;
                    lCompanyInformation: Record "Company Information";
                begin
                    if not lCompanyInformation.ChangeCompany(Name) then
                        Error('Not valid company');
                    if not lCompanyInformation.Get() then
                        Error('Company setup missing');
                    lCompanyInformation.FtaPowerBIEnabled := gFtaPowerBIEnabled;
                    lCompanyInformation.Modify();
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

    }

    trigger OnAfterGetRecord()
    var
        lCompanyInformation: Record "Company Information";
    begin
        if not lCompanyInformation.ChangeCompany(Name) then
            Error('Not valid company: %1', Name);
        IF NOT lCompanyInformation.FINDFIRST THEN BEGIN
            lCompanyInformation.INIT;
            lCompanyInformation."Created DateTime" := CURRENTDATETIME;
            lCompanyInformation.INSERT;
        end;
        if not lCompanyInformation.Get() then
            Error('Company setup missing: %1', Name);
        gFtaPowerBIEnabled := lCompanyInformation.FtaPowerBIEnabled;
    end;

    trigger OnAfterGetCurrRecord()
    var
        lCompanyInformation: Record "Company Information";
    begin
        if not lCompanyInformation.ChangeCompany(Name) then
            Error('Not valid company: %1', Name);
        IF NOT lCompanyInformation.FINDFIRST THEN BEGIN
            lCompanyInformation.INIT;
            lCompanyInformation."Created DateTime" := CURRENTDATETIME;
            lCompanyInformation.INSERT;
        end;
        if not lCompanyInformation.Get() then
            Error('Company setup missing: %1', Name);
        gFtaPowerBIEnabled := lCompanyInformation.FtaPowerBIEnabled;
    end;

    var
        myInt: Integer;
        gFtaPowerBIEnabled: Boolean;
}