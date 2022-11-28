pageextension 6042301 PBICompanyInformationExtFTA extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addlast(Content)
        {
            field(PowerBIEnabledFTA; FtaPowerBIEnabled)
            {
                ApplicationArea = All;
            }
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}