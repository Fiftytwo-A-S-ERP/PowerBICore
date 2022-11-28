tableextension 6042301 PBICompanyExtFTA extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(6042300; "FtaPowerBIEnabled"; Boolean)
        {
            Caption = 'PowerBI enabled', Comment = 'PowerBI aktiveret';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}